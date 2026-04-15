# Quick Reference Guide

## Access URLs

### Authentication
- `http://localhost:8000/` - Login Page (default)
- `http://localhost:8000/login/` - Login Page
- `http://localhost:8000/logout/` - Logout

### Admin URLs
- `http://localhost:8000/admin/dashboard/` - Admin Dashboard
- `http://localhost:8000/admin/students/` - Manage Students
- `http://localhost:8000/admin/students/add/` - Add New Student
- `http://localhost:8000/admin/attendance/mark/` - Mark Attendance
- `http://localhost:8000/admin/attendance/reports/` - View Reports
- `http://localhost:8000/admin/attendance/export/` - Export Attendance CSV
- `http://localhost:8000/admin/leaves/` - Manage Leaves

### Student URLs
- `http://localhost:8000/student/dashboard/` - Student Dashboard
- `http://localhost:8000/student/attendance/` - View My Attendance
- `http://localhost:8000/student/leaves/` - View My Leaves
- `http://localhost:8000/student/leaves/apply/` - Apply for Leave
- `http://localhost:8000/student/profile/` - My Profile

### Django Admin
- `http://localhost:8000/django-admin/` - Django Admin Panel (superuser)

---

## Keyboard Shortcuts

### Global
- `Tab` - Navigate between form fields
- `Enter` - Submit form
- `Ctrl + P` - Print page
- `F12` - Open Developer Tools

### Forms
- `Ctrl + Shift + L` - Clear form

### Tables
- `Ctrl + F` - Search page content

---

## Database Commands

### Common Django Commands
```bash
# Create superuser
python manage.py createsuperuser

# Create migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Clear all data (dangerous!)
python manage.py flush

# Load fixture (sample data)
python manage.py loaddata fixture_name

# Dump data to fixture
python manage.py dumpdata > backup.json

# Interactive Django shell
python manage.py shell

# Check for issues
python manage.py check

# Create backup
python manage.py dumpdata > backup.json

# Restore from backup
python manage.py loaddata backup.json
```

---

## Default Credentials

**Admin Account:**
```
Username: admin
Password: Admin@123
Email: admin@college.edu
```

**New Student (after admin creates):**
```
Username: [Student ID]
Password: TempPassword@123
```

---

## File Locations

- **Database**: `db.sqlite3` in project root
- **Static Files**: `attendance/static/` → `staticfiles/` (after collectstatic)
- **Media Files**: `media/` directory
- **Settings**: `config/settings.py`
- **Database Models**: `attendance/models.py`
- **Views Logic**: `attendance/views.py`
- **Templates**: `attendance/templates/`
- **Static CSS**: `attendance/static/css/style.css`
- **Static JS**: `attendance/static/js/main.js`

---

## Important Settings

### Django Settings (`config/settings.py`)
```python
DEBUG = True                    # Set to False for production
SECRET_KEY = '...'             # Change for production
ALLOWED_HOSTS = ['*']          # Set specific hosts for production
DATABASES = {...}              # Change to PostgreSQL for production
TIME_ZONE = 'UTC'              # Adjust for your timezone
USE_TZ = True                  # Use timezone-aware datetimes
```

---

## Troubleshooting Checklist

### Server Won't Start
- [ ] Check Python is installed: `python --version`
- [ ] Check port 8000 isn't in use
- [ ] Check migrations: `python manage.py migrate`
- [ ] Check virtual environment is activated
- [ ] Check dependencies: `pip list`

### Database Issues
- [ ] Check file exists: `db.sqlite3`
- [ ] Run migrations: `python manage.py migrate`
- [ ] Check permissions on database file

### Login Issues
- [ ] Check database migrations are applied
- [ ] Verify superuser exists: `python manage.py createsuperuser`
- [ ] Check username/password entered correctly
- [ ] Clear browser cookies and cache

