# LUMIÈRE — Boutique Hotel & Resort

A responsive PHP 8 and MySQL hotel website designed for local demonstration with XAMPP. It includes a guest-facing editorial site, room search and reservations, customer accounts, restaurant menu, contact inquiries and a role-protected admin area.

## Run with XAMPP

1. Copy this folder to `C:\xampp\htdocs\hotel-management` (or use the folder name `hotel-management` under your XAMPP `htdocs`). The project links use `/hotel-management` as the local web path.
2. Start **Apache** and **MySQL** in the XAMPP Control Panel.
3. Open `http://localhost/phpmyadmin`, choose **Import**, select `database.sql`, and import it. The script creates the `hotel_management` database and demonstration data.
4. If your MySQL account differs from the XAMPP defaults, edit `config/database.php`. The default is host `127.0.0.1`, user `root`, blank password.
5. Visit `http://localhost/hotel-management/`.

## Free online demo

See [INFINITYFREE.md](INFINITYFREE.md) for the prepared free-hosting deployment steps. Keep your hosting database credentials in the ignored `config/database.local.php` file; do not commit it to GitHub.

## Demonstration accounts

All demo accounts use the password **password**. Passwords are stored as PHP bcrypt hashes and checked with `password_verify()`.

- Administrator: `admin@lumiere.example`
- Guest: `amara@example.com`
- More guests: `rohan@example.com`, `mira@example.com`, `dev@example.com`, `anika@example.com`

## Included workflows

- Guests can register, sign in, browse and filter rooms, submit reservation requests, and see their booking history.
- Reservations calculate nights and price server-side and prevent overlapping pending or confirmed reservations for the same room.
- Contact notes and newsletter subscriptions are saved in MySQL.
- The admin role can manage rooms and menu entries, update reservation status, view guests and their stay history, resolve inquiries, and change its password.
- Dashboard figures and Chart.js visualisations query stored records.

## Notes

- Room and restaurant photography uses remote Unsplash image URLs, so an internet connection is needed to display those images.
- The map on the contact page is an intentional location placeholder. Replace it with the hotel's preferred map embed when the final address is known.
- The admin's demo credentials are for local use. Change the password from **Admin → Settings** before using a non-demo deployment.
- A reservation is stored as **pending** until an administrator confirms it. No payment gateway is included.
