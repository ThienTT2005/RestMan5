
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="dao5.AuthDAO5" %>

<%@ include file="/WEB-INF/jspf/common.jspf" %>

<%
    // Thiết lập mã hóa tiếng Việt
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String errorMessage = "";
    String username = "";

    // Xử lý khi người dùng nhấn nút Đăng nhập
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null) {
            username = "";
        }

        username = username.trim();

        // Kiểm tra dữ liệu đầu vào
        if (username.isEmpty()
                || password == null
                || password.isEmpty()) {

            errorMessage =
                    "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!";

        } else {

            try {
                // Kiểm tra tài khoản trong database
                Member5 user = new AuthDAO5().login(
                        username,
                        password
                );

                if (user == null) {

                    errorMessage =
                            "Tên đăng nhập hoặc mật khẩu không chính xác!";

                } else {

                    // Lưu thông tin người dùng vào session
                    session.setAttribute("user5", user);

                    // Chuyển trang theo vai trò
                    if (manager(user)) {

                        response.sendRedirect(
                                request.getContextPath()
                                        + "/view5/Manager5/ManagerHomeFrm5.jsp"
                        );

                    } else {

                        response.sendRedirect(
                                request.getContextPath()
                                        + "/view5/Customer5/HomeFrm5.jsp"
                        );
                    }

                    return;
                }

            } catch (Exception ex) {

                application.log(
                        "Lỗi xử lý đăng nhập RestMan5",
                        ex
                );

                errorMessage =
                        "Không thể đăng nhập. Vui lòng thử lại!";
            }
        }
    }
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="login-page">

    <div class="login-card">

        <h1 class="login-title">
            Đăng nhập
        </h1>

        <%-- Thông báo khi đăng nhập thất bại --%>
        <% if (!errorMessage.isEmpty()) { %>

        <div class="error"
             role="alert"
             style="margin-bottom: 20px;">

            <%= esc(errorMessage) %>

        </div>

        <% } %>

        <%-- Form đăng nhập --%>
        <form action="<%= request.getContextPath() %>/view5/Member5/LoginFrm5.jsp"
              method="post"
              class="login-form">

            <div class="login-field">

                <label for="username">
                    Tên đăng nhập
                </label>

                <input
                        type="text"
                        id="username"
                        name="username"
                        value="<%= esc(username) %>"
                        placeholder="Nhập tên đăng nhập"
                        autocomplete="username"
                        required
                >

            </div>

            <div class="login-field">

                <label for="password">
                    Mật khẩu
                </label>

                <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Nhập mật khẩu"
                        autocomplete="current-password"
                        required
                >

            </div>

            <button type="submit"
                    class="btn login-button">

                Đăng nhập

            </button>

        </form>

    </div>

</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
