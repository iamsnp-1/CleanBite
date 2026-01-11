// Local Storage Functions
function saveToLocalStorage(key, data) {
    localStorage.setItem(`cleanbite_${key}`, JSON.stringify(data));
}

function getFromLocalStorage(key) {
    const data = localStorage.getItem(`cleanbite_${key}`);
    return data ? JSON.parse(data) : null;
}

function autoSaveForm(formId) {
    const form = document.querySelector(formId);
    if (!form) return;
    
    const inputs = form.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
        input.addEventListener('input', () => {
            const formData = {};
            inputs.forEach(field => {
                if (field.name || field.id) {
                    formData[field.name || field.id] = field.value;
                }
            });
            saveToLocalStorage(`form_${formId.replace('#', '')}`, formData);
        });
    });
}

function loadFormData(formId) {
    const savedData = getFromLocalStorage(`form_${formId.replace('#', '')}`);
    if (!savedData) return;
    
    const form = document.querySelector(formId);
    if (!form) return;
    
    Object.keys(savedData).forEach(key => {
        const field = form.querySelector(`[name="${key}"], #${key}`);
        if (field && savedData[key]) {
            field.value = savedData[key];
        }
    });
}

// CleanBite Frontend-Backend Integration
const API_BASE = 'http://localhost:3000/api';
let currentUser = JSON.parse(localStorage.getItem('cleanbite_user')) || null;

// User Authentication
async function handleSignup(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    
    try {
        const response = await fetch(`${API_BASE}/signup`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                name: formData.get('name'),
                mobile: formData.get('mobile'),
                password: formData.get('password')
            })
        });
        
        const result = await response.json();
        if (result.success) {
            // Create user object and save to localStorage
            const newUser = {
                id: result.userId,
                name: formData.get('name'),
                mobile: formData.get('mobile')
            };
            localStorage.setItem('cleanbite_user', JSON.stringify(newUser));
            
            alert('Account created successfully!');
            window.location.href = 'homepage.html';
        } else {
            alert(result.error);
        }
    } catch (error) {
        alert('Network error. Please try again.');
    }
}

