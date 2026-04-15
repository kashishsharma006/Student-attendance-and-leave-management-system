# System Workflow & Architecture

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      USERS                                  │
│          ┌──────────────┬──────────────┐                    │
│          │              │              │                    │
│      ADMIN          STUDENT          SUPERUSER              │
│   (Staff Users)   (Regular Users)   (Django Admin)          │
└─────────────────┬───────────────────┬──────────────────────┘
                  │                   │
        ┌─────────▼─────────┐    ┌────▼───────────┐
        │   AUTHENTICATION  │    │   DJANGO ORM   │
        └──────────────────┘    └────────────────┘
                  │                   │
        ┌─────────▼──────────────────▼────────┐
        │          DJANGO VIEWS (25+)         │
        │                                     │
        │  ├─ Auth Views                     │
        │  ├─ Admin Views                    │
        │  ├─ Student Views                  │
        │  └─ API Views                      │
        └─────────────┬──────────────────────┘
                      │
        ┌─────────────▼──────────────┐
        │  DATABASE MODELS (4)       │
        │  ├─ Student                │
        │  ├─ Attendance             │
        │  ├─ Leave                  │
        │  └─ AttendancePolicy       │
        └─────────────┬──────────────┘
                      │
        ┌─────────────▼──────────────┐
        │      SQLITE DATABASE       │
        │      (db.sqlite3)          │
        └────────────────────────────┘
```

---

## Data Flow Diagram

### Attendance Marking Flow
```
ADMIN
  │
  ├─ Login
  │  └─ Views: login_view()
  │     └─ Model: User Authentication
  │
  ├─ Go to Mark Attendance
  │  └─ Views: mark_attendance()
  │     └─ Model: Gets all active students
  │
  ├─ Fill Form (Date, Subject, Status)
  │  └─ Form: AttendanceForm
  │     └─ Validation: Client + Server side
  │
  └─ Submit
     └─ Views: Creates/Updates Attendance objects
        └─ Model: Attendance (with unique constraint)
           └─ Database: INSERT/UPDATE record
```

### Attendance Viewing Flow
```
STUDENT
  │
  ├─ Login
  │  └─ Views: login_view()
  │     └─ Model: User Authentication
  │
  ├─ Go to My Attendance
  │  └─ Views: student_attendance_view()
  │     └─ Query: Get all attendances for student
  │
  ├─ View Records
  │  └─ Template: attendance.html
  │     └─ Display: Date, Subject, Status
  │
  └─ See Statistics
     └─ Calculation: Present % = (Present / Total) × 100
```

### Leave Application Flow
```
STUDENT
  │
  ├─ Go to Apply Leave
  │  └─ Views: apply_leave()
  │     └─ Template: apply_leave.html
  │
  ├─ Fill Form (Type, Dates, Reason)
  │  └─ Form: LeaveForm
  │     └─ Validation: Start < End date
  │
  └─ Submit
     └─ Views: Creates Leave object with status="Pending"
        └─ Model: Leave
           └─ Database: INSERT record

ADMIN
  │
  ├─ Go to Manage Leaves
  │  └─ Views: manage_leaves()
  │     └─ Query: Get all pending leaves
  │
  ├─ Review Leave Request
  │  └─ Shows: Student, Type, Duration, Reason
  │
  └─ Approve/Reject
     └─ Views: approve_leave() or reject_leave()
        └─ Model: Updates Leave status & approver
           └─ Database: UPDATE record
```

---

## Database Relationship Diagram

```
                    ┌──────────────────┐
                    │   django_user    │
                    │  (Auth Module)   │
                    │  - id (PK)       │
                    │  - username      │
                    │  - password      │
                    │  - email         │
                    │  - is_staff      │
                    └────────┬─────────┘
                             │
                             │ 1:1 (OneToOneField)
                             │
                    ┌────────▼──────────┐
                    │     Student       │
                    │  - id (PK)        │
                    │  - user (FK)      │────────┐
                    │  - student_id     │        │
                    │  - roll_number    │        │
                    │  - branch         │        │
                    │  - semester       │        │
                    │  - ... (details)  │        │
                    └────────┬──────────┘        │
                             │                  │
              ┌──────────────┼──────────────┐   │
              │              │              │   │
          1:M │          1:M │              │   │
              │              │              │   │
    ┌─────────▼────┐ ┌──────▼────┐ ┌───────▼──────────┐
    │ Attendance   │ │   Leave    │ │ AttendancePolicy │
    │ - id (PK)    │ │ - id (PK)  │ │ - id (PK)        │
    │ - student(FK)│ │-student(FK)│ │ - name           │
    │ - date       │ │ - leave_type   │ - min_percent  │
    │ - status     │ │ - start_date   │ - description│
    │ - subject    │ │ - end_date     │ - ...        │
    │ - remarks    │ │ - reason       │              │
    │ - marked_by  │ │ - status       │              │
    │ - ...        │ │ - approved_by  │              │
    └──────────────┘ │ - approval_date│              │
                     │ - ...          │              │
                     └────────────────┘              │
                                                    │
                                            └────────┘
