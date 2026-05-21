<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "addListing");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai Admin - Listing Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/admin/css/adminListings.css">

</head>
<body>

<%@ include file="sidebar.jsp" %>

<div class="admin-main">

    <%-- TOPBAR --%>
    <div class="admin-topbar">
        <span class="page-title">Listing Management</span>
        <div class="topbar-right">
            <div class="search-box">
                <span>&#x1F50D;</span>
                <input type="text" id="searchInput" placeholder="Search properties...">
            </div>
            <button class="icon-btn">&#x1F514;</button>
            <button class="icon-btn">&#x2753;</button>
            <div class="admin-avatar" style="width:32px;height:32px;border-radius:50%;background:#c8d5e8;cursor:pointer;"></div>
        </div>
    </div>

    <div class="content-body" style="padding-top:24px;">

        <%-- HEADER --%>
        <div class="listings-header">
            <h2>Architectural Inventory</h2>
            <p>Manage the city's premium studio flats and professional workspaces with surgical precision.</p>
            <div class="header-actions">
                <button class="btn-filter">&#x25A6; Filter</button>
                <button class="btn-export">&#x2193; Export Data</button>
            </div>
        </div>

        <%-- MINI STATS  --%>
        <div class="mini-stats">
            <div class="mini-stat">
                <div class="mini-stat-label">Total Listings</div>
                <div class="mini-stat-value">
                    <c:choose>
                        <c:when test="${not empty rooms}">${fn:length(rooms)}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="mini-stat-sub">&#x1F4C8; Live on platform</div>
            </div>
            <div class="mini-stat">
                <div class="mini-stat-label">Active Now</div>
                <div class="mini-stat-value">—</div>
                <div class="mini-stat-sub">&#x25CF; Available units</div>
            </div>
            <div class="mini-stat">
                <div class="mini-stat-label">Pending Review</div>
                <div class="mini-stat-value">—</div>
                <div class="mini-stat-sub warn">&#x23F3; Awaiting approval</div>
            </div>
            <div class="mini-stat dark">
                <div class="mini-stat-label">Premium Slots</div>
                <div class="mini-stat-value">—</div>
                <div class="mini-stat-sub">&#x2714; Exclusive units</div>
            </div>
        </div>

        <%-- PROPERTY REGISTRY TABLE --%>
        <div class="property-table-wrap">
            <div class="property-table-header">
                <h3>Property Registry</h3>
                <div>
                    <label style="font-size:.82rem;color:#888;margin-right:8px;">Sort by:</label>
                    <select class="sort-select">
                        <option>Latest Added</option>
                        <option>Price: High to Low</option>
                        <option>Price: Low to High</option>
                    </select>
                </div>
            </div>

            <table class="data-table" id="listingsTable">
                <thead>
                <tr>
                    <th>Property Details</th>
                    <th>Location</th>
                    <th>Value</th>
                    <th>Ownership</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty rooms}">
                        <c:forEach var="room" items="${rooms}">

                            <tr>

                                    <%-- PROPERTY DETAILS --%>
                                <td>
                                    <div style="display:flex;align-items:center;gap:12px;">

                                        <c:choose>
                                            <c:when test="${not empty room.photo1}">
                                                <img src="${pageContext.request.contextPath}/${room.photo1}"
                                                     class="prop-thumb"
                                                     alt="Room image">
                                            </c:when>

                                            <c:otherwise>
                                                <div class="prop-thumb"></div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div>
                                            <div class="prop-id">
                                                ID: BS-<c:out value="${room.roomId}"/>
                                            </div>

                                            <div class="prop-name">
                                                <c:out value="${room.title}"/>
                                            </div>

                                            <div class="prop-sub-loc">
                                                <c:out value="${room.roomType}"/>
                                            </div>
                                        </div>
                                    </div>
                                </td>

                                    <%-- LOCATION --%>
                                <td>
                                    <div class="prop-location">
                                        <c:out value="${room.city}"/>
                                    </div>

                                    <div class="prop-sub-loc">
                                        <c:out value="${room.address}"/>
                                    </div>
                                </td>

                                    <%-- PRICE --%>
                                <td>
                                    <div class="prop-price">
                                        NPR
                                        <fmt:formatNumber value="${room.rentPrice}" pattern="#,###"/>
                                    </div>

                                    <div class="prop-unit">
                                        PER MONTH
                                    </div>
                                </td>

                                    <%-- OWNER INFO --%>
                                <td>
                                    <div class="owner-cell">
                                        <div class="owner-avatar"></div>

                                        <div>
                                            <c:out value="${room.ownerName}"/>
                                        </div>
                                    </div>
                                </td>

                                    <%-- STATUS --%>
                                <td>

                                    <c:choose>

                                        <c:when test="${room.availabilityStatus == 'Available'}">
                            <span class="badge-available">
                                Available
                            </span>
                                        </c:when>

                                        <c:when test="${room.availabilityStatus == 'Rented'}">
                            <span class="badge-rented">
                                Rented
                            </span>
                                        </c:when>

                                        <c:otherwise>
                            <span class="badge-pending">
                                Unknown
                            </span>
                                        </c:otherwise>

                                    </c:choose>

                                </td>

                                    <%-- ACTIONS --%>
                                <td>
                                    <div class="action-btns">

                                        <button class="action-btn-view"
                                                onclick="location.href='${pageContext.request.contextPath}/rooms/${room.roomId}'">
                                            View
                                        </button>

                                        <form action="${pageContext.request.contextPath}/rooms/delete"
                                              method="post"
                                              style="display:inline;"
                                              onsubmit="return confirm('Remove this listing?')">

                                            <input type="hidden"
                                                   name="roomId"
                                                   value="${room.roomId}">

                                            <button type="submit"
                                                    class="action-btn-remove">
                                                Remove
                                            </button>

                                        </form>

                                    </div>
                                </td>

                            </tr>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="no-data" style="text-align:center">
                                No listings found.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>

            <div style="display:flex;justify-content:space-between;align-items:center;padding:16px 20px;border-top:1px solid #f0f0f0;">
                <span class="pagination-info">
                    Showing ${not empty rooms ? fn:length(rooms) : 0} listings
                </span>
                <div class="pagination">
                    <a href="#">&#8249;</a>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">&#8250;</a>
                </div>
            </div>
        </div>

    </div>
</div>

<%-- Live search filter — client side, no reload needed --%>
<script>
    document.getElementById('searchInput').addEventListener('input', function () {
        const query = this.value.toLowerCase();
        document.querySelectorAll('#listingsTable tbody tr').forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(query) ? '' : 'none';
        });
    });
</script>

</body>
</html>
