<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basai - Find Your Perfect Room, Effortlessly</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{font-family:'Inter',Arial,sans-serif;color:#1a1a2e;background:#fff;}
        /* NAVBAR */
        nav{display:flex;align-items:center;justify-content:space-between;padding:14px 48px;border-bottom:1px solid #eee;position:sticky;top:0;background:#fff;z-index:100;}
        .nav-logo{font-size:1.3rem;font-weight:700;color:#1a1a2e;text-decoration:none;}
        .nav-links{display:flex;gap:28px;list-style:none;}
        .nav-links a{text-decoration:none;color:#444;font-size:.9rem;}
        .nav-links a:hover{color:#1a1a2e;}
        .nav-actions{display:flex;gap:12px;align-items:center;}
        .btn-login{background:none;border:none;cursor:pointer;font-size:.9rem;color:#444;}
        .btn-register{background:#1a1a2e;color:#fff;border:none;padding:8px 20px;border-radius:6px;cursor:pointer;font-size:.9rem;}
        /* HERO */
        .hero{display:flex;align-items:center;padding:64px 48px 40px;gap:48px;max-width:1200px;margin:auto;}
        .hero-text{flex:1;}
        .hero-text h1{font-size:3rem;font-weight:800;line-height:1.1;margin-bottom:16px;color:#1a1a2e;}
        .hero-text h1 em{font-style:italic;}
        .hero-text p{color:#666;font-size:1rem;line-height:1.6;max-width:420px;margin-bottom:28px;}
        .hero-cta{display:flex;gap:12px;margin-bottom:32px;}
        .btn-primary{background:#1a1a2e;color:#fff;padding:12px 24px;border-radius:8px;border:none;cursor:pointer;font-size:.95rem;display:flex;align-items:center;gap:8px;}
        .btn-secondary{background:#fff;color:#1a1a2e;padding:12px 24px;border-radius:8px;border:1.5px solid #1a1a2e;cursor:pointer;font-size:.95rem;}
        .hero-filters{display:flex;gap:12px;align-items:flex-end;flex-wrap:wrap;}
        .filter-group{display:flex;flex-direction:column;gap:4px;}
        .filter-group label{font-size:.75rem;color:#888;text-transform:uppercase;font-weight:600;}
        .filter-group select{padding:8px 12px;border:1.5px solid #ddd;border-radius:6px;font-size:.9rem;color:#333;background:#fff;}
        .filter-group input{padding:8px 12px;border:1.5px solid #ddd;border-radius:6px;font-size:.9rem;color:#333;}
        .hero-img{flex:1;max-width:480px;border-radius:16px;overflow:hidden;}
        .hero-img img{width:100%;height:340px;object-fit:cover;border-radius:16px;}
        .verified-badge{display:inline-flex;align-items:center;gap:6px;background:#fff;border:1px solid #ddd;border-radius:8px;padding:8px 14px;font-size:.85rem;box-shadow:0 2px 8px rgba(0,0,0,.07);margin-top:-20px;}
        /* SECTION TITLES */
        .section-title{text-align:center;margin:56px 0 8px;font-size:1.7rem;font-weight:700;}
        .section-sub{text-align:center;color:#888;font-size:.95rem;margin-bottom:36px;}
        /* EXPLORE ROOMS */
        .rooms-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;padding:0 48px;max-width:1200px;margin:0 auto 48px;}
        .room-card{border:1px solid #eee;border-radius:12px;overflow:hidden;}
        .room-card img{width:100%;height:180px;object-fit:cover;}
        .room-info{padding:14px;}
        .room-tag{background:#e8f5e9;color:#2e7d32;font-size:.75rem;padding:2px 8px;border-radius:4px;font-weight:600;}
        .room-title{font-size:1rem;font-weight:600;margin:8px 0 4px;}
        .room-loc{font-size:.82rem;color:#888;margin-bottom:8px;}
        .room-price{font-size:.95rem;font-weight:700;}
        .room-price span{color:#888;font-weight:400;font-size:.8rem;}
        .room-actions{display:flex;justify-content:flex-end;margin-top:8px;}
        .btn-details{background:none;border:1px solid #1a1a2e;color:#1a1a2e;padding:5px 14px;border-radius:6px;font-size:.82rem;cursor:pointer;}
        /* HOW IT WORKS */
        .how-section{background:#f9f9f9;padding:56px 48px;}
        .how-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:32px;max-width:900px;margin:0 auto;}
        .how-card{text-align:center;}
        .how-icon{width:52px;height:52px;background:#1a1a2e;border-radius:12px;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;color:#fff;font-size:1.4rem;}
        .how-card h3{font-size:1rem;font-weight:700;margin-bottom:8px;}
        .how-card p{font-size:.85rem;color:#666;line-height:1.5;}
        /* DESIGNED FOR */
        .designed-section{padding:56px 48px;}
        .designed-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;max-width:1100px;margin:0 auto;}
        .designed-card{border:1px solid #eee;border-radius:12px;padding:28px;background:#fff;}
        .designed-card h3{font-size:1rem;font-weight:700;margin:12px 0 10px;}
        .designed-card ul{list-style:none;color:#666;font-size:.85rem;line-height:2;}
        .designed-card ul li::before{content:"✓ ";color:#2e7d32;font-weight:700;}
        /* TESTIMONIALS */
        .testimonials-section{background:#f9f9f9;padding:56px 48px;}
        .test-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;max-width:1100px;margin:0 auto;}
        .test-card{background:#fff;border-radius:12px;padding:24px;box-shadow:0 2px 8px rgba(0,0,0,.06);}
        .stars{color:#f4b942;font-size:1rem;margin-bottom:10px;}
        .test-card p{font-size:.88rem;color:#444;line-height:1.6;margin-bottom:14px;}
        .test-author{display:flex;align-items:center;gap:10px;}
        .test-avatar{width:36px;height:36px;border-radius:50%;background:#ddd;}
        .test-name{font-size:.9rem;font-weight:600;}
        .test-role{font-size:.78rem;color:#888;}
        /* SECURITY BANNER */
        .security-banner{background:#1a1a2e;color:#fff;padding:40px 48px;text-align:center;margin:0 48px;border-radius:16px;margin-bottom:40px;}
        .security-banner h3{font-size:1.4rem;font-weight:700;margin:12px 0 8px;}
        .security-banner p{color:#aaa;font-size:.9rem;margin-bottom:16px;}
        .security-badges{display:flex;justify-content:center;gap:24px;font-size:.85rem;color:#aaa;}
        /* CTA */
        .cta-section{background:#e8edf5;padding:56px 48px;text-align:center;border-radius:16px;margin:0 48px 48px;}
        .cta-section h2{font-size:2rem;font-weight:800;margin-bottom:24px;}
        .cta-buttons{display:flex;justify-content:center;gap:16px;}
        /* FOOTER */
        footer{border-top:1px solid #eee;padding:32px 48px;display:flex;justify-content:space-between;align-items:flex-start;flex-wrap:wrap;gap:24px;}
        .footer-logo{font-size:1.1rem;font-weight:700;color:#1a1a2e;margin-bottom:8px;}
        .footer-links{display:flex;gap:48px;}
        .footer-col h4{font-size:.9rem;font-weight:700;margin-bottom:12px;color:#1a1a2e;}
        .footer-col a{display:block;text-decoration:none;color:#888;font-size:.85rem;margin-bottom:6px;}
        .footer-bottom{width:100%;border-top:1px solid #eee;padding-top:16px;text-align:center;color:#888;font-size:.8rem;}
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav>
    <a href="index.jsp" class="nav-logo">Basai</a>
    <ul class="nav-links">
        <li><a href="#">How It Works</a></li>
        <li><a href="#">User Roles</a></li>
        <li><a href="#">Listings</a></li>
        <li><a href="#">Reviews</a></li>
        <li><a href="#">Security</a></li>
    </ul>
    <div class="nav-actions">
        <button class="btn-login" onclick="location.href='views/login.jsp'">Login</button>
        <button class="btn-register" onclick="location.href='views/register.jsp'">Register</button>
    </div>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="hero-text">
        <h1>Find Your Perfect<br><em>Room,</em><br>Effortlessly.</h1>
        <p>Connecting room owners with students and professionals for affordable and hassle-free living in the heart of the Himalayas.</p>
        <div class="hero-cta">
            <button class="btn-primary" onclick="location.href='rooms.jsp'">Find Rooms &#8594;</button>
            <button class="btn-secondary" onclick="location.href='owner/listings.jsp'">List Your Property</button>
        </div>
        <div class="hero-filters">
            <div class="filter-group">
                <label>Location</label>
                <input type="text" placeholder="Search city...">
            </div>
            <div class="filter-group">
                <label>Price Range</label>
                <select>
                    <option>Any Price</option>
                    <option>Under Rs. 10,000</option>
                    <option>Rs. 10,000 – 20,000</option>
                    <option>Rs. 20,000 – 40,000</option>
                    <option>Rs. 40,000+</option>
                </select>
            </div>
            <div class="filter-group">
                <label>Room Type</label>
                <select>
                    <option>Single Room</option>
                    <option>Studio Flat</option>
                    <option>1BHK</option>
                    <option>2BHK</option>
                </select>
            </div>
        </div>
    </div>
    <div class="hero-img">
        <img src="images/hero-room.jpg" alt="Cozy room with mountain view" onerror="this.style.background='#c8d8e8';this.removeAttribute('src')">
        <div class="verified-badge">&#9989; Verified Rooms &nbsp; 2,400+ Listings</div>
    </div>
</section>

<!-- FILTER TAGS -->
<div style="text-align:center;padding:8px 48px 0;color:#888;font-size:.85rem;font-weight:600;letter-spacing:.05em;">
    SEARCH SMARTER. LIVE BETTER. &nbsp;&mdash;&nbsp; ESSENTIAL FILTERS FOR MODERN LIVING
    <span style="display:inline-flex;gap:16px;margin-left:24px;">
        <span>&#x1F4F6; WiFi</span>
        <span>&#x1F17F; Parking</span>
        <span>&#x1F6BF; Water</span>
    </span>
</div>

<!-- EXPLORE POPULAR ROOMS -->
<h2 class="section-title">Explore Popular Rooms</h2>
<p class="section-sub">Handpicked listings just for you, featuring prime locations and essential amenities.</p>
<div class="rooms-grid">
    <div class="room-card">
        <img src="images/room1.jpg" alt="Premium Studio" onerror="this.style.background='#dce8f0';this.removeAttribute('src')">
        <div class="room-info">
            <span class="room-tag">PREMIUM</span>
            <div class="room-title">Premium Studio room fully furnished</div>
            <div class="room-loc">&#x1F4CD; Lazimpat, Kathmandu</div>
            <div class="room-price">Rs. 15,000 <span>/ month</span></div>
            <div class="room-actions"><button class="btn-details" onclick="location.href='room-detail.jsp?id=1'">View Details</button></div>
        </div>
    </div>
    <div class="room-card">
        <img src="images/room2.jpg" alt="Modern Studio Flat" onerror="this.style.background='#dce8f0';this.removeAttribute('src')">
        <div class="room-info">
            <span class="room-tag">NEW</span>
            <div class="room-title">Modern Studio Flat</div>
            <div class="room-loc">&#x1F4CD; Jhamsikhel</div>
            <div class="room-price">Rs. 20,600 <span>/ month</span></div>
            <div class="room-actions"><button class="btn-details" onclick="location.href='room-detail.jsp?id=2'">View Details</button></div>
        </div>
    </div>
    <div class="room-card">
        <img src="images/room3.jpg" alt="Simple Single Room" onerror="this.style.background='#dce8f0';this.removeAttribute('src')">
        <div class="room-info">
            <span class="room-tag">FURNISHED</span>
            <div class="room-title">Simple Single Room Fully Furnished</div>
            <div class="room-loc">&#x1F4CD; Lukundo, Pokhara</div>
            <div class="room-price">Rs. 10,000 <span>/ month</span></div>
            <div class="room-actions"><button class="btn-details" onclick="location.href='room-detail.jsp?id=3'">View Details</button></div>
        </div>
    </div>
</div>

<!-- HOW IT WORKS -->
<section class="how-section">
    <h2 class="section-title" style="margin-top:0;">How It Works</h2>
    <div class="how-grid">
        <div class="how-card">
            <div class="how-icon">&#x1F50D;</div>
            <h3>Search Rooms</h3>
            <p>Browse verified listings based on your location, budget, and preference.</p>
        </div>
        <div class="how-card">
            <div class="how-icon">&#x27A4;</div>
            <h3>Send Request</h3>
            <p>Message owners directly and request to rent with just one click.</p>
        </div>
        <div class="how-card">
            <div class="how-icon">&#x1F3E0;</div>
            <h3>Move In</h3>
            <p>Get approved, sign the digital agreement, and settle into your new home.</p>
        </div>
    </div>
</section>

<!-- DESIGNED FOR EVERYONE -->
<section class="designed-section">
    <h2 class="section-title" style="margin-top:0;">Designed for Everyone</h2>
    <div class="designed-grid">
        <div class="designed-card">
            <div style="font-size:1.8rem;">&#x1F464;</div>
            <h3>For Renters</h3>
            <ul>
                <li>Find affordable rooms easily with advanced maps</li>
                <li>Save favorites &amp; track bookings in real time</li>
            </ul>
        </div>
        <div class="designed-card">
            <div style="font-size:1.8rem;">&#x1F3E2;</div>
            <h3>For Owners</h3>
            <ul>
                <li>Post and manage your properties from a simple dashboard</li>
                <li>Approve rental requests effortlessly after screening</li>
            </ul>
        </div>
        <div class="designed-card">
            <div style="font-size:1.8rem;">&#x1F6E1;</div>
            <h3>Simple Single Room Fully Furnished</h3>
            <ul>
                <li>Monitor users and listings to maintain high standards</li>
                <li>Ensure platform quality, support, and security</li>
            </ul>
        </div>
    </div>
</section>

<!-- TESTIMONIALS -->
<section class="testimonials-section">
    <h2 class="section-title" style="margin-top:0;">Trusted by Renters and Owners</h2>
    <div class="test-grid">
        <div class="test-card">
            <div class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
            <p>"Basai made finding a room so easy! I moved to Kathmandu for my internship and found a verified place within two days."</p>
            <div class="test-author">
                <div class="test-avatar"></div>
                <div>
                    <div class="test-name">Elena P.</div>
                    <div class="test-role">Software Intern</div>
                </div>
            </div>
        </div>
        <div class="test-card">
            <div class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
            <p>"Listing my properties was seamless. The booking management helps me screen renters without any stress."</p>
            <div class="test-author">
                <div class="test-avatar"></div>
                <div>
                    <div class="test-name">Rajesh K.</div>
                    <div class="test-role">Property Owner</div>
                </div>
            </div>
        </div>
        <div class="test-card">
            <div class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
            <p>"The location filters and price range options are incredibly accurate. Best platform for students in Nepal."</p>
            <div class="test-author">
                <div class="test-avatar"></div>
                <div>
                    <div class="test-name">Sandeep B.</div>
                    <div class="test-role">Engineering Student</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- SECURITY BANNER -->
<div style="padding:40px 48px 0;">
    <div class="security-banner">
        <div style="font-size:2rem;">&#x1F6E1;</div>
        <h3>Your Data is Safe with Us</h3>
        <p>Secure login, protected transactions, and verified users are at the core of the Basai experience.</p>
        <div class="security-badges">
            <span>&#x1F512; End-to-end encryption</span>
            <span>&#x2714; Identity Verification</span>
        </div>
    </div>
</div>

<!-- READY CTA -->
<div style="padding:40px 48px;">
    <div class="cta-section">
        <h2>Ready to Find Your New Home?</h2>
        <div class="cta-buttons">
            <button class="btn-primary" onclick="location.href='register.jsp'">Sign Up as Renter</button>
            <button class="btn-secondary" onclick="location.href='register.jsp'">List Your Room</button>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer>
    <div>
        <div class="footer-logo">Basai</div>
        <p style="font-size:.82rem;color:#888;max-width:220px;">Making renting transparent, accessible, and secure across Nepal. The Curated Haven of Himalayan Living.</p>
    </div>
    <div class="footer-links">
        <div class="footer-col">
            <h4>Platform</h4>
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Room Listings</a>
        </div>
        <div class="footer-col">
            <h4>Support</h4>
            <a href="#">Contact Us</a>
            <a href="#">Help Center</a>
            <a href="#">Legal Statements</a>
        </div>
    </div>
    <div class="footer-bottom">&#169; 2024 Basai. The Curated Haven.</div>
</footer>

</body>
</html>
