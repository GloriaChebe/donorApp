<?php
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $email = $data['email'];
    $code = $data['code'];
    $newPassword = $data['newPassword'];

    if (empty($email) || empty($code) || empty($newPassword)) {
        echo json_encode(['error' => 'All fields are required']);
        exit;
    }

    // Database connection
    $conn = new mysqli('localhost', 'root', '', 'donorApp');
    if ($conn->connect_error) {
        echo json_encode(['error' => 'Database connection failed']);
        exit;
    }

    // Verify the code
    $stmt = $conn->prepare('SELECT id FROM password_resets WHERE email = ? AND code = ?');
    $stmt->bind_param('si', $email, $code);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo json_encode(['error' => 'Invalid code']);
        exit;
    }

    // Update the user's password
    $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);
    $stmt = $conn->prepare('UPDATE users SET password = ? WHERE email = ?');
    $stmt->bind_param('ss', $hashedPassword, $email);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        // Delete the reset code
        $stmt = $conn->prepare('DELETE FROM password_resets WHERE email = ?');
        $stmt->bind_param('s', $email);
        $stmt->execute();

        echo json_encode(['success' => 'Password reset successfully']);
    } else {
        echo json_encode(['error' => 'Failed to update password']);
    }

    $conn->close();
}
?>