async function handleLogin(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    
    try {
        const response = await fetch(`${API_BASE}/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                mobile: formData.get('mobile'),
                password: formData.get('password')
            })
        });
        
        const result = await response.json();
        if (result.success) {
            localStorage.setItem('cleanbite_user', JSON.stringify(result.user));
            window.location.href = 'homepage.html';
        } else {
            alert(result.error);
        }
    } catch (error) {
        alert('Network error. Please try again.');
    }
}

// Booking System
async function handleBooking(event) {
    if (event) event.preventDefault();
    if (!currentUser) {
        alert('Please login first');
        return;
    }
    
    const button = document.querySelector('button[onclick="handleBooking()"]');
    const originalText = button.innerHTML;
    
    // Show loading state
    button.innerHTML = `
        <div class="flex items-center justify-center gap-2">
            <div class="animate-spin rounded-full h-5 w-5 border-b-2 border-slate-900"></div>
            <span>Processing...</span>
        </div>
    `;
    button.disabled = true;
    
    const eventType = document.querySelector('select.form-input-refined').value;
    const date = document.querySelector('input[type="date"]').value;
    const location = document.querySelector('input[placeholder*="Stanford"]').value;
    const requirements = document.querySelector('textarea.form-input-refined').value;
    
    if (!eventType || !date || !location) {
        button.innerHTML = originalText;
        button.disabled = false;
        alert('Please fill in all required fields');
        return;
    }
    
    // Get selected vendor or use default
    const selectedVendor = JSON.parse(localStorage.getItem('cleanbite_selected_vendor') || 'null');
    const vendorData = selectedVendor || {
        id: 'taco-loco',
        name: 'Taco Loco Truck'
    };
    
    try {
        const response = await fetch(`${API_BASE}/bookings`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                vendorId: vendorData.id,
                vendorName: vendorData.name,
                eventType,
                date,
                location,
                requirements,
                userId: currentUser.id
            })
        });
        
        const result = await response.json();
        if (result.success) {
            // Success animation
            button.innerHTML = `
                <div class="flex items-center justify-center gap-2">
                    <span class="material-symbols-outlined text-green-600 animate-bounce">check_circle</span>
                    <span>Booking Sent!</span>
                </div>
            `;
            
            localStorage.removeItem('cleanbite_booking_form');
            localStorage.removeItem('cleanbite_selected_vendor');
            showBookingNotification('Booking request sent successfully! You will receive confirmation within 24 hours.', 'success');
            
            // Clear form fields with animation
            const fields = [document.querySelector('select.form-input-refined'), document.querySelector('input[type="date"]'), document.querySelector('input[placeholder*="Stanford"]'), document.querySelector('textarea.form-input-refined')];
            fields.forEach((field, index) => {
                setTimeout(() => {
                    field.style.transform = 'scale(0.95)';
                    field.style.opacity = '0.5';
                    setTimeout(() => {
                        field.value = '';
                        field.style.transform = 'scale(1)';
                        field.style.opacity = '1';
                    }, 200);
                }, index * 100);
            });
            
            setTimeout(() => {
                button.innerHTML = originalText;
                button.disabled = false;
                loadBookingsOnBookingPage();
            }, 2000);
        } else {
            button.innerHTML = originalText;
            button.disabled = false;
            alert('Booking failed. Please try again.');
        }
    } catch (error) {
        button.innerHTML = originalText;
        button.disabled = false;
        alert('Network error. Please try again.');
    }
}

// Show booking notification
function showBookingNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = 'fixed top-4 right-4 z-50 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-700 rounded-lg shadow-2xl transform translate-x-full transition-all duration-500 max-w-sm';
    
    notification.innerHTML = `
        <div class="p-4">
            <div class="flex items-start gap-3">
                <div class="flex-shrink-0">
                    <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center animate-pulse">
                        <span class="material-symbols-outlined text-white text-sm">check_circle</span>
                    </div>
                </div>
                <div class="flex-1 min-w-0">
                    <div class="flex items-center justify-between mb-1">
                        <p class="text-sm font-semibold text-gray-900 dark:text-white">Booking Confirmed</p>
                        <span class="text-xs text-gray-500 dark:text-gray-400">now</span>
                    </div>
                    <p class="text-sm text-gray-600 dark:text-gray-300 leading-relaxed">${message}</p>
                    <div class="flex items-center gap-2 mt-3">
                        <button onclick="this.closest('.fixed').style.transform='translateX(100%)'; setTimeout(() => this.closest('.fixed').remove(), 300)" class="text-xs text-primary hover:text-primary-dark font-medium transition-colors">View Details</button>
                        <button onclick="this.closest('.fixed').style.transform='translateX(100%)'; setTimeout(() => this.closest('.fixed').remove(), 300)" class="text-xs text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 transition-colors">Dismiss</button>
                    </div>
                </div>
                <button onclick="this.closest('.fixed').style.transform='translateX(100%)'; setTimeout(() => this.closest('.fixed').remove(), 300)" class="flex-shrink-0 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 transition-colors hover:scale-110">
                    <span class="material-symbols-outlined text-sm">close</span>
                </button>
            </div>
        </div>
        <div class="h-1 bg-gradient-to-r from-primary to-primary-dark rounded-b-lg animate-pulse"></div>
    `;
    
    document.body.appendChild(notification);
    
    // Slide in animation
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
    }, 100);
    
    // Auto dismiss after 8 seconds
    setTimeout(() => {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => notification.remove(), 300);
    }, 8000);
}

// Load and display user bookings on booking page
async function loadBookingsOnBookingPage() {
    if (!currentUser) return;
    
    try {
        const response = await fetch(`${API_BASE}/bookings/${currentUser.id}`);
        const bookings = await response.json();
        
        if (bookings.length > 0) {
            // Create bookings section
            const bookingsSection = document.createElement('div');
            bookingsSection.className = 'bg-white dark:bg-slate-900 rounded-3xl shadow-premium border border-slate-100 dark:border-slate-800 p-8 md:p-12 mb-12';
            
            bookingsSection.innerHTML = `
                <div class="mb-8 flex items-center gap-4">
                    <div class="size-12 rounded-2xl bg-primary/10 flex items-center justify-center text-primary-dark">
                        <span class="material-symbols-outlined">calendar_month</span>
                    </div>
                    <div>
                        <h2 class="text-2xl font-extrabold text-slate-900 dark:text-white">My Event Bookings</h2>
                        <p class="text-slate-500 text-sm">${bookings.length} booking${bookings.length > 1 ? 's' : ''} found</p>
                    </div>
                </div>
                <div class="grid gap-4">
                    ${bookings.map(booking => `
                        <div class="p-4 bg-slate-50 dark:bg-slate-800/40 rounded-2xl border border-slate-100 dark:border-slate-800">
                            <div class="flex justify-between items-start mb-2">
                                <h4 class="font-bold text-slate-900 dark:text-white">${booking.vendorName}</h4>
                                <span class="px-2 py-1 bg-primary/20 text-primary text-xs font-bold rounded">${booking.status}</span>
                            </div>
                            <div class="grid grid-cols-2 gap-4 text-sm text-slate-600 dark:text-slate-400">
                                <p><strong>Event:</strong> ${booking.eventType}</p>
                                <p><strong>Date:</strong> ${new Date(booking.date).toLocaleDateString()}</p>
                                <p class="col-span-2"><strong>Location:</strong> ${booking.location}</p>
                                ${booking.requirements ? `<p class="col-span-2"><strong>Requirements:</strong> ${booking.requirements}</p>` : ''}
                            </div>
                        </div>
                    `).join('')}
                </div>
            `;
            
            // Insert before the main booking form
            const mainContent = document.querySelector('.max-w-\\[900px\\]');
            const firstChild = mainContent.firstElementChild;
            mainContent.insertBefore(bookingsSection, firstChild);
        }
    } catch (error) {
        console.error('Error loading bookings:', error);
    }
}

// Load and display user bookings
async function loadUserBookings() {
    if (!currentUser) return;
    
    try {
        const response = await fetch(`${API_BASE}/bookings/${currentUser.id}`);
        const bookings = await response.json();
        
        const bookingCard = document.querySelector('.group.cursor-pointer.flex.flex-col.gap-4');
        if (bookingCard && bookings.length > 0) {
            const latestBooking = bookings[bookings.length - 1];
            const bookingText = bookingCard.querySelector('p.text-\\[\\#6b8072\\]');
            if (bookingText) {
                bookingText.textContent = `${latestBooking.vendorName} - ${latestBooking.eventType} on ${new Date(latestBooking.date).toLocaleDateString()}`;
            }
            
            const statusBadge = bookingCard.querySelector('span.bg-emerald-100');
            if (statusBadge) {
                statusBadge.textContent = bookings.length + ' Total';
            }
            
            // Add click handler to view all bookings
            bookingCard.onclick = () => showBookingsModal(bookings);
        }
    } catch (error) {
        console.error('Error loading bookings:', error);
    }
}

// Show bookings modal
function showBookingsModal(bookings) {
    const modal = document.createElement('div');
    modal.className = 'fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4';
    
    const bookingsList = bookings.map(booking => `
        <div class="bg-white dark:bg-[#1c2620] p-4 rounded-lg border border-[#dee3e0] dark:border-[#2d3a31] mb-3">
            <div class="flex justify-between items-start mb-2">
                <h4 class="font-bold text-[#131614] dark:text-white">${booking.vendorName}</h4>
                <span class="px-2 py-1 bg-primary/20 text-primary text-xs font-bold rounded">${booking.status}</span>
            </div>
            <p class="text-sm text-[#6b8072] mb-1"><strong>Event:</strong> ${booking.eventType}</p>
            <p class="text-sm text-[#6b8072] mb-1"><strong>Date:</strong> ${new Date(booking.date).toLocaleDateString()}</p>
            <p class="text-sm text-[#6b8072] mb-1"><strong>Location:</strong> ${booking.location}</p>
            ${booking.requirements ? `<p class="text-sm text-[#6b8072]"><strong>Requirements:</strong> ${booking.requirements}</p>` : ''}
        </div>
    `).join('');
    
    modal.innerHTML = `
        <div class="bg-white dark:bg-[#1c2620] rounded-xl w-full max-w-2xl max-h-[80vh] overflow-auto">
            <div class="flex items-center justify-between p-6 border-b border-[#dee3e0] dark:border-[#2d3a31]">
                <h3 class="text-xl font-bold text-[#131614] dark:text-white">My Event Bookings</h3>
                <button onclick="this.closest('.fixed').remove()" class="text-[#6b8072] hover:text-[#131614] dark:hover:text-white">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <div class="p-6">
                ${bookingsList || '<p class="text-center text-[#6b8072]">No bookings found</p>'}
            </div>
        </div>
    `;
    
    document.body.appendChild(modal);
}

// Review System
async function submitReview() {
    if (!currentUser) {
        alert('Please login first');
        return;
    }
    
    const rating = currentRating;
    const comment = document.querySelector('#reviewModal textarea').value;
    
    if (!rating || !comment) {
        alert('Please provide rating and comment');
        return;
    }
    
    try {
        const response = await fetch(`${API_BASE}/reviews`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                vendorId: 'taco-loco',
                rating,
                comment,
                userId: currentUser.id
            })
        });
        
        const result = await response.json();
        if (result.success) {
            showNotification('Review submitted successfully!', 'success');
            closeReviewModal();
        } else {
            alert('Review submission failed');
        }
    } catch (error) {
        alert('Network error. Please try again.');
    }
}

// Report System
async function handleReport(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    
    const button = event.target.querySelector('button[type="submit"]');
    const originalText = button.innerHTML;
    
    button.innerHTML = '<div class="flex items-center justify-center gap-2"><div class="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>Submitting...</div>';
    button.disabled = true;
    
    try {
        const response = await fetch(`${API_BASE}/reports`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                vendorId: formData.get('vendor'),
                issueType: formData.get('issue'),
                description: formData.get('description'),
                photo: null // Photo handling would need additional implementation
            })
        });
        
        const result = await response.json();
        if (result.success) {
            button.innerHTML = '<span class="material-symbols-outlined">check_circle</span> Report Submitted!';
            setTimeout(() => {
                event.target.reset();
                button.innerHTML = originalText;
                button.disabled = false;
            }, 2000);
        } else {
            throw new Error('Submission failed');
        }
    } catch (error) {
        button.innerHTML = 'Submission Failed';
        setTimeout(() => {
            button.innerHTML = originalText;
            button.disabled = false;
        }, 2000);
    }
}

// Profile Management
async function saveProfile() {
    if (!currentUser) return;
    
    const newName = document.getElementById('nameInput').value.trim();
    if (!newName) return;
    
    const button = document.querySelector('button[onclick="saveProfile()"]');
    const originalText = button.textContent;
    
    button.innerHTML = '<div class="flex items-center justify-center gap-2"><div class="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>Saving...</div>';
    button.disabled = true;
    
    try {
        const response = await fetch(`${API_BASE}/profile/${currentUser.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name: newName })
        });
        
        const result = await response.json();
        if (result.success) {
            currentUser.name = newName;
            localStorage.setItem('cleanbite_user', JSON.stringify(currentUser));
            document.getElementById('userName').textContent = newName;
            
            button.innerHTML = '<span class="material-symbols-outlined">check</span> Saved!';
            setTimeout(() => {
                closeEditModal();
                button.innerHTML = originalText;
                button.disabled = false;
            }, 1500);
        } else {
            throw new Error('Save failed');
        }
    } catch (error) {
        button.innerHTML = 'Save Failed';
        setTimeout(() => {
            button.innerHTML = originalText;
            button.disabled = false;
        }, 2000);
    }
}

