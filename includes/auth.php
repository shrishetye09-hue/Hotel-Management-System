<?php
require_once __DIR__ . '/../config/database.php';
function require_login(): void { if (!current_user()) { flash('error', 'Please sign in to continue.'); redirect(url('login.php')); } }
