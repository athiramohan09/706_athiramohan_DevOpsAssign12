from django.shortcuts import render, redirect
from .models import Login
from django.views.decorators.csrf import csrf_exempt

def register_view(request):
    if request.method == 'POST':
        username = request.POST.get('username','').strip()
        password = request.POST.get('password','').strip()
        if username and password:
            # create only if not exists
            if not Login.objects.filter(username=username).exists():
                Login.objects.create(username=username, password=password)
            return redirect('login')
    return render(request, 'register.html')

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username','').strip()
        password = request.POST.get('password','').strip()
        try:
            user = Login.objects.get(username=username, password=password)
            request.session['username'] = user.username
            return redirect('home')
        except Login.DoesNotExist:
            return render(request, 'login.html', {'error': 'Invalid credentials'})
    return render(request, 'login.html')

def home_view(request):
    username = request.session.get('username')
    if not username:
        return redirect('login')
    return render(request, 'home.html', {'username': username})

def logout_view(request):
    if request.method == 'POST':
        request.session.flush()
        return redirect('login')
    return redirect('login')
