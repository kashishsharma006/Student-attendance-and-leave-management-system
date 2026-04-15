# College Attendance and Leave Management System

A comprehensive web-based attendance and leave management system built with Django, HTML, CSS, and JavaScript. This system is designed for colleges to manage student attendance records and leave requests efficiently.

## Features

### Admin Features
- **Dashboard**: Overview of total students, active students, today's attendance, and pending leaves
- **Student Management**:
  - Add, edit, and delete students
  - Store detailed student information (ID, roll number, email, phone, branch, semester, etc.)
  - Set and reset student passwords
  - Filter and search students by ID, name, branch, or semester

- **Attendance Management**:
  - Mark attendance for multiple students at once
  - Record attendance status (Present, Absent, Late, Leave)
  - View comprehensive attendance reports
  - Generate attendance statistics by branch and semester
  - Export attendance data as CSV

- **Leave Management**:
  - Review student leave applications
  - Approve or reject leave requests
  - Track leave history and duration
  - Filter leaves by status (Pending, Approved, Rejected)

### Student Features
- **Dashboard**: Personal attendance overview and statistics
- **View Attendance**: See personal attendance records with dates and status
- **Apply for Leave**: Submit leave requests with reason and duration
- **View Leaves**: Track status of all leave applications
- **Profile Management**: Update contact information and parent/guardian details

## Technology Stack

- **Backend**: Django 4.2.0
- **Frontend**: HTML5, CSS3, JavaScript (Bootstrap 5.3)
- **Database**: SQLite (easily configurable to PostgreSQL/MySQL)
- **Icons**: Font Awesome 6.4.0

## Installation

### Prerequisites
- Python 3.8 or higher
- pip (Python package manager)
- Git

### Steps

1. **Clone or Extract the Project**
```bash
cd project
```

2. **Create a Virtual Environment**
```bash
python -m venv venv
```

3. **Activate Virtual Environment**
- On Windows:
```bash
venv\Scripts\activate
```
- On macOS/Linux:
```bash
source venv/bin/activate
```

4. **Install Dependencies**
```bash
pip install -r requirements.txt
```

5. **Apply Database Migrations**
```bash
python manage.py migrate
```

6. **Create a Superuser (Admin Account)**
```bash
python manage.py createsuperuser
```
Follow the prompts to create an admin account. Example:
- Username: `admin`
- Email: `admin@college.edu`
- Password: `admin123` (choose a strong password)

7. **Run the Development Server**
```bash
python manage.py runserver
```

The application will be available at `http://localhost:8000/`

## Usage

### First Login
1. Open `http://localhost:8000/` in your browser
2. Login with the admin credentials you created
3. You'll be redirected to the admin dashboard

### Admin Operations

#### Adding Students
1. Go to **Students** → **Add New Student**
2. Fill in all required fields (Student ID, Roll Number, Email, etc.)
3. The system will create a login account with default password `TempPassword@123`
4. Click **Add Student**

#### Marking Attendance
1. Go to **Mark Attendance**
2. Select the date and subject
3. Check the students who are present
4. Select status from the dropdown (Present, Absent, Late, Leave)
5. Click **Mark Attendance**

#### Viewing Reports
1. Go to **Reports** to see attendance statistics
2. Filter by branch or search by student ID/name
3. Click **Details** to view individual student attendance
4. Click **Export as CSV** to download the data

#### Managing Leaves
1. Go to **Leaves**
2. View pending leave requests
3. Click **Approve** or **Reject** for each request
4. Add approval notes if needed

### Student Operations

#### Checking Attendance
1. Login with student credentials
2. Go to **My Attendance** to view attendance records
3. See attendance percentage and statistics

#### Applying for Leave
1. Go to **Apply Leave**
2. Select leave type (Sick, Casual, Medical, Emergency)
3. Set start and end dates
4. Provide reason
5. Click **Submit Leave Request**

#### Viewing Leave Status
1. Go to **My Leaves**
2. See status of all leave applications
3. Track approval status and duration

## Default Credentials (if using provided demo data)

- **Admin Login**: 
  - Username: `admin`
  - Password: (as set during superuser creation)

- **Sample Student** (after adding):
  - Username: Student ID
  - Password: TempPassword@123 (set by admin)

