<?php
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['action'])) {
        $action = $data['action'];
        $email = $data['email'] ?? null;

        // Database connection
        $conn = new mysqli('localhost', 'root', '', 'donorApp');
        if ($conn->connect_error) {
            echo json_encode(['error' => 'Database connection failed']);
            exit;
        }

        if ($action === 'sendCode') {
            if (empty($email)) {
                echo json_encode(['error' => 'Email is required']);
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
            if (mail($email, 'Password Reset Code', "Your reset code is: $code")) {
                echo json_encode(['success' => 'Code sent']);
            } else {
                echo json_encode(['error' => 'Failed to send email']);
            }
        } elseif ($action === 'resetPassword') {
            $code = $data['code'] ?? null;
            $newPassword = $data['newPassword'] ?? null;

            if (empty($email) || empty($code) || empty($newPassword)) {
                echo json_encode(['error' => 'All fields are required']);
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
        } else {
            echo json_encode(['error' => 'Invalid action']);
        }

        $conn->close();
    } else {
        echo json_encode(['error' => 'Action is required']);
    }
} else {
    echo json_encode(['error' => 'Invalid request method']);
}
?>
