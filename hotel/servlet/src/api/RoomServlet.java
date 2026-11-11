package api;
import java.io.*; import java.sql.*; import javax.servlet.annotation.WebServlet; import javax.servlet.http.*;
/** GET /api/rooms?checkIn=2026-12-01&checkOut=2026-12-03&guests=2  -> JSON list of available rooms */
@WebServlet("/api/rooms")
public class RoomServlet extends HttpServlet {
  static final String URL="jdbc:mysql://localhost:3306/hotel_db", USER="root", PASS="";
  protected void doGet(HttpServletRequest q, HttpServletResponse r) throws IOException {
    r.setContentType("application/json;charset=UTF-8"); r.setHeader("Access-Control-Allow-Origin","*");
    String in=q.getParameter("checkIn"), out=q.getParameter("checkOut"); int g=1;
    try{ g=Integer.parseInt(q.getParameter("guests")); }catch(Exception ignored){}
    if(in==null||out==null){ r.setStatus(400); r.getWriter().print("{\"error\":\"checkIn and checkOut required\"}"); return; }
    String sql="SELECT * FROM rooms r WHERE capacity>=? AND NOT EXISTS(SELECT 1 FROM bookings b WHERE b.room_id=r.id AND b.status<>'cancelled' AND b.check_in<? AND b.check_out>?)";
    try(Connection c=DriverManager.getConnection(URL,USER,PASS); PreparedStatement ps=c.prepareStatement(sql)){
      ps.setInt(1,g); ps.setDate(2,Date.valueOf(out)); ps.setDate(3,Date.valueOf(in));
      ResultSet rs=ps.executeQuery(); StringBuilder sb=new StringBuilder("[");
      while(rs.next()){ if(sb.length()>1)sb.append(',');
        sb.append(String.format("{\"id\":%d,\"name\":\"%s\",\"type\":\"%s\",\"price\":%s,\"capacity\":%d}",
          rs.getInt("id"),esc(rs.getString("name")),esc(rs.getString("type")),rs.getBigDecimal("price"),rs.getInt("capacity"))); }
      r.getWriter().print(sb.append(']'));
    }catch(Exception e){ r.setStatus(500); r.getWriter().print("{\"error\":\""+esc(e.getMessage())+"\"}"); }
  }
  static String esc(String s){ return s==null?"":s.replace("\\","\\\\").replace("\"","\\\""); }
  static { try{ Class.forName("com.mysql.cj.jdbc.Driver"); }catch(Exception e){} }
}
