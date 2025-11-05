# GitHub Actions Quick Start 🚀

Get your CI/CD pipeline running in 5 minutes!

## 1️⃣ Add GitHub Secrets (2 minutes)

Go to your GitHub repository:
1. **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Add these secrets:

### Option A: Docker Hub (Free)
```
DOCKER_USERNAME  = your-dockerhub-username
DOCKER_PASSWORD  = your-dockerhub-token
```

Get token: https://hub.docker.com/settings/security → New Access Token

### Option B: JFrog (Enterprise)
```
JFROG_REGISTRY_URL = https://your-domain.jfrog.io/artifactory/docker/
JFROG_USERNAME     = your-jfrog-username
JFROG_PASSWORD     = your-jfrog-api-key
```

## 2️⃣ Test the Workflow (1 minute)

```bash
# Push code to main branch
git add .
git commit -m "Enable GitHub Actions CI/CD"
git push origin main
```

Or trigger manually:
1. Go to **Actions** tab
2. Select **Build All Services**
3. Click **Run workflow**

## 3️⃣ Monitor Build Status (1 minute)

1. Go to **Actions** tab
2. Watch the workflow run
3. Each service builds in parallel:
   - ✅ Cashier-Web (Python)
   - ✅ Kitchen-Worker (Go)
   - ✅ Reservation-API (Node.js)

## 4️⃣ View Built Images (1 minute)

### Docker Hub
```
https://hub.docker.com/r/YOUR_USERNAME
```

Look for:
- `apptrust-cashier-web:latest`
- `apptrust-kitchen-worker:latest`
- `apptrust-reservation-api:latest`

### JFrog Artifactory
```
https://your-domain.jfrog.io/artifactory/docker/apptrust/
```

## 📊 Available Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `build-all.yml` | Push/PR to main,develop | Build all services in parallel |
| `build-jfrog.yml` | Push to main + tags | Push to JFrog Artifactory |
| `build-cashier-web.yml` | Changes in /cashier-web | Auto-test & build Python service |
| `build-kitchen-worker.yml` | Changes in /kitchen-worker | Auto-test & build Go service |
| `build-reservation-api.yml` | Changes in /reserveration-api | Auto-test & build Node service |

## 🎯 Common Tasks

### Deploy Latest Image
```bash
git add .
git commit -m "Update service"
git push origin main
# GitHub Actions automatically builds and pushes!
```

### Create Release
```bash
git tag v1.0.0
git push origin v1.0.0
# All services tagged with v1.0.0
```

### Rebuild Manually
1. **Actions** tab
2. Select workflow
3. **Run workflow** button
4. Select branch
5. Click **Run workflow**

### Check Build Logs
1. Go to **Actions** tab
2. Click workflow run
3. Click job name
4. Expand failed step

## 🔒 Security Best Practices

✅ **Use Personal Access Tokens** (not passwords)
✅ **Rotate tokens regularly** (every 90 days)
✅ **Use environment secrets** for sensitive data
✅ **Review logs** for leaked credentials

## 🐸 Example Commands

### Push to develop (triggers build)
```bash
git checkout develop
git add .
git commit -m "New feature"
git push origin develop
```

### Create release tag
```bash
git tag v1.2.3
git push origin v1.2.3
```

### Manual workflow trigger
```bash
# Via GitHub CLI
gh workflow run build-all.yml --ref main
```

## 📈 Monitoring

### Workflow Statistics
- **Actions** → Select workflow → **All workflow runs**

### Build Badges
Add to README:
```markdown
![Build All Services](https://github.com/YOUR_ORG/YOUR_REPO/actions/workflows/build-all.yml/badge.svg)
```

## ❓ Troubleshooting

### Build Failed?
1. Check **Actions** tab
2. Click failed run
3. Scroll to error message
4. Common causes:
   - Missing secrets
   - Syntax errors in Dockerfile
   - Failed tests

### Images Not Showing?
1. Verify secrets are set correctly
2. Check Docker Hub/JFrog login
3. Check image names match workflow

### Need Help?
See full guide: `.github/GITHUB_ACTIONS_SETUP.md`

---

**That's it! Your CI/CD pipeline is ready!** 🎉

Push code → Tests run → Images built → Auto-deployed 🚀
