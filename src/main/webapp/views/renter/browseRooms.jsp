<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<% if (session.getAttribute("role")==null || !"renter".equals(session.getAttribute("role"))) {
    response.sendRedirect("../login.jsp");
    return; }
    request.setAttribute("currentPage", "browseRooms"
); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Rooms | Basai</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/renter.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/browseRooms.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body>

<%@include file="sidebar.jsp" %>

<div class="main-content">

    <header class="topbar">
        <div class="topbar-left">
            <div class="topbar-brand">Browse Rooms</div>
        </div>
        <div class="topbar-actions">
            <div class="topbar-search">
                <i class="ri-search-line"></i>
                <input type="text" placeholder="Search rooms, location...">
            </div>
            <button class="icon-btn">
                <i class="ri-notification-3-line"></i>
                <span class="notif-dot"></span>
            </button>
            <div class="topbar-user">
                <div class="avatar">SS</div>
                <div>
                    <div class="name">${room.renterName}</div>
                    <div class="role">Renter</div>
                </div>
            </div>
        </div>
    </header>

    <main class="page-body">

        <div class="page-header">
            <div class="breadcrumb">
                Home <span class="sep">/</span> <span>Browse Rooms</span>
            </div>
            <h1 class="page-title">Find Your Next Room</h1>
            <p class="page-subtitle">Discover affordable and comfortable rooms across Nepal.</p>
        </div>

        <form action="${pageContext.request.contextPath}/rooms/browse" method="get">
            <div class="browse-layout">

                <!-- ================= FILTER SIDEBAR ================= -->
                <aside class="filter-sidebar">

                    <h3 class="filter-title">Filter Rooms</h3>

                    <div class="filter-section">
                        <div class="filter-label"><i class="ri-map-pin-line"></i> Location</div>
                        <input type="text" name="keyword" class="form-input" placeholder="Enter location" value="${param.keyword}">
                    </div>


                    <div class="filter-section">
                        <div class="filter-label"><i class="ri-home-4-line"></i> Room Type</div>
                        <label class="checkbox-group">
                            <input type="radio" name="roomType" value="SINGLE"
                            ${param.roomType == 'SINGLE' ? 'checked' : ''}>
                            <span class="check-label">Single Room</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="radio" name="roomType" value="DOUBLE"
                            ${param.roomType == 'DOUBLE' ? 'checked' : ''}>
                            <span class="check-label">Double Room</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="radio" name="roomType" value="ONE_BHK"
                            ${param.roomType == 'ONE_BHK' ? 'checked' : ''}>
                            <span class="check-label">1 BHK</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="radio" name="roomType" value="TWO_BHK"
                            ${param.roomType == 'TWO_BHK' ? 'checked' : ''}>
                            <span class="check-label">2 BHK</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="radio" name="roomType" value="STUDIO"
                            ${param.roomType == 'STUDIO' ? 'checked' : ''}>
                            <span class="check-label">Studio</span>
                        </label>
                    </div>

                    <div class="filter-section">
                        <div class="filter-label"><i class="ri-building-line"></i> Facilities</div>
                        <label class="checkbox-group">
                            <input type="checkbox" name="facilities" value="WiFi"
                            ${fn:contains(param.facilities, 'WiFi') ? 'checked' : ''}>
                            <span class="check-label">WiFi</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="checkbox" name="facilities" value="Parking"
                            ${fn:contains(param.facilities, 'Parking') ? 'checked' : ''}>
                            <span class="check-label">Parking</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="checkbox" name="facilities" value="Laundry"
                            ${fn:contains(param.facilities, 'Laundry') ? 'checked' : ''}>
                            <span class="check-label">Laundry</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="checkbox" name="facilities" value="Kitchen"
                            ${fn:contains(param.facilities, 'Kitchen') ? 'checked' : ''}>
                            <span class="check-label">Kitchen</span>
                        </label>
                    </div>

                    <div class="filter-section">
                        <div class="filter-label"><i class="ri-sofa-line"></i> Furnishing</div>
                        <label class="checkbox-group">
                            <input type="radio" name="furnishing" value="Furnished"
                            ${param.furnishing == 'Furnished' ? 'checked' : ''}>
                            <span class="check-label">Furnished</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="radio" name="furnishing" value="SemiFurnished"
                            ${param.furnishing == 'SemiFurnished' ? 'checked' : ''}>
                            <span class="check-label">Semi Furnished</span>
                        </label>
                        <label class="checkbox-group">
                            <input type="radio" name="furnishing" value="Unfurnished"
                            ${param.furnishing == 'Unfurnished' ? 'checked' : ''}>
                            <span class="check-label">Unfurnished</span>
                        </label>
                    </div>

                    <button class="btn btn-primary filter-btn">
                        <i class="ri-filter-3-line"></i> Apply Filters
                    </button>

                </aside>

                <!-- ================= ROOM GRID ================= -->
                <section class="rooms-section">

                    <div class="rooms-topbar">
                        <div class="rooms-count">
                            Showing <strong>${fn:length(rooms)}</strong> available rooms
                        </div>
                        <select class="form-select sort-select" name="sort"
                                onchange="this.form.submit()">
                            <option value="latest"      ${param.sort == 'latest'      ? 'selected' : ''}>Newest First</option>
                            <option value="price_asc"   ${param.sort == 'price_asc'   ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_desc"  ${param.sort == 'price_desc'  ? 'selected' : ''}>Price: High to Low</option>
                        </select>
                    </div>

                    <div class="rooms-grid">
                        <c:choose>
                            <c:when test="${not empty rooms}">
                                <c:forEach var="room" items="${rooms}">

                                    <div class="room-card">

                                        <div class="room-card-img-wrap">
                                            <c:choose>
                                                <c:when test="${not empty room.photo1}">
                                                    <img src="${pageContext.request.contextPath}/${room.photo1}"
                                                         class="room-card-img" alt="Room">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?q=80&w=1200&auto=format&fit=crop"
                                                         class="room-card-img" alt="Room">
                                                </c:otherwise>
                                            </c:choose>

                                            <span class="room-card-badge">
                                            <c:out value="${room.availabilityStatus}"/>
                                        </span>

                                            <form action="${pageContext.request.contextPath}/favourites/toggle" method="post">
                                                <input type="hidden" name="roomId" value="${room.roomId}">
                                                <c:set var="searchId" value=",${room.roomId},"/>
                                                <button type="submit" class="favorite-btn">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(favouriteRoomIds, searchId)}">
                                                            <i class="ri-heart-fill" style="color:#e53935;"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="ri-heart-line"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </button>
                                            </form>
                                        </div>

                                        <div class="room-card-body">

                                                <%-- PRICE + ROOM TYPE on the same row --%>
                                            <div class="room-card-price-row">
                                                <div class="room-card-price">
                                                    Rs. <fmt:formatNumber value="${room.rentPrice}" pattern="#,###"/>
                                                    <span>/month</span>
                                                </div>
                                                <span class="room-type-tag">
                                                <i class="ri-home-4-line"></i>
                                                <c:out value="${room.roomType}"/>
                                            </span>
                                            </div>

                                            <h3 class="room-card-title">
                                                <c:out value="${room.title}"/>
                                            </h3>

                                            <div class="room-card-loc">
                                                <i class="ri-map-pin-line"></i>
                                                <c:out value="${room.city}"/>
                                            </div>

                                                <%-- FACILITIES split into individual bubbles --%>
                                            <c:if test="${not empty room.facilities}">
                                                <div class="room-facilities">
                                                    <c:forEach var="facility" items="${fn:split(room.facilities, ',')}">
                                                    <span class="facility-bubble">
                                                        <i class="ri-checkbox-circle-line"></i>
                                                        <c:out value="${fn:trim(facility)}"/>
                                                    </span>
                                                    </c:forEach>
                                                </div>
                                            </c:if>

                                        </div>

                                        <div class="room-card-footer">
                                            <a href="${pageContext.request.contextPath}/rooms/detail?roomId=${room.roomId}"
                                               class="btn btn-primary room-btn">
                                                View Details
                                            </a>
                                        </div>

                                    </div>

                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="grid-column:1/-1;text-align:center;padding:48px;color:#888;">
                                    No rooms available at the moment.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="pagination">
                        <button class="page-btn"><i class="ri-arrow-left-s-line"></i></button>
                        <button class="page-btn active">1</button>
                        <button class="page-btn">2</button>
                        <button class="page-btn">3</button>
                        <button class="page-btn"><i class="ri-arrow-right-s-line"></i></button>
                    </div>

                </section>

            </div>
        </form>

    </main>

</div>

</body>
</html>
