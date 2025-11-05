# GitHub Actions Setup Guide

This document explains how to configure GitHub Actions to automatically build and deploy your JFrog AppTrust services.

## 📋 Overview

You have multiple GitHub Actions workflows configured:

1. **build-all.yml** - Builds all services in parallel
2. **build-jfrog.yml** - Pushes images to JFrog Artifactory
3. **build-cashier-web.yml** - Builds cashier-web service
4. **build-kitchen-worker.yml** - Builds kitchen-worker service
5. **build-reservation-api.yml** - Builds reservation-api service

## 🔐 Required Secrets

### For Docker Hub Push
Add these secrets to your GitHub repository settings:

```
DOCKER_USERNAME      → Your Docker Hub username
DOCKER_PASSWORD      → Your Docker Hub personal access token
```

**How to generate a Docker PAT:**
1. Go to https://hub.docker.com/settings/security
2. Click "New Access Token"
3. Copy the token and add it as `DOCKER_PASSWORD` secret

### For JFrog Artifactory Push
Add these secrets for JFrog integration:

```
JFROG_REGISTRY_URL   → https://your-domain.jfrog.io/artifactory/docker/
JFROG_USERNAME       → Your JFrog username
JFROG_PASSWORD       → Your JFrog API key or password
```

**How to get JFrog credentials:**
1. Log in to your JFrog instance
2. Go to Profile → Access Tokens
3. Generate a new access token
4. Use this as `JFROG_PASSWORD`

## 📦 Adding Secrets to GitHub

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret:
   - Name: (e.g., `DOCKER_USERNAME`)
   - Value: (your actual value)
5. Click **Add secret**

## 🚀 Workflow Triggers

Each workflow is triggered by:

### build-all.yml
- Push to `main`, `master`, or `develop` branch
- Pull requests to those branches
- Manual trigger via `workflow_dispatch`

### build-jfrog.yml
- Push to `main`, `master`, or `develop` branch
- Tag pushes (e.g., `v1.0.0`)
- Manual trigger

### Individual Service Workflows
- Push to their respective directories
- Pull requests affecting those directories
- Manual trigger

## 📝 Workflow Examples

### Example 1: Automatic Build on Push

When you push code to `main`:

```bash
git add .
git commit -m "Update cashier-web service"
git push origin main
```

GitHub Actions will:
1. ✅ Run tests
2. ✅ Build Docker image
3. ✅ Push to Docker Hub
4. ✅ Generate metadata and labels

### Example 2: Push to JFrog on Release

Create a new release:

```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions will:
1. ✅ Build all services
2. ✅ Push to JFrog with version tags
3. ✅ Create GitHub Release with artifact info

## 🎯 Image Naming Convention

### Docker Hub
```
{DOCKER_USERNAME}/apptrust-{SERVICE}:{TAG}
```

Examples:
- `yourusername/apptrust-cashier-web:latest`
- `yourusername/apptrust-kitchen-worker:main`
- `yourusername/apptrust-reservation-api:abc123d` (git SHA)

### JFrog Artifactory
```
{JFROG_REGISTRY}/apptrust/{SERVICE}:{TAG}
```

Examples:
- `your-domain.jfrog.io/artifactory/docker/apptrust/cashier-web:1.0.0`
- `your-domain.jfrog.io/artifactory/docker/apptrust/kitchen-worker:2024.11.05`

## 🏷️ Tag Strategies

The workflows automatically generate multiple tags:

```yaml
tags:
  - type=ref,event=branch              # Branch name (main, develop)
  - type=semver,pattern={{version}}    # Semantic version from tags
  - type=sha                           # Short git SHA
  - type=raw,value=latest              # Latest on default branch
```

## 🔧 Customization

### Change Docker Registry

Edit the workflow and replace:
```yaml
REGISTRY: docker.io
```

With your registry:
```yaml
REGISTRY: my-registry.example.com
```

### Change Image Names

Edit the matrix section:
```yaml
image_name: apptrust-cashier-web
```

### Add More Services

Add to the matrix in `build-all.yml`:
```yaml
- name: my-new-service
  dockerfile: ./my-new-service/Dockerfile
  context: ./my-new-service
  image_name: apptrust-my-new-service
```

## 📊 Monitoring Builds

### View Workflow Runs

1. Go to **Actions** tab in GitHub
2. Click on workflow name
3. See all runs with status

### View Logs

1. Click on a run
2. Click on the job (build-matrix, build-and-push-jfrog, etc.)
3. View detailed logs

### Badges

Add to your README:

```markdown
[![Build All Services](https://github.com/YOUR_ORG/YOUR_REPO/actions/workflows/build-all.yml/badge.svg)](https://github.com/YOUR_ORG/YOUR_REPO/actions/workflows/build-all.yml)
[![Build JFrog](https://github.com/YOUR_ORG/YOUR_REPO/actions/workflows/build-jfrog.yml/badge.svg)](https://github.com/YOUR_ORG/YOUR_REPO/actions/workflows/build-jfrog.yml)
```

## ✅ Testing Workflows

### Run Individual Workflow

1. Go to **Actions** tab
2. Select workflow
3. Click **Run workflow**
4. Select branch
5. Click **Run workflow**

### Debug Failed Builds

1. Open the failed run
2. Check error logs
3. Common issues:
   - Missing secrets
   - Docker build context path incorrect
   - Dependencies not installed

## 🐸 JFrog Integration Best Practices

1. **Use Semantic Versioning**: Tag releases as `v1.0.0`, `v1.1.0`, etc.
2. **Create Release Notes**: Workflows will populate release info
3. **Monitor Image Size**: Use `.dockerignore` to minimize images
4. **Set Pull Policies**: In Kubernetes, use `imagePullPolicy: Always` for latest
5. **Document API Changes**: Update docs on service API changes

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Build Push Action](https://github.com/docker/build-push-action)
- [JFrog Documentation](https://jfrog.com/help/)
- [Docker Hub Documentation](https://docs.docker.com/docker-hub/)

## 🆘 Troubleshooting

### Issue: "Unable to authenticate"
**Solution**: Check secrets are correctly set. Re-generate tokens if expired.

### Issue: "Docker image not found"
**Solution**: Verify `context` and `file` paths in workflow match your repository structure.

### Issue: "Insufficient permissions"
**Solution**: Ensure Docker Hub/JFrog user has push permissions to the registry.

### Issue: "Workflow not triggering"
**Solution**: Check:
1. Workflow file syntax (YAML validation)
2. Branch protection rules
3. `on:` trigger conditions

## 🚀 Next Steps

1. Add secrets to GitHub
2. Test by pushing to a develop branch
3. Monitor Actions tab
4. Create a release to test JFrog workflow
5. Verify images appear in registries

---

**Happy deploying! 🐸🚀**
