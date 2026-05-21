<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    if (session.getAttribute("role") == null || !"renter".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "bookings");
%>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai — My Bookings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/renter.css">
</head>

<body>

<%@include file="sidebar.jsp"%>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">
    <header class="topbar">
        <div class="topbar-left">
            <span style="font-size:.72rem;text-transform:uppercase;letter-spacing:1.2px;color:var(--text-muted);">USER
                            MANAGEMENT</span>
        </div>
        <div class="topbar-actions">
            <a href="profile.jsp"
               style="font-size:.84rem;color:var(--text-secondary);padding:6px 14px;border-radius:var(--radius-sm);border:1px solid var(--border);">Profile</a>
            <button class="topbar-btn-primary">Logout</button>
        </div>
    </header>

    <div class="page-body">
        <div class="page-header">
            <div class="page-title">My Bookings</div>
            <div class="page-subtitle">Track your rental applications and manage pending studio requests in
                Kathmandu's premier urban developments.</div>
        </div>

        <!-- Stats -->
        <div class="stats-grid"
             style="grid-template-columns:repeat(3,1fr);max-width:640px;margin-bottom:20px;">
            <div class="stat-card accent">
                <div class="stat-label">Active Requests</div>
                <div class="stat-value">02</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Approved Totals</div>
                <div class="stat-value" style="color:var(--navy);">08</div>
            </div>
            <div class="stat-card accent-teal">
                <div class="stat-label">Member Status</div>
                <div class="stat-value" style="font-size:1rem;">Premium Resident</div>
            </div>
        </div>

        <!-- Filter Tabs -->
        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
            <div class="tab-bar" style="margin-bottom:0;border-bottom:none;">
                <button class="tab-btn active" onclick="filterBookings('all',this)">All</button>
                <button class="tab-btn" onclick="filterBookings('pending',this)">Pending</button>
                <button class="tab-btn" onclick="filterBookings('approved',this)">Approved</button>
                <button class="tab-btn" onclick="filterBookings('rejected',this)">Rejected</button>
            </div>
        </div>

        <!-- Table -->
        <div class="card">
            <div style="overflow-x:auto;">
                <table class="data-table" id="bookingsTable">
                    <thead>
                    <tr>
                        <th>Room Name</th>
                        <th>Location</th>
                        <th>Request Date</th>
                        <th>Status</th>
                        <th>Duration</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty bookings}">
                            <tr>
                                <td colspan="6" style="text-align:center;padding:40px;color:var(--text-muted);">
                                    No bookings found. <a href="${pageContext.request.contextPath}/rooms/browse">Browse rooms</a> to get started.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="booking" items="${bookings}">
                                <tr data-status="${booking.status}"
                                    style="cursor:pointer;"
                                    onclick="location.href='${pageContext.request.contextPath}/rooms/detail?roomId=${booking.roomId}'">
                                    <td>
                                        <div class="room-thumb">
                                            <div class="placeholder-img">🏠</div>
                                            <div>
                                                <div class="room-name">${booking.roomName}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${booking.roomLocation}</td>
                                    <td>${booking.requestDate}</td>
                                    <td>
                    <span class="badge badge-${fn:toLowerCase(booking.status)}">
                            ${booking.status}
                    </span>
                                    </td>
                                    <td>${booking.stayTime} Months</td>
                                    <td style="color:var(--text-muted); text-align:right;">></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
            <div
                    style="padding:14px 16px;border-top:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;">
                <span style="font-size:.78rem;color:var(--text-muted);">Showing ${bookings.size()} bookings</span>
                <div style="display:flex;gap:8px;">
                    <button class="btn btn-outline btn-sm">Prev</button>
                    <button class="btn btn-outline btn-sm">Next</button>
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
            <span>© 2024 Basai Urban Living. All rights reserved.</span>
        </div>
    </footer>
</div>

<script>
    function filterBookings(status, btn) {
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.querySelectorAll('#bookingsTable tbody tr').forEach(row => {
            row.style.display = (status === 'all' || row.dataset.status === status) ? '' : 'none';
        });
    }
</script>
</body>

</html>