```

---

## URL Routing Diagram

```
http://localhost:8000
                      │
                      ├─ / ──────────────────────┐ login_view()
                      │                          │
                      ├─ /login/ ────────────────┐ login_view()
                      │                          │
                      ├─ /logout/ ───────────────┐ logout_view()
                      │                          │
                      ├─ /dashboard/ ────────────┐ dashboard()
                      │                          │
                      ├─ /admin/ ────────────────┐ Django Admin
                      │
                      ├─ /admin/dashboard/ ──────┐ admin_dashboard()
                      │
                      ├─ /admin/students/ ───────┬─ manage_students()
                      │                          │
                      │  ├─ add/               ──┐ add_student()
                      │  │
                      │  ├─ <id>/edit/        ──┐ edit_student()
                      │  │
                      │  └─ <id>/delete/      ──┐ delete_student()
                      │
                      ├─ /admin/attendance/
                      │
                      │  ├─ mark/            ──┐ mark_attendance()
                      │  │
                      │  ├─ reports/         ──┐ attendance_reports()
                      │  │
                      │  ├─ <id>/            ──┐ student_attendance_detail()
                      │  │
                      │  └─ export/          ──┐ export_attendance_report()
                      │
                      ├─ /admin/leaves/
                      │
                      │  ├─ <id>/approve/   ──┐ approve_leave()
                      │  │
                      │  └─ <id>/reject/    ──┐ reject_leave()
                      │
                      └─ /student/
                         │
                         ├─ dashboard/     ──┐ student_dashboard()
                         │
                         ├─ attendance/    ──┐ student_attendance_view()
                         │
                         ├─ leaves/
                         │  ├─ apply/       ──┐ apply_leave()
                         │  │
                         │  └─ view/        ──┐ view_leaves()
                         │
                         └─ profile/       ──┐ student_profile()
```

---

## Template Hierarchy

```
base.html (Master Template)
   │
   ├─ Navbar (Navigation)
   ├─ Main Content
   └─ Footer

   ├─ login.html (No navbar)
   │
   ├─ admin/
   │  ├─ dashboard.html
   │  ├─ manage_students.html
   │  ├─ add_student.html
   │  ├─ edit_student.html
   │  ├─ delete_student.html
   │  ├─ reset_password.html
   │  ├─ mark_attendance.html
   │  ├─ attendance_reports.html
   │  ├─ student_attendance_detail.html
   │  ├─ manage_leaves.html
   │  ├─ approve_leave.html
   │  └─ reject_leave.html
   │
   └─ student/
      ├─ dashboard.html
      ├─ attendance.html
      ├─ apply_leave.html
      ├─ view_leaves.html
      └─ profile.html
```

---

## User Role & Permissions

### SUPERUSER/ADMIN
```
✅ Full system access
✅ Add/Edit/Delete students
✅ Mark attendance
✅ View all reports
✅ Approve/Reject leaves
✅ Reset passwords
✅ Export data
✅ Access Django admin

✗ Cannot edit own profile from interface
✗ Cannot apply for leave as student
```

### REGULAR STUDENT
```
✅ View own attendance records
✅ Apply for leave
✅ View leave status
✅ Update own profile
✅ View dashboard statistics
✅ View personal leave history

