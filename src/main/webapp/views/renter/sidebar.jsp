<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
  String currentPage = (String) request.getAttribute("currentPage");
  if (currentPage == null) currentPage = "";
%>

<aside class="sidebar">
  <div class="sidebar-brand">
    <div class="logo">Basai</div>
  </div>
  <nav class="sidebar-nav">
    <div class="nav-section-label">Main Menu</div>
    <a href="${pageContext.request.contextPath}/renter/dashboard" class="nav-item <%= "dashboard".equals(currentPage) ? "active" : "" %>">
      <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <rect x="3" y="3" width="7" height="7" rx="1" stroke-width="2" />
        <rect x="14" y="3" width="7" height="7" rx="1" stroke-width="2" />
        <rect x="3" y="14" width="7" height="7" rx="1" stroke-width="2" />
        <rect x="14" y="14" width="7" height="7" rx="1" stroke-width="2" />
      </svg>
      Overview
    </a>
    <a href="${pageContext.request.contextPath}/bookings" class="nav-item <%= "bookings".equals(currentPage) ? "active" : "" %>">
      <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <rect x="3" y="4" width="18" height="18" rx="2" stroke-width="2" />
        <path d="M16 2v4M8 2v4M3 10h18" stroke-width="2" />
      </svg>
      Bookings
    </a>
    <a href="${pageContext.request.contextPath}/renter/wishlist" class="nav-item <%= "wishlist".equals(currentPage) ? "active" : "" %>">
      <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
                d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"
                stroke-width="2" />
      </svg>
      Wishlist
    </a>
    <a href="${pageContext.request.contextPath}/rooms/browse" class="nav-item <%= "browseRooms".equals(currentPage) ? "active" : "" %>">
      <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" stroke-width="2" />
      </svg>
      Browse Rooms
    </a>
  </nav>
  <div class="sidebar-footer">
    <div class="sidebar-user">
      <div class="avatar">AS</div>
      <div class="user-info">
        <div class="user-name">Aaryan Sharma</div>
        <div class="user-role">Renter</div>
      </div>
    </div>
    <form action="${pageContext.request.contextPath}/user-auth" method="post" style="margin:0;">
      <input type="hidden" name="action" value="logout">
      <button class="btn-logout">
        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" width="14" height="14">
          <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9" stroke-width="2" />
        </svg>
        Logout
      </button>
    </form>
  </div>
</aside>