## Project Structure

```
project/
├── config/                 # Django configuration
│   ├── settings.py        # Settings and installed apps
│   ├── urls.py            # Main URL configuration
│   └── wsgi.py            # WSGI configuration
├── attendance/            # Main application
│   ├── models.py          # Database models
│   ├── views.py           # View logic
│   ├── forms.py           # Form definitions
│   ├── urls.py            # App URL configuration
│   ├── admin.py           # Admin panel configuration
│   ├── templates/         # HTML templates
│   │   ├── base.html      # Base template
│   │   ├── login.html     # Login page
│   │   ├── admin/         # Admin templates
│   │   └── student/       # Student templates
│   └── static/            # Static files
│       ├── css/           # Stylesheets
│       └── js/            # JavaScript files
├── manage.py              # Django management script
└── requirements.txt       # Python dependencies
```

## Database Models

### Student
- Stores student information including ID, roll number, contact details, branch, semester
- Linked to Django User model for authentication

### Attendance
- Records attendance for each student with status (Present, Absent, Late, Leave)
- Unique constraint on student-date-subject combination

### Leave
- Manages leave applications with type, duration, and approval status
- Tracks approver information and approval timestamps

### AttendancePolicy
- Configurable attendance policies (e.g., minimum attendance percentage)

## Features in Detail

### Advanced Filtering
- Search students by ID, name, roll number, email
- Filter by branch and semester
- Generate reports by department

### Authentication & Authorization
- Role-based access control (Admin vs Student)
- Secure password management
- Session-based authentication

### Data Export
- Export attendance reports as CSV
- Generate printable reports
- Track historical data

### Responsive Design
- Mobile-friendly interface
- Works on desktop, tablet, and mobile devices
- Bootstrap 5 framework for consistent UI

## Configuration

### Database
By default, the system uses SQLite. To use PostgreSQL or MySQL:

Edit `config/settings.py` and update DATABASES:

For PostgreSQL:
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

### Static Files
To collect static files for production:
```bash
python manage.py collectstatic --noinput
```

## Common Tasks

### Reset a Student's Password
1. Go to **Students**
2. Find the student and click the key icon
3. Enter new password and click **Reset Password**

### Change Your Admin Password
1. Go to Django Admin (`/admin/`)
2. Click on your user
3. Update password

### Deactivate a Student
1. Go to **Students**
2. Edit the student
3. Uncheck **is_active** and save

### View Detailed Attendance for a Student
1. Go to **Reports**
2. Click **Details** next to the student's name

## Troubleshooting

### Port Already in Use
If port 8000 is already in use:
```bash
python manage.py runserver 8001
```

### Database Errors
Reset the database (caution - will delete all data):
```bash
rm db.sqlite3
python manage.py migrate
python manage.py createsuperuser
```

### Static Files Not Loading
```bash
python manage.py collectstatic --noinput
```

### Login Issues
- Reset password using the admin panel
- Check that the user account is active
- Clear browser cookies and try again

## Security Recommendations

For production use:
1. Change `DEBUG = False` in `settings.py`
2. Set a strong `SECRET_KEY`
3. Use environment variables for sensitive data
4. Use HTTPS only
5. Set `ALLOWED_HOSTS` to your domain
6. Configure proper database backups
7. Use a production web server (Gunicorn, uWSGI)
8. Set up CSRF and CORS protection

## Performance Tips

- Use indexes on frequently filtered fields
- Limit attendance queries with date ranges
- Cache dashboard statistics
- Use database query optimization
- Monitor database query performance

## Support & Documentation

For more information:
- [Django Documentation](https://docs.djangoproject.com/)
- [Bootstrap Documentation](https://getbootstrap.com/docs/)
- [Font Awesome Icons](https://fontawesome.com/)

## License

This project is created for educational purposes.

## Features Roadmap

Future enhancements:
- Email notifications for leave status
- SMS alerts for low attendance
- Biometric attendance integration
- Automated leave calculation
- Department-wise analytics
- Parent portal access
- Mobile app
- Advanced analytics dashboard

## Contributing

Improvements and suggestions are welcome!

## Support

For issues or questions, please contact the development team.

---

**Version**: 1.0.0  
**Last Updated**: March 2026
