-- NE PAS stocker mots de passe en clair ici, utiliser secrets ou exécuter manuellement
CREATE DATABASE IF NOT EXISTS wordpress;
-- create admin user (remplace username/password par valeurs sûres)
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'WP_DB_PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;

