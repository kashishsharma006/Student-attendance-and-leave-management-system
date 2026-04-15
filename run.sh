#!/bin/bash

echo "=================================================="
echo "   College Attendance Management System"
echo "=================================================="
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
    echo "Virtual environment created."
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "Installing/updating dependencies..."
pip install -r requirements.txt > /dev/null 2>&1

# Run migrations
echo "Running migrations..."
python manage.py migrate > /dev/null 2>&1

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput > /dev/null 2>&1

echo ""
echo "=================================================="
echo "    Server is starting..."
echo "=================================================="
echo ""
echo "Open your browser and go to: http://localhost:8000"
echo ""
echo "Default Admin Credentials:"
echo "   Username: admin"
echo "   Password: Admin@123"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start the development server
python manage.py runserver
