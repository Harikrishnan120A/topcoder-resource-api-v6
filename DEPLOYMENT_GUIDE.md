# 🚀 Deployment Guide - Topcoder Resource API v6

This guide covers multiple deployment options for the Topcoder Resource API v6 project with memberId support.

## 📋 Table of Contents

1. [Heroku Deployment](#heroku-deployment)
2. [Vercel Deployment](#vercel-deployment)
3. [Railway Deployment](#railway-deployment)
4. [DigitalOcean App Platform](#digitalocean-app-platform)
5. [AWS Elastic Beanstalk](#aws-elastic-beanstalk)
6. [Google Cloud Platform](#google-cloud-platform)
7. [Netlify Functions](#netlify-functions)
8. [Docker Deployment](#docker-deployment)
9. [GitHub Pages (Documentation)](#github-pages)

---

## 🟢 Heroku Deployment (Recommended)

### Prerequisites
- Heroku account (free tier available)
- Heroku CLI installed

### Step 1: Prepare Project
```bash
# Login to Heroku
heroku login

# Create new app
heroku create your-api-name

# Add PostgreSQL addon
heroku addons:create heroku-postgresql:hobby-dev
```

### Step 2: Configure Environment Variables
```bash
heroku config:set NODE_ENV=production
heroku config:set AUTH0_CLIENT_ID=your-auth0-client-id
heroku config:set AUTH0_CLIENT_SECRET=your-auth0-client-secret
```

### Step 3: Deploy
```bash
# Add Heroku remote
git remote add heroku https://git.heroku.com/your-api-name.git

# Deploy
git push heroku main

# Run database migrations
heroku run npm run create-tables
heroku run npm run seed-tables
```

### Step 4: Access Your API
- **API URL**: `https://your-api-name.herokuapp.com`
- **Swagger Docs**: `https://your-api-name.herokuapp.com/v5/resources/docs`

---

## 🔵 Vercel Deployment

### Step 1: Install Vercel CLI
```bash
npm i -g vercel
```

### Step 2: Configure vercel.json
Create `vercel.json` in project root (already provided).

### Step 3: Deploy
```bash
# Login to Vercel
vercel login

# Deploy
vercel --prod
```

### Step 4: Configure Database
- Use Vercel Postgres or external PostgreSQL service
- Add environment variables in Vercel dashboard

---

## 🟡 Railway Deployment

### Step 1: Connect Repository
1. Go to [railway.app](https://railway.app)
2. Sign up with GitHub
3. Click "Deploy from GitHub repo"
4. Select your repository

### Step 2: Add Database
1. Click "Add Service" → "Database" → "PostgreSQL"
2. Railway will automatically set DATABASE_URL

### Step 3: Configure Environment
Add environment variables in Railway dashboard:
- `NODE_ENV=production`
- `AUTH0_CLIENT_ID=your-client-id`
- `AUTH0_CLIENT_SECRET=your-client-secret`

### Step 4: Deploy
Railway automatically deploys on git push.

---

## 🔴 DigitalOcean App Platform

### Step 1: Create App
1. Go to [DigitalOcean App Platform](https://cloud.digitalocean.com/apps)
2. Create new app from GitHub repository

### Step 2: Configure Build Settings
- **Build Command**: `npm install`
- **Run Command**: `npm start`
- **Environment**: Node.js

### Step 3: Add Database
1. Add PostgreSQL database component
2. Configure environment variables

### Step 4: Deploy
DigitalOcean handles automatic deployment.

---

## 🟠 AWS Elastic Beanstalk

### Step 1: Install EB CLI
```bash
pip install awsebcli
```

### Step 2: Initialize Application
```bash
eb init
eb create production
```

### Step 3: Configure Environment
Create `.ebextensions/nodecommand.config` (already provided).

### Step 4: Deploy
```bash
eb deploy
```

---

## 🟣 Google Cloud Platform

### Step 1: Setup GCP Project
```bash
gcloud projects create your-project-id
gcloud config set project your-project-id
```

### Step 2: Deploy to App Engine
Create `app.yaml` (already provided).

```bash
gcloud app deploy
```

### Step 3: Configure Database
- Use Cloud SQL for PostgreSQL
- Set environment variables in `app.yaml`

---

## 🟢 Netlify Functions (Serverless)

### Step 1: Install Netlify CLI
```bash
npm install -g netlify-cli
```

### Step 2: Configure Functions
Create `netlify.toml` (already provided).

### Step 3: Deploy
```bash
netlify login
netlify deploy --prod
```

---

## 🐳 Docker Deployment

### Step 1: Build Image
```bash
docker build -t topcoder-resource-api .
```

### Step 2: Run Container
```bash
docker run -p 3000:3000 -e DATABASE_URL=your-db-url topcoder-resource-api
```

### Step 3: Deploy to Container Registry
```bash
# Tag and push to Docker Hub
docker tag topcoder-resource-api yourusername/topcoder-resource-api
docker push yourusername/topcoder-resource-api
```

---

## 📚 GitHub Pages (Documentation Only)

For hosting Swagger documentation:

### Step 1: Create gh-pages Branch
```bash
git checkout -b gh-pages
```

### Step 2: Prepare Documentation
Copy `docs/swagger.yaml` and create HTML wrapper.

### Step 3: Enable GitHub Pages
1. Go to repository Settings
2. Enable Pages from gh-pages branch
3. Access at: `https://yourusername.github.io/repository-name`

---

## 🔧 Environment Variables Reference

All platforms need these environment variables:

### Required
- `DATABASE_URL` - PostgreSQL connection string
- `NODE_ENV` - Set to "production"

### Optional
- `AUTH0_CLIENT_ID` - Auth0 client ID
- `AUTH0_CLIENT_SECRET` - Auth0 client secret
- `PORT` - Server port (usually auto-set by platform)
- `LOG_LEVEL` - Logging level (debug, info, warn, error)

---

## 📝 Post-Deployment Checklist

1. ✅ **Database Setup**: Run migrations and seed data
2. ✅ **Environment Variables**: Set all required variables
3. ✅ **Health Check**: Test `/v5/health` endpoint
4. ✅ **API Documentation**: Verify Swagger UI works
5. ✅ **memberId Testing**: Test new memberId functionality
6. ✅ **Backward Compatibility**: Test memberHandle still works
7. ✅ **Error Handling**: Test error responses
8. ✅ **Performance**: Check response times
9. ✅ **Monitoring**: Set up logging and alerts
10. ✅ **Security**: Verify authentication works

---

## 🚨 Common Issues & Solutions

### Database Connection Issues
- Verify DATABASE_URL format
- Check firewall settings
- Ensure database is accessible from hosting platform

### Build Failures
- Check Node.js version compatibility
- Verify all dependencies are in package.json
- Review build logs for specific errors

### Environment Variable Issues
- Double-check variable names (case-sensitive)
- Ensure no trailing spaces in values
- Use platform-specific configuration methods

### Memory/Performance Issues
- Choose appropriate instance size
- Optimize database queries
- Enable compression middleware

---

## 📞 Support & Resources

- **API Documentation**: Check Swagger UI for endpoint details
- **Implementation Summary**: See `IMPLEMENTATION_SUMMARY.md`
- **Running Locally**: See `HOW_TO_RUN.md`
- **GitHub Issues**: Create issues for bugs or questions

Choose the deployment platform that best fits your needs. Heroku and Railway are great for quick deployments, while AWS/GCP offer more control and scalability options.
