<%-- 
    Document   : product_admin
    Created on : Jun 28, 2023, 1:48:00 PM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.products.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.products.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>
            Admin page Tien's Farm
        </title>
        <link rel="shortcut icon" href="./images/favicon.png" type="image/png">
        <!-- GOOGLE FONT -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
            rel="stylesheet">
        <!-- BOXICONS -->
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>

        <!-- APP CSS -->
        <link rel="stylesheet" href="./css/admin.css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/admin.css/grid.css">
        <link rel="stylesheet" href="./css/admin.css/style.css">
        <link rel="stylesheet" href="./css/admin.css/responsive.css">
        <script src="https://kit.fontawesome.com/ba20315c0b.js" crossorigin="anonymous"></script>
        
        <!--alert-->
        <style>
            /* CSS tùy chỉnh */
            .alert-container {
                position: fixed;
                top: 40px;
                right: 20px;
                transition: all 0.5s ease;
                opacity: 0;
                z-index: 1000;
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

    <body class="sidebar-expand">
        <div id="alertContainer" class="alert-container"></div>
        

         <c:if test="${sessionScope.LOGIN_USER == null}" >
            <c:redirect url="login.jsp" />
      </c:if>
        
        <c:if test="${sessionScope.LOGIN_USER.roleID ne 'AD'}" >
            <c:redirect url="login.jsp" />
      </c:if>
        
        <c:if test="${requestScope.message!=null}">
            <script>
                showAlert();
            </script>
        </c:if>
        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-logo">
                <a href="MainController?action=client_admin">
                    <img src="./images/logo.png" alt="Protend logo">
                </a>
                <div class="sidebar-close" id="sidebar-close">
                    <i class='bx bx-left-arrow-alt'></i>
                </div>
            </div>
            <!-- SIDEBAR MENU -->
            <div class="simlebar-sc" data-simplebar>
                <ul class="sidebar-menu tf">
                    <li>
                        <a href="MainController?action=home_admin">
                            <i class='bx bxs-home'></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="MainController?action=client_admin">
                            <i class='bx bxs-user'></i>
                            <span>Manager Client</span>

                        </a>

                    </li>
                    <li>
                        <a href="MainController?action=product_admin">
                            <i class='bx bxs-dashboard'></i>
                            <span>Manager Product</span>
                        </a>
                    </li>
                    <li>
                        <a class="darkmode-toggle" id="darkmode-toggle" onclick="switchTheme()">
                            <div>
                                <i class='bx bx-cog mr-10'></i>
                                <span>darkmode</span>
                            </div>

                            <span class="darkmode-switch"></span>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- END SIDEBAR MENU -->
        </div>
        <!-- END SIDEBAR -->

        <!-- Main Header -->
        <div class="main-header">
            <div class="d-flex">
                <div class="mobile-toggle" id="mobile-toggle">
                    <i class='bx bx-menu'></i>
                </div>
                <div class="main-title">
                    Products
                </div>
            </div>

            <div class="d-flex align-items-center">

                

                <div class="dropdown d-inline-block">


                    
                </div>
                <!-- <div class="dropdown d-none d-lg-inline-block ms-1">
                    <button type="button" class="btn header-item noti-icon waves-effect" data-toggle="fullscreen">
                            <i class="bx bx-fullscreen"></i>
                        </button>
                </div> -->
                <div class="dropdown d-inline-block mt-12">
                    <button type="button" class="btn header-item waves-effect" id="page-header-user-dropdown"
                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img class="rounded-circle header-profile-user" src="./images/profile/profile.png"
                             alt="Header Avatar">

                        <span class="info d-xl-inline-block  color-span">
                            <span class="d-block fs-20 font-w600">Hi, ${sessionScope.LOGIN_USER.getFullName() }</span>

                        </span>

                        <i class='bx bx-chevron-down'></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-end">
                        <!-- item-->
                        <a class="dropdown-item" href="MainController?action=Profile"><i class="bx bx-user font-size-16 align-middle me-1"></i>
                            <span>Profile</span></a>
                       
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item text-danger" href="MainController?action=Logout"<i
                                class="bx bx-power-off font-size-16 align-middle me-1 text-danger"></i>
                            <span>Logout</span></a>
                    </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Main Header -->

        <!-- MAIN CONTENT -->
        <div class="main">
            <div class="main-content client">

                <div class="row">
                    <div class="col-12">
                        <div class="box">
                            <div class="box-body d-flex justify-content-between box-search pt-0 pb-0">
                                <form class="search-form d-flex list-action" action="MainController" >
                                    <input type="search"  placeholder="Search here...." class="form-control"  name="search" value="${param.search}">
                                    <button type="submit" class="search d-flex" name="action" value="SearchProductAdmin" ><i class="fas fa-search"></i>Search</button>
                                </form>
                                <div class="list-action">

                                    <a href="MainController" class="add" data-toggle="modal" data-target="#add_product">Add product<i
                                            class="fas fa-plus-circle"></i></a>
                                </div>
                            </div>

                        </div>
                    </div>
                                    <c:if test="${requestScope.PRODUCT_ERROR!=null}">
                                        <div class="col-12">
                                            <h4>${requestScope.PRODUCT_ERROR}</h4>
                                        </div>
                                    </c:if>
                    <c:if test="${requestScope.PRODUCT_ERROR==null}">
                    <c:forEach items="${requestScope.PRODUCTS}" var="product">
                        <div class="col-3 col-md-6 col-sm-12 mb-25">
                            <div class="box client">

                                

                                <div class="box-body pt-5 pb-0">
                                    <div class="img-box">
                                        <img class="img-responsive" src="${product.url}" alt="">

                                    </div>
                                    <a href="client-details.html">
                                        <h5 class="mt-17">${product.name}</h5>
                                    </a>

                                    <p class="fs-14 font-w400 font-main">Ngon nhuc nach</p>
                                    <ul class="info">
                                        <li class="fs-14"><i class="fa-solid fa-money-bill-wave"></i></i> PRICE: ${product.price}$</li>
                                        <li class="fs-14"><i class="fa-solid fa-warehouse"></i>QUANTITY: ${product.quantity}</li>
                                    </ul>
                                    <div class="group-btn d-flex justify-content-between">
                                        <a class="bg-btn-pri color-white edit_product" href="#" data-toggle="modal" data-target="#edit_product" data-id="${product.productID}" data-name="${product.name}" data-price="${product.price}" data-quantity="${product.quantity}" data-categori="${product.categori}">Edit</a>
                                        
                                        <a class="bg-btn-sec color-main" href="MainController?action=DeleteProductAdmin&productID=${product.productID}">Delete</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </c:forEach>
                    </c:if>
                </div>


                <div id="add_product" class="modal custom-modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">Add New Product</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <form action="MainController" method="POST" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label>Upload Picture</label>
                                        <input class="form-control" type="file" accept="image/*" required="" name="image">
                                    </div>
                                    <div class="form-group">
                                        <label>Product ID</label>
                                        <input type="text" class="form-control" required="" name="productID" value="">
                                        <p>CMN Lỗi rồi bạn</p>
                                    </div>
                                    <div class="form-group">
                                        <label>Name</label>
                                        <input type="text" class="form-control" required="" name="name" value="">
                                        <p>CMN Lỗi rồi bạn</p>
                                    </div>
                                    <div class="form-group">
                                        <label>Price</label>
                                        <input type="text" class="form-control" required="" name="price" value="">
                                    </div>


                                    <div class="form-group">
                                        <label>Quantity</label>
                                        <input type="number" min="0" class="form-control" required="" name="quantity" value="">
                                    </div>
                                    <div class="form-group">
                                        <label>Categori</label>
                                        <input type="text" min="0" class="form-control" required="" name="categori" value="">
                                    </div>
                                    



                                    <div class="submit-section text-center">
                                        <button class="btn btn-primary submit-btn" name="action" value="CreateProduct" >Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="edit_product" class="modal custom-modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">Edit product</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <form action="MainController" method="GET">
                                    <div class="form-group">
                                        <label>Product ID</label>
                                        <input type="text" class="form-control" name="product_id" readonly="" value="">
                                    </div>
                                    <div class="form-group">
                                        <label>Product Name</label>
                                        <input type="text" class="form-control" required="" name="product_name" value="">
                                    </div>
                                    <div class="form-group">
                                        <label>Product price</label>
                                        <input type="text" class="form-control" required="" name="product_price" value="">
                                    </div>
                                    <div class="form-group">
                                        <label>Product Quantity</label>
                                        <input type="number" min="0" class="form-control" required="" name="product_quantity" value="">
                                    </div>
                                    <div class="form-group">
                                        <label>Categori</label>
                                        <input type="text" class="form-control" required="" name="product_categori" value="">
                                    </div>  
                                    <div class="form-group">
                                        <label>Upload Files</label>
                                        <input class="form-control" type="file">
                                    </div>
                                    <div class="submit-section text-center">
                                        <button class="btn btn-primary submit-btn" name="action" value="UpdateProductAdmin">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END MAIN CONTENT -->

        <div class="overlay"></div>

        <!--Footer Starts-->
        <footer id="footer" class="padding_t " >
            <div class="container footerBg">
                <div class="row">
                    <div class="col-sm-12 text-center">

                        <ul class="social">
                            <li><a href="#."><i class="icon-facebook-1"></i></a></li>
                            <li><a href="#."><i class="icon-pinterest"></i></a></li>
                            <li><a href="#."><i class="icon-twitter"></i></a></li>
                            <li><a href="#."><i class="icon-google4"></i></a></li>
                            <li><a href="#."><i class="icon-instagram"></i></a></li>
                        </ul>
                        <p class="heading_space top15 copyright-text text">Copyright &copy; 2023. All right reserved.
                            Designed
                            by <a href="#." style="font-weight: 500; color: #6096B4;"> CHALS</a></p>
                    </div>
                </div>
            </div>
        </footer>
        <!--Footer Ends-->

        <!-- SCRIPT -->

        <!-- Plugin -->

        <script src="./libs/jquery/jquery.min.js"></script>
        <script src="./libs/moment/min/moment.min.js"></script>
        <script src="./libs/apexcharts/apexcharts.js"></script>
        <script src="./libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="./libs/peity/jquery.peity.min.js"></script>
        <script src="./libs/chart.js/Chart.bundle.min.js"></script>
        <script src="./libs/owl.carousel/owl.carousel.min.js"></script>
        <script src="./libs/bootstrap/js/bootstrap.min.js"></script>
        <script src="./libs/simplebar/simplebar.min.js"></script>

        <!-- APP JS -->
        <script src="./js/admin_js/shortcode.js"></script>
        <script src="./js/admin_js/pages/clients.js"></script>
        <script src="./js/admin_js/main.js?version=2"></script>
    </body>

</html>