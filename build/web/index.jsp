<%-- 
    Document   : index
    Created on : Jun 24, 2023, 3:58:39 PM
    Author     : Acer
--%>

<%@page import="java.util.HashMap"%>
<%@page import="sample.products.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="sample.products.ProductDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>Tien's FARM</title>

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
        <link rel="stylesheet" type="text/css" href="css/style.css?version=2">
        <link rel="icon" href="images/favicon.png">

        <style>
            /* CSS tùy chỉnh */
            .alert-container {
                position: fixed;
                top: 40px;
                right: 20px;
                transition: all 0.5s ease;
                opacity: 0;
                z-index: 900000;
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
            function formatDateTime(millis) {
                var date = new Date(millis);

                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();

                var hours = date.getHours();
                var minutes = date.getMinutes();

                // Đảm bảo có 2 chữ số cho ngày, tháng, giờ, phút
                day = (day < 10) ? '0' + day : day;
                month = (month < 10) ? '0' + month : month;
                hours = (hours < 10) ? '0' + hours : hours;
                minutes = (minutes < 10) ? '0' + minutes : minutes;

                var formattedDateTime = day + '-' + month + '-' + year + ' ' + hours + ':' + minutes;
                return formattedDateTime;
            }
            function addToCart(event, productID, name, price, inputId, quantityy, imgURL) {


                event.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ <a>
                console.log(productID);
                var quantity = document.getElementById(inputId).value;
                var currentTime = new Date().getTime(); // Lấy thời gian hiện tại

                var formattedDateTime = formatDateTime(currentTime);

                var convertedNum1 = parseInt(quantityy);

                var convertedNum2 = parseInt(quantity);
                console.log(convertedNum1 > convertedNum2);
                if (convertedNum2 < 1 || quantity === '') {
                    console.log('quantityy');
                    var alertHtml = '<div class="alert alert-warning  alert-dismissible  show" role="alert">';
                    alertHtml += 'Add to cart product ' + name + ' is not <= 1';
                    alertHtml += '</div>';
                    console.log(alertHtml);
                    var alertContainer = document.getElementById('alertContainer');
                    alertContainer.innerHTML = alertHtml;
                    console.log(alertContainer);
                    // Thêm lớp CSS để hiển thị cảnh báo
                    alertContainer.classList.add('show');
                    alertContainer.classList.add('alert-animation');

                    // Ẩn cảnh báo sau 3 giây (3000 milliseconds)
                    setTimeout(function () {
                        alertContainer.innerHTML = '';
                        alertContainer.classList.remove('show');
                        alertContainer.classList.remove('alert-animation');
                    }, 3000);

                } else
                if (convertedNum1 < convertedNum2) {
                    console.log('quantityy');
                    var alertHtml = '<div class="alert alert-warning  alert-dismissible  show" role="alert">';
                    alertHtml += 'Add to cart product ' + name + ' of TienFarm is not enough products';
                    alertHtml += '</div>';
                    console.log(alertHtml);
                    var alertContainer = document.getElementById('alertContainer');
                    alertContainer.innerHTML = alertHtml;
                    console.log(alertContainer);
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
                else {
            <%--<c:if test="${sessionScope.LOGIN_USER==null}">--%>
            <%--<c:redirect url="login.jsp" />--%>
            <%--</c:if>--%>
                    var url = 'MainController?action=addToCart&productID=' + productID + '&name=' + encodeURIComponent(name) + '&price=' + price + '&quantity=' + quantity + '&time=' + formattedDateTime + '&imgURL=' + imgURL + '&uID=' + '${sessionScope.LOGIN_USER.userID}';
                    window.location.href = url;
                }
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
        <c:if test="${requestScope.PRODUCTS==null}">
            <c:redirect url="MainController" />
        </c:if>

        <main>

            <!--Pre LOADER-->
            <!-- day la index.jsp           
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
                                    <div class="cssload-loader-circle-1">
                                        <div class="cssload-loader-circle-2"></div>
                                    </div>
                                    <div class="cssload-needle"></div>
                                    <div class="cssload-loading">loading</div>
                                </div>
                            </div>
                        </div>-->
            <!--Pre LOader Ends-->



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
                                    <li><a href="MainController?action=Cart" class="hamburger is-closed " style="display: flex; align-items: center;"><i
                                                class="icon-icons102"></i><span class="badge" style="background-color: #6096B4;">${sessionScope.CARTT.getCart().size()}</span></a>
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
            <form>

                <div id="sidebar-wrapper" style="    display: flex; justify-content: center;">
                    <ul class="nav sidebar-nav">
                        <c:if test="${sessionScope.CARTT!=null}">

                            <c:forEach items="${sessionScope.CARTT.getCart()}" var="cart">

                                <%--<c:set var="cart" value="${entry.value}" />--%>
                                <li class="tablecart">
                                    <div class="photo">
                                        <a href="">
                                            <img src="${cart.value.url}" alt="">
                                        </a>
                                    </div>
                                    <div class="cartbody">
                                        <h5>${cart.value.getName()}</h5>
                                        <span> <input type="number" value="${cart.value.quantity}" style="width: 30%"/> × $${cart.value.price}</span>
                                        <i class="fa fa-close cross"></i>
                                    </div>
                                </li>


                            </c:forEach>
                        </c:if> 
                        <c:if test="${sessionScope.CARTT==null}">  
                            <li class="text-center margin40 top40">
                                <div class="image-cart bottom10">
                                    <img src="images/shopping-cart.png" alt="">
                                </div>
                                <h4 class="text-uppercase">no products in the cart.</h4>
                            </li>
                        </c:if> 
                    </ul>
                    <div class="cart-bottom clearfix">
                        <h5 class="pull-left top10 bottom10">SUBTOTAL</h5>
                        <h5 class="pull-right top10 bottom10">$1,798.00</h5>
                        <div class="clearfix"></div>
                        <a class="btn btn_dark button_moema">view cart</a>
                        <a class="btn btn_colored button_moema">Checkout</a>
                    </div>
                </div>
            </form>
            <!--Shopping Cart ends-->




            <!--Search-->

            <div id="search">
                <button type="button" class="close">×</button>
                <form class="centered clearfix" action="MainController">
                    <input type="search"  placeholder="Search here...."  name="search" value="${param.search}" />
                    <button type="submit" class="btn-search" name="action" value="SearchProduct"><i class="icon-icons185"></i></button>
                </form>
            </div>


            <!--Page Header-->
            <section class="page_header shop_one padding_t">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12 text-center padding_t">
                            <h1 class="text-uppercase bottom10 text">TIEN'S FARM</h1>
                            <p class="title_text text padding_b">"Mua 1 tặng 1 tính tiền 2 :=))"</p>
                            <!-- <ul class="breadcrumb">
                         <li><a href="index.html">Home</a> </li>
                         <li class="active">Shop</li>
                      </ul> -->
                        </div>
                    </div>
                </div>
            </section>
            <!--Page Header ends -->


            <!--Gallery Starts-->
            <section id="emp_gallery" class="padding">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 heading_space clearfix">
                            <div id="project-filter" class="cbp-l-filters top10 pull-left">
                                <div data-filter="*" class="cbp-filter-item-active cbp-filter-item text">Show All</div>
                                <div data-filter=".milktea" class="cbp-filter-item text"> Milk Tea </div>
                                <div data-filter=".fruitea" class="cbp-filter-item text"> Fruit Tea</div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>

                    <div id="shop_one" class="cbp">




                        <c:if test="${requestScope.PRODUCT_ERROR==null}">
                            <c:forEach items="${requestScope.PRODUCTS}" var="product">

                                <div class="cbp-item  <c:if test="${ product.categori == 'Milk Tea'}">milktea</c:if> <c:if test="${product.categori == 'Fruit Tea'}">fruitea</c:if> ">
                                        <div class="image"  >



                                            <div class="ptags"><span class="off"> 40% </span></div>
                                            <div class="fader"  overflow: hidden;">
                                                 <img src="${product.url}"   alt="">
                                            <img src="${product.url}"    alt="">
                                        </div>
                                        <div class="shop_buttons">
                                            <a class="add_emp" href="javascript:void(0)" onclick="addToCart(event, '${product.productID}', '${product.name}', '${product.price}', '${product.productID}', '${product.quantity}', '${product.url}');" > <i class="icon-icons102"></i> add to cart </a>
                                            <input type="number" min="1" max="${product.quantity}" name="quantityy" required="" style="width: 20%" id="${product.productID}"/>
                                        </div>
                                    </div>
                                    <div class="product_caption padding_b">
                                        <a href="#.">
                                            <h6 class="bottom10">${product.name}</h6>
                                        </a>
                                        <p class="p-price" style="margin-bottom: 0">Price: $${product.price}</p>
                                        <p class="p-price">Quantity: ${product.quantity}</p>

                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <c:if test="${requestScope.PRODUCT_ERROR!=null}">
                            <div class="cbp-item  milktea fruitea ">
                                <div class="image">
                                    <h4> ${requestScope.PRODUCT_ERROR} </h4>
                                </div>
                            </div>

                        </c:if>
                    </div>
                    <!--                    <div class="col-sm-12 text-center">
                                            <div id="loadMore-gallery" class="btn btn_default button_moema margin40">
                                                <a href="loadmore-gallery/loadMore.html" class="cbp-l-loadMore-link" rel="nofollow">
                                                    <span class="cbp-l-loadMore-defaultText">LOAD MORE</span>
                                                    <span class="cbp-l-loadMore-loadingText">LOADING...</span>
                                                    <span class="cbp-l-loadMore-noMoreLoading">NO MORE WORKS</span>
                                                </a>
                                            </div>
                                        </div>-->
                </div>
            </section>



            <div class="modal fade emp-quickview" id="demo" tabindex="-1" role="dialog" aria-labelledby="demo"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal">X</button>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="image">
                                        <img src="images/product5.jpg" alt="">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="view-rating">
                                        <span class="view-stars bottom30">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </span>
                                        <span>(3 customer review)</span>
                                    </div>
                                    <h2>Barber’s Broom Classiscs</h2>
                                    <h3 class="top10">$112.00</h3>
                                    <p class="top30 bottom30">It is a long established fact that a reader will be distracted by the
                                        readable content
                                        of a page when looking at its distribution of letters.</p>
                                    <a class="btn btn_colored btn_rounded button_moema icon-drop" href="#."> <i
                                            class="icon-icons102"></i> Add to Cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>



        <!--Footer Starts-->
        <footer id="footer" class="padding_t  ">
            <div class="container footerBg">
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <h2 class="text-uppercase bottom10 text">Join Our Newsletter</h2>
                        <p class="heading_space text">Get 10% off your first purchase by subscribing to our Newsletter.</p>
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
                            <li><a href="#.">TIEN'S FARM -> ĐẾN ĂN ĐẢM BẢO LÀ CÓ NGƯỜI YÊU</a></li>

                        </ul>
                        <ul class="social">
                            <li><a href="#."><i class="icon-facebook-1"></i></a></li>
                            <li><a href="#."><i class="icon-pinterest"></i></a></li>
                            <li><a href="#."><i class="icon-twitter"></i></a></li>
                            <li><a href="#."><i class="icon-google4"></i></a></li>
                            <li><a href="#."><i class="icon-instagram"></i></a></li>
                        </ul>
                        <p class="heading_space top15 copyright-text text">Copyright &copy; 2023. All right reserved. Designed
                            by<a href="#." style="font-weight: 500; color: #6096B4;"> CHALS</a></p>
                    </div>
                </div>
            </div>
        </footer>
        <!--Footer Ends-->

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
