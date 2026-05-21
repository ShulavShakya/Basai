<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core"      prefix="c"  %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "dashboard");

    basai.user.model.User sessionUser = (basai.user.model.User) session.getAttribute("user");
    String fullName = sessionUser != null ? sessionUser.getName() : "Admin";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai Admin — Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/adminDashboard.css">
</head>
<body>

<div class="admin-wrapper">
    <%@ include file="sidebar.jsp" %>

    <div class="admin-main">

        <%-- TOPBAR --%>
        <div class="admin-topbar">
            <div>
                <div class="page-title">Dashboard</div>
                <div class="page-subtitle">Welcome back, <%= fullName %>. Here's what's happening today.</div>
            </div>
            <div class="topbar-right">
                <div class="search-box">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                    <input type="text" placeholder="Search system...">
                </div>
                <div style="background:var(--card-bg);border:1px solid var(--border);border-radius:var(--radius-sm);padding:6px 14px;font-size:.78rem;color:var(--text-muted);">
                    <span style="font-weight:600;color:var(--navy);">● Admin</span> &nbsp; Current Session
                </div>
            </div>
        </div>

        <%-- STAT CARDS --%>
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </div>
                <div class="stat-label">Total Users</div>
                <div class="stat-value"><c:out value="${totalUsers}"/></div>
                <div class="stat-meta">All registered users</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                </div>
                <div class="stat-label">Total Listings</div>
                <div class="stat-value"><c:out value="${totalListings}"/></div>
                <div class="stat-meta">Active properties</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><rect x="3" y="4" width="18" height="18" rx="2" stroke-width="2"/><path d="M16 2v4M8 2v4M3 10h18" stroke-width="2"/></svg>
                </div>
                <div class="stat-label">Total Bookings</div>
                <div class="stat-value"><c:out value="${totalBookings}"/></div>
                <div class="stat-meta">
                    <span style="color:var(--yellow);"><c:out value="${pendingCount}"/> pending</span>
                </div>
            </div>
            <div class="stat-card accent">
                <div class="stat-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="18" height="18"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
                </div>
                <div class="stat-label">Estimated Revenue</div>
                <div class="stat-value">—</div>
                <div class="stat-meta">Based on approved bookings</div>
            </div>
        </div>

        <%-- BODY CONTENT --%>
        <div class="content-body">
            <div class="two-col">
                <div>
                    <%-- RECENT BOOKINGS --%>
                    <div class="admin-card" style="margin-bottom:20px;">
                        <div class="section-header">
                            <h3>Recent Bookings</h3>
                            <a href="${pageContext.request.contextPath}/bookings" class="view-all-link">View All</a>
                        </div>
                        <div class="booking-table-wrap">
                            <table class="data-table">
                                <thead>
                                <tr>
                                    <th>Room</th>
                                    <th>Renter</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty recentBookings}">
                                        <c:forEach var="booking" items="${recentBookings}">
                                            <tr>
                                                <td>
                                                    <a href="#" class="room-link"><c:out value="${booking.roomName}"/></a>
                                                    <div style="font-size:.75rem;color:var(--text-muted);"><c:out value="${booking.roomLocation}"/></div>
                                                </td>
                                                <td><c:out value="${booking.renterName}"/></td>
                                                <td style="font-size:.8rem;color:var(--text-muted);">
                                                        ${booking.requestDate.toLocalDate()}
                                                </td>
                                                <td>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${booking.status eq 'Approved'}">badge-confirmed</c:when>
                                                        <c:when test="${booking.status eq 'Pending'}">badge-pending</c:when>
                                                        <c:otherwise>badge-rejected</c:otherwise>
                                                    </c:choose>">
                                                    <c:out value="${booking.status}"/>
                                                </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" style="text-align:center;color:var(--text-muted);padding:2rem;">
                                                No bookings yet.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <%-- RECENT LISTINGS --%>
                    <div class="admin-card">
                        <div class="section-header">
                            <h3>Recent Listings</h3>
                            <a href="${pageContext.request.contextPath}/rooms/all" class="view-all-link">View Inventory</a>
                        </div>
                        <c:choose>
                            <c:when test="${not empty recentRooms}">
                                <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
                                    <c:forEach var="room" items="${recentRooms}">
                                        <div class="listing-card" style="flex-direction:column;align-items:flex-start;border:1px solid var(--border);border-radius:10px;padding:12px;">
                                            <div class="placeholder-img" style="width:100%;height:90px;margin-bottom:10px;border-radius:6px;background:var(--card-bg);display:flex;align-items:center;justify-content:center;">
                                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>
                                            </div>
                                            <div>
                                                <span class="listing-badge">NEW</span>
                                                <span class="listing-id">#PM-<c:out value="${room.roomId}"/></span>
                                                <div class="listing-title"><c:out value="${room.title}"/></div>
                                                <div class="listing-loc"><c:out value="${room.city}"/></div>
                                            </div>
                                            <div style="display:flex;justify-content:space-between;width:100%;align-items:center;margin-top:8px;">
                                                <div class="listing-price">Rs. <c:out value="${room.rentPrice}"/><span style="font-weight:400;font-size:.8rem;">/mo</span></div>
                                                <a href="${pageContext.request.contextPath}/rooms/edit?id=${room.roomId}" class="listing-edit">Edit</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p style="color:var(--text-muted);text-align:center;padding:2rem;">No listings yet.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div>
                    <%-- RECENT USERS --%>
                    <div class="admin-card" style="margin-bottom:20px;">
                        <div class="section-header">
                            <h3>Recent Users</h3>
                        </div>
                        <c:choose>
                            <c:when test="${not empty recentUsers}">
                                <c:forEach var="u" items="${recentUsers}">
                                    <div class="recent-user">
                                        <div class="user-avatar">
                                            <c:out value="${fn:toUpperCase(fn:substring(u.name, 0, 2))}"/>
                                        </div>
                                        <div style="flex:1;">
                                            <div class="user-name"><c:out value="${u.name}"/></div>
                                            <div class="user-joined"><c:out value="${u.role}"/></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p style="color:var(--text-muted);text-align:center;padding:1rem;">No users yet.</p>
                            </c:otherwise>
                        </c:choose>
                        <button class="manage-users-btn"
                                onclick="location.href='${pageContext.request.contextPath}/admin/users'">
                            Manage All Users
                        </button>
                    </div>

                    <div class="dark-card" style="margin-bottom:20px;">
                        <h3>System Summary</h3>
                        <div class="revenue-bar">
                            <div class="revenue-label">
                                <span>Total Listings</span>
                                <span><c:out value="${totalListings}"/></span>
                            </div>
                            <div class="progress">
                                <div class="progress-fill" style="width:75%;"></div>
                            </div>
                        </div>
                        <div class="revenue-bar">
                            <div class="revenue-label">
                                <span style="color:#aaa;">Total Bookings</span>
                                <span style="color:#aaa;"><c:out value="${totalBookings}"/></span>
                            </div>
                            <div class="progress">
                                <div class="progress-fill" style="width:${totalBookings > 0 ? 50 : 0}%;background:#aaa;"></div>
                            </div>
                        </div>
                        <div class="target-row">
                            <div style="font-size:.75rem;color:#aaa;text-transform:uppercase;letter-spacing:.06em;margin-bottom:4px;">Pending Bookings</div>
                            <div class="target-pct"><c:out value="${pendingCount}"/></div>
                            <div class="target-up">Awaiting admin review</div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>