<%-- 
    Document   : information
    Created on : Jun 28, 2023, 12:50:52 PM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Tien's FARM</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/empor-icon.css">
    <link rel="stylesheet" type="text/css" href="css/animate.min.css">
    <link rel="stylesheet" type="text/css" href="css/cubeportfolio.min.css">
    <link rel="stylesheet" type="text/css" href="css/owl.carousel.min.css">
    <link rel="stylesheet" type="text/css" href="css/settings.css">
    <link rel="stylesheet" type="text/css" href="css/stylecus.css">
    <link rel="icon" href="images/favicon.png">
    <script src="https://kit.fontawesome.com/ba20315c0b.js" crossorigin="anonymous"></script>

            <style>
            /* CSS tùy chỉnh */
            .alert-container {
                position: fixed;
                top: 40px;
                right: 20px;
                transition: all 0.5s ease;
                opacity: 0;
                z-index: 30000;
            }

            .alert-container.show {
                opacity: 1;
            }

            .alert-container.alert-animation {
                animation: slide-in-right 0.5s forwards;
            }

            @keyframes slide-in-right {
                0% {
                    transform: translateX(100%);
                }
                100% {
                    transform: translateX(0);
                }
            }
        </style>
        <script>
            function showAlert() {
                // Hiển thị cảnh báo
                var alertHtml = '<div class="alert <c:if test="${requestScope.message_erorr =='ERORR'}"> alert-warning </c:if> <c:if test="${requestScope.message_erorr =='SUCCESS'}"> alert-success  </c:if> alert-dismissible fade show" role="alert">';
      alertHtml += '${requestScope.message}';
      alertHtml += '</div>';

                var alertContainer = document.getElementById('alertContainer');
                alertContainer.innerHTML = alertHtml;

                // Thêm lớp CSS để hiển thị cảnh báo
                alertContainer.classList.add('show');
                alertContainer.classList.add('alert-animation');

                // Ẩn cảnh báo sau 3 giây (3000 milliseconds)
                setTimeout(function () {
                    alertContainer.innerHTML = '';
                    alertContainer.classList.remove('show');
                    alertContainer.classList.remove('alert-animation');
                }, 3000);
            }
        </script>

</head>

<body>
    
    <c:if test="${sessionScope.LOGIN_USER==null}">
        <c:redirect url="MainController"/>
    </c:if>
    <div id="alertContainer" class="alert-container"></div>
        <c:if test="${requestScope.message!=null}">
            <script>
                showAlert();
            </script>
        </c:if>
    <header class="p-3 mb-3 border-bottom sticky-top navbar-light bg-light">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
                    <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap">
                        <use xlink:href="#bootstrap" />
                    </svg>
                </a>

                <div class="navbar-header">

                    <a class="navbar-brand" href="MainController?action=home"><img src="images/logo.png" width="136" height="32"
                            class="logo" alt=""></a>
                </div>



                <div class="dropdown ms-auto p-2">
                    <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
                    </a>
                    <ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1">


                        <li><a class="dropdown-item" href="MainController?action=Logout">Sign out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>

    <section style="margin-top: 100px;">
        <div class="text-center ">
            <h3>CHANGE PERSONAL INFORMATION</h3>
        </div>
    </section>
    <section class="mb-3" style="display: block; padding-bottom: 200px;">
        <div class="container">
            <form action="MainController">

                <div class="mb-3 mt-4 border-bottom heading_space" style="display: flex; justify-content: start;">
                    <a href="information.html" class="me-2">
                        <h4 class="title">Your information </h4>
                    </a>
                   
                   
                </div>

                <div class="mb-3">
                    <label for="userID" class="form-label">User ID</label>
                    <input type="text" name="userID1" class="form-control" id="exampleInputPassword1" value="${sessionScope.LOGIN_USER.userID}" readonly="true">
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">Full name</label>
                    <input type="text" name="fullName" class="form-control" id="exampleInputPassword1" value="${sessionScope.LOGIN_USER.fullName}">
                </div>
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                           value="${sessionScope.LOGIN_USER.mail}" name="mail" readonly="true">
                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                </div>
                <div class="mb-3 input-group">
                    <label for="passwordInput" class="form-label">Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="passwordInput" name="password" value="${sessionScope.LOGIN_USER.password}">
                        <span class="input-group-text">
                            <i class="fa-solid fa-eye" id="eye-icon-pass"></i>
                        </span>
                    </div>
                </div>

                <div class="mb-3 input-group">
                    <label for="rePasswordInput" class="form-label">Re-Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="rePasswordInput" name="repassword" value="${sessionScope.LOGIN_USER.password}">
                        <span class="input-group-text">
                            <i class="fa-solid fa-eye" id="eye-icon-repass"></i>
                        </span>
                    </div>
                </div>



                        <button type="submit" name="action" value="ChangeInformation" class="btn btn-cus">Save</button>
            </form>
        </div>
    </section>


    <div class=" navbar fixed-bottom  navbar-light bg-light nav justify-content-center">
        <footer style="margin-top: 1rem!important;">
            <p class="nav justify-content-center border-bottom pb-1 mb-1 textFooted">
                TIEN'S FARM -> ĐẾN ĂN ĐẢM BẢO LÀ CÓ NGƯỜI YÊU
            </p>
            <ul class="nav justify-content-center border-bottom pb-1    mb-1 textFooted ">
                <li class="social"><a href="#."><i class="icon-facebook-1"></i></a></li>
                <li class="social"><a href="#."><i class="icon-twitter"></i></a></li>
                <li class="social"><a href="#."><i class="icon-github"></i></a></li>
            </ul>
            <p class="text-center textFooted  ">Copyright &copy; 2023 All right reserved. Designed by
                <span><a href="https://www.facebook.com/chals.nit" class="textFootedAu">CHALS</a></span>
            </p>
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
    <script src="./js/funtioncus.js"></script>
</body>

</html>
