<?php
declare(strict_types=1);

if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

// Copy config/database.example.php to config/database.local.php and fill in
// the values supplied by your host. Keep database.local.php out of GitHub.
$localConfig = __DIR__ . '/database.local.php';
if (is_file($localConfig)) {
    $databaseSettings = require $localConfig;
} else {
    $databaseSettings = [
        'host' => getenv('DB_HOST') ?: '127.0.0.1',
        'name' => getenv('DB_NAME') ?: 'hotel_management',
        'user' => getenv('DB_USER') ?: 'root',
        'pass' => getenv('DB_PASS') ?: '',
    ];
}
$dbHost = $databaseSettings['host'];
$dbName = $databaseSettings['name'];
$dbUser = $databaseSettings['user'];
$dbPass = $databaseSettings['pass'];
$scriptPath = str_replace('\\', '/', $_SERVER['SCRIPT_NAME'] ?? '/');
$appPath = preg_replace('~/(admin|pages)/[^/]+$~', '', $scriptPath);
$appPath = preg_replace('~/[^/]+$~', '', $appPath);
define('APP_BASE', rtrim($appPath === '/' ? '' : $appPath, '/'));

try {
    $pdo = new PDO('mysql:host=' . $dbHost . ';dbname=' . $dbName . ';charset=utf8mb4', $dbUser, $dbPass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    exit('Database connection failed. Check the database credentials in config/database.php.');
}

function e(mixed $value): string { return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8'); }
function csrf_token(): string { return $_SESSION['csrf'] ??= bin2hex(random_bytes(32)); }
function csrf_check(): void {
    if (!hash_equals($_SESSION['csrf'] ?? '', (string)($_POST['csrf'] ?? ''))) {
        http_response_code(419); exit('Your session expired. Please go back and try again.');
    }
}
function flash(string $type, string $message): void { $_SESSION['flash'] = ['type'=>$type, 'message'=>$message]; }
function redirect(string $path): never { header('Location: ' . $path); exit; }
function url(string $path): string { return APP_BASE . '/' . ltrim($path, '/'); }
function current_user(): ?array { return $_SESSION['user'] ?? null; }
