# InfinityFree demo deployment

This guide is for a demonstration deployment. Free hosting can impose traffic, resource, or service limits. Do not use the demo admin password or seed customer data for a real hotel.

## 1. Create the hosting account

1. Create an account at [InfinityFree](https://www.infinityfree.com/) and create a free hosting account with a subdomain.
2. Open the hosting control panel. Create a MySQL database and note the **database host, database name, username, and password** shown there. The host may not be `localhost`.
3. Use the hosting control panel's phpMyAdmin link for that database.

## 2. Import the database

1. In phpMyAdmin, select the newly created database.
2. Choose **Import**, select `database.sql`, and start the import.
3. If the provider has already created the database and user for you, remove the initial `CREATE DATABASE ...` and `USE hotel_management;` lines from a copy of `database.sql` before importing. Run the remaining statements inside the selected database.

## 3. Prepare the project files

1. Copy `config/database.example.php` to `config/database.local.php`.
2. Put the exact host, database name, username, and password from the control panel into `database.local.php`.
3. Keep `database.local.php` private. It is ignored by Git, so it will not be committed.
4. Upload the application files and folders to the account's web root (often named `htdocs`). Upload the *contents* of the project so `index.php` is directly in the web root.
5. Upload `database.local.php` separately into the remote `config` folder. Do not upload the example file in its place and do not publish the real credentials in GitHub.

## 4. Open and verify the demo

Open the subdomain provided by InfinityFree. Try browsing rooms, creating a customer account, submitting a reservation, and signing into the admin area.

The seeded demo admin is `admin@lumiere.example` with password `password`. Change it after import using **Admin → Settings**. The sample reservations use 2026/2027 dates; some may be in the past depending on when the demo is viewed.

## Limitations

- The site uses remote Unsplash photos and Google Fonts, so those need an internet connection.
- Room photos are currently supplied as URLs. Upload-to-server image editing is not part of this build.
- If the host's PHP version or PDO MySQL support is incompatible, use the host's PHP selector/support settings or choose another PHP/MySQL host.
- This is prepared for manual FTP/file-manager upload. GitHub is the source of code; InfinityFree runs PHP and MySQL.
