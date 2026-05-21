<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%@ page isELIgnored="false" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
  if (session.getAttribute("role") == null || !"owner".equals(session.getAttribute("role"))) {
    response.sendRedirect("../login.jsp");
    return;
  }
  request.setAttribute("currentPage", "profile");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile | Basai Owner</title>
  <link rel="stylesheet" href="css/owner.css">
  <link rel="stylesheet" href="css/profile.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<!-- MAIN -->
<div class="main-content">
  <header class="topbar">
    <div class="topbar-search">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <input type="text" placeholder="Search properties...">
    </div>
    <div class="topbar-actions">
      <div class="icon-btn">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 01-3.46 0"/></svg>
        <span class="notif-dot"></span>
      </div>
      <div class="topbar-user">
        <div class="avatar">RS</div>
        <div>
          <div class="name">Ram Sharma</div>
          <div class="role">Owner Portal</div>
        </div>
      </div>
    </div>
  </header>

  <main class="page-body">
    <div class="page-header">
      <h1 class="page-title">My Profile</h1>
      <p class="page-subtitle">Manage your personal information and security settings.</p>
    </div>

    <!-- Profile Hero -->
    <div class="profile-hero" style="margin-bottom:20px;">
      <div class="profile-hero-avatar">RS</div>
      <div class="profile-hero-info">
        <div class="profile-hero-name">Ram Sharma</div>
        <div class="profile-hero-since">Property Owner since January 2021</div>
        <div class="hero-tags">
          <span class="hero-tag hero-tag-green">12 Properties</span>
          <span class="hero-tag hero-tag-blue">Verified Account</span>
        </div>
      </div>
    </div>

    <form action="OwnerProfileServlet" method="post" id="profileForm">

      <div class="profile-grid">

        <!-- LEFT -->
        <div class="profile-left">

          <!-- Personal Info -->
          <div class="card">
            <div class="card-header">
              <div class="form-section-title" style="margin:0;">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                Personal Information
              </div>
            </div>
            <div class="card-body">
              <div class="profile-form-row">
                <div class="form-group">
                  <label class="form-label" for="fullName">Full Name</label>
                  <input class="form-input" id="fullName" name="fullName" type="text"
                         value="${owner.fullName != null ? owner.fullName : 'Ram Sharma'}">
                </div>
                <div class="form-group">
                  <label class="form-label" for="email">Email Address</label>
                  <input class="form-input" id="email" name="email" type="email"
                         value="${owner.email != null ? owner.email : 'ram.sharma@propmanage.com'}">
                </div>
                <div class="form-group">
                  <label class="form-label" for="phone">Phone Number</label>
                  <input class="form-input" id="phone" name="phone" type="tel"
                         value="${owner.phone != null ? owner.phone : '+1 (555) 123-4567'}">
                </div>
                <div class="form-group">
                  <label class="form-label" for="timezone">Timezone</label>
                  <select class="form-select" id="timezone" name="timezone">
                    <option value="ET"  ${owner.timezone=='ET' ?'selected':''}>Eastern Time (ET)</option>
                    <option value="CT"  ${owner.timezone=='CT' ?'selected':''}>Central Time (CT)</option>
                    <option value="MT"  ${owner.timezone=='MT' ?'selected':''}>Mountain Time (MT)</option>
                    <option value="PT"  ${owner.timezone=='PT' ?'selected':''}>Pacific Time (PT)</option>
                    <option value="NPT" ${owner.timezone=='NPT'?'selected':''}>Nepal Time (NPT +5:45)</option>
                  </select>
                </div>
                <div class="form-group form-full">
                  <label class="form-label" for="address">Physical Address</label>
                  <textarea class="form-textarea" id="address" name="address" rows="2"><c:out value="${owner.address != null ? owner.address : '742 Evergreen Terrace, Springfield, IL 62704'}"/></textarea>
                </div>
              </div>
            </div>
          </div>

          <!-- Actions -->
          <div class="profile-actions">
            <button type="button" class="btn btn-outline" onclick="window.location.href='ownerDashboard.jsp'">Discard Changes</button>
            <button type="submit" class="btn btn-primary">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
              Update Profile
            </button>
          </div>

        </div>

        <!-- RIGHT -->
        <div class="profile-right">

          <!-- Account Info -->
          <div class="panel-card">
            <div class="panel-card-header">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>
              Account Info
            </div>
            <div class="panel-card-body">
              <div class="inline-field">
                <div>
                  <div class="if-label">Username</div>
                  <div class="if-value">athompson_owner</div>
                </div>
                <button type="button" class="inline-btn">Change</button>
              </div>
              <div class="inline-field">
                <div>
                  <div class="if-label">Password</div>
                  <div class="if-value">••••••••••••</div>
                  <div style="font-size:.68rem;color:var(--text-muted);margin-top:2px;">Last changed 4 months ago</div>
                </div>
                <button type="button" class="inline-btn">Edit</button>
              </div>
              <div class="toggle-row" style="margin-top:8px;">
                <div>
                  <div class="toggle-label">Two-Factor Auth</div>
                  <div class="toggle-sub">Recommended for security</div>
                </div>
                <label class="toggle">
                  <input type="checkbox" name="twoFactor" checked>
                  <span class="toggle-slider"></span>
                </label>
              </div>
            </div>
          </div>

          <!-- Preferences -->
          <div class="panel-card">
            <div class="panel-card-header">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 010 14.14M4.93 4.93a10 10 0 000 14.14"/></svg>
              Preferences
            </div>
            <div class="panel-card-body">
              <div class="pref-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22 6 12 13 2 6"/></svg>
                <div>
                  <div class="pref-text">Email Notifications</div>
                </div>
                <span class="pref-val">On for bookings and alerts</span>
              </div>
              <div class="pref-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 010 20M12 2a15.3 15.3 0 000 20"/></svg>
                <div>
                  <div class="pref-text">Language</div>
                </div>
                <span class="pref-val">English (United States)</span>
              </div>
            </div>
          </div>

        </div><!-- /profile-right -->
      </div><!-- /profile-grid -->

    </form>
  </main>
</div>

</body>
</html>
