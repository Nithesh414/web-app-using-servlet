# Grand Stay – Hotel Booking System
## 1. Database
`mysql -u root -p < schema.sql`
## 2. PHP web app (UI + all features)
Copy `php/` into XAMPP `htdocs/hotel` (or run `php -S localhost:8000 -t php`). Edit DB credentials in `php/config.php`.
Open http://localhost:8000 . The FIRST account you register becomes admin.
Features: room search by date/guests/type, double-booking protection (transactional), register/login (hashed passwords),
booking confirmation, my bookings + cancel, admin dashboard (stats, add/delete rooms, manage booking status).
## 3. Java Servlet availability API (Tomcat 9, javax.servlet)
Compile `servlet/src/api/RoomServlet.java` with servlet-api + mysql-connector-j on the classpath into `WEB-INF/classes`,
put mysql connector in `WEB-INF/lib`, zip `WEB-INF` as `hotel.war`, deploy to Tomcat.
Test: http://localhost:8080/hotel/api/rooms?checkIn=2026-12-01&checkOut=2026-12-03&guests=2
