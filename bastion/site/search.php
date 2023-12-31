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

    // Validate and sanitize user input 
    $tableName = mysqli_real_escape_string($conn, $tableName);
    $searchTerm = mysqli_real_escape_string($conn, $searchTerm);

    // Build and execute your SQL query 
    $sql = "SELECT * FROM donor WHERE FName LIKE '%$searchTerm%'";
    $result = $conn->query($sql);

    if ($result) {
        // Display the search results 
        echo "<h2>Search Results</h2>";
        while ($row = $result->fetch_assoc()) {
            // Output your search results here
            echo "First Name: " . $row['FName'] . "<br>";
	    echo "Last Name: " . $row['LName'] . "<br>";
	    echo "City: " . $row['City'] . "<br>";
	    echo "State: " . $row['State'] . "<br>";
	   
        }
    } 

    // Close the database connection
    $conn->close();
}
?>

