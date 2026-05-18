    <%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String selectedRole = request.getParameter("role");
    if (selectedRole == null || (!selectedRole.equals("owner"))) {
        selectedRole = "renter";
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai - Create Account</title>
    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:'Inter',Arial,sans-serif;min-height:100vh;background:#f0f2f5;display:flex;flex-direction:column;}

        /* TOPBAR */
        .topbar{display:flex;justify-content:space-between;align-items:center;padding:16px 48px;background:#fff;border-bottom:1px solid #eee;}
        .brand-logo{font-size:1.2rem;font-weight:800;color:#1a1a2e;text-decoration:none;}
        .topbar-right{font-size:.88rem;color:#888;}
        .topbar-right a{color:#1a1a2e;font-weight:700;text-decoration:none;}

        /* MAIN */
        main{flex:1;display:flex;align-items:center;justify-content:center;padding:40px 24px;position:relative;overflow:hidden;}
        .shape-tl{position:absolute;left:-60px;top:-60px;width:260px;height:260px;background:linear-gradient(135deg,#c8d5e8,#e0e8f5);border-radius:50%;opacity:.45;pointer-events:none;}
        .shape-br{position:absolute;right:-60px;bottom:-60px;width:200px;height:200px;background:linear-gradient(135deg,#e0e8f5,#c8d5e8);border-radius:50%;opacity:.35;pointer-events:none;}

        /* CARD */
        .register-card{background:#fff;border-radius:16px;padding:36px 44px;width:100%;max-width:660px;z-index:2;box-shadow:0 4px 24px rgba(0,0,0,.08);border-left:4px solid #1a1a2e;}
        .card-title{font-size:1.75rem;font-weight:800;color:#1a1a2e;margin-bottom:4px;}
        .card-sub{color:#888;font-size:.88rem;margin-bottom:24px;}

        /* ROLE TOGGLE */
        .role-toggle{display:flex;background:#f0f2f5;border-radius:10px;padding:4px;margin-bottom:28px;gap:4px;}
        .role-btn{flex:1;display:flex;align-items:center;justify-content:center;gap:8px;padding:10px 16px;border-radius:8px;text-decoration:none;font-size:.9rem;font-weight:600;color:#888;transition:all .2s;}
        .role-btn.active{background:#1a1a2e;color:#fff;box-shadow:0 2px 8px rgba(26,26,46,.15);}
        .role-btn .role-icon{font-size:1.1rem;}

        /* FORM */
        .form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px 20px;}
        .form-group{display:flex;flex-direction:column;gap:5px;}
        .form-group.full{grid-column:1/-1;}
        .form-group label{font-size:.72rem;font-weight:700;color:#555;letter-spacing:.07em;text-transform:uppercase;}
        .form-group input,.form-group select{padding:10px 14px;border:1.5px solid #e0e0e0;border-radius:8px;font-size:.92rem;color:#1a1a2e;background:#f7f8fa;outline:none;transition:border .2s;}
        .form-group input:focus,.form-group select:focus{border-color:#1a1a2e;background:#fff;}
        .form-group input::placeholder{color:#bbb;}

        /* FILE INPUTS */
        .file-input-label{display:flex;align-items:center;gap:10px;padding:10px 14px;border:1.5px solid #e0e0e0;border-radius:8px;background:#f7f8fa;cursor:pointer;font-size:.88rem;color:#555;transition:border .2s;}
        .file-input-label:hover{border-color:#1a1a2e;}
        .file-input-label .file-name{font-size:.82rem;color:#aaa;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}

        /* RENTER ONLY FIELDS */
        .renter-only{display:<%= "renter".equals(selectedRole) ? "contents" : "none" %>;}
        .owner-only{display:<%= "owner".equals(selectedRole) ? "contents" : "none" %>;}

        /* PASSWORD STRENGTH */
        .password-wrap{position:relative;}
        .password-wrap input{width:100%;padding-right:40px;}
        .eye-btn{position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:#aaa;font-size:1rem;padding:0;}

        /* SUBMIT */
        .btn-register{width:100%;background:#1a1a2e;color:#fff;padding:13px;border:none;border-radius:8px;font-size:1rem;font-weight:700;cursor:pointer;margin-top:20px;transition:opacity .2s;letter-spacing:.02em;}
        .btn-register:hover{opacity:.88;}

        /* FOOTER LINKS */
        .card-footer{text-align:center;margin-top:16px;font-size:.88rem;color:#888;}
        .card-footer a{color:#1a1a2e;font-weight:700;text-decoration:none;}
        .terms{text-align:center;font-size:.72rem;color:#bbb;text-transform:uppercase;letter-spacing:.04em;margin-top:8px;}

        /* ERROR */
        .error-box{background:#ffe0e0;color:#c0392b;padding:10px 14px;border-radius:7px;font-size:.85rem;margin-bottom:16px;border-left:3px solid #c0392b;}

        /* FOOTER */
        footer{border-top:1px solid #eee;padding:18px 48px;display:flex;justify-content:space-between;align-items:center;background:#fff;flex-wrap:wrap;gap:12px;}
        .footer-logo{font-size:.95rem;font-weight:800;color:#1a1a2e;}
        .footer-links{display:flex;gap:20px;}
        .footer-links a{text-decoration:none;color:#aaa;font-size:.8rem;}
        .footer-copy{font-size:.8rem;color:#aaa;}
    </style>
</head>
<body>

<!-- TOPBAR -->
<div class="topbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">Basai</a>
    <div class="topbar-right">Already have an account? <a href="${pageContext.request.contextPath}/views/login.jsp">Login</a></div>
</div>

<!-- MAIN -->
<main>
    <div class="shape-tl"></div>
    <div class="shape-br"></div>

    <div class="register-card">
        <div class="card-title">Create Account</div>
        <div class="card-sub">Fill in your details to get started on Basai</div>

        <!-- VERIFICATION NOTICE -->
        <div style="background:#e8f5e9;border-left:4px solid #2e7d32;padding:14px 16px;border-radius:8px;margin-bottom:20px;font-size:.88rem;color:#2e7d32;line-height:1.5;">
            <strong style="display:block;margin-bottom:6px;">✓ Verification Required</strong>
            Your account will require admin verification before you can access certain features. Make sure to upload a valid verification document (ID, passport, or license).
        </div>

        <% if (error != null) { %>
        <div class="error-box"><%= error %></div>
        <% } %>

        <!-- ROLE TOGGLE -->
        <div class="role-toggle">
            <a href="?role=renter" class="role-btn <%= "renter".equals(selectedRole) ? "active" : "" %>">
                <span class="role-icon">&#x1F464;</span> I'm a Renter
            </a>
            <a href="?role=owner" class="role-btn <%= "owner".equals(selectedRole) ? "active" : "" %>">
                <span class="role-icon">&#x1F3E2;</span> I'm an Owner
            </a>
        </div>

        <!-- FORM -->
        <form action="${pageContext.request.contextPath}/user-auth" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="register">
            <input type="hidden" name="role" value="<%= selectedRole %>">
            <input type="hidden" name="verificationStatus" value="PENDING">

            <div class="form-grid">

                <!-- COMMON FIELDS -->
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" name="phone" placeholder="+977 98XX-XXXXXX" required>
                </div>

                <div class="form-group">
                    <label>Date of Birth</label>
                    <input type="date" name="dob">
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <div class="password-wrap">
                        <input type="password" name="password" id="password" placeholder="Min. 8 characters" required>
                        <button type="button" class="eye-btn" onclick="togglePass('password')">&#x1F441;</button>
                    </div>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <div class="password-wrap">
                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Re-enter password" required>
                        <button type="button" class="eye-btn" onclick="togglePass('confirmPassword')">&#x1F441;</button>
                    </div>
                </div>

                <!-- RENTER ONLY FIELDS -->
                <div class="renter-only">
                    <div class="form-group">
                        <label>Occupation</label>
                        <input type="text" name="occupation" placeholder="e.g. Student, Engineer">
                    </div>

                    <div class="form-group">
                        <label>Preferred Location</label>
                        <input type="text" name="preferredLocation" placeholder="e.g. Jhamsikhel, Thamel">
                    </div>
                </div>

                <!-- OWNER ONLY FIELDS -->
                <div class="owner-only">
                    <div class="form-group">
                        <label>Business / Property Name</label>
                        <input type="text" name="occupation" placeholder="e.g. Karki Properties">
                    </div>

                    <div class="form-group">
                        <label>Primary Location</label>
                        <input type="text" name="preferredLocation" placeholder="e.g. Lazimpat, Baluwatar">
                    </div>
                </div>

                <div class="form-group full">
                    <label>Address</label>
                    <input type="text" name="address" placeholder="Your current address">
                </div>

                <div class="form-group">
                    <label>Verification Document <span style="color:#e74c3c;font-weight:700;">*</span></label>
                    <label class="file-input-label" for="verificationDocFile">
                        <span>&#x1F4C4;</span>
                        <span class="file-name" id="verDocName">Choose image...</span>
                    </label>
                    <input type="file" id="verificationDocFile" name="verificationDocument"
                           accept="image/jpeg,image/png,image/webp,application/pdf"
                           style="display:none;" onchange="updateFileName(this,'verDocName')" required>
                    <p style="font-size:.75rem;color:#888;margin-top:6px;">Accepted: Passport, ID, License, or Government Documents</p>
                </div>

                <div class="form-group">
                    <label>Profile Photo <span style="color:#bbb;font-weight:400;text-transform:none;">(optional)</span></label>
                    <label class="file-input-label" for="profilePhotoFile">
                        <span>&#x1F5BC;</span>
                        <span class="file-name" id="photoName">Choose image...</span>
                    </label>
                    <input type="file" id="profilePhotoFile" name="profilePhoto"
                           accept="image/jpeg,image/png,image/webp"
                           style="display:none;" onchange="updateFileName(this,'photoName')">
                </div>

            </div>

            <button type="submit" class="btn-register">
                Create <%= "renter".equals(selectedRole) ? "Renter" : "Owner" %> Account
            </button>
        </form>

        <div class="card-footer">Already have an account? <a href="${pageContext.request.contextPath}/views/login.jsp">Login</a></div>
        <div class="terms">By registering, you agree to the Basai terms and conditions</div>
    </div>
</main>

<!-- FOOTER -->
<footer>
    <div class="footer-logo">Basai</div>
    <div class="footer-copy">&#169; 2024 Basai Urban Living. All rights reserved.</div>
    <div class="footer-links">
        <a href="#">Terms of Service</a>
        <a href="#">Privacy Policy</a>
        <a href="#">Help Center</a>
        <a href="#">Contact</a>
    </div>
</footer>

<script>
    function updateFileName(input, labelId) {
        const label = document.getElementById(labelId);
        if (input.files && input.files[0]) {
            label.textContent = input.files[0].name;
            label.style.color = '#1a1a2e';
        } else {
            label.textContent = 'Choose image...';
            label.style.color = '#aaa';
        }
    }

    function togglePass(id) {
        const f = document.getElementById(id);
        f.type = f.type === 'password' ? 'text' : 'password';
    }

    // Client-side password match check before submit
    document.querySelector('form').addEventListener('submit', function(e) {
        const p = document.getElementById('password').value;
        const c = document.getElementById('confirmPassword').value;
        const verDoc = document.getElementById('verificationDocFile');

        if (p !== c) {
            e.preventDefault();
            alert('Passwords do not match.');
            return;
        }
        if (p.length < 8) {
            e.preventDefault();
            alert('Password must be at least 8 characters.');
            return;
        }
        if (!verDoc.files || verDoc.files.length === 0) {
            e.preventDefault();
            alert('Please upload a verification document to continue.');
            return;
        }
    });
</script>

</body>
</html>
