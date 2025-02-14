#!/usr/bin/env bash
echo "=== Setting up Django 5.x ==="
# Check Python version
echo "Checking Python version..."
python3 --version || { echo "Python3 is not installed."; exit 1; }

# Define absolute paths
BASE_DIR="$(pwd)"
PROJECT_DIR="$BASE_DIR/imp/django"
VENV_DIR="$PROJECT_DIR/venv"

# Check if the project already exists
if [ -d "$PROJECT_DIR" ]; then
  echo "Project $PROJECT_DIR already exists. Updating dependencies..."
  cd "$PROJECT_DIR" || exit 1
  source "$VENV_DIR/bin/activate" || { echo "Failed to activate virtual environment."; exit 1; }
  
  # Update dependencies
  pip install --upgrade pip
  pip install "Django==5.*"
  
  # Apply migrations
  echo "Applying migrations..."
  python manage.py migrate || { echo "Failed to apply migrations."; exit 1; }
  
  echo "=== Django setup completed! ==="
  exit 0
fi

# Create project directory
mkdir -p "$BASE_DIR/imp"
cd "$BASE_DIR/imp" || exit 1
echo "Initializing Django project in folder $PROJECT_DIR..."
mkdir -p django
cd "$PROJECT_DIR" || exit 1

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv "$VENV_DIR" || { echo "Failed to create virtual environment."; exit 1; }

# Activate virtual environment
echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate" || { echo "Failed to activate virtual environment."; exit 1; }

# Install dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install "Django==5.*" || { echo "Failed to install Django."; exit 1; }

# Create Django project
echo "Creating Django project..."
django-admin startproject main .

# Check if the project was created successfully
if [ ! -f "manage.py" ]; then
  echo "Error: manage.py not found. The project was not created."
  exit 1
fi

# Apply migrations
echo "Applying migrations..."
python manage.py migrate || { echo "Failed to apply migrations."; exit 1; }

echo "=== Django setup completed! ==="