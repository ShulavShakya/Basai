
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = "";

    basai.user.model.User sessionUser = (basai.user.model.User) session.getAttribute("user");
    String fullName = (sessionUser != null) ? sessionUser.getName() : "Owner";

    String initials = "";
    for (String part : fullName.trim().split("\\s+")) {
        if (!part.isEmpty()) initials += part.charAt(0);
    }
    initials = initials.toUpperCase();
    if (initials.length() > 2) initials = initials.substring(0, 2);
%>

<!-- ===== SIDEBAR ===== -->
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="logo">Basai Owner</div>
        <div class="portal-label">Owner Portal</div>
    </div>

    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/owner/dashboard" class="nav-item <%= "dashboard".equals(currentPage) ? "active" : ""%>">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/rooms/my-listings" class="nav-item <%= "myListings".equals(currentPage) ? "active" : ""%>">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/></svg>
            My Listings
        </a>
        <a href="${pageContext.request.contextPath}/rooms/add" class="nav-item <%= "addListing".equals(currentPage) ? "active" : ""%>">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>
            Add Listing
        </a>
        <a href="${pageContext.request.contextPath}/bookings" class="nav-item <%= "bookingRequests".equals(currentPage) ? "active" : ""%>">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            Booking Requests
        </a>
        <a href="${pageContext.request.contextPath}/views/owner/profile.jsp" class="nav-item <%= "profile".equals(currentPage) ? "active" : ""%>">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            Profile
        </a>
    </nav>

    <div class="sidebar-footer">
        <div class="sidebar-user">
            <div class="avatar">AS</div>
            <div class="user-info">
                <div class="user-name">Alex Smith</div>
                <div class="user-role">Owner Portal</div>
            </div>
        </div>
        <form action="${pageContext.request.contextPath}/user-auth" method="post" style="margin:0;">
            <input type="hidden" name="action" value="logout" >
            <button type="submit" class="btn-logout" style="background:none;border:none;cursor:pointer;width:100%;text-align:left;">
                &#x1F6AA; Logout
            </button>
        </form>
    </div>
</aside>