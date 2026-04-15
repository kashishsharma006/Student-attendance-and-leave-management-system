# Getting Started - College Attendance Management System

## Quick Start Guide

### 1. Initial Setup (Windows)

Double-click `run.bat` to start the server automatically. It will:
- Create virtual environment (if needed)
- Install dependencies
- Run migrations
- Start the development server

Then open: **http://localhost:8000** in your browser

### 2. Initial Setup (macOS/Linux)

Open terminal in the project directory and run:
```bash
chmod +x run.sh
./run.sh
```

### 3. First Login

**Admin Login:**
- Username: `admin`
- Password: `Admin@123`

Navigate to the admin dashboard to start!

---

## Project Structure Overview

```
project/
├── attendance/              # Main Django app
│   ├── models.py           # Database models (Student, Attendance, Leave)
│   ├── views.py            # Business logic + page views
│   ├── forms.py            # Form definitions
│   ├── urls.py             # URL routing
│   ├── admin.py            # Django admin configuration
│   ├── templates/          # HTML templates
│   │   ├── base.html       # Master template
│   │   ├── login.html      # Login page
│   │   ├── admin/          # Admin pages
│   │   └── student/        # Student pages
│   └── static/             # CSS, JS, images
│
├── config/                 # Django project configuration
│   ├── settings.py        # Project settings
│   ├── urls.py            # Main URL router
│   └── wsgi.py            # Production config
│
├── manage.py              # Django command utility
├── db.sqlite3             # Database (auto-created)
├── requirements.txt       # Python dependencies
├── README.md              # Full documentation
├── run.bat                # Windows startup script
└── run.sh                 # Linux/macOS startup script
```

---

## Key Features

### Admin Panel
- ✅ Add/edit/delete students
- ✅ Set and reset student passwords
- ✅ Mark attendance for multiple students
- ✅ View attendance reports and statistics
- ✅ Approve/reject leave requests
- ✅ Export data as CSV

### Student Portal
- ✅ View personal attendance
- ✅ Apply for leave with reason
- ✅ Track leave status
- ✅ Check attendance percentage
- ✅ Update profile information

---

## Common Tasks

### Adding a Student (Admin)

1. Login as admin
2. Click **Manage Students** → **Add New Student**
3. Fill in details:
   - Student ID (e.g., STU001)
   - Roll Number
   - Name, Email, Phone
   - Branch, Semester
   - Address, Parent Info
4. Click **Add Student**
5. System creates login with ID = Username, Password = TempPassword@123

### Marking Attendance (Admin)

1. Click **Mark Attendance**
2. Select Date and Subject
3. Check students who are present
4. Select status: Present/Absent/Late/Leave
5. Click **Mark Attendance**

### Student Viewing Attendance

1. Login with student credentials
2. Click **My Attendance**
3. See all attendance records
4. View attendance percentage

### Applying for Leave (Student)

1. Click **Apply Leave**
2. Select leave type (Sick/Casual/Medical/Emergency)
3. Set start and end dates
4. Provide reason
5. Click **Submit Leave Request**

### Approving Leaves (Admin)

1. Click **Manage Leaves**
2. Filter by status (Pending/Approved/Rejected)
3. Click **Approve** or **Reject**
4. Leave status updates automatically

---

## Troubleshooting

### Port 8000 Already In Use
Run on different port:
```bash
python manage.py runserver 8001
```

### Database Issues
Reset database (caution - deletes all data):
```bash
rm db.sqlite3
python manage.py migrate
python manage.py createsuperuser
```

### Can't Login
- Check capslock is off
- Reset password from admin panel
- Username is case-sensitive

### Static Files Missing
Collect static files:
```bash
python manage.py collectstatic --noinput
```

---

## Security Notes

1. **Never share admin credentials**
2. **Change SECRET_KEY for production** (settings.py)
3. **Use strong passwords**
4. **Backup database regularly**
5. **Update Django regularly**

---

## Important Files

- `settings.py` - Database, apps, security settings
- `models.py` - Data structure definitions
- `views.py` - Page logic and business rules
- `templates/` - HTML pages
- `static/` - CSS and JavaScript

---

## Database Models

### Student
- Personal info, branch, semester, contact details
- Linked to Django User for login

### Attendance
- Date, student, subject, status, remarks
- Records for present/absent/late/leave

### Leave
- Type (sick/casual/medical/emergency)
- Dates, reason, status, approver

### AttendancePolicy
- Configurable attendance rules/percentages

---

## What's Next?

1. **Customize** the system for your college
2. **Add students** with their details
3. **Configure** attendance policies
4. **Setup email** notifications (optional)
5. **Backup** database regularly

---

## Support

For issues:
1. Check README.md
2. Review error messages carefully
3. Check database is initialized (manage.py migrate)
4. Ensure admin account exists

---

## Production Deployment

When deploying to production:

1. Set `DEBUG = False` in settings.py
2. Use strong `SECRET_KEY`
3. Setup PostgreSQL database
4. Use Gunicorn web server
5. Configure HTTPS
6. Setup proper backups
7. Configure error logging

---

**Happy using the Attendance Management System! 🎓**
