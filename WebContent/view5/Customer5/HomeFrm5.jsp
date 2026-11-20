
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/jspf/common.jspf" %>
<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--medium panel--home">

    <h1 class="page-title page-title--center">
        Tìm kiếm món ăn
    </h1>

    <form class="search-form"
          action="<%= request.getContextPath() %>/view5/Customer5/SearchListFrm5.jsp"
          method="get"
          onsubmit="if (!this.keyword.value.trim()) {
              alert('Vui lòng nhập từ khóa tìm kiếm!');
              return false;
          }">

        <label for="keyword">
            Từ khóa:
        </label>

        <input
                id="keyword"
                type="text"
                name="keyword"
                placeholder="Nhập từ khóa (ví dụ: Kimbap)"
                required
        >

        <button type="submit">
            Tìm kiếm
        </button>

    </form>

</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
