# 🏥 EHR Consent Platform

> **A comprehensive blockchain-enabled consent management system for Electronic Health Records**

This monorepo contains a full-stack platform that enables secure, transparent, and auditable consent management for healthcare data sharing between patients, providers, and institutions.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Node.js](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen.svg)
![TypeScript](https://img.shields.io/badge/typescript-5.x-blue.svg)
![Solidity](https://img.shields.io/badge/solidity-0.8.24-red.svg)

## ✨ Recent Platform Enhancements

- **Consent caching for PDP decisions** – The EHR Gateway now ships with an in-memory consent cache, configurable via `CONSENT_CACHE_TTL_MS`, with automated invalidation hooks to keep decisions fast without sacrificing accuracy.
- **Prometheus observability** – The `metrics.ts` module exposes decision counters, denial breakdowns, cache hit/miss tracking, and indexer latency histograms. Toggle collection with `METRICS_ENABLED` and reference the new `docs/services/ehr-gateway-metrics.md` playbook for dashboard ideas.
- **Documentation catalog refresh** – Service, architecture, and forms documentation now provide linked indices (`docs/services`, `docs/architecture`, `docs/Forms`) so teams can navigate design artifacts quickly.
- **Expanded PDP test coverage** – Unit suites for the consent service, metrics recorder, audit logger, and config bootstrapping lift statement coverage above 90% across the decision path.

## 🏗️ Architecture Overview

```mermaid
graph TB
    subgraph "Frontend Applications"
        A[Patient Portal] --> D[EHR Gateway]
        B[Clinic Console] --> D
        C[Admin Dashboard] --> D
    end

    subgraph "Backend Services"
        D --> E[Auth Service]
        D --> F[Consent Indexer]
        D --> G[Audit Pipeline]
    end

    subgraph "Blockchain Layer"
        F --> H[ConsentRegistry]
        F --> I[ProviderIdentity]
        F --> J[HospitalRegistry]
    end

    subgraph "Infrastructure"
        G --> K[S3 Archive]
        D --> L[FHIR Server]
    end
```

## � Documentation Index

- [API Specs](./docs/api-specs/README.md) – Reference documentation for on-chain contracts powering consent workflows.
- [Architecture](./docs/architecture/README.md) – Conceptual models, clarifications, roadmap, and release notes.
- [Service Guides](./docs/services/README.md) – Gateway behavior, metrics catalog, and consent indexer notes.
- [Consent Forms](./docs/Forms/README.md) – Regulatory templates and phased rollout planning artifacts.
- [Compliance](./docs/compliance/README.md) – Regulatory governance and audit guidance (in progress).

## �📁 Repository Structure

```text
ehr-consent-platform/
├── 📄 README.md                    # This file
├── 📄 package.json                 # Root workspace configuration
├── 📄 turbo.json                   # Turborepo build orchestration
├── 📄 pnpm-workspace.yaml          # pnpm workspace configuration
├── 📄 .gitignore                   # Comprehensive gitignore
│
├── 🔗 contracts/                   # Solidity smart contracts
│   ├── src/ConsentRegistry.sol     # Core consent state management
│   ├── src/ProviderIdentity.sol    # Healthcare provider verification
│   ├── src/HospitalRegistry.sol    # Hospital organization registry
│   ├── test/                       # Contract unit tests
│   └── scripts/                    # Deployment scripts
│
├── 🛠️ services/                    # Backend microservices
│   ├── ehr-gateway/                # FHIR proxy + consent validation
│   ├── consent-indexer/            # Blockchain event synchronization
│   ├── audit-pipeline/             # Event logging and archival
│   └── auth-service/               # OAuth2/SSO authentication
│
├── 🎨 frontends/                   # Frontend applications
│   ├── patient-portal/             # Patient-facing Next.js app
│   ├── clinic-console/             # Healthcare provider dashboard
│   └── admin-dashboard/            # System administration panel
│
├── 📦 sdk/                         # Software Development Kits
│   ├── js-sdk/                     # JavaScript/TypeScript client
│   └── py-sdk/                     # Python integration library
│
├── 🏗️ infra/                       # Infrastructure as Code
│   ├── terraform/                  # Cloud infrastructure definitions
│   ├── docker-compose.yml          # Local development environment
│   └── k8s/                        # Kubernetes manifests
│
├── 🧪 qa/                          # Quality Assurance
│   ├── load-tests/                 # Performance testing (k6)
│   ├── synthetic-data/             # FHIR test datasets
│   └── integration-tests/          # End-to-end test suites
│
├── 🔧 tools/                       # Development tooling
│   ├── cli/                        # Internal CLI for operations
│   └── plop-templates/             # Code generation templates
│
└── 📝 scripts/                     # Utility scripts
    ├── setup-dev.sh                # Development environment setup
    ├── deploy.sh                   # Deployment automation
    └── db-migrate.sh                # Database migration runner
```

- --

## 🚀 Quick Start

### Prerequisites

Before setting up the project, ensure you have the following installed:

- **Node.js** `>= 18.0.0` ([Download](https://nodejs.org/))
- **pnpm** `>= 8.0.0` ([Install Guide](https://pnpm.io/installation))
- **Git** ([Download](https://git-scm.com/downloads))
- **Docker** & **Docker Compose** ([Install Guide](https://docs.docker.com/get-docker/))
- **GitHub Container Registry access** (`docker login ghcr.io` with a PAT granting `read:packages`)
- **Python** `>= 3.9` (for backend services)
- **Postgres client utilities** (optional, for inspecting the indexer database)

### 1. 📥 Clone the Repository

```bash

# Clone from GitHub

git clone https://github.com/your-org/ehr-consent-platform.git
cd ehr-consent-platform

# Or if starting fresh, initialize the repo

git init
git remote add origin https://github.com/your-org/ehr-consent-platform.git
```

## 2. 📦 Install Dependencies

```bash

# Install all workspace dependencies

pnpm install

# Verify installation

pnpm list --depth=0

## 3. 🔧 Environment Setup

```bash

# Copy environment templatesn

cp .env.example .env.local

# Configure environment variables for each service

cp services/ehr-gateway/.env.example services/ehr-gateway/.env.local
cp services/auth-service/.env.example services/auth-service/.env.local
cp frontends/patient-portal/.env.local.example frontends/patient-portal/.env.local

```text

- *Required Environment Variables:**

```bash

# Database

DATABASE_URL="postgresql://username:password@localhost:5432/ehr_consent_db"

# Blockchain

BLOCKCHAIN_RPC_URL="http://localhost:8545"
PRIVATE_KEY="your-deployment-private-key"

# Authentication

NEXTAUTH_SECRET="your-nextauth-secret"
NEXTAUTH_URL="http://localhost:3000"

# FHIR Server

FHIR_SERVER_URL="http://localhost:8080/fhir"

# AWS (for production)

AWS_ACCESS_KEY_ID="your-aws-key"
AWS_SECRET_ACCESS_KEY="your-aws-secret"
AWS_REGION="us-east-1"

```text

## 4. 🐳 Start Development Infrastructure

```bash

# Start local blockchain, FHIR server, and databases

docker compose -f infra/docker-compose.yml up -d

# Verify services are running

docker compose -f infra/docker-compose.yml ps

```text

> The `pnpm dev` launcher runs `docker compose -f infra/docker-compose.yml up -d` automatically, so you can skip this manual step when using it.

If `docker compose` reports `manifest unknown` while pulling images, authenticate with GHCR and retry:

```bash

docker login ghcr.io -u <github-username> -p <personal-access-token>

```text

## 5. ⛓️ Deploy Smart Contracts

```bash

# Compile contracts

pnpm --filter contracts build

# Deploy to local network

pnpm --filter contracts deploy:local

# Verify deployment

pnpm --filter contracts test

```text

## 6. 🏃‍♂️ Run the Application

Make sure Docker Desktop (or the Docker Engine service) is running and that you have already executed `pnpm install`.

```bash

# Launch Docker Compose and all dev processes in one command

pnpm dev

# Forward additional turborepo flags if needed

pnpm dev -- --filter frontends/*

```text

The launcher ensures the Docker stack is online before delegating to Turbo. You can still start targeted workspaces directly:

```bash

pnpm --filter ehr-gateway dev
pnpm --filter patient-portal dev
pnpm --filter @ehr/consent-indexer dev

```text

The consent indexer expects:

- `DATABASE_URL` pointing at the Postgres instance from `infra/docker-compose.yml` (defaults match the compose file).
- `CONSENT_REGISTRY_ADDRESS` for the deployed contract (auto-detected from `contracts/deployed-contracts.json`).
- `RPC_URL` of the local Anvil node (`http://localhost:8545`).

## 7. ✅ Smoke Test

Once the stack is running, validate the environment with the smoke script:

```bash

pnpm smoke

```text

The script performs two checks:

- Gateway health endpoint at `http://localhost:4000/health` (override with `SMOKE_GATEWAY_URL`).
- Local chain JSON-RPC at `http://localhost:8545` (override with `SMOKE_RPC_URL`).

It exits non-zero on failure, which makes it suitable for future CI gating.

- *Access Points:**

- **Patient Portal:** <http://localhost:3000>
- **Clinic Console:** <http://localhost:3001>
- **Admin Dashboard:** <http://localhost:3002>
- **API Gateway:** <http://localhost:4000>
- **Storybook:** <http://localhost:6006>

- --

## 🛠️ Development Tools

### Package Management

```bash

# Add dependency to specific workspace

pnpm --filter patient-portal add react-query

# Add dev dependency to root

pnpm add -D -W prettier

# Update all dependencies

pnpm update -r

```text

## Building & Testing

```bash

# Build all packages

pnpm build

# Run all tests

pnpm test

# Lint all code

pnpm lint

# Format code

pnpm format

```text

## Storybook Development

```bash

# Start Storybook for component development

pnpm --filter patient-portal storybook

# Build Storybook static site

pnpm --filter patient-portal build-storybook

```text

## Database Operations

```bash

# Run database migrations

./scripts/db-migrate.sh

# Seed development data

pnpm --filter ehr-gateway db:seed

# Reset database

pnpm --filter ehr-gateway db:reset

```text

- --

## 🔗 GitHub Repository Setup

### Initial Repository Creation

<!-- markdownlint-disable MD029 -->

1. **Create GitHub Repository:**

   ```bash
   # Using GitHub CLI
   gh repo create your-org/ehr-consent-platform --private --description "EHR Consent Management Platform"

   # Or create manually at https://github.com/new
   ```

2. **Configure Repository Settings:**

   - Enable **Issues** and **Projects**
   - Set up **Branch Protection Rules** for `main`
   - Configure **Required Status Checks**
   - Enable **Automatic Security Updates**

3. **Set up GitHub Actions:**

   ```bash
   # CI/CD pipeline is already configured in .github/workflows/
   git add .github/
   git commit -m "Add CI/CD pipeline"
   git push origin main
   ```

<!-- markdownlint-enable MD029 -->

### Branch Strategy

```bash

# Development workflow

git checkout -b feature/consent-ui-improvements

# Make changes...

git add .
git commit -m "feat: improve consent form validation"
git push origin feature/consent-ui-improvements

# Create PR on GitHub

```text

## Recommended GitHub Settings

```yaml

# .github/settings.yml (with probot/settings app)

repository:
  description: "Blockchain-enabled EHR consent management platform"
  topics: ["healthcare", "blockchain", "consent-management", "fhir", "nextjs"]
  private: true

branches:

  - name: main

    protection:
      required_status_checks:
        strict: true
        contexts: ["ci/build", "ci/test", "ci/security"]
      enforce_admins: false
      required_pull_request_reviews:
        required_approving_review_count: 2
        dismiss_stale_reviews: true

```text

- --

## 📋 Third-Party Packages & Tools

### Core Dependencies

- **🔗 Turborepo** - Monorepo build system
- **📦 pnpm** - Fast, disk space efficient package manager
- **⚛️ Next.js** - React framework for production
- **🎨 Tailwind CSS** - Utility-first CSS framework
- **📊 Storybook** - Component development environment
- **🔒 NextAuth.js** - Authentication for Next.js
- **⛓️ Hardhat** - Ethereum development environment
- **🐍 FastAPI** - Modern Python web framework
- **🗄️ PostgreSQL** - Relational database
- **📝 Prisma** - Database ORM and migration tool

### Development Tools

```bash

# Install additional development tools

pnpm -r --filter "frontends/*" dlx storybook@latest init --type nextjs --builder @storybook/nextjs-vite
pnpm add -D -w jest @testing-library/react
pnpm add -D -w eslint prettier husky lint-staged
pnpm add -D -w @playwright/test

```text

## Blockchain Tools

```bash

# Hardhat ecosystem

pnpm --filter contracts add -D @nomicfoundation/hardhat-toolbox
pnpm --filter contracts add -D @openzeppelin/contracts
pnpm --filter contracts add -D solhint prettier-plugin-solidity

# Testing and verification

pnpm --filter contracts add -D @nomicfoundation/hardhat-verify
pnpm --filter contracts add -D hardhat-gas-reporter

```text

## Infrastructure Tools

```bash

# Docker development

docker --version
docker-compose --version

# Terraform (install separately)

terraform --version

# AWS CLI (for production deployment)

aws --version

```text

- --

## 🚀 Deployment

### Development Deployment

```bash

# Deploy to staging environment

./scripts/deploy.sh staging

# Run smoke tests

pnpm --filter qa smoke-test

```text

## Production Deployment

```bash

# Deploy infrastructure

cd infra/terraform/environments/prod
terraform plan
terraform apply

# Deploy application

./scripts/deploy.sh production

# Run health checks

pnpm --filter qa health-check

```text

- --

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes**
4. **Run tests** (`pnpm test`)
5. **Commit changes** (`git commit -m 'feat: add amazing feature'`)
6. **Push to branch** (`git push origin feature/amazing-feature`)
7. **Open a Pull Request**

### Commit Convention

We use [Conventional Commits](https://conventionalcommits.org/):

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `test:` - Test additions/modifications
- `chore:` - Maintenance tasks

- --

## 📞 Support & Documentation

- **📚 API Documentation:** <http://localhost:4000/docs> (when running)
- - **🎨 Component Library:** (Storybook removed from workspace)
- **🏥 FHIR Compliance:** See `docs/compliance/`
- **🔒 Security Guidelines:** See `docs/security/`
- **🏗️ Architecture Deep Dive:** See `docs/architecture/`

- --

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

- --

## ⚠️ Important Security Notes

- **Never commit PHI/PII data** to version control
- **Use environment variables** for all secrets and API keys
- **Enable 2FA** on all GitHub accounts with repository access
- **Regularly update dependencies** to patch security vulnerabilities
- **Follow HIPAA compliance guidelines** for healthcare data handling

- --

- *Built with ❤️ for secure healthcare data management*
