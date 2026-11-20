
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/common.jspf" %>
<%@ include file="/WEB-INF/jspf/managerGuard.jspf" %>
<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--medium panel--home">
    <h1 class="page-title page-title--center">
        Trang chủ quản lý
    </h1>

    <a class="btn btn--large" href="<%= request.getContextPath() %>/view5/Manager5/StatSelectFrm5.jsp">
        Xem thống kê
    </a>
</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
