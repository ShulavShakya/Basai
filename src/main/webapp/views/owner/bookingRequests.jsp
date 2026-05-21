<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@ page isELIgnored="false" %>--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    if (session.getAttribute("role") == null || !"owner".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "bookingRequests");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Requests | Basai Owner</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/owner.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/bookingRequest.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<!-- MAIN -->
<div class="main-content">

    <main class="page-body">
        <div class="page-header">
            <h1 class="page-title">Booking Requests</h1>
            <p class="page-subtitle">Review and manage incoming stay requests for your properties.</p>
        </div>

        <!-- Summary -->
        <div class="req-summary">
            <div class="req-summary-card">
                <div class="req-sum-icon yellow">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                </div>
                <div class="req-sum-info">
                    <div class="req-sum-count" style="color:var(--yellow)">24</div>
                    <div class="req-sum-label">Pending</div>
                    <div class="req-sum-sub">Active requests requiring action</div>
                </div>
            </div>
            <div class="req-summary-card">
                <div class="req-sum-icon teal">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                </div>
                <div class="req-sum-info">
                    <div class="req-sum-count" style="color:var(--navy)">156</div>
                    <div class="req-sum-label">Approved</div>
                    <div class="req-sum-sub">Confirmed bookings this quarter</div>
                </div>
            </div>
            <div class="req-summary-card highlight">
                <div class="req-sum-icon green">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                </div>
                <div class="req-sum-info">
                    <div class="req-sum-count">85%</div>
                    <div class="req-sum-label">Approval Rate</div>
                    <div class="req-sum-sub">+12% vs last month</div>
                </div>
            </div>
        </div>

        <!-- Table -->
        <div class="card">
            <div class="card-body" style="padding:0;">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Room Name</th>
                        <th>Renter Name</th>
                        <th>Request Date</th>
                        <th>Duration</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>
                                <div class="room-thumb">
                                    <div class="placeholder-img">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <div class="room-name">${booking.roomName}</div>
                                        <div class="room-sub">${booking.roomLocation}</div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="renter-cell">
                                    <div class="avatar-init" style="background:#3b82f6;">
                                            ${fn:toUpperCase(fn:substring(booking.renterName, 0, 2))}
                                    </div>
                                        ${booking.renterName}
                                </div>
                            </td>
                            <td>${booking.requestDate}</td>
                            <td>${booking.stayTime} Months</td>
                            <td><span class="badge badge-${fn:toLowerCase(booking.status)}">${booking.status}</span></td>
                            <td>
                                <div class="tbl-actions">
                                    <form action="${pageContext.request.contextPath}/owner/bookings/update" method="post" style="display:inline">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <input type="hidden" name="action" value="approve">
                                        <button class="btn-approve" title="Approve">
                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                                                <polyline points="20 6 9 17 4 12"/>
                                            </svg>
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/owner/bookings/update" method="post" style="display:inline">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <input type="hidden" name="action" value="reject">
                                        <button class="btn-reject" title="Reject">
                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                                                <line x1="18" y1="6" x2="6" y2="18"/>
                                                <line x1="6" y1="6" x2="18" y2="18"/>
                                            </svg>
                                        </button>
                                    </form>
                                    <a href="#" class="btn btn-sm btn-outline">View Details</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="display:flex;justify-content:space-between;align-items:center;margin-top:14px;">
            <span class="showing-label" style="font-size:.8rem;color:var(--text-muted);">Showing 4 of 24 requests</span>
            <div class="pagination">
                <div class="page-btn">‹</div>
                <div class="page-btn active">1</div>
                <div class="page-btn">2</div>
                <div class="page-btn">3</div>
                <div class="page-btn">›</div>
            </div>
        </div>

    </main>
</div>
<script>
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const sidebar = document.getElementById('sidebar');
    const sidebarOverlay = document.getElementById('sidebarOverlay');

    mobileMenuBtn.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        sidebarOverlay.classList.toggle('active');
    });

    sidebarOverlay.addEventListener('click', () => {
        sidebar.classList.remove('active');
        sidebarOverlay.classList.remove('active');
    });
</script>
</body>
</html>
