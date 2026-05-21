<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%-- Admin Sidebar  --%>
<%
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = "";
%>
<aside class="admin-sidebar">
    <div class="sidebar-brand">Basai Admin</div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="nav-item <%= "dashboard".equals(currentPage) ? "active" : "" %>">
            <span class="nav-icon">&#x229E;</span> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/users/all" class="nav-item <%= "users".equals(currentPage) ? "active" : "" %>">
            <span class="nav-icon">&#x1F464;</span> Users
        </a>
        <a href="${pageContext.request.contextPath}/rooms/all" class="nav-item <%= "listings".equals(currentPage) ? "active" : "" %>">
            <span class="nav-icon">&#x1F4CA;</span> Listings
        </a>
    </nav>
    <div class="sidebar-bottom">
        <div class="sidebar-new-listing">
            <button class="btn-new-listing" onclick="window.location = '${pageContext.request.contextPath}/rooms/add'">&#43; New Listing</button>
        </div>
        <div class="admin-user-info">
            <div class="admin-avatar"></div>
            <div>
                <div class="admin-name">Admin User</div>
                <div class="admin-role">Super Admin</div>
            </div>
        </div>
        <form action="${pageContext.request.contextPath}/user-auth" method="post" style="margin:0;">
            <input type="hidden" name="action" value="logout" >
            <button type="submit" class="logout-link" style="background:none;border:none;cursor:pointer;width:100%;text-align:left;">
                &#x1F6AA; Logout
            </button>
        </form>
    </div>
</aside>
