package com.pharmacy.pharmacyweb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the action and product ID from the request
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");

        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {

                int productId = Integer.parseInt(productIdStr);
                HttpSession session = request.getSession();

                // 2. Retrieve the cart from session, or create a new one if it doesn't exist
                // Using a Map<Integer, Integer> to store ID -> Quantity
                Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
                if (cart == null) {
                    cart = new HashMap<>();
                }
                if ("update".equals(action)) {
                    String qtyStr = request.getParameter("quantity");
                    if (qtyStr != null && !qtyStr.isEmpty()) {
                        int quantity = Integer.parseInt(qtyStr);
                        if (quantity > 0) {
                            // This updates the value for that specific Key (Product ID)
                            cart.put(productId, quantity);
                        } else {
                            // If they set quantity to 0, just remove it
                            cart.remove(productId);
                        }
                    }
                }
                // 3. Handle specific CRUD actions
                switch (action) {
                    case "add":
                        // Increase quantity by 1 if it exists, otherwise set to 1
                        cart.put(productId, cart.getOrDefault(productId, 0) + 1);
                        break;

                    case "update":
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        if (quantity > 0) {
                            cart.put(productId, quantity);
                        } else {
                            cart.remove(productId);
                        }
                        break;

                    case "delete":
                        cart.remove(productId);
                        break;
                }

                // 4. Save the updated cart back to the session
                session.setAttribute("cart", cart);
            }
            catch (NumberFormatException e) {
                System.out.println("Invalid ID format received");
            }
        }
        // 5. Redirect back to the cart page to show changes
        response.sendRedirect("cart.jsp");
    }
}