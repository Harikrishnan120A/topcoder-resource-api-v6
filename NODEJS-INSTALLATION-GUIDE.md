# Node.js Installation Guide

## 🚀 Quick Installation Steps

### Method 1: Official Website (Easiest)
1. **Open your browser**
2. **Go to: https://nodejs.org/**
3. **Click the green "LTS" button** (recommended version)
4. **Download will start automatically** (file will be like `node-v20.x.x-x64.msi`)
5. **Double-click the downloaded file**
6. **Follow the installation wizard:**
   - Click "Next" through all steps
   - Accept the license agreement
   - Keep all default settings
   - Make sure "Add to PATH" is checked ✅
   - Click "Install"
7. **Restart your terminal/PowerShell**

### Method 2: Using Chocolatey (If you have it)
```powershell
choco install nodejs
```

### Method 3: Using winget (Windows 10/11)
```powershell
winget install OpenJS.NodeJS
```

## 🔍 Verify Installation

After installation, open a **new** PowerShell window and run:

```powershell
node --version
npm --version
```

You should see something like:
```
v20.10.0
10.2.3
```

## 🛠️ If Installation Fails

### Problem: "node is not recognized as a command"
**Solution:**
1. Close all PowerShell/Command Prompt windows
2. Open a **new** PowerShell window
3. Try again

If still not working:
1. Go to Windows Settings → Apps → Installed Apps
2. Search for "Node.js"
3. If found, uninstall and reinstall
4. If not found, the installation didn't complete

### Problem: Installation hangs or fails
**Solution:**
1. Download manually from https://nodejs.org/
2. Right-click the `.msi` file → "Run as administrator"
3. Complete the installation

## 🎯 After Node.js is Installed

Once Node.js is working, you can run our Resource API:

```powershell
# Install project dependencies
npm install

# Start the API
npm run mock-challenge-api    # Terminal 1
npm start                     # Terminal 2

# Or use our quick start script
.\RUN-API.bat
```

## 📍 Quick Test

Create a test file to verify Node.js works:

```powershell
echo "console.log('Node.js is working!');" > test.js
node test.js
```

Should output: `Node.js is working!`

## 🆘 Need Help?

If you encounter any issues:
1. Make sure you downloaded from the official site: https://nodejs.org/
2. Try running PowerShell as Administrator
3. Restart your computer after installation
4. Check Windows Defender/Antivirus isn't blocking the installation

Once Node.js is installed, our Topcoder Resource API with memberId support will be ready to run! 🚀
