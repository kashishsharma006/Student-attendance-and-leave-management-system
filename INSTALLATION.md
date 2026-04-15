# Installation & Configuration Guide

## System Requirements

### Minimum Requirements
- **Operating System**: Windows 7+, macOS 10.12+, or any Linux distribution
- **Python**: 3.8 or higher
- **RAM**: 512MB minimum (2GB recommended)
- **Storage**: 200MB free space
- **Browser**: Chrome, Firefox, Safari, or Edge (modern version)
- **Internet**: Required for initial setup only

### Installation Time
- Total: ~5-10 minutes
- Fastest method: Double-click `run.bat` (Windows)

---

## Prerequisites Checklist

- [ ] Python 3.8+ installed
- [ ] pip (Python package manager) installed
- [ ] Administrator access to install packages
- [ ] 200MB free disk space
- [ ] Port 8000 available (or configurable)
- [ ] Modern web browser

### Check Python Installation

**Windows:**
```cmd
python --version
```

**macOS/Linux:**
```bash
python3 --version
```

If not installed, download from: https://www.python.org/downloads/

---

## Installation Methods

### Method 1: Automatic (Recommended)

#### Windows
1. Navigate to project folder
2. Double-click: `run.bat`
3. Wait for setup to complete
4. Browser opens automatically
5. Login with: admin / Admin@123

#### macOS/Linux
1. Open Terminal in project folder
2. Run:
```bash
chmod +x run.sh
./run.sh
```
3. Wait for setup
4. Open browser: http://localhost:8000
5. Login with: admin / Admin@123

### Method 2: Manual Setup

#### Step 1: Create Virtual Environment
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

#### Step 2: Install Dependencies
```bash
pip install -r requirements.txt
```

#### Step 3: Apply Migrations
```bash
python manage.py migrate
```

#### Step 4: Create Admin Account
```bash
python manage.py createsuperuser
# Follow prompts to create admin account
```

#### Step 5: Start Server
```bash
python manage.py runserver
```

#### Step 6: Access Application
Open browser: `http://localhost:8000`

---

## Initial Configuration

### After First Installation

#### 1. Login to System
- Open: http://localhost:8000
- Username: `admin`
- Password: `Admin@123`
- Click: **Login**

#### 2. Navigate to Admin Dashboard
You'll see:
- Total Students: 0
- Active Students: 0
- Today's Attendance: 0
- Pending Leaves: 0

#### 3. Add First Student
1. Click: **Manage Students** → **Add New Student**
2. Fill in the form:
   - First Name: John
   - Last Name: Doe
   - Student ID: STU001
   - Roll Number: 1
   - Email: john@college.edu
   - Branch: CSE
   - Semester: 1
3. Click: **Add Student**
4. System will create login:
   - Username: STU001
   - Password: TempPassword@123

#### 4. Test Student Login
1. Logout from admin
2. Login as:
   - Username: STU001
   - Password: TempPassword@123
3. You should see: **Student Dashboard**

---

## Configuration Files

### Important Configuration Files

#### `config/settings.py`
Main Django configuration. Key settings:

```python
# Debug mode (set to False for production)
DEBUG = True

# Allowed hosts
ALLOWED_HOSTS = ['*']

# Database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Time zone
TIME_ZONE = 'UTC'

# Static files
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

# Login URLs
LOGIN_URL = 'login'
LOGIN_REDIRECT_URL = 'dashboard'
```

#### Changing Database
To use PostgreSQL instead of SQLite:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'attendance_db',
        'USER': 'postgres',
        'PASSWORD': 'your_password',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

Then run:
```bash
pip install psycopg2-binary
python manage.py migrate
```

---

## Changing Port

### Default Port: 8000

To use a different port:

```bash
python manage.py runserver 8001
python manage.py runserver 8080
python manage.py runserver 5000
```

Then access: http://localhost:PORT

---

## Database Configuration

### Current Setup
**SQLite** - File-based database
- File: `db.sqlite3` in project root
- No additional installation needed
- Good for small installations

### For Production
**PostgreSQL Recommended**

1. Install PostgreSQL:
   - Windows: https://www.postgresql.org/download/windows/
   - macOS: `brew install postgresql`
   - Linux: `apt-get install postgresql`

2. Create database:
```sql
createdb attendance_db
```

3. Update `settings.py`:
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'attendance_db',
        'USER': 'postgres',
        'PASSWORD': 'password',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

4. Install Python driver:
```bash
pip install psycopg2-binary
pip install -r requirements.txt
```

5. Run migrations:
```bash
python manage.py migrate
```

---

## Environment Variables (Optional)

### Create `.env` file

```bash
# .env file in project root

DEBUG=True
SECRET_KEY=your-secret-key-here
ALLOWED_HOSTS=localhost,127.0.0.1

# Database configuration
DB_ENGINE=django.db.backends.sqlite3
DB_NAME=db.sqlite3
# For PostgreSQL:
# DB_ENGINE=django.db.backends.postgresql
# DB_NAME=attendance_db
# DB_USER=postgres
# DB_PASSWORD=password
# DB_HOST=localhost
# DB_PORT=5432

# Email configuration (optional)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_HOST_USER=your_email@gmail.com
EMAIL_HOST_PASSWORD=your_password

# Timezone
TIME_ZONE=Asia/Kolkata
```

### Load environment variables

Install python-dotenv:
```bash
pip install python-dotenv
```

