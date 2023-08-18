<%-- 
    Document   : dashboard_admin
    Created on : Jun 26, 2023, 3:31:18 PM
    Author     : Acer
--%>

<%@page import="sample.users.UserDTO"%>
<%@page import="sample.users.UserDAO"%>
<%@page import="sample.products.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.products.ProductDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <!-- Plugin -->
        <link rel="stylesheet" href="./libs/owl.carousel/assets/owl.carousel.min.css">

        <!-- APP CSS -->
        <link rel="stylesheet" href="./css/admin.css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/admin.css/grid.css">
        <link rel="stylesheet" href="./css/admin.css/style.css?version=1.0">
        <link rel="stylesheet" href="./css/admin.css/responsive.css">
    </head>

    <body class="sidebar-expand">
        
        
        <c:if test="${sessionScope.LOGIN_USER == null}" >
            <c:redirect url="login.jsp" />
      </c:if>
        
        <c:if test="${sessionScope.LOGIN_USER.roleID ne 'AD'}" >
            <c:redirect url="login.jsp" />
      </c:if>

        
      
        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-logo">
                <a href="MainController?action=home">
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
                        <a href="MainController?action=home_admin" class="sidebar-menu-dropdown">
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
                    Dashboard
                </div>
            </div>

            <div class="d-flex align-items-center">

               



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
        <!-- End Main Header -->
        <!-- MAIN CONTENT -->

        <div class="main">


            <div class="main-content dashboard">

                <div class="row">
                 
                    <div class="col-10 col-md-10 col-sm-12 mb-0">
                        <div class="row">
                            <div class="col-12 col-xl-12 col-md-12 col-sm-12">
                                <div class="box">
                                    <div class="box-header">
                                        <div class="me-auto">
                                            <h6 class="card-title font-w400 mb-20">Current Balance</h6>
                                            <div class="count-number d-flex">
                                                <span class="h4 font-w900">$</span>
                                                <h4 class="count font-w900 pl-5">${requestScope.BA1ACE}</h4>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="chartBar2" class="bar-chart "></div>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>

                    <div class="col-2 col-md-2 col-col-sm-12 mb-0">
                        <div class="row">
                            <div class="col-12 col-xl-12 col-sm-12">
                                <div class="box">
                                    <div class="box-body d-flex pb-0">
                                        <div class="me-auto">
                                            <h5 class="box-title">Total Clients</h5>
                                            <div class="d-flex align-items-center">
                                                <h4 class="mb-0 font-wb fs-30 mt-23">  ${requestScope.LIST_USER.size()} </h4>

                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div>

                            <div class="col-12 col-xl-12 col-sm-12">
                                <div class="box">
                                    <div class="box-body d-flex pb-0">
                                        <div class="me-auto">
                                            <h5 class="box-title">Total Admin</h5>
                                            <div class="d-flex align-items-center">
                                                <h4 class="mb-0 font-wb fs-30 mt-23"><c:set var="countAD" value="0" /> 
                                                    <c:forEach items="${requestScope.LIST_USER}" var="user">
                                                        <c:if test="${user.roleID == 'AD'}"> 
                                                            <c:set var="countAD" value="${countAD + 1}" /> 
                                                        </c:if>
                                                    </c:forEach>

                                                   <c:out value="${countAD}" /></h4>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-xl-12 col-sm-12">
                                <div class="box">
                                    <div class="box-body d-flex pb-0">
                                        <div class="me-auto">
                                            <h5 class="box-title">Total User</h5>
                                            <div class="d-flex align-items-center">
                                                <h4 class="mb-0 font-wb fs-30 mt-23"><c:set var="countUS" value="0" /> 
                                                    <c:forEach items="${requestScope.LIST_USER}" var="user">
                                                        <c:if test="${user.roleID == 'US'}"> 
                                                            <c:set var="countUS" value="${countUS + 1}" /> 
                                                        </c:if>
                                                    </c:forEach>

                                                   <c:out value="${countUS}" /></h4>

                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>


                <div id="add_project" class="modal custom-modal fade" role="dialog">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Create Project</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="row">
                                        <div class="col-sm-6 mb-0">
                                            <div class="form-group">
                                                <label>Project Name</label>
                                                <input class="form-control" value="" type="text">
                                            </div>
                                        </div>
                                        <div class="col-sm-6 mb-0">
                                            <div class="form-group">
                                                <label>Client</label>
                                                <select class="select">
                                                    <option>Client 1</option>
                                                    <option>Client 2</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 mb-0">
                                            <div class="form-group">
                                                <label>Start Date</label>
                                                <div class="cal-icon">
                                                    <input class="form-control " type="date">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 mb-0">
                                            <div class="form-group">
                                                <label>End Date</label>
                                                <div class="cal-icon">
                                                    <input class="form-control" type="date">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3 mb-0">
                                            <div class="form-group">
                                                <label>Rate</label>
                                                <input placeholder="$50" class="form-control" value="" type="text">
                                            </div>
                                        </div>
                                        <div class="col-sm-3 mb-0">
                                            <div class="form-group">
                                                <label>&nbsp;</label>
                                                <select class="select">
                                                    <option>Hourly</option>
                                                    <option selected>Fixed</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 mb-0">
                                            <div class="form-group">
                                                <label>Priority</label>
                                                <select class="select">
                                                    <option selected>High</option>
                                                    <option>Medium</option>
                                                    <option>Low</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea rows="4" class="form-control"
                                                  placeholder="Enter your message here"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>Upload Files</label>
                                        <input class="form-control" type="file">
                                    </div>
                                    <div class="submit-section">
                                        <button class="btn btn-primary submit-btn">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal custom-modal fade" id="delete_project" role="dialog">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div class="form-header">
                                    <h3>Delete Project</h3>
                                    <p>Are you sure want to delete?</p>
                                </div>
                                <div class="modal-btn delete-action">
                                    <div class="row">
                                        <div class="col-6 mb-0">
                                            <a href="javascript:void(0);" class="btn btn-primary continue-btn">Delete</a>
                                        </div>
                                        <div class="col-6 mb-0">
                                            <a href="javascript:void(0);" data-dismiss="modal"
                                               class="btn btn-primary cancel-btn">Cancel</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal custom-modal fade" id="edit_project" role="dialog">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div class="form-header">
                                    <h5 class="modal-title">Edit Project</h5>
                                </div>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="row">
                                        <div class="col-sm-6 mb-0">
                                            <div class="form-group">
                                                <label>Project Name</label>
                                                <input class="form-control" value="Gold App" type="text">
                                            </div>
                                        </div>
                                        <div class="col-sm-6 mb-0">
                                            <div class="form-group">
                                                <label>Client</label>
                                                <select class="select">
                                                    <option>Client 1</option>
                                                    <option>Client 2</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="submit-section">
                                        <button class="btn btn-primary submit-btn">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- END MAIN CONTENT -->

        <!--Footer Starts-->
        <footer id="footer" class="padding_t  ">
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

        <div class="overlay"></div>

        <!-- SCRIPT -->
        <!-- APEX CHART -->

        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script>
                            var options = {
                                series: [{
                                        name: "Desktops",
                                        data: [10, 41, 35, 51, 49, 62, 69, 91, 148]
                                    }],
                                chart: {
                                    type: 'area',
                                    stacked: false,
                                    height: 350,
                                    zoom: {
                                        type: 'x',
                                        enabled: true,
                                        autoScaleYaxis: true
                                    },
                                    toolbar: {
                                        autoSelected: 'zoom'
                                    }
                                },
                                dataLabels: {
                                    enabled: false
                                },
                                markers: {
                                    size: 0,
                                },
                                title: {
                                    text: '',
                                    align: 'left'
                                },
                                colors: ['#93BFCF'],
                                fill: {
                                    type: 'gradient',
                                    gradient: {
                                        shadeIntensity: 1,
                                        inverseColors: false,
                                        opacityFrom: 0.5,
                                        opacityTo: 0,
                                        stops: [0, 90, 100]
                                    },
                                },
                                xaxis: {
                                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
                                    labels: {
                                        style: {
                                            colors: '#93BFCF',
                                            fontSize: '15px',
                                            fontFamily: 'poppins',
                                            fontWeight: 400,
                                            cssClass: 'apexcharts-xaxis-label',
                                        },
                                    },
                                },
                                yaxis: {
                                    labels: {
                                        offsetX: -16,
                                        style: {
                                            colors: '#93BFCF',
                                            fontSize: '15px',
                                            fontFamily: 'poppins',
                                            fontWeight: 400,
                                            cssClass: 'apexcharts-xaxis-label',
                                        },
                                    },
                                },
                            };

                            var chart = new ApexCharts(document.querySelector("#chart1"), options);
                            chart.render();
        </script>
        
        <script>
               var chartBar2 = function () {

            var options = {
                series: [
                    {
                        name: 'Balance',
                        data: ${requestScope.BALANCE_DATA}, //${requestScope.GET_BALENCE_DATA},
                    },

                ],
                chart: {
                    type: 'bar',
                    height: 350,

                    toolbar: {
                        show: false,
                    },

                },
                plotOptions: {
                    bar: {
                        horizontal: false,
                        columnWidth: '70%',
                        borderRadius: 10
                    },

                },
                states: {
                    hover: {
                        filter: 'none',
                    }
                },
                colors: ['#93BFCF'],
                dataLabels: {
                    enabled: false,
                },
                markers: {
                    shape: "circle",
                },


                legend: {
                    position: 'top',
                    horizontalAlign: 'right',
                    show: false,
                    fontSize: '12px',
                    labels: {
                        colors: '#000000',

                    },
                    markers: {
                        width: 18,
                        height: 18,
                        strokeWidth: 0,
                        strokeColor: '#fff',
                        fillColors: undefined,
                        radius: 12,
                    }
                },
                stroke: {
                    show: true,
                    width: 5,
                    colors: ['transparent']
                },
                grid: {
                    borderColor: '#eee',
                },
                xaxis: {

                    categories: ${requestScope.BALANCE_DATE},
                    labels: {
                        style: {
                            colors: '#93BFCF',
                            fontSize: '15px',
                            fontFamily: 'poppins',
                            fontWeight: 400,
                            cssClass: 'apexcharts-xaxis-label',
                        },
                    },
                    crosshairs: {
                        show: false,
                    }
                },
                yaxis: {
                    labels: {
                        offsetX: -16,
                        style: {
                            colors: '#93BFCF',
                            fontSize: '15px',
                            fontFamily: 'poppins',
                            fontWeight: 400,
                            cssClass: 'apexcharts-xaxis-label',
                        },
                    },
                },
                fill: {
                    opacity: 1,
                    colors: ['#F1C27B'],
                },
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return " " + val + " "
                        }
                    }
                },
                responsive: [{
                    breakpoint: 575,
                    options: {
                        chart: {
                            height: 250,
                        }
                    },
                }]
            };

            var chartBar2 = new ApexCharts(document.querySelector("#chartBar2"), options);
            chartBar2.render();
        }
        </script>
        <script src="./libs/jquery/jquery.min.js"></script>
        <script src="./libs/moment/min/moment.min.js"></script>
        <script src="./libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="./libs/peity/jquery.peity.min.js"></script>
        <script src="./libs/chart.js/Chart.bundle.min.js"></script>
        <script src="./libs/owl.carousel/owl.carousel.min.js"></script>
        <script src="./libs/bootstrap/js/bootstrap.min.js"></script>
        <script src="./libs/apexcharts/apexcharts.js"></script>
        <script src="./libs/simplebar/simplebar.min.js"></script>

        <!-- APP JS -->
        <script src="./js/admin_js/main.js"></script>
        <script src="./js/admin_js/dashboard.js?version=1"></script>
        <script src="./js/admin_js/shortcode.js"></script>
        <script src="./js/admin_js/pages/dashboard.js"></script>


    </body>

</html>