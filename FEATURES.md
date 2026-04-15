# System Features & Functionality

## Admin Dashboard

### Overview Statistics
- **Total Students**: Count of all registered students
- **Active Students**: Currently enrolled students
- **Today's Attendance**: Number of students marked present today
- **Pending Leaves**: Leave requests awaiting approval

### Admin Operations

#### 1. Student Management
**Home**: Admin Dashboard → Students

**Features:**
- Add new students with complete profile information
- Edit student details (except ID and roll number)
- Delete students (with confirmation)
- Reset student passwords anytime
- Search by student ID, name, roll number
- Filter by branch and semester
- View student attendance records

**Student Fields:**
- Personal: First Name, Last Name, Date of Birth, Email, Phone
- Academic: Student ID (Unique), Roll Number, Branch, Semester
- Contact: Address, Parent Name, Parent Phone
- System: Auto-created username (uses Student ID), auto-generated password

#### 2. Attendance Management
**Home**: Admin Dashboard → Mark Attendance

**Features:**
- Mark attendance for multiple students simultaneously
- Select date and subject
- Choose status: Present, Absent, Late, Leave
- Bulk operations reduce time

**Attendance Views:**
- Go to Reports → View summary attendance statistics
- Click "Details" next to student to see full attendance history
- Filter by branch or search by student/name
- Export all attendance data as CSV file

**Attendance Status:**
- **Present**: Student attended class
- **Absent**: Student didn't attend
- **Late**: Student came after class started
- **Leave**: Student was on approved leave

#### 3. Leave Management
**Home**: Admin Dashboard → Manage Leaves

**Features:**
- Review all leave requests from students
- Approve or reject with admin approval record
- Filter by status: Pending, Approved, Rejected
- View leave duration and reason
- Track approver and approval date

**Leave Types:**
- Sick Leave
- Casual Leave
- Medical Leave
- Emergency Leave

#### 4. Reports & Analytics
**Home**: Admin Dashboard → Reports

**Viewing:**
- Attendance percentage by student
- Color-coded status: Green (≥75%), Yellow (50-75%), Red (<50%)
- Branch-wise statistics
- Semester-wise breakdown

**Export Data:**
- Download as CSV file
- Compatible with Excel/Sheets
- Includes all attendance details

---

## Student Portal

### Dashboard Features
- **Personal Info**: Student ID, Roll Number, Branch, Semester
- **Statistics**:
  - Total Classes: Number of classes marked
  - Present: Number of classes attended
  - Absent: Number of absences
  - Attendance %: Present/Total × 100
- **Leave Summary**: Approved leaves and pending requests
- **Quick Access**: Links to attendance, leaves, and profile

### Student Operations

#### 1. View Attendance
**Home**: My Attendance

**Shows:**
- List of all attendance records
- Date and subject for each class
- Status with color indicators
- Remarks added by faculty
- Sorted by latest first

#### 2. Apply for Leave
**Home**: Apply Leave

**Process:**
1. Select leave type
2. Set start date and end date
3. Provide detailed reason
4. Submit request

**Duration Calculation:**
- System automatically calculates number of days
- End date must be after start date

**Status Tracking:**
- After submission, leave is in "Pending" status
- Admin reviews and approves/rejects
- Students get notification (via status page)
- Can apply multiple leaves

#### 3. View Leaves
**Home**: My Leaves

**Information:**
- Leave type and duration
- Start and end dates
- Reason provided
- Current status (Pending/Approved/Rejected)
- Approval date and approver name

#### 4. Update Profile
**Home**: My Profile

**Editable Fields:**
- Email address
- Phone number
- Parent/Guardian name
- Parent phone number

**Read-Only Fields:**
- Name (set by admin)
- Student ID
- Roll Number
- Branch and Semester
- Date of birth

---

## Login System

### Authentication
- **Username**: Student ID (for students) or assigned username (for admin)
- **Password**: Set by admin when creating student account
- **Session**: Automatically logs out after browser closes

### Password Management
- **Initial**: Admin sets temporary password (default: TempPassword@123)
- **Reset**: Admin can reset anytime from student management
- **Change**: Available through Django admin panel (/admin/)

---

## Database Architecture

### Student Table
```
- user (link to Django User)
- student_id (unique)
- roll_number (unique)
- email (unique)
- phone, date_of_birth
- branch, semester
- address
- parent_name, parent_phone
- admission_date
- is_active (true/false)
- created_at, updated_at
```

### Attendance Table
```
- student (foreign key to Student)
- date
- status (Present/Absent/Late/Leave)
- subject
- remarks
- marked_by (admin who marked)
- created_at (unique per student-date-subject)
```

