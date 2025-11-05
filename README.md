# 🐸 JFrog AppTrust Demo

A modern, multi-service microservices demo showcasing containerized applications with automated CI/CD pipelines. Built with Python, Go, and Node.js to demonstrate JFrog's artifact management and deployment capabilities.

![Build All Services](https://github.com/yonarbel/apptrustDemo/actions/workflows/build-all.yml/badge.svg)
![Build JFrog](https://github.com/yonarbel/apptrustDemo/actions/workflows/build-jfrog.yml/badge.svg)

## 🎯 Overview

JFrog AppTrust is a restaurant ordering system that demonstrates:

- **Multi-language microservices** - Python (FastAPI), Go, Node.js (Express)
- **Docker containerization** - Multi-stage builds, optimized images
- **Automated CI/CD** - GitHub Actions with parallel builds
- **JFrog integration** - Artifactory-ready for artifact management
- **Modern UI** - Interactive web interface with frog-themed design
- **Comprehensive testing** - Unit tests for all services

### Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENT REQUESTS                         │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                ┌─────────┴──────────┐
                │                    │
        ┌───────▼────────┐  ┌────────▼─────────┐
        │                │  │                  │
    ┌──►│ Reservation-   │  │   Cashier-Web    │◄──┐
    │   │ API (Node.js)  │  │  (Python/FastAPI)│   │
    │   │ Port: 3001     │  │  Port: 3002      │   │
    │   │                │  │                  │   │
    │   └────────────────┘  └──────────────────┘   │
    │                                               │
    │   ┌──────────────────────────────────────┐   │
    │   │    Kitchen-Worker (Go)               │   │
    │   │    Order Processing Background Job   │   │
    │   └──────────────────────────────────────┘   │
    │                                               │
    └───────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Git
- Node.js 20+
- Python 3.12+
- Go 1.22+

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/yonarbel/apptrustDemo.git
   cd apptrustDemo
   ```

2. **Start all services**
   ```bash
   make up
   ```

3. **Access the services**
   - 🍴 Reservation API: http://localhost:3001
   - 💳 Cashier Web UI: http://localhost:3002

4. **Run tests**
   ```bash
   make test
   ```

5. **Stop services**
   ```bash
   make down
   ```

### Available Make Commands

```bash
make help              # Show all available commands
make build             # Build all Docker images
make build-cashier     # Build cashier-web only
make build-kitchen     # Build kitchen-worker only
make build-reservation # Build reservation-api only

make test              # Run all tests
make test-cashier      # Test cashier-web
make test-kitchen      # Test kitchen-worker
make test-reservation  # Test reservation-api

make up                # Start all services with docker-compose
make down              # Stop all services
make clean             # Clean up Docker resources
```

## 📦 Services

### 1. Reservation-API (Node.js)

**Port**: 3001
**Framework**: Express.js
**Language**: Node.js 20

Manages restaurant reservations with in-memory storage.

**Endpoints**:
- `POST /reserve` - Create a new reservation
  ```json
  {
    "name": "Alice Johnson",
    "time": "2025-11-05T19:00",
    "guests": 4
  }
  ```
- `GET /reservations` - List all reservations
- `GET /health` - Health check

**Tests**: `npm test`

### 2. Cashier-Web (Python)

**Port**: 3002
**Framework**: FastAPI
**Language**: Python 3.12
**UI**: Interactive HTML/CSS/JavaScript

Beautiful frog-themed bill calculator with a stunning web UI.

**Features**:
- 🎨 Animated frog mascot with hopping animation
- 🍽️ 8 frog-themed menu items
- 💳 Real-time bill calculation
- 🧮 Automatic tax calculation (10%)
- 🐸 JFrog branded interface

**Endpoints**:
- `GET /` - Interactive UI (open in browser)
- `POST /bill` - Calculate bill for items
  ```json
  {
    "items": ["fly-burger", "lily-fries", "tadpole-shake"]
  }
  ```
- `GET /menu` - Get all menu items with prices
- `GET /health` - Health check

**Tests**: `pytest test_app.py -v`

**Menu Items**:
```
🍔 Fly Burger ($12.00)       - Catch of the day!
🍟 Lily Pad Fries ($5.00)    - Golden & crispy
🥤 Tadpole Shake ($3.50)     - Sweet refreshment
🍕 Dragonfly Pizza ($14.00)  - Speedy delivery!
🍗 Mosquito Wings ($8.50)    - Protein-packed!
🥗 Swamp Salad ($7.00)       - Fresh from the bog
🥔 Cricket Chips ($4.50)     - Jumpy good!
🐟 Catfish Combo ($16.00)    - Aquatic adventure
```

### 3. Kitchen-Worker (Go)

**Language**: Go 1.22

Background worker that processes kitchen orders from a queue.

**Features**:
- Order queue processing
- Simulated cooking time
- JSON order inspection

**Commands**:
```bash
# Process next order
kitchen-worker

# View pending orders
kitchen-worker peek
```

**Tests**: `go test -v`

## 🔄 Workflow Example

### Scenario: Customer Places Reservation & Orders Food

```
1. Customer calls to reserve table
   POST http://localhost:3001/reserve
   {
     "name": "Bob Smith",
     "time": "2025-11-05T20:30",
     "guests": 2
   }

2. Cashier checks menu
   GET http://localhost:3002/menu
   Response: { "fly-burger": 12.0, "lily-fries": 5.0, ... }

3. Customer orders: 2 burgers + fries
   POST http://localhost:3002/bill
   {
     "items": ["fly-burger", "fly-burger", "lily-fries"]
   }

   Response:
   {
     "line_items": [
       {"item": "fly-burger", "price": 12.0},
       {"item": "fly-burger", "price": 12.0},
       {"item": "lily-fries", "price": 5.0}
     ],
     "total": 29.0
   }

4. Kitchen worker processes order
   kitchen-worker
   Output: [kitchen-worker] Preparing order 101 for table 5: [burger, fries]
           [kitchen-worker] DONE order 101
```

## 🐳 Docker & Docker Compose

### Build Individual Services

```bash
# Build a single service
docker build -t apptrust-cashier-web:latest ./cashier-web
docker build -t apptrust-kitchen-worker:latest ./kitchen-worker
docker build -t apptrust-reservation-api:latest ./reserveration-api

# Run a service
docker run -p 3001:3001 apptrust-reservation-api:latest
docker run -p 3002:3002 apptrust-cashier-web:latest
```

### Docker Compose

```bash
# Start all services
docker-compose up

# Start in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild images
docker-compose up --build
```

## 🚀 CI/CD with GitHub Actions

### Automated Workflows

All workflows are configured in `.github/workflows/`:

#### 1. **build-all.yml** - Build All Services
- **Trigger**: Push to `main`, `master`, `develop` branches
- **Actions**:
  - Builds all 3 services in parallel
  - Runs tests for each service
  - Pushes to Docker Hub (on merge)
  - Generates metadata and tags

#### 2. **build-jfrog.yml** - JFrog Artifactory Integration
- **Trigger**: Push to main/develop + version tags (`v1.0.0`)
- **Actions**:
  - Builds and pushes to JFrog
  - Multiple tag strategies (version, date, latest, git SHA)
  - Auto-creates GitHub releases
  - OCI metadata labels

#### 3. **Individual Service Workflows**
- `build-cashier-web.yml` - Triggers on changes to `/cashier-web`
- `build-kitchen-worker.yml` - Triggers on changes to `/kitchen-worker`
- `build-reservation-api.yml` - Triggers on changes to `/reserveration-api`

### Setup GitHub Actions

1. **Add secrets** to your GitHub repository:
   ```
   Settings → Secrets and variables → Actions
   ```

2. **For Docker Hub**:
   ```
   DOCKER_USERNAME = your-dockerhub-username
   DOCKER_PASSWORD = your-personal-access-token
   ```

3. **For JFrog** (optional):
   ```
   JFROG_REGISTRY_URL = https://your-domain.jfrog.io/artifactory/docker/
   JFROG_USERNAME = your-jfrog-username
   JFROG_PASSWORD = your-jfrog-api-key
   ```

4. **View workflows**:
   - Go to **Actions** tab in GitHub
   - See all builds, tests, and deployments

### Manual Workflow Trigger

```bash
# Trigger build-all workflow
gh workflow run build-all.yml --ref main

# View workflow runs
gh run list --repo yonarbel/apptrustDemo

# View specific run logs
gh run view <RUN_ID>
```

## 📋 Testing

### Run All Tests

```bash
make test
```

### Individual Tests

```bash
# Python tests (cashier-web)
cd cashier-web
pip install -r requirements.txt
pytest test_app.py -v

# Go tests (kitchen-worker)
cd kitchen-worker
go test -v

# Node.js tests (reservation-api)
cd reserveration-api
npm install
npm test
```

### Test Coverage

- **cashier-web**: Menu validation, bill calculation, unknown items
- **kitchen-worker**: Order queue processing
- **reservation-api**: Reservation creation, listing

## 📚 Project Structure

```
apptrustDemo/
├── README.md                          # This file
├── Makefile                           # Build orchestration
├── docker-compose.yml                 # Local dev setup
├── PROJECT_STATUS.md                  # Project details
│
├── .github/
│   ├── workflows/
│   │   ├── build-all.yml             # Build all services
│   │   ├── build-jfrog.yml           # JFrog integration
│   │   ├── build-cashier-web.yml     # Python service
│   │   ├── build-kitchen-worker.yml  # Go service
│   │   └── build-reservation-api.yml # Node service
│   ├── QUICK_START.md                # 5-min setup guide
│   └── GITHUB_ACTIONS_SETUP.md       # Full CI/CD guide
│
├── cashier-web/
│   ├── app.py                        # FastAPI application
│   ├── test_app.py                   # Unit tests
│   ├── requirements.txt               # Python dependencies
│   ├── Dockerfile                    # Container config
│   ├── .dockerignore                 # Optimization
│   └── static/
│       └── index.html                # Beautiful UI
│
├── kitchen-worker/
│   ├── main.go                       # CLI application
│   ├── main_test.go                  # Unit tests
│   ├── go.mod                        # Go dependencies
│   ├── Dockerfile                    # Container config
│   └── .dockerignore                 # Optimization
│
└── reserveration-api/
    ├── server.js                     # Express server
    ├── test.js                       # Unit tests
    ├── package.json                  # Dependencies
    ├── package-lock.json             # Locked versions
    ├── Dockerfile                    # Container config
    └── .dockerignore                 # Optimization
```

## 🎨 UI Features

The cashier-web service includes a stunning interactive UI:

- **Animated Frog Mascot** 🐸 - Hopping animation on the homepage
- **JFrog Branding** - Green gradient theme matching JFrog colors
- **Interactive Menu** - Click +/- buttons to add items
- **Real-time Calculation** - Instant bill total with 10% tax
- **Frog-themed Menu** - Funny frog-related food names
- **Jokes of the Day** - Programming & frog humor
- **Beautiful Design** - Responsive, modern UI

**Open in browser**: http://localhost:3002

## 🔧 Troubleshooting

### Port Already in Use

```bash
# Find process using port
lsof -i :3001
lsof -i :3002

# Kill process
kill -9 <PID>
```

### Docker Issues

```bash
# Clean up all containers
docker system prune -a

# Rebuild without cache
docker-compose build --no-cache

# View logs
docker-compose logs -f service-name
```

### GitHub Actions Not Triggering

1. Check workflow file syntax (YAML validation)
2. Verify branch protection rules aren't blocking
3. Confirm secrets are set correctly
4. Check `.github/workflows/` files exist

## 📖 Documentation

- **QUICK_START.md** - Get running in 5 minutes
- **GITHUB_ACTIONS_SETUP.md** - Full CI/CD configuration guide
- **PROJECT_STATUS.md** - Detailed project overview

## 🎯 Use Cases

### Local Development
```bash
make up
# All services running locally, ready for development
```

### Testing Changes
```bash
# Make code changes
git add .
git commit -m "Update service"
git push origin main

# GitHub Actions automatically:
# 1. Runs tests
# 2. Builds Docker images
# 3. Pushes to registries
```

### Creating Releases
```bash
git tag v1.0.0
git push origin v1.0.0

# Triggers:
# - Build all services
# - Push to JFrog with version tags
# - Create GitHub release
```

## 🔐 Security

- ✅ Environment-based configuration
- ✅ No hardcoded credentials
- ✅ Use GitHub secrets for sensitive data
- ✅ Regular dependency updates recommended
- ✅ Container image scanning (JFrog)

## 📞 Support

For questions or issues:

1. Check existing documentation
2. Review GitHub Actions logs
3. Inspect Docker logs
4. Check individual service logs

## 📝 License

This is a demo project for JFrog. Feel free to use for educational and demonstration purposes.

## 🐸 Credits

Built with ❤️ and 🐸 jokes for the JFrog community.

---

**Ready to hop into microservices?** Clone the repo and run `make up`! 🚀
