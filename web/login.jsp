<%-- Document : login Created on : Jun 24, 2023, 4:00:03 PM Author : Acer --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>LOGIN</title>

        <!-- Bootstrap -->
        <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/empor-icon.css">
        <link rel="stylesheet" type="text/css" href="css/animate.min.css">
        <!-- <link rel="stylesheet" type="text/css" href="css/bootstrap-select.min.css">
  <link rel="stylesheet" type="text/css" href="css/bootstrap-slider.min.css"> -->
        <link rel="stylesheet" type="text/css" href="css/cubeportfolio.min.css">
        <link rel="stylesheet" type="text/css" href="css/owl.carousel.min.css">
        <link rel="stylesheet" type="text/css" href="css/settings.css">
        <link rel="stylesheet" type="text/css" href="css/bootsnav.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="icon" href="images/favicon.png">
        <link rel="stylesheet" type="text/css" href="css/stylecus.css">
        <script src="https://kit.fontawesome.com/ba20315c0b.js" crossorigin="anonymous"></script>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
    </head>

    <body class="boxed" >
        <main>





            <!--HEADER STARTS-->
            <header class="default menu-full">
                <nav class="navbar navbar-default navbar-sticky bootsnav">
                    <div class="container-fluid">
                        <!-- Start Header Navigation -->
                        <div class="navbar-header text-center">
                            <a class="navbar-brand" href="MainController?action=home">
                                <img src="images/logo.png" class="logo" alt="">
                            </a>
                        </div>
                        <a class="togglemenu" href="javascript:void(0)"><img src="" alt=""></a>
                        <!-- End Header Navigation -->
                    </div>
                </nav>
            </header>



            <!--HEADER ENDS-->


            <!-- Login starts -->
            <div class="login_containers d-flex justify-content-center align-items-center ">
                <div class="row ">
                    <div class="col-sm-12">
                        <div class="contentform ">

                            <div class="logintabbed bottom30">
                                <ul class="nav nav-tabs nav-justified heading_space" role="tablist">
                                    <li role="presentation" class="active"><a href="#registered" aria-controls="registered" role="tab"
                                                                              data-toggle="tab">Already Registered</a></li>
                                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">New
                                            member of Tien's Farm</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade in active" id="registered">
                                        <form class="callus" action="MainController" method="post">
                                            <div class="form-group">
                                                <label>UserID</label>

                                                <input type="text" class="form-control" name="userID" placeholder="userID" required="TRUE" <c:if test="${requestScope.ERROR != null}">
                                                       style="border: solid #df6053;"
                                                    </c:if>>
                                            </div>

                                            <div class="form-group">
                                                <label>PASSWORD </label>

                                                <input type="password" class="form-control" name="password" placeholder="Password" required="TRUE" <c:if test="${requestScope.ERROR != null}">
                                                       style="border: solid #df6053;"
                                                    </c:if>>
                                            </div>
                                            <c:if test="${requestScope.ERROR != null}">
                                                <div class="form-group">

                                                    ${requestScope.ERROR}
                                                </div>
                                            </c:if>
                                           
                                           <div class="g-recaptcha" style="margin-bottom: 20px;" data-sitekey="6Lco9fkmAAAAAGSahnUiKLCIx9ul3s8oqwvSp0Mg" data-callback="onReCaptchaSuccess" data-expired-callback="onReCaptchaExpired" data-error-callback="onReCaptchaError"></div>
                                           <button type="submit" id="registerBtn" name="action" class="btn btn_dark btn_full" disabled  value="Login">login</button>
                                        </form>
                                        <!--xoa chu n-->
                                    </div>
                                   
                                    <div role="tabpanel" class="tab-pane fade" id="profile">
                                        
                                        <form class="callus" action="MainController" method="POST">
                                            <div class="form-group">
                                                <label>User ID </label>
                                                <input type="text" class="form-control" placeholder="UserID" required="" name="userID">
                                                ${requestScope.USER_ERROR.userIDError}
                                            </div>
                                            <div class="form-group">
                                                <label>Name </label>
                                                <input type="text" class="form-control" name="fullName" required placeholder="Name">
                                                ${requestScope.USER_ERROR.fullNameError}
                                            </div>
                                            <div class="form-group">
                                                <label>EMAIL ADDRESS</label>
                                                <input type="email" class="form-control" name="mail" required placeholder="Email">

                                            </div>
                                            <div class="form-group">
                                                <label>PASSWORD </label>


                                                <input type="password" class="form-control" name="password" required id="passwordInput" placeholder="Password">
                                                ${requestScope.USER_ERROR.confirmError}
                                                <span class="input-group-btn">
                                                    <i class="fa-solid fa-eye" id="eye-icon-pass"></i>

                                                </span>

                                            </div>
                                            <div class="form-group">
                                                <label>RE-PASSWORD</label>

                                                <input type="password" class="form-control" name="repassword" required id="rePasswordInput" placeholder="Re-password">
                                                ${requestScope.USER_ERROR.confirmError}
                                                <span class="input-group-btn">
                                                    <i class="fa-solid fa-eye" id="eye-icon-repass"></i>
                                                </span>

                                            </div>
                                            <div class="g-recaptcha" style="margin-bottom: 20px;" data-sitekey="6Lco9fkmAAAAAGSahnUiKLCIx9ul3s8oqwvSp0Mg" data-callback="onReCaptchaSuccess" data-expired-callback="onReCaptchaExpired" data-error-callback="onReCaptchaError"></div>
                                            <button type="submit" name="action" value="createNewUser" class="btn btn_dark btn_full" disabled="" id="registerBtn" >Register</button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="share_with text-center top30">
                                <h5 class="bottom20">OR SIGN IN WITH...</h5>

                                <a href="    " class="google"><i class="icon-google4"></i> google </a>
                                
                            </div>



                        </div>
                    </div>
                </div>
            </div>
            <!-- Login end -->
        </main>



        <!--Footer Starts-->
        <footer id="footer" class="padding_t  clearfix" >
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
                        <p class="heading_space top15 copyright-text">Copyright &copy; 2023. All right reserved. Designed by<a
                                href="#."> CHALS</a></p>
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
        <script src="js/funtioncus.js"></script>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
           function onReCaptchaSuccess() {
    isReCaptchaCompleted = true;
    document.getElementById("registerBtn").disabled = false;
  }

  function onReCaptchaExpired() {
    isReCaptchaCompleted = false;
    document.getElementById("registerBtn").disabled = true;
  }

  function onReCaptchaError() {
    isReCaptchaCompleted = false;
    document.getElementById("registerBtn").disabled = true;
  }
        </script>

    </body>

</html>