<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"  %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    if (session.getAttribute("role") == null || !"renter".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "dashboard");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai — Renter Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/renter.css">
</head>
<body>

<%@ include file="sidebar.jsp"%>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">
    <!-- Page Body -->
    <div class="page-body">
        <!-- Header -->
        <div class="page-header" style="display:flex;align-items:flex-start;justify-content:space-between;">
            <div>
                <div class="page-title">Dashboard</div>
                <%
                    basai.user.model.User sessionUser = (basai.user.model.User) session.getAttribute("user");
                    String fullName = sessionUser != null ? sessionUser.getName() : "Renter";
                %>
                <div class="page-subtitle">Welcome back, <%= fullName %>. Here's an overview of your rental activity.</div>            </div>
            <div style="background:var(--card-bg);border:1px solid var(--border);border-radius:var(--radius-sm);padding:6px 14px;font-size:.78rem;color:var(--text-muted);">
                <span style="font-weight:600;color:var(--navy);">● Active Searcher</span> &nbsp; Current Session
            </div>
        </div>


        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><rect x="3" y="4" width="18" height="18" rx="2" stroke-width="2"/><path d="M16 2v4M8 2v4M3 10h18" stroke-width="2"/></svg>
                </div>
                <div class="stat-label">Total Bookings</div>
                <div class="stat-value"><c:out value="${totalBookings}"/></div>
                <div class="stat-meta">All time requests</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><circle cx="12" cy="12" r="10" stroke-width="2"/><path d="M12 8v4l3 3" stroke-width="2"/></svg>
                </div>
                <div class="stat-label">Pending Requests</div>
                <div class="stat-value" style="color:var(--yellow);"><c:out value="${pendingCount}"/></div>
                <div class="stat-meta">Awaiting response</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" stroke-width="2"/><polyline points="22 4 12 14.01 9 11.01" stroke-width="2"/></svg>
                </div>
                <div class="stat-label">Approved Rentals</div>
                <div class="stat-value" style="color:var(--green);"><c:out value="${approvedCount}"/></div>
                <div class="stat-meta">Successfully approved</div>
            </div>
            <div class="stat-card accent">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" stroke-width="2"/></svg>
                </div>
                <div class="stat-label">Saved Rooms</div>
                <div class="stat-value"><c:out value="${savedCount}"/></div>
                <div class="stat-meta">In your wishlist</div>
            </div>
        </div>

        <!-- Content Grid -->
        <div style="display:grid;grid-template-columns:1fr 300px;gap:20px;">

            <!-- Recent Bookings -->
            <div class="card">
                <div class="card-header">
                    <span class="card-title">Recent Bookings</span>
                    <a href="bookings.jsp" class="btn btn-outline btn-sm">View All Activity</a>
                </div>
                <div style="overflow-x:auto;">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Property Detail</th>
                            <th>Status</th>
                            <th>Date</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty recentBookings}">
                                <c:forEach var="booking" items="${recentBookings}">
                                    <tr>
                                        <td>
                                            <div class="room-thumb">
                                                <div class="placeholder-img"></div>
                                                <div>
                                                    <div class="room-name"><c:out value="${booking.roomName}"/></div>
                                                    <div class="room-sub"><c:out value="${booking.roomLocation}"/></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge
                                                <c:choose>
                                                    <c:when test="${booking.status eq 'Pending'}">badge-pending</c:when>
                                                    <c:when test="${booking.status eq 'Approved'}">badge-approved</c:when>
                                                    <c:otherwise>badge-rejected</c:otherwise>
                                                </c:choose>">
                                                <c:out value="${booking.status}"/>
                                            </span>
                                        </td>
                                        <td style="color:var(--text-muted);font-size:.8rem;">
                                                ${booking.requestDate.toLocalDate()}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3" style="text-align:center;color:var(--text-muted);padding:2rem;">
                                        No bookings yet. <a href="${pageContext.request.contextPath}/rooms">Browse rooms →</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Right Column -->
            <div style="display:flex;flex-direction:column;gap:20px;">
                <!-- CTA Card -->
                <div class="cta-card">
                    <h3>Find Your Next Metropolitan Space</h3>
                    <p>Access exclusive studio apartments and professional lofts in Kathmandu's premier sectors.</p>
                    <a href="browse.jsp" class="btn-cta">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="14" height="14"><circle cx="11" cy="11" r="8" stroke-width="2"/><path d="m21 21-4.35-4.35" stroke-width="2"/></svg>
                        Browse Rooms
                    </a>
                    <a href="wishlist.jsp" class="btn-cta-outline">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="14" height="14"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" stroke-width="2"/></svg>
                        View Wishlist
                    </a>
                </div>

                <!-- Urban Insights -->
                <div class="card">
                    <div class="card-header">
                        <span class="card-title" style="font-size:.82rem;letter-spacing:1px;text-transform:uppercase;color:var(--navy);">● Urban Insights</span>
                    </div>
                    <div class="card-body" style="padding:16px;">
                        <div class="insight-item">
                            <div class="insight-thumb"></div>
                            <div class="insight-text">
                                <h4>Kathmandu Real Estate Trends</h4>
                                <p>Studio apartments are seeing a 14% increase in professional demand this quarter.</p>
                            </div>
                        </div>
                        <div class="insight-item">
                            <div class="insight-thumb" style="background:linear-gradient(135deg,var(--navy),#0f9488);"></div>
                            <div class="insight-text">
                                <h4>New High-Demand Zone</h4>
                                <p>Jhamsikhel metropolitan area has 5 new verified listings this week.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="page-footer">
        <div class="footer-grid">
            <div class="footer-brand">
                <div class="logo">Basai Professional</div>
                <p>The urban architecture of rental management. Precise, structural, and intentional matching for Kathmandu's modern workforce.</p>
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
            <span>© 2024 Basai Urban Living. All rights reserved.</span>
            <span>Privacy Policy · Terms of Service</span>
        </div>
    </footer>
</div>

</body>
</html>