### Static Files Missing
- [ ] Run: `python manage.py collectstatic --noinput`
- [ ] Check `STATIC_ROOT` in settings
- [ ] Hard refresh browser: `Ctrl + Shift + R`

### Template Not Found
- [ ] Check template file exists in `templates/` directory
- [ ] Check `TEMPLATES` setting in `settings.py`
- [ ] Check `INSTALLED_APPS` includes `'attendance'`

---

## Environment Variables

Create `.env` file in project root:
```
DEBUG=True
SECRET_KEY=your-secret-key
DB_NAME=attendance_db
DB_USER=postgres
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
TIMEZONE=Asia/Kolkata
```

---

## Backup & Restore

### Backup Database
```bash
# SQLite
cp db.sqlite3 db.sqlite3.backup

# JSON export (data only)
python manage.py dumpdata > backup.json
```

### Restore Database
```bash
# SQLite
cp db.sqlite3.backup db.sqlite3

# JSON import
python manage.py loaddata backup.json
```

---

## Performance Tips

### Database
- Add indexes on frequently searched fields
- Use select_related() for foreign keys
- Limit queryset with .filter()
- Paginate large lists

### Frontend
- Minimize CSS/JS
- Compress images
- Cache static files
- Use CDN for Bootstrap/FontAwesome

### Django
- Enable caching
- Use database connection pooling
- Enable query logging in development
- Monitor slow queries

---

## Security Checklist

For Production:
- [ ] Set `DEBUG = False`
- [ ] Change `SECRET_KEY`
- [ ] Update `ALLOWED_HOSTS`
- [ ] Use strong passwords
- [ ] Enable HTTPS only
- [ ] Setup CSRF protection
- [ ] Configure CORS properly
- [ ] Use environment variables
- [ ] Setup database backups
- [ ] Enable logging
- [ ] Regular security updates

---

## Testing Commands

```bash
# Run tests
python manage.py test

# Run specific test
python manage.py test attendance.tests.TestStudent

# With coverage
coverage run --source='.' manage.py test
coverage report
```

---

## Deployment Checklist

- [ ] Set DEBUG = False
- [ ] Collect static files
- [ ] Create .env file with env variables
- [ ] Setup database (PostgreSQL/MySQL)
- [ ] Setup Gunicorn/uWSGI
- [ ] Setup Nginx reverse proxy
- [ ] SSL certificate (Let's Encrypt)
- [ ] Setup email backend
- [ ] Configure logging
- [ ] Setup error tracking (Sentry)
- [ ] Database backups
- [ ] Monitor uptime

---

## Useful Django Admin URLs

```
/admin/auth/user/ - Manage users
/admin/auth/group/ - Manage user groups
/admin/attendance/student/ - Manage students
/admin/attendance/attendance/ - Manage attendance records
/admin/attendance/leave/ - Manage leaves
```

---

## System Requirements

- **OS**: Windows, macOS, Linux
- **Python**: 3.8+
- **RAM**: 512MB minimum
- **Storage**: 100MB minimum
- **Browser**: Chrome, Firefox, Safari, Edge (latest)

---

## Support Resources

- Django Docs: https://docs.djangoproject.com/
- Bootstrap Docs: https://getbootstrap.com/docs/
- Font Awesome: https://fontawesome.com/icons
- Python Docs: https://docs.python.org/3/

---

## Version Information

- Django: 4.2.0
- Python: 3.8+
- Bootstrap: 5.3.0
- Font Awesome: 6.4.0
- Last Updated: March 2026

---

## Quick Start Commands

```bash
# Windows startup
run.bat

# Linux/Mac startup
./run.sh

# Manual startup
python manage.py runserver

# Create admin
python manage.py createsuperuser

# Generate migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Open Django shell
python manage.py shell

# Collect static files
python manage.py collectstatic

# Run tests
python manage.py test

# Backup data
python manage.py dumpdata > backup.json

# Restore data
python manage.py loaddata backup.json
```

---

**Print this guide for quick reference!** 📋
