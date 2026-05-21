<%@ page isELIgnored="false" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%-- Security check: redirect if not admin --%>
<%
    if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "addListing");
%>

<c:set var="activeTab" value="${not empty activeTab ? activeTab : (not empty param.tab ? param.tab : 'all')}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai Admin - User Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/adminUsers.css">

</head>
<body>

<%@ include file="sidebar.jsp" %>

<div class="admin-main">

    <%-- TOPBAR --%>
    <div class="admin-topbar">
        <span class="page-title">User Management</span>
        <div class="topbar-right">
            <div class="search-box">
                <span>&#x1F50D;</span>
                <input type="text" placeholder="Search professionals...">
            </div>
            <button class="icon-btn">&#x1F514;</button>
            <button class="icon-btn">&#x2753;</button>
            <div class="admin-avatar" style="width:32px;height:32px;border-radius:50%;background:#c8d5e8;cursor:pointer;"></div>
        </div>
    </div>

    <div class="content-body" style="padding-top:24px;">

        <%-- HEADER BLOCK --%>
        <div class="user-header-block">
            <div>
                <h2 style="font-size:1.5rem;font-weight:800;">Active Community</h2>
                <p style="color:#888;font-size:.88rem;margin-top:4px;max-width:420px;">
                    Overseeing the growth of Kathmandu's premier modern living ecosystem through precision data management.
                </p>
                <div class="user-stats">
                    <div class="user-stat-item">
                        <span class="user-stat-label">Total Users</span>
                        <span class="user-stat-value">
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:out value="${fn:length(users)}" default="0"/>
                                </c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="user-stat-growth">&#x1F4C8; +12% this month</span>
                    </div>
                    <div class="user-stat-item">
                        <span class="user-stat-label">Verified Owners</span>
                        <span class="user-stat-value">
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:set var="ownerCount" value="0"/>
                                    <c:forEach var="u" items="${users}">
                                        <c:if test="${u.role == 'owner' and u.verificationStatus == 'Verified'}">
                                            <c:set var="ownerCount" value="${ownerCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:out value="${ownerCount}" default="0"/>
                                </c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="user-stat-item">
                        <span class="user-stat-label">Pending Reviews</span>
                        <span class="user-stat-value teal">18</span>
                    </div>
                </div>
            </div>
            <div class="security-block">
                <div style="font-size:1.6rem;">&#x1F6E1;</div>
                <h4>Security Protocol</h4>
                <p>Ensure all system administrators have updated their two-factor authentication for the new quarter.</p>
                <button class="audit-btn">AUDIT LOGS</button>
            </div>
        </div>

        <%-- TABS ROW --%>
        <div class="tabs-row">
            <div class="tabs">
                <button class="tab-btn ${activeTab == 'all'     ? 'active' : ''}"
                        onclick="location.href='${pageContext.request.contextPath}/users/all?tab=all'">
                    All Users
                </button>
                <button class="tab-btn ${activeTab == 'renters' ? 'active' : ''}"
                        onclick="location.href='${pageContext.request.contextPath}/users/all?tab=renters'">
                    Renters
                </button>
                <button class="tab-btn ${activeTab == 'owners'  ? 'active' : ''}"
                        onclick="location.href='${pageContext.request.contextPath}/users/all?tab=owners'">
                    Owners
                </button>
                <button class="tab-btn ${activeTab == 'admins'  ? 'active' : ''}"
                        onclick="location.href='${pageContext.request.contextPath}/users/all?tab=admins'">
                    Admins
                </button>
            </div>
            <button class="filter-btn">&#x25A6; Advanced Filters</button>
        </div>

        <%-- USER TABLE --%>
        <div class="users-table-card">
            <table class="data-table">
                <thead>
                <tr>
                    <th>User ID</th>
                    <th>Full Name</th>
                    <th>Contact Info</th>
                    <th>Role</th>
                    <th>Verification Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="u" items="${users}">
                            <tr>
                                    <%-- User ID --%>
                                <td style="color:#888;font-size:.85rem;">
                                    #BAS-<c:out value="${u.user_id}"/>
                                </td>
                                    <%-- Full Name --%>
                                <td>
                                    <div class="user-cell">
                                        <div class="admin-avatar"></div>
                                        <div>
                                            <div style="font-weight:600;">
                                                <c:out value="${u.name}"/>
                                            </div>
                                        </div>
                                    </div>
                                </td>

                                    <%-- Contact Info --%>
                                <td>
                                    <div class="contact-cell">
                                        <span><c:out value="${u.email}"/></span>
                                        <span style="color:#888;">
                                                <c:out value="${not empty u.phone ? u.phone : 'N/A'}"/>
                                            </span>
                                    </div>
                                </td>

                                    <%-- Role Badge --%>
                                <td>
                                        <span class="badge badge-${fn:toLowerCase(u.role)}">
                                            <c:out value="${fn:toUpperCase(u.role)}"/>
                                        </span>
                                </td>

                                    <%-- Verification Status Badge --%>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.verificationStatus == 'Verified'}">
                                            <span class="badge badge-verified">Verified</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-pending">Pending</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                    <%-- Actions --%>
                                <td>
                                        <%-- Verify / Reject --%>
                                    <c:if test="${u.verificationStatus != 'Verified'}">
                                        <form action="${pageContext.request.contextPath}/users/verify"
                                              method="post" style="display:inline;">
                                            <input type="hidden" name="userId" value="${u.user_id}">
                                            <input type="hidden" name="action" value="verify">
                                            <button type="submit" class="action-link" style="color:#27ae60;">Verify</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/users/verify"
                                              method="post" style="display:inline;">
                                            <input type="hidden" name="userId" value="${u.user_id}">
                                            <input type="hidden" name="action" value="reject">
                                            <button type="submit" class="action-link" style="color:#e74c3c;">Reject</button>
                                        </form>
                                    </c:if>
                                    <button class="action-link">View</button>
                                    <button class="action-link">Edit</button>
                                    <button class="action-link" style="color:#e74c3c;">Remove</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="no-data">No users found.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>

            <div class="table-footer">
                <span class="pagination-info">
                    Showing <c:out value="${not empty users ? fn:length(users) : 0}"/> results
                </span>
                <div class="pagination">
                    <a href="#">Previous</a>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">Next</a>
                </div>
            </div>
        </div>

    </div>

    <%-- FOOTER --%>
    <div style="margin-top:auto;border-top:1px solid #eee;padding:16px 32px;display:flex;justify-content:space-between;font-size:.75rem;color:#aaa;">
        <span>&#169; 2024 BASAI ADMIN</span>
        <span>SYSTEM STATUS: OPERATIONAL</span>
        <span>DATA PRIVACY PROTOCOL</span>
    </div>
</div>

</body>
</html>
