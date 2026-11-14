<?php
require_once __DIR__.'/../includes/admin_auth.php';require_admin();
function admin_start(string $title): void { $GLOBALS['pageTitle']=$title.' | LUMIÈRE';require __DIR__.'/../includes/header.php';echo '<div class="admin-shell"><aside class="admin-sidebar"><a href="dashboard.php">Overview</a><a href="rooms.php">Rooms</a><a href="bookings.php">Bookings</a><a href="customers.php">Guests</a><a href="restaurant.php">Restaurant</a><a href="inquiries.php">Inquiries</a><a href="settings.php">Settings</a></aside><section class="admin-main"><h1>'.e($title).'</h1>'; }
function admin_end(): void { echo '</section></div>';require __DIR__.'/../includes/footer.php'; }
