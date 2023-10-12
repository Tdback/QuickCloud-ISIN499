<?php
require_once('config.php');

// Check if the form was submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve the selected table and search term from the form
    $tableName = $_POST['table'];
    $searchTerm = $_POST['search'];

    // Create a connection to the database
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Validate and sanitize user input (you should do more validation)
    $tableName = mysqli_real_escape_string($conn, $tableName);
    $searchTerm = mysqli_real_escape_string($conn, $searchTerm);

    // Build and execute your SQL query (modify this query as per your table structure)
    $sql = "SELECT * FROM $tableName WHERE column_name LIKE '%$searchTerm%'";
    $result = $conn->query($sql);

    if ($result) {
        // Display the search results (modify this as needed)
        echo "<h2>Search Results</h2>";
        while ($row = $result->fetch_assoc()) {
            // Output your search results here
            echo "Result: " . $row['column_name'] . "<br>";
        }
    } else {
        echo "Error: " . $conn->error;
    }

    // Close the database connection
    $conn->close();
}
?>

