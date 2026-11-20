<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% 
    session.invalidate();
    response.sendRedirect(request.getContextPath() + "/view5/Customer5/HomeFrm5.jsp");
%>