✗ Cannot mark attendance
✗ Cannot view other student's records
✗ Cannot access admin features
✗ Cannot modify attendance
```

### SUPERUSER (Django Admin)
```
✅ Everything admin can do
✅ Manage users and groups
✅ Database access
✅ Advanced queries
✅ Bulk operations
```

---

## State Transitions

### Leave Status Flow
```
┌─────────────┐
│   PENDING   │ (Initial state after student applies)
└──────┬──────┘
       │
       ├─────────────────────────────────┐
       │                                 │
    (Approve)                        (Reject)
       │                                 │
       ▼                                 ▼
┌─────────────┐                    ┌─────────────┐
│  APPROVED   │                    │  REJECTED   │
└─────────────┘                    └─────────────┘
(Admin can view)                (Student notified)
```

### Student Active Status Flow
```
┌─────────────┐
│   ACTIVE    │ (Default - can login & view records)
└──────┬──────┘
       │ (Admin deactivates)
       ▼
┌─────────────┐
│  INACTIVE   │ (Cannot login - records archived)
└─────────────┘
```

### Attendance Recording
```
Single Class
   │
   ├─ Date + Subject (Unique Key)
   │
   ├─ Student Records:
   │  ├─ Present (Counts to attendance %)
   │  ├─ Absent  (Counts against attendance %)
   │  ├─ Late    (May count to attendance %)
   │  └─ Leave   (Excluded from calculation)
   │
   └─ Can be edited by admin anytime
```

---

## Data Processing Flow

### When Admin Marks Attendance
```
1. Admin fills form
2. Client-side validation (JavaScript)
3. Form submission
4. Server receives request
5. CSRF validation
6. User authentication check
7. Form validation (backend)
8. Database unique constraint check
9. Create/Update Attendance record
10. Return success message
11. Redirect to next page
```

### When Student Views Attendance
```
1. Student navigates to attendance page
2. Check authentication (login required)
3. Query: Get all attendances for student
4. Filter: Order by date DESC
5. Calculate: Present count, Total count, Percentage
6. Render template with data
7. Display: List of all attendances + stats
8. Return HTML to browser
```

### When Generating Report
```
1. Admin navigates to reports
2. Apply filters (branch, semester, search)
3. Query database for matching students
4. For each student:
   - Count total attendance records
   - Count present records
   - Count absent records
   - Calculate percentage
5. Sort by percentage
6. Render in template with color coding
```

---

## Security Flow

### Login Process
```
1. User enters username & password
2. Form submitted via POST (CSRF token included)
3. CSRF validation
4. Username/password authentication
5. Django checks against User table
6. Hash comparison (password not stored plain)
7. Session created on success
8. Redirect to appropriate dashboard
9. Failed attempt: Error message, stay on login
```

### Access Control
```
Every Protected View:
1. @login_required decorator
2. Check if user is authenticated
3. Check if user is staff (for admin views)
4. Check if user is owner (for student views)
5. Render or redirect to login
```

---

## Performance Considerations

### Database Queries
```
Optimized Queries:
- select_related() for foreign keys
- Filter before query
- Limit results with pagination
- Index on frequently searched fields
```

### Frontend Optimization
```
- CDN for Bootstrap & Font Awesome
- Minified CSS & JavaScript
- Static file collection
- Browser caching headers
```

### Caching Strategy
```
Future improvements:
- Cache dashboard statistics
- Cache attendance calculations
- Cache reports data
```

---

## Backup & Recovery

### Database Backup
```
SQLite:
- Copy db.sqlite3 file

JSON Export:
- python manage.py dumpdata > backup.json
- Includes all data + timestamps

CSV Export:
- From admin interface
- Formatted for Excel
```

### Data Recovery
```
From JSON:
- python manage.py loaddata backup.json
- Restores exact state

From CSV:
- Manual import (not automated currently)
```

---

## System Scalability

### Current Design
```
- SQLite: Good for < 1000 users
- Single Django server
- In-memory sessions
- No caching layer
```

### For Large Scale
```
Recommended upgrades:
- PostgreSQL database
- Multiple Django servers
- Redis caching
- Load balancer (Nginx)
- Separate databases for reads
```

---

## Monitoring & Logging

### Currently Implemented
```
✅ Django error logging
✅ Database transaction logging
✅ User action timestamps
✅ Admin action tracking
```

### Should Add for Production
```
- Error tracking (Sentry)
- Performance monitoring
- User activity logs
- Database query profiling
- Email alerts for errors
```

---

**This architecture ensures a scalable, secure, and maintainable system!**
