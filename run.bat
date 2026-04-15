@echo off
REM Start the Attendance Management System

cls
echo.
echo ====================================================
echo    College Attendance Management System
echo ====================================================
echo.

REM Check if virtual environment exists
if not exist venv (
    echo Creating virtual environment...
    python -m venv venv
    echo Virtual environment created.
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Install dependencies if needed
echo Installing/updating dependencies...
pip install -r requirements.txt > nul 2>&1

REM Run migrations
echo Running migrations...
python manage.py migrate > nul 2>&1

REM Collect static files
echo Collecting static files...
python manage.py collectstatic --noinput > nul 2>&1

echo.
echo ====================================================
echo    Server is starting...
echo ====================================================
echo.
echo Open your browser and go to: http://localhost:8000
echo.
echo Default Admin Credentials:
echo   Username: admin
echo   Password: Admin@123
echo.
echo Press Ctrl+C to stop the server
echo.

REM Start the development server
python manage.py runserver
