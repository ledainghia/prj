<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<%
    // Thông tin c?n thi?t ?? g?i email
    String recipient = request.getParameter("recipient");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    // ??nh d?ng l?i n?i dung email ?? truy?n vào URL
    String encodedSubject = URLEncoder.encode(subject, StandardCharsets.UTF_8.toString());
    String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());

    // G?i yêu c?u HTTP POST ??n API Postmark
    String apiKey = "YOUR_POSTMARK_API_KEY";
    String postmarkUrl = "https://api.postmarkapp.com/email";
    String postData = "From=noreply@example.com&To=" + recipient + "&Subject=" + encodedSubject + "&HtmlBody=" + encodedMessage;

    URL url = new URL(postmarkUrl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setDoOutput(true);
    conn.setRequestMethod("POST");
    conn.setRequestProperty("Accept", "application/json");
    conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
    conn.setRequestProperty("X-Postmark-Server-Token", apiKey);

    conn.getOutputStream().write(postData.getBytes("UTF-8"));

    // ??c ph?n h?i t? API Postmark
    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    String line;
    StringBuilder response = new StringBuilder();

    while ((line = reader.readLine()) != null) {
        response.append(line);
    }

    reader.close();

    // X? lý ph?n h?i t? API Postmark (n?u c?n)
    String apiResponse = response.toString();
    // ...

    // Chuy?n h??ng trang sau khi g?i email thành công (ho?c th?t b?i)
    response.sendRedirect("result.jsp");
%>
