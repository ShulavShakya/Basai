<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("role") == null || !"renter".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "profile");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai — My Profile</title>
    <link rel="stylesheet" href="css/renter.css">
</head>

<body>

<!-- Topbar (no sidebar on profile page per design) -->
<div style="width:100%;">
    <header class="topbar" style="margin-left:0;position:sticky;top:0;">
        <div class="topbar-left">
                        <span
                                style="font-family:'Sora',sans-serif;font-size:1.1rem;font-weight:700;color:var(--navy);">Basai</span>
            <span style="color:var(--border);margin:0 8px;">|</span>
            <a href="dashboard.jsp" class="topbar-link">Home</a>
            <a href="browse.jsp" class="topbar-link">Search Rooms</a>
            <a href="dashboard.jsp" class="topbar-link">Dashboard</a>
            <a href="profile.jsp" class="topbar-link active">Profile</a>
        </div>
        <div class="topbar-actions">
            <div class="topbar-search">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <circle cx="11" cy="11" r="8" stroke-width="2" />
                    <path d="m21 21-4.35-4.35" stroke-width="2" />
                </svg>
                <input type="text" placeholder="Search...">
            </div>
            <button class="topbar-btn-primary">Logout</button>
        </div>
    </header>

    <div class="page-body" style="max-width:900px;margin:0 auto;">
        <div class="page-header">
            <div class="page-title" style="font-size:2rem;">My Profile</div>
            <div class="page-subtitle">Manage your urban residence details and account security in one
                streamlined architectural interface.</div>
        </div>

        <div class="profile-layout">
            <!-- Left Sidebar -->
            <div>
                <div class="profile-sidebar-card">
                    <div class="profile-sidebar-img">
                        <span style="font-size:3rem;opacity:.3;">👤</span>
                        <div
                                style="position:absolute;bottom:10px;left:10px;background:var(--navy);color:#fff;font-size:.62rem;font-weight:700;padding:3px 8px;border-radius:999px;letter-spacing:.5px;text-transform:uppercase;">
                            Premium Member</div>
                        <div
                                style="position:absolute;bottom:30px;left:10px;font-size:.82rem;font-weight:700;color:#fff;">
                            Lalitpur Heights Residence</div>
                        <style>
                            .profile-sidebar-img {
                                position: relative;
                            }
                        </style>
                    </div>
                    <div class="profile-sidebar-body" style="padding:14px 12px;">
                        <div
                                style="font-size:.72rem;color:var(--text-muted);margin-bottom:10px;padding:0 4px;">
                            300×300</div>
                        <a href="#personal" class="profile-nav-item active"
                           onclick="showSection('personal',this)">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" stroke-width="2" />
                                <circle cx="12" cy="7" r="4" stroke-width="2" />
                            </svg>
                            Personal Information
                        </a>
                        <a href="#account" class="profile-nav-item" onclick="showSection('account',this)">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2" stroke-width="2" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke-width="2" />
                            </svg>
                            Account &amp; Security
                        </a>
                        <a href="#verification" class="profile-nav-item"
                           onclick="showSection('verification',this)">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <rect x="2" y="5" width="20" height="14" rx="2" stroke-width="2" />
                                <path d="M2 10h20" stroke-width="2" />
                            </svg>
                            ID Verification
                        </a>
                    </div>
                </div>
            </div>

            <!-- Right Content -->
            <div>
                <!-- Personal Information -->
                <div id="section-personal" class="card" style="margin-bottom:20px;">
                    <div class="card-body">
                        <div class="profile-section-title">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <rect x="3" y="4" width="18" height="18" rx="2" stroke-width="2" />
                                <line x1="16" y1="2" x2="16" y2="6" stroke-width="2" />
                                <line x1="8" y1="2" x2="8" y2="6" stroke-width="2" />
                                <line x1="3" y1="10" x2="21" y2="10" stroke-width="2" />
                            </svg>
                            Personal Information
                        </div>
                        <form action="ProfileServlet" method="post" id="personalForm">
                            <input type="hidden" name="section" value="personal">
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <div class="profile-field-value">Aaryan Sharma</div>
                                    <input type="text" name="fullName" class="form-input"
                                           value="Aaryan Sharma" style="display:none;" id="input-fullName">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Email Address</label>
                                    <div class="profile-field-value">aaryan.sharma@example.com</div>
                                    <input type="email" name="email" class="form-input"
                                           value="aaryan.sharma@example.com" style="display:none;"
                                           id="input-email">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">Phone Number</label>
                                    <div class="profile-field-value">+977 9801234567</div>
                                    <input type="tel" name="phone" class="form-input"
                                           value="+977 9801234567" style="display:none;" id="input-phone">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Permanent Address</label>
                                    <div class="profile-field-value">Jhamsikhel, Lalitpur, Nepal</div>
                                    <input type="text" name="address" class="form-input"
                                           value="Jhamsikhel, Lalitpur, Nepal" style="display:none;"
                                           id="input-address">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Account Settings -->
                <div id="section-account" class="card" style="margin-bottom:20px;display:none;">
                    <div class="card-body">
                        <div class="profile-section-title" style="justify-content:space-between;">
                                        <span style="display:flex;align-items:center;gap:8px;">
                                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="16"
                                                 height="16">
                                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"
                                                      stroke-width="2" />
                                                <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke-width="2" />
                                            </svg>
                                            Account Settings
                                        </span>
                            <button class="btn btn-outline btn-sm" onclick="toggleEdit()">✏ Edit
                                Details</button>
                        </div>
                        <form action="ProfileServlet" method="post">
                            <input type="hidden" name="section" value="account">
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">Username</label>
                                    <input type="text" name="username" class="form-input"
                                           value="aaryan_urbano_24" readonly id="usernameInput">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Password</label>
                                    <div class="input-icon-wrap">
                                        <input type="password" name="password" class="form-input"
                                               value="••••••••••••••" readonly id="passwordInput">
                                        <button type="button" class="eye-btn" onclick="togglePwd()">
                                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                                 width="16" height="16">
                                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"
                                                      stroke-width="2" />
                                                <circle cx="12" cy="12" r="3" stroke-width="2" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- ID Verification -->
                <div id="section-verification" class="card" style="margin-bottom:20px;display:none;">
                    <div class="card-body">
                        <div class="profile-section-title">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="16"
                                 height="16">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" stroke-width="2" />
                            </svg>
                            Upload Identification
                        </div>
                        <p
                                style="font-size:.82rem;color:var(--text-muted);margin-bottom:16px;font-style:italic;">
                            Mandatory for secure lease agreements. We accept citizenship cards, driving
                            licenses, or passports.</p>
                        <div class="upload-zone" onclick="document.getElementById('idUpload').click()">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <polyline points="16 16 12 12 8 16" stroke-width="2" />
                                <line x1="12" y1="12" x2="12" y2="21" stroke-width="2" />
                                <path d="M20.39 18.39A5 5 0 0 0 18 9h-1.26A8 8 0 1 0 3 16.3"
                                      stroke-width="2" />
                            </svg>
                            <p>Click to upload or drag and drop</p>
                            <small>PNG, JPG or PDF (MAX. 5MB)</small>
                            <input type="file" id="idUpload" name="idDocument" accept=".png,.jpg,.jpeg,.pdf"
                                   style="display:none;" onchange="handleUpload(this)">
                        </div>
                        <div id="uploadedFiles" style="margin-top:12px;"></div>
                    </div>
                </div>

                <!-- Update Button -->
                <div style="display:flex;justify-content:flex-end;gap:10px;">
                    <button class="btn btn-outline" onclick="window.history.back()">Discard Changes</button>
                    <button class="btn btn-teal" onclick="saveProfile()">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="14" height="14">
                            <polyline points="20 6 9 17 4 12" stroke-width="2" />
                        </svg>
                        Update Profile
                    </button>
                </div>
            </div>
        </div>
    </div>

    <footer class="page-footer" style="margin-left:0;">
        <div class="footer-grid">
            <div class="footer-brand">
                <div class="logo">Basai</div>
                <p>Urban Living Redefined. Precision-engineered solutions for the modern Kathmandu resident.
                </p>
            </div>
            <div class="footer-col">
                <h4>Support</h4>
                <a href="#">Terms of Service</a>
                <a href="#">Contact Support</a>
                <a href="#">About Us</a>
            </div>
            <div class="footer-col">
                <h4>Links</h4>
                <a href="#">Privacy Policy</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2024 Basai. Urban Living Redefined.</span>
        </div>
    </footer>
