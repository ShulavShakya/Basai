<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    if (session.getAttribute("role") == null || !"owner".equals(session.getAttribute("role"))) {
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
    <title><c:choose><c:when test="${not empty param.id}">Edit Listing</c:when><c:otherwise>Add Listing</c:otherwise></c:choose> | Basai Owner</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/owner.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/owner/css/addListings.css">
</head>
<body>

<%@include file="sidebar.jsp"%>

<!-- MAIN -->
<div class="main-content">
    <main class="page-body">

        <!-- Action Bar -->
        <div class="form-actions-bar">
            <div class="page-header" style="margin:0;">
                <h1 class="page-title">
                    <c:choose>
                        <c:when test="${not empty param.id}">Edit Room Listing</c:when>
                        <c:otherwise>Add Room Listing</c:otherwise>
                    </c:choose>
                </h1>
                <p class="page-subtitle">Create a new listing to start receiving booking requests for your property.</p>
            </div>

        </div>

        <form id="listingForm" action="${pageContext.request.contextPath}/rooms/add" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add">

            <div class="listing-form-grid">

                <!-- LEFT COLUMN -->
                <div class="form-left">

                    <!-- Basic Info -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                            Basic Information
                        </div>
                        <div class="form-section-body">
                            <div class="form-group">
                                <label class="form-label" for="roomTitle">Room Title</label>
                                <input class="form-input" id="roomTitle" name="title" type="text"
                                       placeholder="e.g. Modern Studio Room with City View">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="description">Description</label>
                                <textarea class="form-textarea" id="description" name="description"
                                          placeholder="Describe the room features, ambiance, and any special highlights..."
                                          rows="4"></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Location -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/><circle cx="12" cy="10" r="3"/></svg>
                            Location Details
                        </div>
                        <div class="form-section-body">
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="city">City / Area</label>
                                    <input class="form-input" id="city" name="city" type="text"
                                           placeholder="e.g. Kathmandu, Nepal">
                                </div>
                                <div class="form-group">
                                    <label class="form-label" for="fullAddress">Full Address</label>
                                    <input class="form-input" id="fullAddress" name="address" type="text"
                                           placeholder="House no, Street name, Landmark">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Room Details & Pricing -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
                            Room Details &amp; Pricing
                        </div>
                        <div class="form-section-body">
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="roomType">Room Type</label>
                                    <select class="form-select" id="roomType" name="roomType">
                                        <option value="">Select type</option>
                                        <option value="SINGLE">Single Room</option>
                                        <option value="DOUBLE">Double Room</option>
                                        <option value="ONE_BHK">1 BHK</option>
                                        <option value="TWO_BHK">2 BHK</option>
                                        <option value="STUDIO">Studio</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-label" for="pricePerMonth">Price per Month ($)</label>
                                    <input class="form-input" id="pricePerMonth" name="rentPrice" type="number"
                                           placeholder="0.00" min="0" step="0.01">
                                </div>
                            </div>

                        </div>
                    </div>

                </div><!-- /form-left -->

                <!-- RIGHT COLUMN -->
                <div class="form-right">

                    <!-- Upload Photos -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M23 19a2 2 0 01-2 2H3a2 2 0 01-2-2V8a2 2 0 012-2h4l2-3h6l2 3h4a2 2 0 012 2z"/>
                                <circle cx="12" cy="13" r="4"/>
                            </svg>
                            Upload Photos <span style="font-size:0.9rem; color:#666;">(Maximum 3)</span>
                        </div>
                        <div class="form-section-body">
                            <label for="photos">
                                <div class="upload-zone" style="padding:40px 20px;">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                                        <polyline points="16 16 12 12 8 16"/>
                                        <line x1="12" y1="12" x2="12" y2="21"/>
                                        <path d="M20.39 18.39A5 5 0 0018 9h-1.26A8 8 0 103 16.3"/>
                                    </svg>
                                    <div class="upload-text">Click to upload or drag & drop</div>
                                    <div class="upload-sub">PNG, JPG or WEBP (Max 3 photos)</div>
                                </div>
                            </label>
                            <input type="file" id="photos" name="photos" multiple accept="image/*" style="display:none;">

                            <!-- Preview Container -->
                            <div class="photo-previews" id="photoPreviews" style="margin-top:15px;"></div>
                        </div>
                    </div>

                    <!-- Furnishing -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.38 3.46L16 2a4 4 0 01-8 0L3.62 3.46a2 2 0 00-1.34 2.23l.58 3.57a1 1 0 00.99.84H6v10c0 1.1.9 2 2 2h8a2 2 0 002-2V10h2.15a1 1 0 00.99-.84l.58-3.57a2 2 0 00-1.34-2.23z"/></svg>
                            Furnishing
                        </div>
                        <div class="form-section-body">
                            <div class="form-group">
                                <label class="form-label" for="furnishing">Select Status</label>
                                <select class="form-select" id="furnishing" name="furnishingStatus">
                                    <option value="Furnished"      ${listing.furnishing=='Furnished'     ?'selected':''}>Furnished</option>
                                    <option value="SemiFurnished" ${listing.furnishing=='SemiFurnished'?'selected':''}>Semi-Furnished</option>
                                    <option value="Unfurnished"    ${listing.furnishing=='Unfurnished'   ?'selected':''}>Unfurnished</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Facilities -->
                    <div class="form-section">
                        <div class="form-section-header">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                            Facilities
                        </div>
                        <div class="form-section-body">
                            <div class="facilities-grid">
                                <label class="facility-item">
                                    <input type="checkbox" name="facilities" value="wifi" ${listing.wifi?'checked':''}>
                                    <div>
                                        <div class="fac-name">WiFi</div>
                                        <div class="fac-sub">High-speed broadband</div>
                                    </div>
                                </label>
                                <label class="facility-item">
                                    <input type="checkbox" name="facilities" value="parking" ${listing.parking?'checked':''}>
                                    <div>
                                        <div class="fac-name">Parking</div>
                                        <div class="fac-sub">Reserved spot</div>
                                    </div>
                                </label>
                                <label class="facility-item">
                                    <input type="checkbox" name="facilities" value="water" ${listing.water?'checked':''}>
                                    <div>
                                        <div class="fac-name">Water Supply</div>
                                        <div class="fac-sub">24/7 availability</div>
                                    </div>
                                </label>
                                <label class="facility-item">
                                    <input type="checkbox" name="facilities" value="electricity" ${listing.electricity?'checked':''}>
                                    <div>
                                        <div class="fac-name">Electricity</div>
                                        <div class="fac-sub">Power backup available</div>
                                    </div>
                                </label>
                                <label class="facility-item">
                                    <input type="checkbox" name="facilities" value="bathroom" ${listing.bathroom?'checked':''}>
                                    <div>
                                        <div class="fac-name">Attached Bathroom</div>
                                        <div class="fac-sub">Private en-suite</div>
                                    </div>
                                </label>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Bottom bar -->
            <div style="display:flex;align-items:center;justify-content:space-between;margin-top:20px;">
                <div style="display:flex;gap:10px;">
                    <button type="button" class="btn btn-outline">Preview</button>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty param.id}">Update Listing</c:when>
                            <c:otherwise>Publish Listing</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </div>

        </form>
    </main>
</div>

<script>
    // Simple and clear preview script
    document.getElementById('photos').addEventListener('change', function(e) {
        const previewContainer = document.getElementById('photoPreviews');
        previewContainer.innerHTML = '';

        if (this.files.length > 3) {
            alert("Maximum 3 photos allowed!");
            this.value = '';
            return;
        }

        Array.from(this.files).forEach((file, index) => {
            if (file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    const div = document.createElement('div');
                    div.className = 'photo-thumb';

                    const img = document.createElement('img');
                    img.src = event.target.result;
                    img.alt = 'Preview ' + (index + 1);

                    const span = document.createElement('span');
                    span.className = 'photo-index';
                    span.textContent = index + 1;

                    div.appendChild(img);
                    div.appendChild(span);
                    previewContainer.appendChild(div);
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>
</body>
</html>
