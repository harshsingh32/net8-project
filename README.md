# SampleApp CI/CD Project

## Technologies

- AWS EC2
- Jenkins
- GitHub
- ASP.NET Core MVC (.NET 8)
- Docker
- Apache Reverse Proxy

## Pipeline

GitHub
→ Jenkins
→ Build
→ Publish
→ ZIP
→ Transfer
→ Deploy

## Deployment

Deployment scripts are located in:

deployment/

## Health Check

http://localhost/health

## Rollback

Automatic rollback occurs when deployment fails.