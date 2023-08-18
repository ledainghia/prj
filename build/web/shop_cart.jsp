<%-- 
    Document   : shop_cart
    Created on : Jul 8, 2023, 8:06:15 AM
    Author     : Acer
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>Tien's Farm Cart</title>

        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/empor-icon.css">
        <link rel="stylesheet" type="text/css" href="css/animate.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-select.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-slider.min.css">
        <link rel="stylesheet" type="text/css" href="css/cubeportfolio.min.css">
        <link rel="stylesheet" type="text/css" href="css/owl.carousel.min.css">
        <link rel="stylesheet" type="text/css" href="css/settings.css">
        <link rel="stylesheet" type="text/css" href="css/bootsnav.css">
        <link rel="stylesheet" type="text/css" href="css/style.css?version=1">
        <link rel="icon" href="images/favicon.png">
        <style>
            h2 {
                color: #333;
                text-align: center;
                margin-bottom: 30px;
            }

            table {
                background-color: #f8f8f8;
                border: 1px solid #ddd;
                margin: 0 auto;
            }

            th {
                background-color: #6096B4;
                color: #fff;
                text-align: center;
            }

            .product-image {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 10%;
            }

            td {
                text-align: center;
                vertical-align: middle;
            }

            .btn-update {
                background-color: #6096B4;
                color: #fff;
            }

            .btn-remove {
                background-color: #d9534f;
                color: #fff;
            }
        </style>



        <script>
            function updateCart(productId) {
                var quantityInput = document.getElementById("quantityInput" + productId);
                var quantity = quantityInput.value;

                var url = 'EditController?id=' + productId + '&quantity=' + quantity;
                window.location.href = url;
            }
        </script>


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
                var alertHtml = '<div class="alert <c:if test="${requestScope.message_erorr =='ERORR'}"> alert-warning </c:if> <c:if test="${requestScope.message_erorr =='SUCCESS'}"> alert-success  </c:if> alert-dismissible  show" role="alert">';
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






        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
     <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
     <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
     <![endif]-->
    </head>

    <body class="boxed">
        
        <div id="alertContainer" class="alert-container"></div>
        <c:if test="${requestScope.message!=null}">
            <script>
                showAlert();
            </script>
        </c:if>
        <!--Pre LOADER-->
        <div class="loader">
            <div id="cssload-wrapper">
                <div class="cssload-loader">
                    <div class="cssload-line"></div>
                    <div class="cssload-line"></div>
                    <div class="cssload-line"></div>
                    <div class="cssload-line"></div>
                    <div class="cssload-line"></div>
                    <div class="cssload-line"></div>
                    <div class="cssload-subline"></div>
                    <div class="cssload-subline"></div>
                    <div class="cssload-subline"></div>
                    <div class="cssload-subline"></div>
                    <div class="cssload-subline"></div>
                    <div class="cssload-loader-circle-1"><div class="cssload-loader-circle-2"></div></div>
                    <div class="cssload-needle"></div>
                    <div class="cssload-loading">loading</div>
                </div>
            </div>
        </div>
        <!--Pre LOader Ends-->

        <div class="overlaybody"></div>

        <!--HEADER STARTS-->
        <header class="default">
            <nav class="navbar navbar-default navbar-sticky bootsnav">
                <div class="container-fluid">


                    <div class="side_item">
                        <c:if test="${sessionScope.LOGIN_USER==null}">
                            <ul class="cols selection">
                                <li><a class="login_toggle text"  href="login.jsp">Login</a></li>
                                <li>
                                    <a class="register_toggle text" href="login.jsp" >Register</a>
                                </li>
                            </ul> 
                        </c:if>


                        <c:if test="${sessionScope.LOGIN_USER!=null}">
                            <ul class="cols selection">
                                <li><a class="login_toggle text" href="MainController?action=Profile">Hi, ${sessionScope.LOGIN_USER.getFullName()}</a></li>

                            </ul> 
                        </c:if>
                        <div class="cols">
                            <ul class="empr_nav">
                                <li class="search_btn"><i class="icon-icons185"></i></li>
                                <li><a href="javascript:void(0)" class="hamburger is-closed" data-toggle="offcanvas"><i
                                            class="icon-icons102"></i></a>
                                </li>
                                <c:if test="${sessionScope.LOGIN_USER!=null}">
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                            <i class="icon-profile-male"></i>
                                        </a>
                                        <ul class=" dropdown-menu dropdown-menu-right " style="width: 80px" >
                                            <li><a href="MainController?action=Profile" >Profile</a></li>
                                            <li><div class="dropdown-divider"></div></li>
                                            <li><a href="MainController?action=Logout">Sign out</a></li>

                                        </ul>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <!--                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                                                        <i class="fa fa-bars"></i>
                                                    </button>-->
                        <a class="navbar-brand" href="index.html"><img src="images/logo.png" class="logo" alt=""></a>
                    </div>
                    <!-- End Header Navigation -->

                </div>
            </nav>
        </header>
        <!--HEADER ENDS-->

        <!--Shopping Cart-->
        <div id="sidebar-wrapper">
            <ul class="nav sidebar-nav">
                <li class="tablecart">
                    <div class="photo">
                        <a href="#">
                            <img class="product-image" src="images/tablecart1.jpg" alt="">
                        </a>
                    </div>
                    <div class="cartbody">
                        <h5>Little Barrel in White</h5>
                        <span>1 × $1,288.00</span>
                        <i class="fa fa-close cross"></i>
                    </div>
                </li>
                <li class="tablecart">
                    <div class="photo">
                        <a href="#">
                            <img src="images/tablecart1.jpg" alt="">
                        </a>
                    </div>
                    <div class="cartbody">
                        <h5>Little Barrel in White</h5>
                        <span>1 × $1,288.00</span>
                        <i class="fa fa-close cross"></i>
                    </div>
                </li>
                <li class="tablecart">
                    <div class="photo">
                        <a href="#">
                            <img src="images/tablecart1.jpg" alt="">
                        </a>
                    </div>
                    <div class="cartbody">
                        <h5>Little Barrel in White</h5>
                        <span>1 × $1,288.00</span>
                        <i class="fa fa-close cross"></i>
                    </div>
                </li>
                <li class="text-center margin40 top40">
                    <div class="image-cart bottom10">
                        <img src="images/shopping-cart.png" alt="">
                    </div>
                    <h4 class="text-uppercase">no products in the cart.</h4>
                </li>
            </ul>
            <div class="cart-bottom clearfix">
                <h5 class="pull-left top10 bottom10">SUBTOTAL</h5>
                <h5 class="pull-right top10 bottom10">$1,798.00</h5>
                <div class="clearfix"></div>
                <a class="btn btn_dark button_moema">view cart</a>
                <a class="btn btn_colored button_moema">Checkout</a>
            </div>
        </div>
        <!--Shopping Cart ends-->



        <main>
            <!--Shoping Cart-->
            <section id="emp-cart">
                <div class="container-fluid equal_parent">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 bglight blackcolor padding equal_inner">
                            <div class="bg_info bgcart row">
                                <h2 class="bottom30 text-uppercase text-center">Shopping Cart</h2>
                                <div class="table-responsive emp_cart bottom50">
                                    <div class="container d-flex align-items-center justify-content-center">
                                        <div>
                                            <table class="table">
                                                <thead>
                                                    <tr class="text-center">
                                                        <th class="text-center">Image</th>
                                                        <th  class="text-center">Name</th>
                                                        <th  class="text-center">Price</th>
                                                        <th  class="text-center">Quantity</th>
                                                        <th class="text-center">Update</th>
                                                        <th class="text-center">Remove</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${sessionScope.CARTT!=null}">
                                                        <c:forEach items="${sessionScope.CARTT.getCart()}" var="cart">
                                                            <tr class="product-row">
                                                                <td><img class="product-image" src="${cart.value.url}" alt="Product 1"></td>
                                                                <td>${cart.value.getName()}</td>
                                                                <td class="price" >$${cart.value.price}</td>
                                                                <td> <input id="quantityInput${cart.value.id}" type="number" min="1" value="${cart.value.quantity}" > </td>
                                                                <td><button class="btn btn-update" onclick="updateCart('${cart.value.id}')">Update</button></td>
                                                                <td><button class="btn btn-remove" onclick="window.location.href = 'RemoveController?id=${cart.value.id}'">Remove</button></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:if>
                                                    <!-- Add more rows for additional products -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="cart_totals bottom50">
                                            <h4 class="bottom30">Shopping Bag Totals</h4>



                                            <form class="callus" action="MainController" > 
                                               
                                                <div class="row">
                                                    <div class="col-sm-2">
                                                        <p class="total-text no-border clearfix bottom20">
                                                            <strong class="pull-left">Total Products</strong>
                                                            <strong class="pull-right" id="totalQuantity">Product</strong>
                                                        </p>
                                                        <p class="total-text no-border clearfix bottom20">
                                                            <strong class="pull-left">Total price</strong>
                                                            <strong class="pull-right" id="totalPrice">$520.00</strong>
                                                        </p>
                                                        
                                                    </div>
                                                </div>
                                                <input type="hidden" name="totalPrice" id="totalPriceInput" value=""/>
                                                <input type="hidden" name="action"  value="Checkout"/>
                                                <button type="button" onclick="submit()" class="btn btn_colored btn_rounded button_moema">
                                                    Proced to checkout
                                                </button>
                                                <button onclick="window.location.href = 'MainController?action=home'" type="button" class="btn btn_default  btn_rounded button_moema">
                                                    Back to home
                                                </button>
                                            </form>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>

        </main>

        <!--Footer Starts-->
        <footer id="footer" class="footer padding_t clearfix">
            <div class="container footerBg">
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <h2 class="text-uppercase bottom10">Join Our Newsletter</h2>
                        <p class="heading_space">Get 10% off your first purchase. by subscribing to our Newsletter.</p>
                        <div class="row">
                            <div class="col-sm-2"></div>
                            <div class="col-sm-8">
                                <form>
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Email Address" required>
                                        <span class="input-group-btn">
                                            <button type="button"><i class="icon-arrow-right2"></i></button>
                                        </span>
                                    </div>
                                </form>
                            </div>
                            <div class="col-sm-2"></div>
                        </div>
                        <ul class="simple_breadcrumb padding">
                            <li><a href="#.">Shop Now</a></li>
                            <li><a href="#.">The Story</a></li>
                            <li><a href="#.">Lookbook</a></li>
                            <li><a href="#.">Life Style </a></li>
                            <li><a href="#.">Blog</a></li>
                            <li><a href="#.">Contact Us</a></li>
                            <li><a href="#.">Privacy Policy</a></li>
                        </ul>
                        <ul class="social">
                            <li><a href="#."><i class="icon-facebook-1"></i></a></li>
                            <li><a href="#."><i class="icon-pinterest"></i></a></li>
                            <li><a href="#."><i class="icon-twitter"></i></a></li>
                            <li><a href="#."><i class="icon-google4"></i></a></li>
                            <li><a href="#."><i class="icon-instagram"></i></a></li>
                        </ul>
                        <p class="heading_space top15 copyright-text">Copyright &copy; 2017 Empor. All right reserved. Designed by<a href="#."> Brighthemes</a></p>
                    </div>
                </div>
            </div>
        </footer>
        <!--Footer Ends-->

        <script>
            // Hàm tính tổng giá và số lượng
            function calculateTotal() {
                var totalQuantity = 0;
                var totalPrice = 0;

                var cartItems = document.querySelectorAll(".product-row");

                for (var i = 0; i < cartItems.length; i++) {
                    var quantityInput = cartItems[i].querySelector("input[type='number']");
                    var priceElement = cartItems[i].querySelector(".price");

                    var quantity = parseInt(quantityInput.value);
                    var price = parseFloat(priceElement.innerText.replace("$", ""));

                    totalQuantity += quantity;
                    totalPrice += quantity * price;
                }

                // Hiển thị tổng giá và số lượng
                document.getElementById("totalQuantity").innerText = totalQuantity;
                document.getElementById("totalPrice").innerText = "$" + totalPrice.toFixed(2);
                document.getElementById("totalPriceInput").value = totalPrice.toFixed(2);
            }

            // Gọi hàm tính tổng khi có sự thay đổi số lượng
            var quantityInputs = document.querySelectorAll(".product-row input[type='number']");
            for (var i = 0; i < quantityInputs.length; i++) {
                quantityInputs[i].addEventListener("change", calculateTotal);
            }
            document.addEventListener("DOMContentLoaded", function () {
                calculateTotal();
            });
        </script>
        <script src="js/jquery.2.2.3.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/bootsnav.js"></script>
        <script src="js/jquery.appear.js"></script>
        <script src="js/jquery-countTo.js"></script>
        <script src="js/jquery.cubeportfolio.min.js"></script>
        <script src="js/footer-reveal.min.js"></script>
        <script src="js/jquery.matchHeight-min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/viedobox_video.js"></script>
        <script src="js/bootstrap-slider.min.js"></script>
        <script src="js/bootstrap-select.min.js"></script>
        <script src="js/select.js"></script>  
        <script src="js/jquery.themepunch.tools.min.js"></script>
        <script src="js/jquery.themepunch.revolution.min.js"></script>
        <script src="js/revolution.extension.actions.min.js"></script>
        <script src="js/revolution.extension.layeranimation.min.js"></script>
        <script src="js/revolution.extension.navigation.min.js"></script>
        <script src="js/revolution.extension.parallax.min.js"></script>
        <script src="js/revolution.extension.slideanims.min.js"></script>
        <script src="js/revolution.extension.video.min.js"></script>
        <script src="js/functions.js"></script>
    </body>

</html>