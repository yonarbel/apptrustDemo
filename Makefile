.PHONY: help build build-cashier build-kitchen build-reservation test test-cashier test-kitchen test-reservation clean up down

help:
	@echo "AppTrust Project - Build & Test Management"
	@echo "=========================================="
	@echo ""
	@echo "Build targets:"
	@echo "  make build                 - Build all Docker images"
	@echo "  make build-cashier         - Build cashier-web image"
	@echo "  make build-kitchen         - Build kitchen-worker image"
	@echo "  make build-reservation     - Build reservation-api image"
	@echo ""
	@echo "Test targets:"
	@echo "  make test                  - Run tests for all projects"
	@echo "  make test-cashier          - Run cashier-web tests"
	@echo "  make test-kitchen          - Run kitchen-worker tests"
	@echo "  make test-reservation      - Run reservation-api tests"
	@echo ""
	@echo "Docker Compose targets:"
	@echo "  make up                    - Start all services with docker-compose"
	@echo "  make down                  - Stop all services"
	@echo "  make clean                 - Clean up Docker images and containers"
	@echo ""

# Build targets
build: build-cashier build-kitchen build-reservation
	@echo "✓ All images built successfully"

build-cashier:
	@echo "Building cashier-web..."
	docker build -t apptrust/cashier-web:latest ./cashier-web

build-kitchen:
	@echo "Building kitchen-worker..."
	docker build -t apptrust/kitchen-worker:latest ./kitchen-worker

build-reservation:
	@echo "Building reservation-api..."
	docker build -t apptrust/reservation-api:latest ./reserveration-api

# Test targets
test: test-cashier test-kitchen test-reservation
	@echo "✓ All tests passed"

test-cashier:
	@echo "Running cashier-web tests..."
	cd cashier-web && python -m pytest test_app.py -v

test-kitchen:
	@echo "Running kitchen-worker tests..."
	cd kitchen-worker && go test -v

test-reservation:
	@echo "Running reservation-api tests..."
	cd reserveration-api && npm test

# Docker Compose targets
up:
	docker-compose up -d
	@echo "✓ All services started"
	@echo ""
	@echo "Services running:"
	@echo "  - reservation-api: http://localhost:3001"
	@echo "  - cashier-web: http://localhost:3002"
	@echo "  - kitchen-worker: background worker"

down:
	docker-compose down
	@echo "✓ All services stopped"

# Cleanup
clean:
	@echo "Cleaning up Docker resources..."
	docker-compose down --volumes
	docker rmi apptrust/cashier-web:latest 2>/dev/null || true
	docker rmi apptrust/kitchen-worker:latest 2>/dev/null || true
	docker rmi apptrust/reservation-api:latest 2>/dev/null || true
	@echo "✓ Cleanup completed"
