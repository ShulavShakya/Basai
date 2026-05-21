<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai - Verification Pending</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #1a1a2e 0%, #2d4a7a 50%, #1a3a4a 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: #fff;
            border-radius: 16px;
            padding: 48px;
            max-width: 520px;
            width: 100%;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            text-align: center;
        }

        .icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }

        .title {
            font-size: 1.8rem;
            font-weight: 800;
            color: #1a1a2e;
            margin-bottom: 12px;
        }

        .subtitle {
            font-size: .95rem;
            color: #666;
            line-height: 1.6;
            margin-bottom: 28px;
        }

        .status-badge {
            display: inline-block;
            background: #fff3cd;
            color: #856404;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: .85rem;
            font-weight: 600;
            margin-bottom: 24px;
            text-transform: uppercase;
            letter-spacing: .05em;
        }

        .checklist {
            text-align: left;
            background: #f9f9f9;
            padding: 24px;
            border-radius: 12px;
            margin: 24px 0;
            border-left: 4px solid #20c997;
        }

        .checklist-title {
            font-size: .9rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 14px;
            text-transform: uppercase;
            letter-spacing: .05em;
        }

        .checklist-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 10px;
            font-size: .88rem;
            color: #555;
            line-height: 1.5;
        }

        .checklist-item:last-child {
            margin-bottom: 0;
        }

        .checklist-icon {
            font-size: 1.2rem;
            color: #20c997;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .info-box {
            background: #e8f5e9;
            border-left: 4px solid #2e7d32;
            padding: 16px;
            border-radius: 8px;
            font-size: .88rem;
            color: #2e7d32;
            margin: 24px 0;
            line-height: 1.6;
        }

        .timeline {
            text-align: left;
            margin: 24px 0;
        }

        .timeline-item {
            display: flex;
            gap: 16px;
            margin-bottom: 16px;
            font-size: .85rem;
        }

        .timeline-dot {
            width: 24px;
            height: 24px;
            background: #1a1a2e;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            flex-shrink: 0;
        }

        .timeline-content {
            padding-top: 2px;
        }

        .timeline-label {
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 2px;
        }

        .timeline-desc {
            color: #888;
            font-size: .8rem;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 32px;
        }

        .btn {
            flex: 1;
            padding: 12px 24px;
            border-radius: 8px;
            border: none;
            font-size: .95rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all .2s;
        }

        .btn-primary {
            background: #1a1a2e;
            color: #fff;
        }

        .btn-primary:hover {
            opacity: 0.88;
        }

        .btn-secondary {
            background: #f0f2f5;
            color: #1a1a2e;
            border: 1.5px solid #e0e0e0;
        }

        .btn-secondary:hover {
            background: #e8edf5;
        }

        .contact-support {
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid #eee;
            font-size: .85rem;
            color: #888;
        }

        .contact-support a {
            color: #1a1a2e;
            font-weight: 600;
            text-decoration: none;
        }

        .contact-support a:hover {
            text-decoration: underline;
        }

        .footer-note {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid #eee;
            font-size: .8rem;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: .05em;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="icon">⏳</div>

    <div class="title">Verification Pending</div>
    <div class="subtitle">Thank you for registering! Your account is under review by our admin team.</div>

    <div class="status-badge">Status: Awaiting Verification</div>

    <div class="checklist">
        <div class="checklist-title">We Are Reviewing:</div>
        <div class="checklist-item">
            <div class="checklist-icon">✓</div>
            <div>Your personal information and identity verification document</div>
        </div>
        <div class="checklist-item">
            <div class="checklist-icon">✓</div>
            <div>Account authenticity and compliance with Basai policies</div>
        </div>
        <div class="checklist-item">
            <div class="checklist-icon">✓</div>
            <div>Background checks for property owners and renters</div>
        </div>
    </div>

    <div class="timeline">
        <div class="timeline-item">
            <div class="timeline-dot">1</div>
            <div class="timeline-content">
                <div class="timeline-label">Account Created</div>
                <div class="timeline-desc">You've successfully registered on Basai</div>
            </div>
        </div>
        <div class="timeline-item">
            <div class="timeline-dot" style="background:#f0b500;">2</div>
            <div class="timeline-content">
                <div class="timeline-label">Under Review</div>
                <div class="timeline-desc">Admin team is verifying your information (24-48 hours)</div>
            </div>
        </div>
        <div class="timeline-item">
            <div class="timeline-dot" style="background:#888;opacity:0.5;">3</div>
            <div class="timeline-content">
                <div class="timeline-label">Account Verified</div>
                <div class="timeline-desc">You'll receive an email once your account is approved</div>
            </div>
        </div>
    </div>

    <div class="info-box">
        <strong>📧 Check your email</strong> - We'll send you a notification as soon as your account is verified. This typically takes 24-48 hours.
    </div>

    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">Back to Home</a>
        <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn btn-primary">Go to Login</a>
    </div>

    <div class="contact-support">
        Having issues? <a href="#">Contact Support</a>
    </div>

    <div class="footer-note">
        You can still log in, but some features may be restricted until your account is verified.
    </div>
</div>

</body>
</html>

