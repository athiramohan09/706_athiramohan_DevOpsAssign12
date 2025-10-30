# DevOps_Assignment_ITB706

This repository is a complete submission for the assignment:
**Design and Provision of a Multi-Server Django–PostgreSQL Application on AWS using Terraform and Ansible**,
and **Automation of Container Orchestration and CI/CD Deployment using Docker Swarm, Docker Compose, and GitHub Actions/Jenkins**.

> Branch name for submission: `ITB706`

This package contains template code and a full functional Django app (login/register/home/logout)
wired to a `login` table in PostgreSQL. The repo is intended for submission only (no infra will be provisioned here).

## Layout
```
DevOps_Assignment_ITB706/
├─ terraform/
├─ ansible/
│  ├─ playbooks/
├─ docker/
│  ├─ web/
│  └─ db/
├─ django_app/
│  ├─ manage.py
│  ├─ requirements.txt
│  ├─ mysite/
│  └─ accounts/
├─ scripts/
├─ ci/
└─ selenium/
```

## Notes
- The Django app is functional and can run locally with Docker or via a virtualenv.
- Replace placeholders (like AWS AMIs, Docker registry user names, secrets) before attempting real deployment.
- Do not commit real secrets or AWS keys to the repo.
- This repo is organized for educational/demo purposes and follows the assignment requirements.

## Quick local run (using Docker Compose)
1. Install Docker & Docker Compose.
2. From repo root run: `docker compose -f docker/docker-compose.yml up --build`
3. Access the app on `http://localhost/` after containers are up.
4. Register a user, then login using Roll No as username and Admission No as password.