### Leave Table
```
- student (foreign key to Student)
- leave_type
- start_date, end_date
- reason
- status (Pending/Approved/Rejected)
- approved_by (admin who approved)
- approval_date
- created_at, updated_at
```

### AttendancePolicy Table
```
- name
- minimum_percentage (e.g., 75%)
- description
- created_at, updated_at
```

---

## User Interface Features

### Navigation
- **Responsive Design**: Works on desktop, tablet, mobile
- **Sidebar Navigation**: Quick access to all features
- **Breadcrumbs**: Know your location in system
- **Search & Filter**: Find data quickly

### Visual Indicators
- **Badges**: Color-coded status badges
- **Progress Bars**: Attendance percentage visualization
- **Icons**: Font Awesome icons for clarity
- **Alerts**: Success/error/info messages

### Forms
- **Validation**: Client and server-side
- **Help Text**: Guidance for each field
- **Error Messages**: Clear error descriptions
- **Auto-fill**: Date-time pickers for dates

---

## Security Features

### Authentication
- Password hashing with Django's security
- Session-based authentication
- Login required for all pages
- Role-based access (admin vs student)

### Data Protection
- User cannot modify other user's data
- Admin-only operations protected
- CSRF token protection on forms
- SQL injection protection (Django ORM)

### Audit Trail
- created_at timestamp on all records
- updated_at timestamp on updates
- Approver tracking on leaves
- Last login tracking

---

## Advanced Features

### Filtering & Search
- Multi-field search (ID, name, email, roll number)
- Branch and semester filtering
- Status filtering on leaves
- Date range filtering

### Reports
- Attendance percentage calculation
- Branch-wise statistics
- CSV export functionality
- Printable reports

### Bulk Operations
- Mark attendance for entire class
- Add multiple students
- Filter large datasets

---

## Performance Considerations

### Optimizations
- Pagination for large lists
- Index on frequently searched fields
- Efficient queries with select_related/prefetch_related
- Static files collection for production

### Scalability
- Database normalized for efficiency
- Split into logical modules
- Ready for caching implementation
- Production-ready deployment configuration

---

## Customization Options

### Easy to Customize
- Branch list (in Student model)
- Semester count (1-8)
- Leave types
- Attendance statuses
- Minimum attendance percentage
- Colors and styling (CSS)

### Extension Points
- Add new models (e.g., Departments)
- Add new fields to existing models
- Create new views and pages
- Add email notifications
- Implement SMS alerts

---

## Workflow Examples

### Complete Attendance Workflow
1. **Admin marks attendance**
   - Opens Mark Attendance page
   - Selects date and subject
   - Checks students present
   - Marks attendance

2. **Student views attendance**
   - Login as student
   - Go to My Attendance
   - See all records
   - Track percentage

3. **Admin generates report**
   - Go to Reports
   - View statistics
   - Export as CSV

### Complete Leave Workflow
1. **Student applies for leave**
   - Click Apply Leave
   - Fill details and reason
   - Submit request

2. **Admin reviews leave**
   - Go to Manage Leaves
   - Check details
   - Approve or reject

3. **Student checks status**
   - Go to My Leaves
   - See updated status
   - View approver name

---

## Tips & Best Practices

### For Admins
- ✅ Create all students before semester starts
- ✅ Mark attendance daily for consistency
- ✅ Review and approve leaves promptly
- ✅ Use CSV export for backups
- ✅ Reset forgotten passwords quickly

### For Students
- ✅ Login regularly to check attendance
- ✅ Apply for leave in advance when possible
- ✅ Keep contact info updated
- ✅ Check leave approval status
- ✅ Report discrepancies to admin

---

## Common Scenarios

### Scenario 1: New Student Enrollment
1. Admin creates student account
2. System generates login credentials
3. Student logs in and updates profile
4. Student views empty attendance records
5. Admin starts marking attendance next class

### Scenario 2: Student Absent Due to Illness
1. Student applies for sick leave with medical reason
2. Admin receives notification (via system)
3. Admin approves sick leave
4. Absence automatically converted to leave
5. Doesn't count against attendance percentage

### Scenario 3: Attendance Check
1. Student views My Attendance anytime
2. See all classes with status
3. Calculate percentage automatically
4. Identify weaknesses
5. Plan to improve

### Scenario 4: End of Semester Report
1. Admin generates attendance report
2. Export as CSV
3. Analyze statistics by branch
4. Identify students below threshold
5. Share with department heads

---

**Note**: All features are designed for simplicity while maintaining data integrity and security.
