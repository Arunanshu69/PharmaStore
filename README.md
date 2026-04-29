# PharmaStore

PharmaStore is a dynamic and responsive web application designed for managing an online pharmacy. It provides a complete shopping experience, allowing users to browse products, manage a shopping cart, and simulate the checkout process. The application is built using Java Servlets, JSP, and MySQL, with a modern frontend styled with Bootstrap 5.

## Features

-   **Product Catalog:** Displays a list of available medicines from the database, showing names, prices, and current stock levels.
-   **Dynamic Stock Indicators:** Visually indicates stock levels (e.g., changing colors for low stock).
-   **Shopping Cart:** Users can add products to a session-based shopping cart.
-   **Cart Management:** View items in the cart, update product quantities, or remove items.
-   **Order Summary:** Automatically calculates and displays the subtotal and grand total.
-   **Checkout Process:** A dedicated checkout page to review the order and enter delivery details.
-   **Stock Management:** Upon order confirmation, the application automatically updates the product stock in the database.
-   **User Feedback:** Displays a success message after an order is placed.

## Technology Stack

-   **Backend:** Java, Jakarta Servlets
-   **Frontend:** JSP (JavaServer Pages), JSTL (Jakarta Standard Tag Library), HTML, CSS
-   **UI Framework:** Bootstrap 5
-   **Database:** MySQL
-   **Build Tool:** Apache Maven
-   **Server:** Any Jakarta EE compatible servlet container (e.g., Apache Tomcat)

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:
-   Java Development Kit (JDK) 8 or higher
-   Apache Maven
-   MySQL Server
-   An IDE like IntelliJ IDEA or Eclipse
-   A servlet container like Apache Tomcat

## Setup and Installation

Follow these steps to get the PharmaStore application running on your local machine.

### 1. Clone the Repository

```bash
git clone https://github.com/Arunanshu69/PharmaStore.git
cd PharmaStore
```

### 2. Database Setup

1.  Connect to your local MySQL server.
2.  Create a new database for the application.

    ```sql
    CREATE DATABASE pharmacy_db;
    ```

3.  Use the new database.

    ```sql
    USE pharmacy_db;
    ```

4.  Create the `products` table and insert some sample data by running the following SQL script:

    ```sql
    CREATE TABLE products (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        price DOUBLE NOT NULL,
        stock_quantity INT NOT NULL
    );

    INSERT INTO products (name, price, stock_quantity) VALUES
    ('Paracetamol 500mg', 5.99, 150),
    ('Ibuprofen 200mg', 8.50, 80),
    ('Aspirin 100mg', 4.25, 200),
    ('Vitamin C 1000mg', 12.00, 95),
    ('Loratadine 10mg', 15.75, 50),
    ('Amoxicillin 250mg', 22.50, 30),
    ('Cough Syrup', 10.99, 8);
    ```

### 3. Configure Database Connection

Open the `src/main/java/com/pharmacy/pharmacyweb/util/DBConnection.java` file and update the database URL, username, and password to match your MySQL server configuration.

```java
// src/main/java/com/pharmacy/pharmacyweb/util/DBConnection.java

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pharmacy_db", // Your DB URL
                    "root", // Your DB username
                    "your_password_here" // Your DB password
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
```

### 4. Build the Project

Navigate to the root directory of the project and use the Maven wrapper to build the application. This will generate a `.war` file in the `target/` directory.

```bash
# For Linux/macOS
./mvnw clean install

# For Windows
./mvnw.cmd clean install
```

### 5. Deploy the Application

1.  Start your Apache Tomcat server (or any other servlet container).
2.  Deploy the generated `.war` file (e.g., `pharmacy-web-1.0-SNAPSHOT.war`) to your server. You can typically do this by copying the file from the `target/` directory into the `webapps/` directory of your Tomcat installation.
3.  Tomcat will automatically deploy the application.

### 6. Access the Application

Open your web browser and navigate to the application URL. The context path is usually derived from the `.war` file name.

`http://localhost:8080/pharmacy-web-1.0-SNAPSHOT/`

## Project Structure

```
.
├── pom.xml                   # Maven project configuration
└── src
    ├── main
    │   ├── java
    │   │   └── com/pharmacy/pharmacyweb
    │   │       ├── dao         # Data Access Objects (for DB interaction)
    │   │       │   └── ProductDAO.java
    │   │       ├── model       # Data models (POJOs)
    │   │       │   └── Product.java
    │   │       ├── servlet     # Servlets for handling HTTP requests
    │   │       │   ├── CartServlet.java
    │   │       │   └── ConfirmOrderServlet.java
    │   │       └── util        # Utility classes
    │   │           └── DBConnection.java
    │   └── webapp              # Web application root
    │       ├── index.jsp       # Main product listing page
    │       ├── cart.jsp        # Shopping cart page
    │       ├── checkout.jsp    # Checkout and order summary page
    │       └── WEB-INF
    │           └── web.xml     # Web deployment descriptor
    └── ...
