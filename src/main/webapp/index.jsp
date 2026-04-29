<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pharmacy.pharmacyweb.dao.ProductDAO" %>
<%@ page import="com.pharmacy.pharmacyweb.model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PharmaStore | Modern Health Solutions</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }
        .navbar { background-color: #ffffff; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .hero-section { background: linear-gradient(135deg, #0d6efd 0%, #00d4ff 100%); color: white; padding: 60px 0; }
        .card { border: none; border-radius: 12px; transition: transform 0.2s; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 15px rgba(0,0,0,0.1); }
        .badge-stock { font-size: 0.8rem; }
        .btn-add { border-radius: 8px; font-weight: 600; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="#">🏥 PharmaStore</a>
        <div class="d-flex">
            <a href="cart.jsp" class="btn btn-outline-primary position-relative">
                🛒 View Cart
                <%-- Optional: Logic to show item count badge --%>
            </a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="hero-section text-center">
    <div class="container">
        <h1 class="display-4 fw-bold">Quality Medicines, Delivered.</h1>
        <p class="lead">Your trusted partner in healthcare and pharmacy management.</p>
    </div>
</header>

<main class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Available Stock</h2>
        <span class="text-muted">Current Inventory:
            <% ProductDAO dao = new ProductDAO();
                List<Product> products = dao.getAllProducts();
            %>
            <%= products.size() %> Items
        </span>
    </div>

    <!-- Order Success Alert -->
    <% if ("success".equals(request.getParameter("order"))) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Order Placed!</strong> Your medicines have been reserved and stock updated.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <div class="row g-4">
        <% for(Product p : products) { %>
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 p-3">
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <h5 class="card-title fw-bold mb-0"><%= p.getName() %></h5>
                        <span class="text-success fw-bold">$<%= p.getPrice() %></span>
                    </div>
                    <p class="card-text text-muted small">Generic pharmaceutical grade medication.</p>

                    <div class="d-flex align-items-center mb-3">
                            <span class="badge <%= p.getStock() > 10 ? "bg-info-subtle text-info" : "bg-danger-subtle text-danger" %> badge-stock">
                                In Stock: <%= p.getStock() %>
                            </span>
                    </div>

                    <form action="cart" method="post">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <input type="hidden" name="action" value="add">
                        <button type="submit" class="btn btn-primary w-100 btn-add">
                            Add to Cart
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</main>

<footer class="text-center py-4 text-muted border-top bg-white mt-5">
    <p>&copy; 2026 PharmaStore Management System</p>
</footer>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>