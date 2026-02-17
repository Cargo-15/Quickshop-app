# QuickShop E-Commerce Application

A containerized ASP.NET Core 8.0 application demonstrating DevOps best practices.

## Quick Start

### Prerequisites
- .NET 8.0 SDK (download from https://dotnet.microsoft.com/download)
- Docker Desktop
- Azure CLI
- Git

### How to Build & Run Locally

```bash
# Step 1: Clone the repository
git clone https://github.com/Cargo-15/quickshop-app.git
cd quickshop-app

# Step 2: Download required libraries
dotnet restore

# Step 3: Build the project
dotnet build

# Step 4: Run tests
dotnet test

# Step 5: Run the application
dotnet run --project src
