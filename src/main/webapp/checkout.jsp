<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.pharmacy.pharmacyweb.dao.ProductDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Checkout | PharmaStore</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Google Fonts: Inter -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Inter', sans-serif; background-color: #f4f7f6; color: #2d3436; }
    .navbar { background-color: #ffffff; border-bottom: 1px solid #e1e8e7; }
    .checkout-card { border: none; border-radius: 16px; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.03); }
    .form-label { font-weight: 600; font-size: 0.9rem; color: #636e72; }
    .form-control { border-radius: 8px; padding: 12px; border: 1px solid #dfe6e9; }
    .order-summary { background-color: #f8fafb; border-radius: 16px; padding: 25px; border: 1px solid #edf2f4; }
    .item-line { border-bottom: 1px dashed #d1d8e0; padding-bottom: 10px; margin-bottom: 10px; }
    .item-line:last-child { border-bottom: none; }
    .confirm-btn { background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%); border: none; border-radius: 10px; padding: 15px; font-weight: 700; transition: all 0.3s; }
    .confirm-btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(46, 204, 113, 0.3); }
    .secure-badge { background-color: #e3fcef; color: #00875a; padding: 5px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 700; }
  </style>
</head>
<body>

<!-- Minimal Navbar -->
<nav class="navbar py-3 mb-5">
  <div class="container">
    <a class="navbar-brand fw-bold text-primary" href="index.jsp">🏥 PharmaStore</a>
    <span class="text-muted small">Secure Checkout</span>
  </div>
</nav>

<div class="container pb-5">
  <div class="row g-5">
    <!-- Left Side: Shipping Information -->
    <div class="col-lg-7">
      <div class="checkout-card p-4 p-md-5">
        <h4 class="fw-bold mb-4">Delivery Information</h4>
        <form class="row g-3">
          <div class="col-md-6">
            <label class="form-label">First Name</label>
            <input type="text" class="form-control" placeholder="John" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Last Name</label>
            <input type="text" class="form-control" placeholder="Doe" required>
          </div>
          <div class="col-12">
            <label class="form-label">Address</label>
            <input type="text" class="form-control" placeholder="123 Health St, Medical District">
          </div>
          <div class="col-md-6">
            <label class="form-label">City</label>
            <input type="text" class="form-control" placeholder="Bhubaneswar">
          </div>
          <div class="col-md-6">
            <label class="form-label">Phone Number</label>
            <input type="tel" class="form-control" placeholder="+91 98765 43210">
          </div>
        </form>

        <h4 class="fw-bold mt-5 mb-4">Payment Method</h4>
        <div class="card p-3 mb-3 border-primary bg-light">
          <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" id="cod" checked>
            <label class="form-check-label fw-bold" for="cod">
              Cash on Delivery (COD)
            </label>
            <div class="text-muted small">Pay when your medicines arrive at your doorstep.</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Right Side: Order Summary -->
    <div class="col-lg-5">
      <div class="order-summary shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h5 class="fw-bold mb-0">Your Order</h5>
          <span class="secure-badge">SSL SECURE</span>
        </div>

        <div class="mb-4">
          <c:set var="total" value="0" />
          <% ProductDAO dao = new ProductDAO(); request.setAttribute("dao", dao); %>

          <c:forEach var="item" items="${sessionScope.cart}">
            <c:set var="product" value="${dao.getProductById(item.key)}" />
            <div class="item-line d-flex justify-content-between align-items-start">
              <div>
                <div class="fw-bold text-dark">${product.name}</div>
                <div class="text-muted small">Qty: ${item.value}</div>
              </div>
              <div class="fw-bold">$${product.price * item.value}</div>
            </div>
            <c:set var="total" value="${total + (product.price * item.value)}" />
          </c:forEach>
        </div>

        <div class="d-flex justify-content-between mb-2">
          <span class="text-muted">Subtotal</span>
          <span class="fw-bold">$${total}</span>
        </div>
        <div class="d-flex justify-content-between mb-2">
          <span class="text-muted">Shipping</span>
          <span class="text-success fw-bold">FREE</span>
        </div>
        <hr>
        <div class="d-flex justify-content-between align-items-center mb-4">
          <span class="h4 fw-bold">Total</span>
          <span class="h4 fw-bold text-primary">$${total}</span>
        </div>

        <form action="confirmOrder" method="post">
          <button type="submit" class="confirm-btn btn btn-success w-100 btn-lg mb-3">
            PLACE ORDER NOW
          </button>
        </form>

        <div class="text-center">
          <a href="cart.jsp" class="text-muted small text-decoration-none">← Return to Cart</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>