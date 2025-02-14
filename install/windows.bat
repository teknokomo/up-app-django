@echo off
echo === Setting up Django 5.x ===
echo Checking Python...
:: Check Python version
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Please install Python first.
    exit /b 1
)
:: Check pip
pip --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo pip is not installed. Please install pip first.
    exit /b 1
)
:: Define paths
set PROJECT_DIR=imp\django
set VENV_DIR=%PROJECT_DIR%\venv
:: Check if the project already exists
if exist "%PROJECT_DIR%" (
    echo Project %PROJECT_DIR% already exists. Updating dependencies...
    cd "%PROJECT_DIR%"
    
    :: Activate virtual environment
    call "%VENV_DIR%\Scripts\activate" || (
        echo Failed to activate virtual environment.
        exit /b 1
    )
    :: Update dependencies
    call pip install --upgrade pip
    call pip install "Django==5.*"
    
    echo === Django setup completed! ===
    exit /b 0
)
:: Create project directory
if not exist "imp" mkdir imp
cd imp
echo Initializing Django project in folder %PROJECT_DIR%...
mkdir django
cd django
:: Create virtual environment
echo Creating virtual environment...
python -m venv "%VENV_DIR%" || (
    echo Failed to create virtual environment.
    exit /b 1
)
:: Activate virtual environment
call "%VENV_DIR%\Scripts\activate" || (
    echo Failed to activate virtual environment.
    exit /b 1
)
:: Install dependencies
echo Installing dependencies...
call pip install --upgrade pip
call pip install "Django==5.*" || (
    echo Failed to install Django.
    exit /b 1
)
:: Create Django project
echo Creating Django project...
django-admin startproject main .
:: Check if the project was created successfully
if not exist "manage.py" (
    echo Error: manage.py not found. The project was not created.
    exit /b 1
)
:: Apply migrations
echo Applying migrations...
call python manage.py migrate || (
    echo Failed to apply migrations.
    exit /b 1
)
echo === Django setup completed! ===