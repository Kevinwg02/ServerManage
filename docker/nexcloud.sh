docker run -d \
  --name nextcloud-db \
  -e MYSQL_ROOT_PASSWORD='password' \
  -e MYSQL_PASSWORD='password' \
  -e MYSQL_DATABASE=nextcloud \
  -e MYSQL_USER=nextcloud \
  -v nextcloud_db:/var/lib/mysql \
  --restart unless-stopped \
  --network nextcloud-net \
  mariadb:latest \
  --transaction-isolation=READ-COMMITTED --binlog-format=ROW