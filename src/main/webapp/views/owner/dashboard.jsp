<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page import="java.util.*" %>
<%-- Security check: redirect to login if not admin --%>
<%
    if (session.getAttribute("role") == null || !"owner".equals(session.getAttribute("role"))) {
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
    <title>Owner Dashboard | Basai</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/owner.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/dashboard.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">

    <!-- Page Body -->
    <main class="page-body">

        <div class="page-header">
            <h1 class="page-title">Owner Dashboard</h1>
            <p class="page-subtitle">Welcome back, Alex. Here's what's happening with your properties today.</p>
        </div>

        <div class="stats-grid">

            <div class="stat-card">
                <div class="stat-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                </div>
                <div class="stat-label">Total Listings</div>
                <div class="stat-value"><c:out value="${totalListings}"/></div>
                <div class="stat-badge up">↑ Growth +4%</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
                </div>
                <div class="stat-label">Active Listings</div>
                <div class="stat-value"><c:out value="${activeListings}"/></div>
                <div class="stat-badge neutral">92% Occupied</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07A19.5 19.5 0 013.07 9.8a19.79 19.79 0 01-3.07-8.63A2 2 0 012 1.18h3a2 2 0 012 1.72c.127.96.361 1.903.7 2.81a2 2 0 01-.45 2.11L6.09 8.91a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0122 16.92z"/></svg>
                </div>
                <div class="stat-label">Booking Requests</div>
                <div class="stat-value"><c:out value="${bookingRequests}"/></div>
                <div class="stat-badge warn">Action Required</div>
            </div>

            <div class="stat-card accent">
                <div class="stat-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                </div>
                <div class="stat-label">Approved Bookings</div>
                <div class="stat-value"><c:out value="${approvedBookings}"/></div>
                <div class="stat-badge neutral" style="color:rgba(255,255,255,.7)">This Month</div>
            </div>
        </div>

        <!-- Main Grid -->
        <div class="dashboard-grid">

            <!-- LEFT -->
            <div class="dashboard-left">

                <!-- Recent Listings -->
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">Recent Listings</span>
                        <a href="myListings.jsp" class="view-all-link">
                            View All →
                        </a>
                    </div>
                    <div class="card-body">

                            <div class="request-list">
                                <c:forEach var="booking" items="${recentBookings}">
                                    <div class="request-item">
                                            <%-- Initials avatar from renter name --%>
                                        <div class="avatar-init" style="background:#3b82f6;">
                                            <c:out value="${fn:toUpperCase(fn:substring(booking.renterName, 0, 2))}"/>
                                        </div>
                                        <div class="req-info">
                                            <div class="req-name"><c:out value="${booking.renterName}"/></div>
                                            <div class="req-room">Applied for <c:out value="${booking.roomName}"/></div>
                                            <div class="req-meta"><c:out value="${booking.stayTime}"/> Months</div>
                                        </div>
                                        <div class="req-right">
                                            <span class="badge
                                                <c:choose>
                                                    <c:when test="${booking.status eq 'Pending'}">badge-pending</c:when>
                                                    <c:when test="${booking.status eq 'Approved'}">badge-approved</c:when>
                                                    <c:otherwise>badge-declined</c:otherwise>
                                                </c:choose>">
                                                <c:out value="${booking.status}"/>
                                            </span>
                                            <span class="req-time">${booking.requestDate.toLocalDate()}</span>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty recentBookings}">
                                    <p style="color:var(--text-muted);padding:1rem 0;">No requests yet.</p>
                                </c:if>
                            </div>
                    </div>
                </div>

            </div>

            <!-- RIGHT -->
            <div class="dashboard-right">
                <div class="card">
                    <div class="card-header">
                        <span class="card-title">Recent Requests</span>
                        <a href="${pageContext.request.contextPath}/bookings" class="view-all-link">Manage All</a>
                    </div>
                    <div class="request-list">

                        <%-- Request 1 --%>
                        <div class="request-item">
                            <div class="avatar-init" style="background:#3b82f6;">DC</div>
                            <div class="req-info">
                                <div class="req-name">David Chen</div>
                                <div class="req-room">Applied for Suite B12</div>
                                <div class="req-meta">12 Months</div>
                            </div>
                            <div class="req-right">
                                <span class="badge badge-pending">Pending</span>
                                <span class="req-time">2 hours ago</span>
                            </div>
                        </div>

                        <%-- Request 2 --%>
                        <div class="request-item">
                            <div class="avatar-init" style="background:#1abc9c;">SM</div>
                            <div class="req-info">
                                <div class="req-name">Sarah Miller</div>
                                <div class="req-room">Applied for Garden Room</div>
                                <div class="req-meta">6 Months</div>
                            </div>
                            <div class="req-right">
                                <span class="badge badge-approved">Approved</span>
                                <span class="req-time">5 hours ago</span>
                            </div>
                        </div>

                        <%-- Request 3 --%>
                        <div class="request-item">
                            <div class="avatar-init" style="background:#ef4444;">MR</div>
                            <div class="req-info">
                                <div class="req-name">Michael Ross</div>
                                <div class="req-room">Applied for Suite B12</div>
                                <div class="req-meta">24 Months</div>
                            </div>
                            <div class="req-right">
                                <span class="badge badge-declined">Declined</span>
                                <span class="req-time">Yesterday</span>
                            </div>
                        </div>

                    </div>
                </div>
            </div><!-- /dashboard-right -->

        </div><!-- /dashboard-grid -->
    </main>
</div>

</body>
</html>
