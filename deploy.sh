#!/bin/bash

echo "🚀 Topcoder Resource API - Automated Deployment Setup"
echo "======================================================"

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📂 Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit - Topcoder Resource API v6 with memberId support"
fi

echo ""
echo "🌐 Choose your deployment platform:"
echo "1. Heroku (Recommended - Free tier available)"
echo "2. Vercel (Fast deployment)"
echo "3. Railway (Simple setup)"
echo "4. GitHub (Push to repository)"
echo "5. Docker (Build container)"
echo ""

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo "🟢 Setting up Heroku deployment..."
        
        # Check if Heroku CLI is installed
        if ! command -v heroku &> /dev/null; then
            echo "❌ Heroku CLI not found. Please install it from: https://devcenter.heroku.com/articles/heroku-cli"
            exit 1
        fi
        
        read -p "Enter your app name: " app_name
        
        echo "Creating Heroku app..."
        heroku create $app_name
        
        echo "Adding PostgreSQL database..."
        heroku addons:create heroku-postgresql:hobby-dev --app $app_name
        
        echo "Setting environment variables..."
        heroku config:set NODE_ENV=production --app $app_name
        
        read -p "Enter AUTH0_CLIENT_ID (or press Enter to skip): " auth0_id
        if [ ! -z "$auth0_id" ]; then
            heroku config:set AUTH0_CLIENT_ID=$auth0_id --app $app_name
        fi
        
        read -p "Enter AUTH0_CLIENT_SECRET (or press Enter to skip): " auth0_secret
        if [ ! -z "$auth0_secret" ]; then
            heroku config:set AUTH0_CLIENT_SECRET=$auth0_secret --app $app_name
        fi
        
        echo "Deploying to Heroku..."
        git push heroku main || git push heroku master
        
        echo "Setting up database..."
        heroku run npm run create-tables --app $app_name
        heroku run npm run seed-tables --app $app_name
        
        echo "✅ Deployment complete!"
        echo "🌐 Your API is live at: https://$app_name.herokuapp.com"
        echo "📚 API Docs: https://$app_name.herokuapp.com/v5/resources/docs"
        ;;
        
    2)
        echo "🔵 Setting up Vercel deployment..."
        
        # Check if Vercel CLI is installed
        if ! command -v vercel &> /dev/null; then
            echo "Installing Vercel CLI..."
            npm install -g vercel
        fi
        
        echo "Deploying to Vercel..."
        vercel --prod
        
        echo "✅ Deployment complete!"
        echo "🌐 Your API is live at the URL shown above"
        echo "⚠️ Don't forget to add environment variables in Vercel dashboard"
        ;;
        
    3)
        echo "🟡 Railway deployment setup..."
        echo "1. Go to https://railway.app"
        echo "2. Sign up with GitHub"
        echo "3. Click 'Deploy from GitHub repo'"
        echo "4. Select this repository"
        echo "5. Add PostgreSQL service"
        echo "6. Set environment variables in Railway dashboard"
        echo "✅ Railway will automatically deploy your API"
        ;;
        
    4)
        echo "📚 GitHub repository setup..."
        
        read -p "Enter your GitHub username: " github_user
        read -p "Enter repository name: " repo_name
        
        echo "Adding GitHub remote..."
        git remote add origin https://github.com/$github_user/$repo_name.git
        
        echo "Pushing to GitHub..."
        git branch -M main
        git push -u origin main
        
        echo "✅ Code pushed to GitHub!"
        echo "🌐 Repository: https://github.com/$github_user/$repo_name"
        echo "📝 You can now deploy from GitHub to any platform"
        ;;
        
    5)
        echo "🐳 Building Docker container..."
        
        read -p "Enter Docker image name: " image_name
        
        echo "Building Docker image..."
        docker build -t $image_name .
        
        echo "✅ Docker image built successfully!"
        echo "🚀 Run locally with: docker run -p 3000:3000 $image_name"
        echo "📤 Push to registry with: docker push $image_name"
        ;;
        
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Deployment setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Test your API health check endpoint"
echo "2. Verify Swagger documentation loads"
echo "3. Test memberId functionality"
echo "4. Set up monitoring and logging"
echo ""
echo "📞 Need help? Check DEPLOYMENT_GUIDE.md for detailed instructions"
