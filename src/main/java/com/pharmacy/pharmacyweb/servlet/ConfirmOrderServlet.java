package com.pharmacy.pharmacyweb.servlet;

import com.pharmacy.pharmacyweb.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/confirmOrder") // This MUST match the action in your checkout.jsp
public class ConfirmOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null && !cart.isEmpty()) {
            ProductDAO dao = new ProductDAO();

            // Loop through the cart and update the MySQL stock
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int productId = entry.getKey();
                int quantityToDeduct = entry.getValue();

                // Call the DAO method to subtract stock from the database
                dao.updateStock(productId, quantityToDeduct);
            }

            // Clear the cart session after a successful order
            session.removeAttribute("cart");

            // Redirect to a "Thank You" page or back to the index
            response.sendRedirect("index.jsp?order=success");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}