// Initialize page-specific functionality
document.addEventListener('DOMContentLoaded', function() {
    // Update UI based on login status
    if (currentUser) {
        const userNameElements = document.querySelectorAll('[data-user-name]');
        userNameElements.forEach(el => el.textContent = currentUser.name);
        
        // Update profile page with user info
        if (window.location.pathname.includes('profile.html')) {
            const userNameEl = document.getElementById('userName');
            const nameInputEl = document.getElementById('nameInput');
            if (userNameEl) userNameEl.textContent = currentUser.name;
            if (nameInputEl) nameInputEl.value = currentUser.name;
            
            loadUserBookings();
            // Show sign out section for logged in users
            const signOutSection = document.querySelector('.flex.flex-col.items-center.pt-8.border-t');
            if (signOutSection) {
                signOutSection.style.display = 'flex';
            }
        }
    } else {
        // Hide sign out section if not logged in
        if (window.location.pathname.includes('profile.html')) {
            const signOutSection = document.querySelector('.flex.flex-col.items-center.pt-8.border-t');
            if (signOutSection) {
                signOutSection.style.display = 'none';
            }
        }
    }
    
    // Auto-save forms based on page
    if (window.location.pathname.includes('signup.html')) {
        autoSaveForm('form');
        loadFormData('form');
    }
    
    if (window.location.pathname.includes('login.html')) {
        autoSaveForm('form');
        loadFormData('form');
    }
    
    if (window.location.pathname.includes('booking.html')) {
        // Load existing bookings
        if (currentUser) {
            loadBookingsOnBookingPage();
        }
        
        // Auto-save booking form fields
        const bookingInputs = document.querySelectorAll('select, input[type="date"], input[placeholder*="Stanford"], textarea');
        bookingInputs.forEach((input, index) => {
            input.id = input.id || `booking_field_${index}`;
            input.addEventListener('input', () => {
                const bookingData = {
                    eventType: document.querySelector('select').value,
                    date: document.querySelector('input[type="date"]').value,
                    location: document.querySelector('input[placeholder*="Stanford"]').value,
                    requirements: document.querySelector('textarea').value
                };
                saveToLocalStorage('booking_form', bookingData);
            });
        });
        
        // Load saved booking data
        const savedBooking = getFromLocalStorage('booking_form');
        if (savedBooking) {
            if (savedBooking.eventType) document.querySelector('select').value = savedBooking.eventType;
            if (savedBooking.date) document.querySelector('input[type="date"]').value = savedBooking.date;
            if (savedBooking.location) document.querySelector('input[placeholder*="Stanford"]').value = savedBooking.location;
            if (savedBooking.requirements) document.querySelector('textarea').value = savedBooking.requirements;
        }
    }
    
    if (window.location.pathname.includes('report.html')) {
        // Auto-save report form
        const reportInputs = document.querySelectorAll('select, textarea');
        reportInputs.forEach(input => {
            input.addEventListener('input', () => {
                const reportData = {
                    vendor: document.querySelector('select').value,
                    description: document.querySelector('textarea').value
                };
                saveToLocalStorage('report_form', reportData);
            });
        });
        
        // Load saved report data
        const savedReport = getFromLocalStorage('report_form');
        if (savedReport) {
            if (savedReport.vendor) document.querySelector('select').value = savedReport.vendor;
            if (savedReport.description) document.querySelector('textarea').value = savedReport.description;
        }
    }
    
    // Make functions globally available
    window.handleBooking = handleBooking;
    window.submitReview = submitReview;
    window.saveProfile = saveProfile;
    window.loadUserBookings = loadUserBookings;
    
    // Attach form handlers based on page
    const signupForm = document.querySelector('form[action*="signup"]');
    if (signupForm) signupForm.addEventListener('submit', handleSignup);
    
    const loginForm = document.querySelector('form[action*="login"]');
    if (loginForm) loginForm.addEventListener('submit', handleLogin);
    
    const bookingForm = document.querySelector('form[action*="booking"]');
    if (bookingForm) bookingForm.addEventListener('submit', handleBooking);
    
    const reportForm = document.querySelector('form[action*="report"]');
    if (reportForm) reportForm.addEventListener('submit', handleReport);
});