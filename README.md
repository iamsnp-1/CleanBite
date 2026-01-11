# CleanBite - Food Safety Platform

A complete food safety platform with frontend and backend integration for vendor booking, reviews, and hygiene reporting.

## 🚀 Quick Start

### Backend Setup
1. Navigate to the `backend` folder
2. Double-click `start-server.bat` (Windows) or run:
   ```bash
   cd backend
   npm install
   npm start
   ```
3. Server will start on `http://localhost:3000`

### Frontend Access
1. Open any HTML file in your browser (homepage.html recommended)
2. Make sure the backend server is running for full functionality

## 📁 Project Structure

```
CleanBite/
├── backend/
│   ├── server.js           # Express server
│   ├── package.json        # Dependencies
│   ├── start-server.bat    # Windows startup script
│   └── data/              # JSON data storage (auto-created)
├── js/
│   └── api.js             # Frontend-backend integration
├── homepage.html          # Main landing page
├── booking.html           # Event booking system
├── profile.html           # User profile management
├── vendor detailpage.html # Vendor details with booking
├── login.html            # User authentication
├── signup.html           # User registration
└── report.html           # Hygiene reporting
```

## 🔧 Features Integrated

### ✅ User Authentication
- **Signup**: Create new user accounts
- **Login**: Authenticate existing users
- **Profile Management**: Update user information
- **Session Persistence**: Login state maintained across pages

### ✅ Booking System
- **Vendor Selection**: Choose from certified vendors
- **Event Booking**: Complete booking workflow
- **Booking History**: View past and current bookings
- **Real-time Notifications**: Booking confirmations
- **Auto-save**: Form data preserved during session

### ✅ Review System
- **Write Reviews**: Rate and review vendors
- **Star Ratings**: 5-star rating system
- **Comment System**: Detailed feedback

### ✅ Reporting System
- **Hygiene Reports**: Submit safety concerns
- **Issue Tracking**: Report status monitoring

### ✅ Data Persistence
- **JSON Storage**: File-based data storage
- **Auto-backup**: Data automatically saved
- **Local Storage**: Client-side form auto-save

## 🌐 API Endpoints

### Authentication
- `POST /api/signup` - Create new user
- `POST /api/login` - User login

### Bookings
- `POST /api/bookings` - Create booking
- `GET /api/bookings/:userId` - Get user bookings

### Reviews
- `POST /api/reviews` - Submit review

### Reports
- `POST /api/reports` - Submit hygiene report

### Profile
- `PUT /api/profile/:userId` - Update profile

## 💡 Usage Flow

1. **Start Backend**: Run `start-server.bat`
2. **Open Frontend**: Access `homepage.html`
3. **Create Account**: Use signup.html
4. **Login**: Use login.html
5. **Browse Vendors**: View vendor details
6. **Book Events**: Complete booking process
7. **Manage Profile**: Update user information

## 🔒 Security Features

- Input validation on all forms
- CORS protection
- Data sanitization
- Session management

## 📱 Responsive Design

- Mobile-friendly interface
- Dark/light mode support
- Touch-optimized interactions
- Progressive enhancement

## 🛠 Technical Stack

- **Frontend**: HTML5, CSS3, JavaScript, TailwindCSS
- **Backend**: Node.js, Express.js
- **Storage**: JSON files
- **Icons**: Material Symbols
- **Fonts**: Plus Jakarta Sans

## 🚨 Troubleshooting

### Backend Issues
- Ensure Node.js is installed
- Check port 3000 is available
- Verify file permissions for data folder

### Frontend Issues
- Enable JavaScript in browser
- Check browser console for errors
- Ensure backend server is running

### Data Issues
- Data stored in `backend/data/` folder
- Delete JSON files to reset data
- Backup data folder before updates

## 📈 Future Enhancements

- Real-time notifications
- Payment integration
- Advanced search filters
- Mobile app development
- Analytics dashboard

---

**CleanBite** - Ensuring street food is safe for everyone. 🍴✨