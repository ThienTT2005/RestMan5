
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
          onsubmit="return validateSearch5();">

        <label for="keyword">
            Từ khóa:
        </label>

        <input
                id="keyword"
                type="text"
                name="keyword"
                placeholder="Nhập từ khóa (ví dụ: Kimbap)"
        >

        <button type="submit">
            Tìm kiếm
        </button>

    </form>

</section>

<script>
    function validateSearch5() {
        const keywordInput = document.getElementById("keyword");
        const keyword = keywordInput.value.trim();

        if (keyword === "") {
            alert("Vui lòng nhập từ khóa tìm kiếm");
            keywordInput.focus();
            return false;
        }

        return true;
    }
</script>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
