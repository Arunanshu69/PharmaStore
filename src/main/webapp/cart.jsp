<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.pharmacy.pharmacyweb.dao.ProductDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart | PharmaStore</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; color: #333; }
        .navbar { background-color: #ffffff; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .cart-card { border: none; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); background: #fff; }
        .table thead th { border-top: none; text-transform: uppercase; font-size: 0.75rem; letter-spacing: 1px; color: #777; }
        .product-name { font-weight: 700; color: #0d6efd; }
        .summary-box { background-color: #f1f8ff; border-radius: 12px; padding: 20px; position: sticky; top: 100px; }
        .btn-update { font-size: 0.8rem; padding: 2px 8px; border-radius: 6px; }
        .btn-remove { font-size: 0.85rem; color: #dc3545; background: none; border: none; padding: 0; }
        .btn-remove:hover { text-decoration: underline; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar mb-5">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="index.jsp">🏥 PharmaStore</a>
        <a href="index.jsp" class="btn btn-sm btn-outline-secondary">← Back to Shop</a>
    </div>
</nav>

<div class="container pb-5">
    <h2 class="fw-bold mb-4">Your Shopping Cart</h2>

    <c:choose>
        <c:when test="${empty sessionScope.cart}">
            <div class="text-center py-5 cart-card">
                <div class="mb-4" style="font-size: 4rem;">🛒</div>
                <h4>Your cart is feeling light!</h4>
                <p class="text-muted">You haven't added any medicines yet.</p>
                <a href="index.jsp" class="btn btn-primary px-4 mt-2">Start Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <!-- Cart Items List -->
                <div class="col-lg-8">
                    <div class="cart-card p-4">
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead>
                                <tr>
                                    <th>Medicine Details</th>
                                    <th class="text-center">Quantity</th>
                                    <th class="text-end">Subtotal</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set var="total" value="0" />
                                <% ProductDAO dao = new ProductDAO(); request.setAttribute("dao", dao); %>

                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <c:set var="product" value="${dao.getProductById(item.key)}" />
                                    <tr>
                                        <td>
                                            <div class="product-name">${product.name}</div>
                                            <div class="text-muted small">$${product.price} per unit</div>
                                            <form action="cart" method="post" class="mt-1">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <input type="hidden" name="action" value="delete">
                                                <button type="submit" class="btn-remove">Remove Item</button>
                                            </form>
                                        </td>
                                        <td style="width: 180px;">
                                            <form action="cart" method="post" class="d-flex align-items-center gap-2">
                                                <input type="hidden" name="productId" value="${item.key}">
                                                <input type="hidden" name="action" value="update">
                                                <input type="number" name="quantity" value="${item.value}" min="1"
                                                       class="form-control form-control-sm text-center" style="width: 70px;">
                                                <button type="submit" class="btn btn-outline-primary btn-update">Update</button>
                                            </form>
                                        </td>
                                        <td class="text-end fw-bold text-dark">
                                            $${product.price * item.value}
                                        </td>
                                    </tr>
                                    <c:set var="total" value="${total + (product.price * item.value)}" />
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Order Summary Sidebar -->
                <div class="col-lg-4">
                    <div class="summary-box shadow-sm">
                        <h5 class="fw-bold mb-4">Order Summary</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Items (${sessionScope.cart.size()})</span>
                            <span>$${total}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Pharmacy Processing</span>
                            <span class="text-success">FREE</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-4">
                            <span class="h5 fw-bold">Grand Total</span>
                            <span class="h5 fw-bold text-primary">$${total}</span>
                        </div>

                        <button onclick="window.location.href='checkout.jsp'" class="btn btn-primary w-100 py-3 fw-bold shadow-sm">
                            Proceed to Checkout →
                        </button>

                        <p class="text-center text-muted small mt-3">
                            Secure Healthcare Checkout 🛡️
                        </p>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>