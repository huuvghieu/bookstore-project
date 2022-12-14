<%-- 
    Document   : header
    Created on : Sep 20, 2022, 3:56:09 PM
    Author     : PC
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="dto.PublisherDTO"%>
<%@page import="dto.CategoryDTO"%>
<%@page import="dto.CustomerDTO"%>
<%@page import="dto.StaffDTO"%>
<%@page import="javax.smartcardio.Card"%>
<%@page import="cart.Cart"%>
<%@page import="dto.BookDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Header</title>
        <meta charset="utf-8">
        <link rel = "icon" href ="https://cdn-icons-png.flaticon.com/512/1903/1903162.png" type = "image/x-icon">
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="CSS/bootstrap.min.css" />
        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="CSS/slick.css" />
        <link type="text/css" rel="stylesheet" href="CSS/slick-theme.css" />
        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="CSS/nouislider.min.css" />
        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="CSS/font-awesome.min.css" />
        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="CSS/stylefix.css" />
        <link rel="stylesheet" type="text/css" href="STYLES/bootstrap4/bootstrap.min.css" />
        <link href="PLUGINS/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="STYLES/main_styles.css" />
        <link rel="stylesheet" type="text/css" href="STYLES/responsive.css" />
        <style>
            #emptyList{
                font-size: 20px;
                text-align: center;
            }
        </style>
        <!-- jQuery Plugins -->
        <script src="JS/jquery.min.js"></script>
        <script src="JS/bootstrap.min.js"></script>
        <script src="JS/slick.min.js"></script>
        <script src="JS/nouislider.min.js"></script>
        <script src="JS/jquery.zoom.min.js"></script>
        <script src="JS/main.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <%            String messModal = (String) request.getAttribute("MODAL");
            if (messModal == null) {
                messModal = "";
            } else {
        %>
        <script type="text/javascript">
            $(window).on('load', function () {
                $('#exampleModal').modal('show');
            });
        </script>
        <%
            }
        %>
        <!-- Modal -->
        <div  class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Th??ng b??o</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <%= messModal%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">????ng</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <!-- Header -->
        <header style="z-index: 50;" class="header trans_300">
            <!-- Top Navigation -->
            <div class="top_nav">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="top_nav_left">
                                <ul class="header-links pull-left">
                                    <li><a href="#"><i class="fa fa-phone"></i>1900-6656</a></li>
                                    <li><a href="#"><i class="fa fa-envelope-o"></i> hotro@nspn.com</a></li>
                                    <li><a href="#"><i class="fa fa-map-marker"></i>Th??nh ph??? H??? Ch?? Minh</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6 text-right">
                            <div class="top_nav_right">
                                <ul class="top_nav_menu">
                                    <!-- Welcome / My Account -->
                                    <%
                                        StaffDTO staff = new StaffDTO();
                                        CustomerDTO cus = new CustomerDTO();
                                        try {
                                            staff = (StaffDTO) session.getAttribute("LOGIN_STAFF");
                                            cus = (CustomerDTO) session.getAttribute("LOGIN_CUS");
                                        } catch (Exception e) {
                                        }
                                        if (staff == null && cus == null) {
                                    %>
                                    <li class="currency">
                                        <a href="#">
                                            Ch??o m???ng ?????n v???i Ph????ng Nam										
                                        </a>
                                    </li>
                                    <li class="account">
                                        <a href="#">
                                            T??i kho???n
                                            <i class="fa fa-angle-down"></i>
                                        </a>
                                        <ul style="width: 120px;" class="account_selection">
                                            <li><a href="LoginController?action=Login"><i class="fa fa-sign-in" aria-hidden="true"></i>????ng nh???p</a></li>
                                            <li><a href="RegisterController?action=Register"><i class="fa fa-user-plus" aria-hidden="true"></i>????ng k??</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <%
                                    } else if (cus != null) {
                                    %>
                                    <li class="currency">
                                        <a href="#">
                                            Ch??o m???ng <%= cus.getName()%>										
                                        </a>
                                    </li>   
                                    <li class="account">
                                        <a href="#">
                                            T??i kho???n
                                            <i class="fa fa-angle-down"></i>
                                        </a>
                                        <ul style="width: 120px;"  class="account_selection">
                                            <li><a href="ViewProfileController?action=Profile"><i class="fa fa-user" aria-hidden="true"></i>T??i kho???n</a></li>
                                            <li><a href="LogoutController?cusID=<%= cus.getCustomerID()%>"><i class="fa fa-sign-out" aria-hidden="true"></i>????ng xu???t</a></li>
                                                <%
                                                } else {
                                                %>
                                            <li class="currency">
                                                <a href="LoadManageController?action=manage">
                                                    Qu???n l??										
                                                </a>
                                            </li>
                                            <li class="currency">
                                                <a href="#">
                                                    Ch??o m???ng <%= staff.getName()%>										
                                                </a>
                                            </li>
                                            <li class="account">
                                                <a href="#">
                                                    T??i kho???n
                                                    <i class="fa fa-angle-down"></i>
                                                </a>    
                                                <ul style="width: 120px;"  class="account_selection">
                                                    <li><a href="ViewProfileController?action=Profile"><i class="fa fa-user" aria-hidden="true"></i>T??i kho???n</a></li>
                                                    <li><a href="LogoutController?staffID=<%= staff.getStaffID()%>"><i class="fa fa-sign-out" aria-hidden="true"></i>????ng xu???t</a></li>
                                                        <%
                                                            }
                                                        %>
                                                </ul>
                                            </li>
                                            <!--Welcome loginUser-->
                                        </ul>
                                        </div>
                                        </div>
                                        </div>
                                        </div>
                                        </div>       
                                        <!-- Main Navigation -->
                                        <div class="main_nav_container">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-lg-12 text-right">
                                                        <div style="width: 100%; text-align: center;" class="logo_container">
                                                            <a style="font-size: 60px;" href="GetController?">Ph????ng<span style="color: #d10024;">Nam</span></a>
                                                        </div>
                                                        <nav class="navbar">
                                                            <%
                                                                float total = 0;
                                                                if (staff == null) {
                                                            %>
                                                            <!-- ACCOUNT -->
                                                            <div class="clearfix">
                                                                <div class="header-ctn">
                                                                    <!-- Cart -->
                                                                    <div class="dropdown">
                                                                        <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true" style="cursor: pointer;">
                                                                            <i class="fa fa-shopping-cart fa-3x"></i>
                                                                            <span>H??a ????n</span>

                                                                            <%
                                                                                if (session.getAttribute("SIZE") != null && (int) session.getAttribute("SIZE") > 0) {
                                                                                    int count = (int) session.getAttribute("SIZE");
                                                                            %>
                                                                            <div class="qty"><%= count%></div>
                                                                            <%
                                                                                }
                                                                            %>
                                                                        </a>
                                                                        <div class="cart-dropdown">
                                                                            <%
                                                                                try {
                                                                                    Locale localeVN = new Locale("vi", "VN");
                                                                                    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
                                                                                    Cart cart = (Cart) session.getAttribute("CART");
                                                                                    if (cart != null && cart.getCart().size() > 0) {
                                                                            %>
                                                                            <div class="cart-list">
                                                                                <%           for (BookDTO book : cart.getCart().values()) {
                                                                                        total += book.getPrice() * book.getQuantity();
                                                                                %>
                                                                                <div class="product-widget">
                                                                                    <div class="product-img">
                                                                                        <img src="<%= book.getImg()%>" alt="">
                                                                                    </div>
                                                                                    <div class="product-body">
                                                                                        <form action="LoadController" method="GET">
                                                                                            <input type="hidden" name="isbn" value="<%= book.getIsbn()%>" >
                                                                                            <h3 onclick="this.parentNode.submit();" class="product-name"> <a style="cursor: pointer;"><%= book.getName()%></a></h3>
                                                                                        </form>
                                                                                        <h4 class="product-price"><span class="qty">S??? l?????ng: <%= book.getQuantity()%> </span></h4>
                                                                                    </div>
                                                                                </div>
                                                                                <%
                                                                                    }
                                                                                %>
                                                                                <div class="cart-summary">
                                                                                    <small>${sessionScope.SELECT} s???n ph???m  </small>
                                                                                    <h5>T???ng ti???n: <%= currencyVN.format(total)%></h5>
                                                                                </div>
                                                                            </div>
                                                                            <%
                                                                            } else {
                                                                            %>
                                                                            <p id="emptyList">Tr???ng</p>
                                                                            <%       }
                                                                                if (cart == null || cart.getCart().isEmpty() || (cus == null && staff == null)) {
                                                                            %>
                                                                            <style>
                                                                                #checkout{
                                                                                    display: none;
                                                                                }
                                                                                #viewC{
                                                                                    width: 100%;
                                                                                    margin: auto;   
                                                                                }
                                                                            </style>
                                                                            <%}
                                                                                } catch (Exception e) {
                                                                                }
                                                                            %> 
                                                                            <div class="cart-btns">
                                                                                <a id="viewC" href="AddBookCartController?action=View">Xem gi??? h??ng</a>
                                                                                <a id="checkout" href="CheckoutController?action=Checkout">Thanh to??n <i class="fa fa-arrow-circle-right"></i></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!-- /Cart -->
                                                                </div> 
                                                            </div>
                                                            <!-- /ACCOUNT -->
                                                            <%
                                                            } else {
                                                            %>
                                                            <a style="text-decoration: none;" href="CreateCartController?action=Create">
                                                                <div style="text-align: center; margin-top: 20px; cursor: pointer; text-decoration: none;">
                                                                    <i style="color: #1e1e27" class="fa fa-cart-plus fa-3x" aria-hidden="true"></i>
                                                                    <p style="color: #1e1e27"><b>H??a ????n</b></p>
                                                                </div>
                                                            </a>
                                                            <%
                                                                }
                                                            %>
                                                        </nav>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </header>
                                        </body>
                                        </html>