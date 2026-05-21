<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    if (session.getAttribute("role") == null || !"renter".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "browseRooms");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${room.title}"/> | Basai</title>

    <!-- Base CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/renter.css">

    <!-- Room Detail CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/roomDetail.css">

    <!-- Remix Icons -->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body>

<%@include file="sidebar.jsp"%>

<!-- ================= MAIN CONTENT ================= -->
<div class="main-content">

    <!-- ================= PAGE BODY ================= -->
    <main class="page-body">

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
        </div>

        <!-- ================= PHOTO GALLERY ================= -->
        <div class="gallery">

            <!-- Main large photo -->
            <div class="gallery-main">
                <c:choose>
                    <c:when test="${not empty room.photo1}">
                        <img src="${pageContext.request.contextPath}/${room.photo1}" alt="Room main photo">
                    </c:when>
                    <c:otherwise>
                        <img src="https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?q=80&w=1200&auto=format&fit=crop" alt="Room">
                    </c:otherwise>
                </c:choose>
                <span class="gallery-featured-tag">Featured</span>
            </div>

            <!-- Side thumbnails -->
            <div class="gallery-grid">

                <div class="gallery-thumb">
                    <c:choose>
                        <c:when test="${not empty room.photo2}">
                            <img src="${pageContext.request.contextPath}/${room.photo2}" alt="Room photo 2">
                        </c:when>
                        <c:otherwise>
                            <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=800&auto=format&fit=crop" alt="Room">
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="gallery-thumb">
                    <c:choose>
                        <c:when test="${not empty room.photo3}">
                            <img src="${pageContext.request.contextPath}/${room.photo3}" alt="Room photo 3">
                        </c:when>
                        <c:otherwise>
                            <img src="https://images.unsplash.com/photo-1494526585095-c41746248156?q=80&w=800&auto=format&fit=crop" alt="Room">
                        </c:otherwise>
                    </c:choose>
                    <!-- Show +more overlay if photos 4/5 exist -->
                    <c:if test="${not empty room.photo4}">
                        <div class="gallery-more-overlay">
                            <span>+2</span>
                            <small>More Photos</small>
                        </div>
                    </c:if>
                </div>

            </div>
        </div>

        <!-- ================= DETAIL LAYOUT ================= -->
        <div class="detail-layout">

            <!-- ================= LEFT COLUMN ================= -->
            <div class="detail-left">

                <!-- MAIN INFO -->
                <div class="room-main-info">

                    <div class="room-title-row">
                        <h1 class="room-title"><c:out value="${room.title}"/></h1>
                        <div class="room-rating">
                            <div class="rating-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
                            <span class="rating-score">4.5 / 5</span>
                            <span class="rating-count">12 Reviews</span>
                        </div>
                    </div>

                    <div class="room-location-row">
                        <i class="ri-map-pin-fill"></i>
                        <c:out value="${room.city}"/>, Nepal
                    </div>

                    <div class="room-price-row">
                        <div class="room-price">
                            Rs. <fmt:formatNumber value="${room.rentPrice}" pattern="#,###"/>
                            <span>/ month</span>
                        </div>
                        <div class="room-actions-row">
                            <button class="btn-share">
                                <i class="ri-share-line"></i> Share
                            </button>
                            <button class="btn-save">
                                <i class="ri-heart-line"></i> Save
                            </button>
                        </div>
                    </div>

                </div>

                <!-- PROPERTY OVERVIEW -->
                <div class="section-card">

                    <h3 class="section-heading">
                        <i class="ri-information-line"></i>
                        Property Overview
                    </h3>

                    <p class="room-description">
                        <c:choose>
                            <c:when test="${not empty room.description}">
                                <c:out value="${room.description}"/>
                            </c:when>
                            <c:otherwise>
                                Spacious and well-ventilated room suitable for professionals and students.
                                This modern unit features quality finishes and is conveniently located for
                                easy access to the city's key areas.
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <!-- META STRIP -->
                    <div class="room-meta-strip">
                        <div class="meta-item">
                            <div class="meta-label">Room Type</div>
                            <div class="meta-value"><c:out value="${room.roomType}"/></div>
                        </div>
                        <div class="meta-item">
                            <div class="meta-label">Furnishing</div>
                            <div class="meta-value"><c:out value="${room.furnishingStatus}"/></div>
                        </div>
                        <div class="meta-item">
                            <div class="meta-label">Location</div>
                            <div class="meta-value"><c:out value="${room.city}"/></div>
                        </div>
                        <div class="meta-item">
                            <div class="meta-label">Availability</div>
                            <div class="meta-value"><c:out value="${room.availabilityStatus}"/></div>
                        </div>
                    </div>

                </div>

                <!-- FACILITIES & AMENITIES -->
                <div class="section-card">

                    <h3 class="section-heading">
                        <i class="ri-checkbox-circle-line"></i>
                        Facilities &amp; Amenities
                    </h3>

                    <c:choose>
                        <c:when test="${not empty room.facilities}">
                            <div class="facilities-grid">
                                <c:forEach var="facility" items="${fn:split(room.facilities, ',')}">
                                    <div class="facility-item">
                                        <c:set var="fac" value="${fn:trim(facility)}"/>
                                        <c:choose>
                                            <c:when test="${fn:containsIgnoreCase(fac, 'wifi') or fn:containsIgnoreCase(fac, 'internet')}">
                                                <i class="ri-wifi-line"></i>
                                            </c:when>
                                            <c:when test="${fn:containsIgnoreCase(fac, 'parking')}">
                                                <i class="ri-parking-box-line"></i>
                                            </c:when>
                                            <c:when test="${fn:containsIgnoreCase(fac, 'water')}">
                                                <i class="ri-drop-line"></i>
                                            </c:when>
                                            <c:when test="${fn:containsIgnoreCase(fac, 'electric') or fn:containsIgnoreCase(fac, 'power')}">
                                                <i class="ri-flashlight-line"></i>
                                            </c:when>
                                            <c:when test="${fn:containsIgnoreCase(fac, 'kitchen')}">
                                                <i class="ri-restaurant-line"></i>
                                            </c:when>
                                            <c:when test="${fn:containsIgnoreCase(fac, 'bath') or fn:containsIgnoreCase(fac, 'toilet')}">
                                                <i class="ri-home-smile-line"></i>
                                            </c:when>
                                            <c:when test="${fn:containsIgnoreCase(fac, 'laundry') or fn:containsIgnoreCase(fac, 'wash')}">
                                                <i class="ri-t-shirt-line"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="ri-checkbox-circle-line"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:out value="${fac}"/>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p style="color:var(--text-muted);font-size:.85rem;">No facilities listed.</p>
                        </c:otherwise>
                    </c:choose>

                </div>

                <!-- ================= TENANT EXPERIENCES / REVIEWS ================= -->
                <div class="section-card">

                    <h3 class="section-heading">
                        <i class="ri-user-voice-line"></i>
                        Tenant Experiences
                    </h3>

                    <%-- Alert messages --%>
                    <c:if test="${param.success eq 'reviewed'}">
                        <div class="alert alert-success">
                            <i class="ri-checkbox-circle-line"></i>
                            <span>Your review was submitted successfully!</span>
                        </div>
                    </c:if>
                    <c:if test="${param.success eq 'deleted'}">
                        <div class="alert alert-warn">
                            <i class="ri-delete-bin-line"></i>
                            <span>Review deleted.</span>
                        </div>
                    </c:if>
                    <c:if test="${param.error eq 'invalid_rating'}">
                        <div class="alert alert-info">
                            <i class="ri-error-warning-line"></i>
                            <span>Please select a valid rating (1–5).</span>
                        </div>
                    </c:if>
                    <c:if test="${param.error eq 'no_booking'}">
                        <div class="alert alert-warn">
                            <i class="ri-information-line"></i>
                            <span>Only renters with an approved booking can leave a review.</span>
                        </div>
                    </c:if>

                    <%-- Reviews list --%>
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="review" items="${reviews}">
                                <div class="review-item">
                                    <div class="review-header">
                                        <div class="reviewer-info">
                                            <div class="reviewer-avatar">
                                                <c:out value="${fn:substring(review.renterName, 0, 2)}"/>
                                            </div>
                                            <div>
                                                <div class="reviewer-name"><c:out value="${review.renterName}"/></div>
                                                <div class="reviewer-tag">Verified Tenant</div>
                                            </div>
                                        </div>
                                        <div style="display:flex;align-items:center;gap:12px;">
                                            <div class="review-stars">
                                                <c:forEach begin="1" end="${review.rating}" var="s">&#9733;</c:forEach>
                                            </div>
                                            <c:if test="${sessionScope.userId == review.renterId or sessionScope.role == 'admin'}">
                                                <form action="${pageContext.request.contextPath}/reviews/delete"
                                                      method="post"
                                                      onsubmit="return confirm('Delete this review?');"
                                                      style="margin:0;">
                                                    <input type="hidden" name="reviewId" value="${review.reviewId}">
                                                    <button type="submit" class="btn btn-danger btn-sm">
                                                        <i class="ri-delete-bin-line"></i> Delete
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                    <p class="review-text">"<c:out value="${review.comment}"/>"</p>
                                </div>
                            </c:forEach>

                            <button class="btn-view-all-reviews">
                                View All <c:out value="${fn:length(reviews)}"/> Reviews
                            </button>
                        </c:when>

                        <c:otherwise>
                            <%-- No reviews placeholder --%>
                            <div class="no-reviews-placeholder">
                                <div class="no-reviews-icon">
                                    <i class="ri-chat-3-line"></i>
                                </div>
                                <h4>No Reviews Yet</h4>
                                <p>Be the first to share your experience in this room.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <%-- ADD REVIEW FORM --%>
                    <c:if test="${hasApprovedBooking}">
                        <div class="review-form-wrap">
                            <h4 class="section-heading" style="margin-bottom:16px;">
                                <i class="ri-edit-line"></i> Leave a Review
                            </h4>

                            <form action="${pageContext.request.contextPath}/reviews/add" method="post">
                                <input type="hidden" name="roomId" value="${room.roomId}">

                                    <%-- Star Rating --%>
                                <div class="form-group">
                                    <label class="form-label">Your Rating</label>
                                    <div class="star-rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <input type="radio" name="rating" id="star${i}" value="${i}" required>
                                            <label for="star${i}" title="${i} star">
                                                <i class="ri-star-fill"></i>
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>

                                    <%-- Comment --%>
                                <div class="form-group">
                                    <label class="form-label" for="reviewComment">Your Experience</label>
                                    <textarea id="reviewComment"
                                              name="comment"
                                              class="form-textarea"
                                              rows="3"
                                              placeholder="Share what you liked or what could be improved..."></textarea>
                                </div>

                                <button type="submit" class="btn btn-primary">
                                    <i class="ri-send-plane-line"></i> Submit Review
                                </button>
                            </form>
                        </div>
                    </c:if>

                </div>
                <!-- ================= END REVIEWS ================= -->

            </div>

            <!-- ================= RIGHT COLUMN ================= -->
            <div class="detail-right">

                <!-- INVESTMENT / BOOKING CARD -->
                <div class="investment-card">

                    <div class="investment-label">Investment</div>

                    <div class="investment-price">
                        Rs. <fmt:formatNumber value="${room.rentPrice}" pattern="#,###"/>
                        <span>/ Mo</span>
                    </div>

                    <a href="${pageContext.request.contextPath}/bookings/request?roomId=${room.roomId}">
                        <button class="btn-book-now">BOOK NOW / APPLY</button>
                    </a>

                    <form action="${pageContext.request.contextPath}/favourites/toggle" method="post">
                        <input type="hidden" name="roomId" value="${room.roomId}">
                        <button type="submit" class="btn-wishlist">
                            <c:choose>
                                <c:when test="${isFavourite}">
                                    <i class="ri-heart-fill" style="color:#e53935;"></i> WISHLISTED
                                </c:when>
                                <c:otherwise>
                                    <i class="ri-heart-line"></i> ADD TO WISHLIST
                                </c:otherwise>
                            </c:choose>
                        </button>
                    </form>

                    <!-- Owner info -->
                    <div class="owner-info-block">
                        <div class="owner-info-label">Property Managed By</div>
                        <div class="owner-info-row">
                            <div class="owner-avatar-sm">
                                <c:choose>
                                    <c:when test="${not empty room.ownerName}">
                                        <c:out value="${fn:substring(room.ownerName, 0, 2)}"/>
                                    </c:when>
                                    <c:otherwise>OW</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="owner-name-block">
                                <div class="owner-name">
                                    <c:choose>
                                        <c:when test="${not empty room.ownerName}">
                                            <c:out value="${room.ownerName}"/>
                                        </c:when>
                                        <c:otherwise>Property Owner</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="owner-phone">
                                    <i class="ri-phone-line"></i>
                                    +977 98XXXXXXXX
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>

        <!-- ================= FOOTER ================= -->
        <footer class="page-footer">
            <div class="footer-grid">
                <div class="footer-brand">
                    <div class="logo">Basai Urban Rentals</div>
                    <p>Precision-engineered solutions for the modern Kathmandu resident.</p>
                </div>
                <div class="footer-col">
                    <h4>Support</h4>
                    <a href="#">Terms of Service</a>
                    <a href="#">Privacy Policy</a>
                    <a href="#">Contact Support</a>
                    <a href="#">List Your Property</a>
                </div>
                <div class="footer-col">
                    <h4>Account</h4>
                    <a href="#">My Profile</a>
                    <a href="#">My Bookings</a>
                    <a href="#">Wishlist</a>
                </div>
            </div>
            <div class="footer-bottom">
                <span>&copy; 2024 Basai Urban Rentals. Precision in Living.</span>
                <span>
                    <a href="#">Privacy</a> &nbsp;&bull;&nbsp; <a href="#">Terms</a>
                </span>
            </div>
        </footer>

    </main>

</div>

</body>
</html>
