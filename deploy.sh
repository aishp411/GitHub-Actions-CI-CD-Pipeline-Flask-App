#!/bin/bash

# Usage: ./deploy.sh [staging|production] [tag_if_production]

APP_DIR="$HOME/flask-app"
VENV_DIR="$APP_DIR/venv"

echo "📦 Deploying Flask app to environment: $1"

cd $APP_DIR || exit 1

if [[ "$1" == "staging" ]]; then
  echo "🔄 Pulling from staging branch..."
  git pull origin staging
elif [[ "$1" == "production" ]]; then
  TAG=$2
  if [ -z "$TAG" ]; then
    echo "❌ Tag name is required for production!"
    exit 1
  fi
  echo "🏷️  Checking out tag: $TAG"
  git fetch --tags
  git checkout tags/$TAG -f
else
  echo "❌ Unknown environment: $1"
  exit 1
fi

# Set up Python virtual environment
echo "🐍 Setting up virtual environment..."
python3 -m venv $VENV_DIR
source $VENV_DIR/bin/activate

echo "📦 Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Start the app (simple way)
echo "🚀 Starting Flask app..."
nohup $VENV_DIR/bin/python app.py > app.log 2>&1 &

echo "✅ Deployment complete."