</div>

<script>
    function showSection(name, el) {
        ['personal', 'account', 'verification'].forEach(s => {
            document.getElementById('section-' + s).style.display = (s === name) ? '' : 'none';
        });
        document.querySelectorAll('.profile-nav-item').forEach(i => i.classList.remove('active'));
        el.classList.add('active');
        return false;
    }

    function toggleEdit() {
        const fields = ['usernameInput', 'passwordInput'];
        fields.forEach(id => {
            const el = document.getElementById(id);
            el.readOnly = !el.readOnly;
        });
    }

    function togglePwd() {
        const input = document.getElementById('passwordInput');
        input.type = input.type === 'password' ? 'text' : 'password';
    }

    function saveProfile() {
        alert('Profile updated successfully!');
    }

    function handleUpload(input) {
        const container = document.getElementById('uploadedFiles');
        container.innerHTML = '';
        Array.from(input.files).forEach(file => {
            const div = document.createElement('div');
            div.style.cssText = 'display:flex;align-items:center;gap:8px;padding:8px 12px;background:var(--input-bg);border:1px solid var(--border);border-radius:var(--radius-sm);font-size:.82rem;color:var(--text-secondary);margin-bottom:6px;';
            div.textContent = '📄 ' + file.name + ' (' + (file.size / 1024).toFixed(1) + ' KB)';
            container.appendChild(div);
        });
    }
</script>
</body>

</html>