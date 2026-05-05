<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai - Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', Arial, sans-serif;
            height: 100vh;
            display: flex;
        }

        /* LEFT PANEL */
        .left-panel {
            flex: 0 0 58%;
            position: relative;
            overflow: hidden;
        }

        .left-panel img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .left-panel-bg {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #1a1a2e 0%, #2d4a7a 50%, #1a3a4a 100%);
        }

        .left-overlay {
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, .35);
        }

        .left-content {
            position: absolute;
            inset: 0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 32px 40px;
        }

        .brand-logo {
            font-size: 1.3rem;
            font-weight: 700;
            color: #fff;
        }

        .hero-text h1 {
            font-size: 2.6rem;
            font-weight: 800;
            color: #fff;
            line-height: 1.15;
            margin-bottom: 12px;
        }

        .hero-text p {
            color: rgba(255, 255, 255, .8);
            font-size: 1rem;
        }

        .footer-copy {
            color: rgba(255, 255, 255, .55);
            font-size: .8rem;
        }

        /* RIGHT PANEL */
        .right-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 48px;
        }

        .login-box {
            width: 100%;
            max-width: 380px;
        }

        .login-box h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 6px;
        }

        .login-box .subtitle {
            color: #888;
            font-size: .9rem;
            margin-bottom: 32px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: .75rem;
            font-weight: 600;
            color: #555;
            letter-spacing: .05em;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .input-wrap {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrap .icon {
            position: absolute;
            left: 12px;
            color: #aaa;
            font-size: 1rem;
        }

        .input-wrap input {
            width: 100%;
            padding: 11px 12px 11px 38px;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            font-size: .95rem;
            color: #1a1a2e;
            background: #f7f8fa;
            outline: none;
            transition: border .2s;
        }

        .input-wrap input:focus {
            border-color: #1a1a2e;
            background: #fff;
        }

        .input-wrap .eye-icon {
            position: absolute;
            right: 12px;
            cursor: pointer;
            color: #aaa;
            font-size: 1rem;
        }

        .row-between {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: .88rem;
            color: #555;
            cursor: pointer;
        }

        .forgot-link {
            font-size: .88rem;
            color: #1a1a2e;
            font-weight: 600;
            text-decoration: none;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            background: #1a1a2e;
            color: #fff;
            padding: 13px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-bottom: 20px;
            transition: opacity .2s;
        }

        .btn-login:hover {
            opacity: .88;
        }

        .signup-row {
            text-align: center;
            font-size: .9rem;
            color: #888;
        }

        .signup-row a {
            color: #1a1a2e;
            font-weight: 700;
            text-decoration: none;
        }

        .signup-row a:hover {
            text-decoration: underline;
        }

        /* Error message */
        .error-msg {
            background: #ffe0e0;
            color: #c0392b;
            padding: 10px 14px;
            border-radius: 7px;
            font-size: .88rem;
            margin-bottom: 16px;
            display: none;
        }
    </style>
</head>
<body>

<!-- LEFT PANEL -->
<div class="left-panel">
    <div class="left-panel-bg"></div>
    <div class="left-overlay"></div>
    <div class="left-content">
        <div class="brand-logo">Basai</div>
        <div class="hero-text">
            <h1>Welcome Back<br>to Basai</h1>
            <p>Find rooms. Book easily. Live better.</p>
        </div>
        <div class="footer-copy">&#169; 2024 Basai. The Curated Haven.</div>
    </div>
</div>

<!-- RIGHT PANEL -->
<div class="right-panel">
    <div class="login-box">
        <h2>Login</h2>
        <p class="subtitle">Please enter your details to access your account.</p>

        <%-- Show error if login failed --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg" style="display:block;">${error}</div>
        <% } %>

        <form action="${pageContext.request.contextPath}/user-auth" method="post">
            <input type="hidden" name="action" value="login" >
            <div class="form-group">
                <label>Email or Username</label>
                <div class="input-wrap">
                    <span class="icon">&#x1F464;</span>
                    <input type="text" name="email" placeholder="Enter your email" required autofocus>
                </div>
            </div>
            <div class="form-group">
                <label>Password</label>
                <div class="input-wrap">
                    <span class="icon">&#x1F512;</span>
                    <input type="password" name="password" id="passwordField" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" required>
                    <span class="eye-icon" onclick="togglePassword()">&#x1F441;</span>
                </div>
            </div>
            <div class="row-between">
                <label class="remember-me">
                    <input type="checkbox" name="rememberMe"> Remember me
                </label>
                <a href="forgot-password.jsp" class="forgot-link">Forgot password?</a>
            </div>
            <button type="submit" class="btn-login">Login</button>
        </form>

        <div class="signup-row">
            Don't have an account? <a href="register.jsp">Sign Up</a>
        </div>
    </div>
</div>

<script>
    function togglePassword() {
        const field = document.getElementById('passwordField');
        field.type = field.type === 'password' ? 'text' : 'password';
    }
</script>

</body>
</html>
