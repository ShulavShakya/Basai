<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    if (session.getAttribute("role") == null || !"renter".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("currentPage", "wishlist");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai — My Wishlist</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/renter/css/renter.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<div class="main-content">
    <header class="topbar">
        <div class="topbar-left">
            <span style="font-size:.72rem;text-transform:uppercase;letter-spacing:1.2px;color:var(--text-muted);">USER MANAGEMENT</span>
        </div>
        <div class="topbar-actions">
            <a href="profile.jsp"
               style="font-size:.84rem;color:var(--text-secondary);padding:6px 14px;border-radius:var(--radius-sm);border:1px solid var(--border);">Profile</a>
            <button class="topbar-btn-primary">Logout</button>
        </div>
    </header>

    <div class="page-body">
        <div class="page-header" style="display:flex;align-items:flex-start;justify-content:space-between;">
            <div>
                <div class="page-title">My Wishlist</div>
                <div class="page-subtitle">A curated selection of your prospective homes in the heart of the
                    city. Manage your preferences and finalize your urban living choice.</div>
            </div>
            <div style="display:flex;align-items:center;gap:6px;font-size:.82rem;color:var(--text-muted);background:var(--card-bg);border:1px solid var(--border);border-radius:var(--radius-sm);padding:8px 14px;">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="14" height="14">
                    <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z" stroke-width="2"/>
                </svg>
                <span><strong style="color:var(--text-primary);">${favouriteCount}</strong> Saved Properties</span>
            </div>
        </div>

        <!-- Empty state -->
        <c:if test="${empty wishlistedRooms}">
            <div style="text-align:center;padding:80px 20px;color:var(--text-muted);">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="48" height="48"
                     style="margin-bottom:16px;opacity:.3;">
                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" stroke-width="2"/>
                </svg>
                <div style="font-size:1rem;margin-bottom:8px;">Your wishlist is empty</div>
                <a href="${pageContext.request.contextPath}/rooms/browse"
                   class="btn btn-primary" style="display:inline-block;margin-top:8px;">Browse Rooms</a>
            </div>
        </c:if>

        <!-- Room Grid -->
        <c:if test="${not empty wishlistedRooms}">
            <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:20px;" id="wishlistGrid">
                <c:forEach var="room" items="${wishlistedRooms}">
                    <div class="room-card" id="card-${room.roomId}">

                        <div class="room-card-img-wrap">
                            <c:choose>
                                <c:when test="${not empty room.photo1}">
                                    <img src="${pageContext.request.contextPath}/${room.photo1}"
                                         alt="${room.title}"
                                         style="width:100%;height:180px;object-fit:cover;">
                                </c:when>
                                <c:otherwise>
                                    <div style="width:100%;height:180px;background:linear-gradient(135deg,#2a3a4a,#1a2e3e);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,.2);font-size:2rem;">🏠</div>
                                </c:otherwise>
                            </c:choose>

                            <span class="room-card-badge">${room.roomType}</span>

                            <!-- Remove button — posts to /favourites with action=remove -->
                            <form action="${pageContext.request.contextPath}/favourites/toggle"
                                  method="post" style="display:inline;">
                                <input type="hidden" name="roomId" value="${room.roomId}">
                                <input type="hidden" name="action"  value="remove">
                                <button type="submit"
                                        class="room-card-del-btn"
                                        title="Remove from wishlist"
                                        onclick="animateRemove(event, 'card-${room.roomId}')">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="14" height="14">
                                        <polyline points="3 6 5 6 21 6" stroke-width="2"/>
                                        <path d="M19 6l-1 14H6L5 6M10 11v6M14 11v6M9 6V4h6v2" stroke-width="2"/>
                                    </svg>
                                </button>
                            </form>
                        </div>

                        <div class="room-card-body">
                            <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                                <div class="room-card-title">${room.title}</div>
                                <div style="text-align:right;">
                                    <div class="room-card-price">
                                        Rs. <fmt:formatNumber value="${room.rentPrice}" pattern="#,###"/>
                                        <span>/month</span>
                                    </div>
                                </div>
                            </div>
                            <div class="room-card-loc">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" stroke-width="2"/>
                                    <circle cx="12" cy="10" r="3" stroke-width="2"/>
                                </svg>
                                    ${room.city}, Nepal
                            </div>
                        </div>

                        <div class="room-card-footer">
                            <a href="${pageContext.request.contextPath}/rooms/detail?id=${room.roomId}"
                               class="btn btn-primary" style="width:100%;justify-content:center;">
                                View Details →
                            </a>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:if>
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
            <span>© 2024 Basai Urban Rentals. All rights reserved.</span>
            <span><a href="#">Privacy Policy</a> · <a href="#">Terms of Service</a></span>
        </div>
    </footer>
</div>

<script>
    function animateRemove(event, cardId) {
        event.preventDefault();
        const card = document.getElementById(cardId);
        const form = event.target.closest('form');
        if (card) {
            card.style.opacity = '0';
            card.style.transform = 'scale(0.9)';
            card.style.transition = 'all .25s ease';
            setTimeout(() => form.submit(), 260);
        }
    }
</script>
</body>
</html>