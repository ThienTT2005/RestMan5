
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/jspf/common.jspf" %>
<%@ include file="/WEB-INF/jspf/managerGuard.jspf" %>
<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--narrow">

    <h1 class="page-title">
        Chọn loại thống kê
    </h1>

    <form class="form-stack"
          action="<%= request.getContextPath() %>/view5/Manager5/DishStatFrm5.jsp"
          method="get"
          onsubmit="return validateStatisticForm();">

        <label class="field" for="type">
            Loại thống kê:

            <select id="type" name="type">
                <option value="dish">
                    Thống kê món ăn
                </option>

                <option value="ingredient">
                    Thống kê nguyên liệu
                </option>

                <option value="customer">
                    Thống kê khách hàng
                </option>

                <option value="supplier">
                    Thống kê nhà cung cấp
                </option>
            </select>
        </label>

        <label class="field" for="startDateDisplay">
            Ngày bắt đầu:

            <input
                    type="text"
                    id="startDateDisplay"
                    placeholder="dd/MM/yyyy"
                    maxlength="10"
                    value="01/11/2026"
                    required
            >
        </label>

        <label class="field" for="endDateDisplay">
            Ngày kết thúc:

            <input
                    type="text"
                    id="endDateDisplay"
                    placeholder="dd/MM/yyyy"
                    maxlength="10"
                    value="19/11/2026"
                    required
            >
        </label>

        <input
                type="hidden"
                id="startDate"
                name="startDate"
        >

        <input
                type="hidden"
                id="endDate"
                name="endDate"
        >

        <div class="actions">

            <a class="btn btn--secondary"
               href="<%= request.getContextPath() %>/view5/Manager5/ManagerHomeFrm5.jsp">
                Quay lại
            </a>

            <button type="submit">
                Thống kê
            </button>

        </div>

    </form>

</section>

<script>
    function parseVietnameseDate(value) {
        const match = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(
            value.trim()
        );

        if (!match) {
            return null;
        }

        const day = Number(match[1]);
        const month = Number(match[2]);
        const year = Number(match[3]);

        const parsed = new Date(year, month - 1, day);

        if (
            parsed.getFullYear() !== year ||
            parsed.getMonth() !== month - 1 ||
            parsed.getDate() !== day
        ) {
            return null;
        }

        return {
            iso: match[3] + "-" + match[2] + "-" + match[1],
            time: parsed.getTime()
        };
    }


    function validateStatisticForm() {
        // 1. Kiểm tra loại thống kê được chọn
        const statType = document.getElementById("type").value;

        if (statType !== "dish") {
            alert("Chức năng thống kê này chưa được hỗ trợ.");
            return false;
        }

        // 2. Kiểm tra ngày bắt đầu và ngày kết thúc
        const start = parseVietnameseDate(
            document.getElementById("startDateDisplay").value
        );

        const end = parseVietnameseDate(
            document.getElementById("endDateDisplay").value
        );

        if (start === null || end === null) {
            alert("Vui lòng nhập ngày đúng định dạng dd/MM/yyyy!");
            return false;
        }

        // 3. Kiểm tra khoảng thời gian
        if (start.time > end.time) {
            alert("Vui lòng chọn khoảng thời gian hợp lệ!");
            return false;
        }

        // 4. Gán giá trị cho các input ẩn để gửi sang JSP
        document.getElementById("startDate").value = start.iso;
        document.getElementById("endDate").value = end.iso;

        return true;
    }
</script>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