Update `settings.py`:
```python
from decouple import config

DEBUG = config('DEBUG', default=True, cast=bool)
SECRET_KEY = config('SECRET_KEY')
ALLOWED_HOSTS = config('ALLOWED_HOSTS', default='localhost', cast=lambda v: [s.strip() for s in v.split(',')])
```

---

## Static Files Collection

For production:
```bash
python manage.py collectstatic
```

This collects all CSS, JS, and image files into `staticfiles/` directory.

---

## Creating Additional Admin Accounts

```bash
python manage.py createsuperuser
```

Then:
1. Enter username (e.g., admin2)
2. Enter email
3. Enter password (twice)
4. User created successfully

New admin can login and manage system.

---

## Backup Database

### SQLite Backup
```bash
# Windows
copy db.sqlite3 db.sqlite3.backup

# macOS/Linux
cp db.sqlite3 db.sqlite3.backup
```

### JSON Back up (Data Export)
```bash
python manage.py dumpdata > backup.json
```

### Restore from Backup
```bash
python manage.py loaddata backup.json
```

---

## Reset Database

**CAUTION: This deletes all data!**

```bash
# Delete database file
# Windows
del db.sqlite3

# macOS/Linux
rm db.sqlite3

# Recreate migrations
python manage.py migrate

# Create new admin
python manage.py createsuperuser
```

---

## Troubleshooting Installation

### Python Not Found
**Error**: `'python' is not recognized...`

**Solution**:
1. Install Python from https://python.org
2. Add to PATH during installation
3. Restart terminal
4. Try again

### Virtual Environment Issues
**Error**: `No module named...`

**Solution**:
```bash
# Activate virtual environment first
# Windows
venv\Scripts\activate

# macOS/Linux
source venv/bin/activate
```

### Port 8000 Already In Use
**Error**: `Address already in use`

**Solution**:
```bash
# Use different port
python manage.py runserver 8001

# Or find process using port 8000
# Windows: netstat -ano | findstr :8000
# Linux: lsof -i :8000
```

### Database Error
**Error**: `database is locked`

**Solution**:
1. Close server (Ctrl+C)
2. Delete `db.sqlite3`
3. Run migrations: `python manage.py migrate`
4. Start server again

### Migration Errors
**Error**: `No migrations to apply`

**Solution**:
```bash
# Create migrations
python manage.py makemigrations

# Apply them
python manage.py migrate
```

### Dependencies Error
**Error**: `No module named django`

**Solution**:
```bash
pip install -r requirements.txt
```

---

## Security Configuration

### For Development
```python
DEBUG = True  # Shows detailed error pages
SECRET_KEY = 'any-value-ok-for-dev'
ALLOWED_HOSTS = ['*']
```

### For Production
```python
DEBUG = False  # Hide errors
SECRET_KEY = os.environ.get('SECRET_KEY')  # Strong key from env
ALLOWED_HOSTS = ['yourdomain.com', 'www.yourdomain.com']
SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
```

---

## Performance Optimization

### For Small Installation (< 50 users)
```python
# Current setup is fine
# SQLite database OK
# Single Django server OK
```

### For Medium Installation (50-300 users)
```python
# Switch to PostgreSQL
# Setup caching (Redis)
# Enable DEBUG=False
# Compress static files
```

### For Large Installation (> 300 users)
```python
# PostgreSQL + Read replicas
# Redis caching
# Load balancer (Nginx/Apache)
# Separate application servers
# CDN for static files
# Database optimization
```

---

## Regular Maintenance

### Weekly
- [ ] Backup database
- [ ] Check error logs
- [ ] Monitor disk space

### Monthly
- [ ] Update Python packages: `pip install --upgrade -r requirements.txt`
- [ ] Review user accounts
- [ ] Analyze system performance

### Quarterly
- [ ] Update Django version
- [ ] Security audit
- [ ] Database optimization
- [ ] Full system backup

### Yearly
- [ ] Major update planning
- [ ] Feature review
- [ ] Infrastructure upgrade consideration

---

## Upgrading to New Version

```bash
# Backup current version
cp -r project project_backup

# Fetch updates (if using Git)
git pull

# Update dependencies
pip install -r requirements.txt --upgrade

# Create migrations for changes
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic --noinput

# Test system
python manage.py runserver

# Backup after successful upgrade
python manage.py dumpdata > backup_after_upgrade.json
```

---

## Uninstalling

To completely remove the system:

```bash
# Windows
rmdir /s venv
del db.sqlite3
del -r attendance/migrations/__pycache__
del -r __pycache__

# macOS/Linux
rm -rf venv
rm db.sqlite3
rm -rf attendance/migrations/__pycache__
rm -rf __pycache__
```

---

## Next Steps After Installation

1. ✅ **Verify Installation**: Login successfully
2. ✅ **Add Test Data**: Create sample students
3. ✅ **Test Workflows**: Mark attendance, apply leave
4. ✅ **Explore Features**: Check all pages
5. ✅ **Customize**: Adjust to your needs
6. ✅ **Backup**: Save database regularly
7. ✅ **Plan Deployment**: If deploying to production

---

## Contact & Support

For issues:
1. Check error logs: Browser console (F12)
2. Review README.md FAQ
3. Check GETTING_STARTED.md
4. Check database is initialized: `python manage.py migrate status`

---

**Installation Complete! Happy using! 🚀**
