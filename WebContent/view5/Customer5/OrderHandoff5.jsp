<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/jspf/common.jspf" %>

<% 
    String key=request.getParameter("key");
    Object[] result=(Object[])session.getAttribute("search5_"+key);
    if(result==null) {
        response.sendRedirect(request.getContextPath() + "/view5/Customer5/HomeFrm5.jsp");
        return;
    }
    int index;
    try {
        index=Integer.parseInt(request.getParameter("index"));
    }
    catch(Exception e) {
        response.sendError(400);
        return;
    }
    String kind=request.getParameter("kind");
    Object selected=null;
    if("dish".equals(kind)) {
        List<Dish5> list=(List<Dish5>)result[0];
        if(index>=0&&index<list.size())selected=list.get(index);
    }
    else if("combo".equals(kind)) {
        List<Combo5> list=(List<Combo5>)result[1];
        if(index>=0&&index<list.size())selected=list.get(index);
    }
    if(selected==null) {
        response.sendError(404);
        return;
    }
    session.setAttribute("orderHandoff5",selected);
    session.setAttribute("handoffUrl5","/view5/Customer5/OrderHandoff5.jsp?kind="+kind+"&key="+key+"&index="+index);
    if(currentUser==null) {
        response.sendRedirect(request.getContextPath() + "/view5/Member5/LoginFrm5.jsp");
        return;
    }
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>
<h1>Chuyển sang quy trình Đặt món</h1>
<p>Đã xác định đối tượng món/combo và người dùng đăng nhập. Module Đặt món nằm ngoài phạm vi hai module được triển khai; hệ thống chưa tạo đơn hàng.</p>
<a class="btn" href="<%= request.getContextPath() %>/view5/Customer5/HomeFrm5.jsp">Về trang chủ</a>
<%@ include file="/WEB-INF/jspf/end.jspf" %>
