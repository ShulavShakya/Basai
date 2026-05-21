<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.time.LocalDate"%>

<%
    LocalDate today = LocalDate.now();
%>

<%
    if (session.getAttribute("role") == null || !"renter".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "bookingRequest");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai — Request Room Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/renter.css">
</head>

<body>

<!-- ===== SIDEBAR ===== -->

<%@include file="sidebar.jsp"%>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">
    <header class="topbar">
        <div class="topbar-left">
                        <span
                                style="font-family:'Sora',sans-serif;font-size:1rem;font-weight:700;color:var(--navy);">Basai</span>
            <span style="color:var(--border);margin:0 8px;">|</span>
            <a href="dashboard.jsp" class="topbar-link">Home</a>
            <a href="browse.jsp" class="topbar-link">Search Rooms</a>
        </div>
        <div class="topbar-actions">
            <a href="profile.jsp" style="font-size:.84rem;color:var(--text-secondary);">Profile</a>
            <button class="topbar-btn-primary">Logout</button>
        </div>
    </header>

    <div class="page-body">
        <div class="page-header">
            <div class="breadcrumb">
                <a href="bookings.jsp">Bookings</a>
                <span class="sep">›</span>
                <span>Request Room</span>
            </div>
            <div class="page-title">Request Room Booking</div>
            <div class="page-subtitle">Complete the structural details for your residency request. Our team
                will review your application within 24 hours.</div>
        </div>

        <div class="booking-layout">
            <!-- Form -->
            <div class="card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/bookings/submit" method="post" id="bookingForm">
                        <input type="hidden" name="roomId"  value="${room.roomId}">

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Request Date</label>
                                <input type="date" name="requestDate" class="form-input" value="<%= today %>" disabled>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Duration (Months)</label>
                                <input type="number" name="stayTime" class="form-input" placeholder="e.g. 6"
                                       min="1" max="60" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Message for Owner</label>
                            <textarea name="message" class="form-textarea"
                                      placeholder="Add any message for the owner — introduce yourself, mention your profession, or ask questions..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-teal"
                                style="width:100%;justify-content:center;padding:12px;">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="16"
                                 height="16">
                                <line x1="22" y1="2" x2="11" y2="13" stroke-width="2" />
                                <polygon points="22 2 15 22 11 13 2 9 22 2" stroke-width="2" />
                            </svg>
                            Submit Request
                        </button>
                    </form>
                </div>
            </div>

            <!-- Summary Sidebar -->
            <div style="display:flex;flex-direction:column;gap:16px;">
                <div class="booking-summary-card">
                    <div class="booking-summary-img">
                        <span style="font-size:2.5rem;opacity:.3;">🏠</span>
                        <span class="booking-summary-badge">Verified Listing</span>
                    </div>
                    <div class="booking-summary-body">
                        <div class="booking-summary-title">1 BHK Furnished Room</div>

                        <div class="booking-detail-row">
                            <span class="label">Location</span>
                            <span class="value"><c:out value="${room.city}"/></span>
                        </div>
                        <div class="booking-detail-row">
                            <span class="label">Monthly Rent</span>
                            <span class="value price"><c:out value="${room.rentPrice}"/></span>
                        </div>
                        <div class="booking-detail-row">
                            <span class="label">Type</span>
                            <span class="value"><c:out value="${room.roomType}"/></span>
                        </div>

                        <div style="margin-top:12px;">
                            <div
                                    style="font-size:.72rem;text-transform:uppercase;letter-spacing:1px;color:var(--text-muted);margin-bottom:8px;">
                                Amenities Included</div>
                            <div class="amenity-grid">
                                <div class="amenity-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path
                                                d="M5 12.55a11 11 0 0 1 14.08 0M1.42 9a16 16 0 0 1 21.16 0M8.53 16.11a6 6 0 0 1 6.95 0M12 20h.01"
                                                stroke-width="2" />
                                    </svg>
                                    High Speed WiFi
                                </div>
                                <div class="amenity-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"
                                              stroke-width="2" />
                                    </svg>
                                    24/7 Water
                                </div>
                                <div class="amenity-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"
                                                 stroke-width="2" />
                                    </svg>
                                    Power Backup
                                </div>
                                <div class="amenity-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"
                                              stroke-width="2" />
                                        <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke-width="2" />
                                    </svg>
                                    Secure Entry
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="secure-banner">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" stroke-width="2" />
                    </svg>
                    <div>
                        <strong>Secure Application Process</strong>
                        <p>Your data is encrypted and only visible to the property owner during the
                            selection process.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="page-footer">
        <div class="footer-grid">
            <div class="footer-brand">
                <div class="logo">Basai Professional</div>
                <p>The urban architecture of rental management. Precise, structural, and intentional
                    matching for Kathmandu's modern workforce.</p>
            </div>
            <div class="footer-col">
                <h4>Account</h4>
                <a href="#">Billing</a>
                <a href="#">Verification</a>
                <a href="#">Security</a>
            </div>
            <div class="footer-col">
                <h4>Support</h4>
                <a href="#">Renter Guide</a>
                <a href="#">Contact Admin</a>
                <a href="#">Legal Terms</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2024 Basai. All rights reserved.</span>
            <span><a href="#">Terms</a> · <a href="#">Privacy</a></span>
        </div>
    </footer>
</div>

</body>

</html>