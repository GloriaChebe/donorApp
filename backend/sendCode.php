<?php
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $email = $data['email'];

    if (empty($email)) {
        echo json_encode(['error' => 'Email is required']);
        exit;
    }

    // Database connection
    $conn = new mysqli('localhost', 'root', '', 'donorApp');
    if ($conn->connect_error) {
        echo json_encode(['error' => 'Database connection failed']);
        exit;
    }

    // Check if email exists
    $stmt = $conn->prepare('SELECT id FROM users WHERE email = ?');
    $stmt->bind_param('s', $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo json_encode(['error' => 'Email not found']);
        exit;
    }

    // Generate a random code
    $code = rand(100000, 999999);

    // Save the code to the database
    $stmt = $conn->prepare('INSERT INTO password_resets (email, code) VALUES (?, ?) ON DUPLICATE KEY UPDATE code = ?');
    $stmt->bind_param('sis', $email, $code, $code);
    $stmt->execute();

    // Send the code via email (use a real mailer in production)
    mail($email, 'Password Reset Code', "Your reset code is: $code");

    echo json_encode(['success' => 'Code sent']);
    $conn->close();
}
?>
