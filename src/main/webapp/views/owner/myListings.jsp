<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
  if (session.getAttribute("role") == null || !"owner".equals(session.getAttribute("role"))) {
    response.sendRedirect("../login.jsp");
    return;
  }
  request.setAttribute("currentPage", "myListings");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Listings | Basai Owner</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/owner.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/listings.css">
</head>
<body>

<!-- SIDEBAR -->
<%@ include file="sidebar.jsp" %>

<!-- MAIN CONTENT -->
<div class="main-content">

  <main class="page-body">

    <div class="page-header">
      <h1 class="page-title">My Listings</h1>
      <p class="page-subtitle">Manage and monitor your properties' performance.</p>
    </div>

    <!-- Summary -->
    <div class="listings-summary">
      <div class="summary-item">
        <div class="s-label">Total Listings</div>
        <div class="s-value">24</div>
        <div class="s-sub">+2 this month</div>
      </div>
      <div class="summary-item">
        <div class="s-label">Occupancy Rate</div>
        <div class="s-value" style="color:var(--navy)">92%</div>
        <div class="occ-bar"><div class="occ-fill" style="width:92%"></div></div>
      </div>
      <div class="summary-item">
        <div class="s-label">Active Status</div>
        <div class="s-value">18</div>
        <div class="s-sub"><span class="badge badge-active">Stable</span></div>
      </div>
      <div class="summary-item">
        <div class="s-label">Maintenance</div>
        <div class="s-value" style="color:var(--yellow)">3</div>
        <div class="s-sub" style="color:var(--yellow)">Needs attention</div>
      </div>
    </div>

    <!-- Action Row -->
    <div class="action-row">
      <div></div>
      <div style="display:flex;gap:10px;">
        <button class="btn btn-outline">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="6" x2="20" y2="6"/><line x1="8" y1="12" x2="20" y2="12"/><line x1="12" y1="18" x2="20" y2="18"/></svg>
          Filter
        </button>
        <a href="addListing.jsp" class="btn btn-primary">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
          New Property
        </a>
      </div>
    </div>

    <!-- Table -->
    <div class="card">
      <div class="card-body" style="padding:0;">
        <table class="data-table">
          <thead>
          <tr>
            <th>Room / Property</th>
            <th>Location</th>
            <th>Monthly Price</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${not empty rooms}">
              <c:forEach var="room" items="${rooms}">
                <tr>
                  <td>
                    <div class="room-thumb" style="display:flex; align-items:center; gap:12px;">
                      <div class="placeholder-img">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                          <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                        </svg>
                      </div>
                      <div>
                        <div class="room-name"> <c:out value="${room.title}"/></div>
                        <div class="room-sub">ID: PM-<c:out value="${room.roomId}"/></div>
                      </div>
                    </div>
                  </td>
                  <td>${room.city}<br><small><c:out value="${room.address}"/></small></td>
                  <td class="price-cell">
                    Rs.<c:out value="${room.rentPrice}"/>
                  </td>
                  <td>
                    <span class="badge
                          <c:choose>
                              <c:when test="${room.availabilityStatus.name() eq 'Available'}">badge-active</c:when>
                              <c:otherwise>badge-inactive</c:otherwise>
                          </c:choose>">
                          <c:out value="${room.availabilityStatus}"/>
                      </span>
                  </td>
                  <td>
                    <div class="action-menu">
                      <a href="addListing.jsp?id=${room.roomId}" class="btn btn-sm btn-outline">Edit</a>
                      <button onclick="window.location.href='${pageContext.request.contextPath}/room/delete?roomId=${room.roomId}'"
                              class="btn btn-sm btn-danger">Delete</button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="5" class="no-data" style="text-align:center">
                  You don't have any listings yet.<br>
                  <a href="addListing.jsp" style="color:#1a1a2e; text-decoration:underline;">Create your first listing →</a>
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>

    <div style="display:flex; justify-content:space-between; align-items:center; margin-top:14px;">
      <span class="showing-label">Showing 4 of 24 listings</span>
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

<!-- FAB -->
<button class="fab" onclick="window.location.href='addListing.jsp'" title="Add New Listing">+</button>

</body>
</html>
