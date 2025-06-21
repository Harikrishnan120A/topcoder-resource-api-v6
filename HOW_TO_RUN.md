# How to Run Topcoder Resource API v6

## Prerequisites

First, make sure you have the following installed:

1. **Node.js** (v10 or higher) - [Download here](https://nodejs.org/)
2. **PostgreSQL** - [Download here](https://www.postgresql.org/download/)
3. **Git** - [Download here](https://git-scm.com/)

You can verify installations by running:
```bash
node --version
npm --version
psql --version
git --version
```

## Step-by-Step Setup

### 1. Install Dependencies

```bash
npm install
```

This will install all required Node.js packages including Prisma.

### 2. Database Setup

You need to set up a PostgreSQL database and configure the connection.

#### Option A: Local PostgreSQL Setup
1. Create a new PostgreSQL database:
```sql
CREATE DATABASE topcoder_resources;
```

2. Set the database URL environment variable:
```bash
# Windows (PowerShell)
$env:DATABASE_URL="postgresql://username:password@localhost:5432/topcoder_resources"

# Windows (CMD)
set DATABASE_URL=postgresql://username:password@localhost:5432/topcoder_resources

# macOS/Linux
export DATABASE_URL="postgresql://username:password@localhost:5432/topcoder_resources"
```

#### Option B: Using Docker (Recommended)
```bash
docker run --name postgres-resources -e POSTGRES_DB=topcoder_resources -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres:13

# Set the database URL
$env:DATABASE_URL="postgresql://postgres:password@localhost:5432/topcoder_resources"
```

### 3. Initialize Database

```bash
# Create and run migrations
npm run create-tables

# Seed the database with initial data
npm run seed-tables

# Or do both at once
npm run init-db
```

### 4. Environment Configuration

The API requires some environment variables. Create a `.env` file or set them directly:

```bash
# Required for authentication (get from Topcoder)
$env:AUTH0_CLIENT_ID="your-auth0-client-id"
$env:AUTH0_CLIENT_SECRET="your-auth0-client-secret"

# Optional: Override default ports
$env:PORT=3000
$env:MOCK_CHALLENGE_API_PORT=4000
```

### 5. Start Mock Services (For Development)

The API depends on external services. For local development, start the mock servers:

```bash
# Terminal 1: Start mock challenge API
npm run mock-challenge-api

# Terminal 2: Start mock API server  
npm run mock-api
```

### 6. Start the API Server

```bash
npm start
```

The API will be available at: `http://localhost:3000`

### 7. Verify Installation

Open your browser and go to:
- **API Health Check**: `http://localhost:3000/v5/health`
- **Swagger Documentation**: `http://localhost:3000/v5/resources/docs`

## Testing the memberId Implementation

### Test with curl commands:

#### 1. Create Resource with memberId (New Feature):
```bash
curl -X POST http://localhost:3000/v5/resources \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "challengeId": "fe6d0a58-ce7d-4521-8501-b8132b1c0391",
    "memberId": 16096823,
    "roleId": "observer-role-id"
  }'
```

#### 2. Create Resource with memberHandle (Backward Compatible):
```bash
curl -X POST http://localhost:3000/v5/resources \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "challengeId": "fe6d0a58-ce7d-4521-8501-b8132b1c0391",
    "memberHandle": "hohosky",
    "roleId": "observer-role-id"
  }'
```

#### 3. Get Resources:
```bash
curl "http://localhost:3000/v5/resources?challengeId=fe6d0a58-ce7d-4521-8501-b8132b1c0391" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Running Tests

### Unit Tests:
```bash
npm test
```

### Newman/Postman Tests:
```bash
# Setup test environment first
npm run create-tables:test

# Run postman tests
npm run test:newman

# Clean up test data
npm run test:newman:clear
```

## Common Issues and Solutions

### Issue 1: Database Connection Error
**Error**: `Error: P1001: Can't reach database server`
**Solution**: 
- Make sure PostgreSQL is running
- Verify DATABASE_URL is correct
- Check firewall settings

### Issue 2: npm install fails
**Error**: Various npm errors
**Solution**:
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Issue 3: Prisma Migration Issues
**Error**: Prisma migration errors
**Solution**:
```bash
# Reset database and migrations
npm run drop-tables
npm run create-tables
```

### Issue 4: Authentication Errors
**Error**: JWT token validation errors
**Solution**:
- Set correct AUTH0_CLIENT_ID and AUTH0_CLIENT_SECRET
- Use valid JWT tokens from Topcoder dev environment
- For testing, you can disable auth temporarily in routes

## Available Scripts

- `npm start` - Start the API server
- `npm run lint` - Run ESLint
- `npm run lint:fix` - Fix ESLint issues
- `npm test` - Run unit tests
- `npm run init-db` - Initialize database
- `npm run reset-db` - Reset database
- `npm run create-tables` - Create tables
- `npm run drop-tables` - Drop tables
- `npm run seed-tables` - Seed data
- `npm run mock-api` - Start mock API server
- `npm run mock-challenge-api` - Start mock challenge API

## Development Workflow

1. **Make changes** to the code
2. **Run tests** to verify functionality: `npm test`
3. **Run linting** to check code style: `npm run lint`
4. **Test manually** using curl or Postman
5. **Check logs** for any errors

## Production Deployment

For production deployment:

1. Set production environment variables
2. Use a production PostgreSQL database
3. Configure proper authentication
4. Use process managers like PM2
5. Set up load balancing and monitoring

## Need Help?

- Check the [README.md](./ReadMe.md) for detailed configuration
- Review the [Swagger documentation](./docs/swagger.yaml)
- See the [Implementation Summary](./IMPLEMENTATION_SUMMARY.md) for recent changes
