# 🚀 QUICK DEPLOYMENT COMMANDS

## 1. Heroku (Easiest)
```bash
# Install Heroku CLI first: https://devcenter.heroku.com/articles/heroku-cli

# Login and create app
heroku login
heroku create your-api-name

# Add database
heroku addons:create heroku-postgresql:hobby-dev

# Set environment variables
heroku config:set NODE_ENV=production
heroku config:set AUTH0_CLIENT_ID=your-auth0-client-id
heroku config:set AUTH0_CLIENT_SECRET=your-auth0-client-secret

# Deploy
git add .
git commit -m "Deploy to Heroku"
git push heroku main

# Setup database
heroku run npm run create-tables
heroku run npm run seed-tables

# Your API will be live at: https://your-api-name.herokuapp.com
```

## 2. Vercel (Fast & Free)
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel login
vercel --prod

# Add environment variables in Vercel dashboard
# Your API will be live at: https://your-project.vercel.app
```

## 3. Railway (Simple)
```bash
# Go to https://railway.app
# Connect your GitHub repository
# Add PostgreSQL service
# Deploy automatically happens
```

## 4. Docker (Local/Cloud)
```bash
# Build and run locally
docker-compose up --build

# Or build for cloud deployment
docker build -t topcoder-resource-api .
docker tag topcoder-resource-api yourusername/topcoder-resource-api
docker push yourusername/topcoder-resource-api
```

## 5. DigitalOcean App Platform
```bash
# Go to https://cloud.digitalocean.com/apps
# Create app from GitHub repo
# Add PostgreSQL database
# Configure environment variables
# Deploy automatically
```

## Environment Variables Needed:
- `DATABASE_URL` (PostgreSQL connection string)
- `NODE_ENV=production`
- `AUTH0_CLIENT_ID` (optional, for authentication)
- `AUTH0_CLIENT_SECRET` (optional, for authentication)

## Test Your Deployment:
- Health Check: `https://your-domain/v5/health`
- API Docs: `https://your-domain/v5/resources/docs`
- Test memberId: POST to `https://your-domain/v5/resources` with memberId in body
