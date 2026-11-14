<?php
require_once __DIR__ . '/../config/database.php';
function require_admin(): void {
    if (!current_user() || current_user()['role'] !== 'admin') { flash('error', 'Administrator access is required.'); redirect(url('login.php')); }
}
