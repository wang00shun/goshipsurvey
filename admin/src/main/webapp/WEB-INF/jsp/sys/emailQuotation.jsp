<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="go" uri="http://www.ctoangels.com/jsp/jstl/common" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="global" value="https://shipinfo.oss-cn-shanghai.aliyuncs.com"/>
<c:set value="${sessionScope.emailQuotation}" var="quotation"/>
<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<head>
    <title>Quotation</title>

    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Favicon -->
    <link rel="shortcut icon" href="${global}/icon/icon.ico">

    <!-- Web Fonts -->
    <%--<link rel='stylesheet' type='text/css'--%>
    <%--href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600&subset=cyrillic,latin'>--%>

    <!-- CSS Global Compulsory -->
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${global}/unify/assets/css/style.css">

    <!-- CSS Header and Footer -->
    <link rel="stylesheet"
          href="${global}/unify/assets/css/headers/header-default.css">
    <link rel="stylesheet" href="${global}/unify/assets/css/footers/footer-v1.css">

    <!-- CSS Implementing Plugins -->
    <link rel="stylesheet" href="${global}/unify/assets/plugins/animate.css">
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/line-icons/line-icons.css">
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/fancybox/source/jquery.fancybox.css">
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/owl-carousel/owl-carousel/owl.carousel.css">
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/revolution-slider/rs-plugin/css/settings.css"
          type="text/css" media="screen">
    <!--[if lt IE 9]>
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/revolution-slider/rs-plugin/css/settings-ie8.css"
          type="text/css" media="screen"><![endif]-->

    <!-- CSS Theme -->
    <link rel="stylesheet" href="${global}/unify/assets/css/theme-colors/default.css"
          id="style_color">
    <link rel="stylesheet" href="${global}/unify/assets/css/theme-skins/dark.css">

    <!-- CSS Customization -->
    <link rel="stylesheet" href="${global}/unify/assets/css/custom.css">

    <style>
        .header {
            background-color: #f3f2f1;
        }

        .header .topbar ul.loginbar > li > a {
            color: #eee;
        }

        .header .topbar ul.loginbar > li > a:hover {
            color: black;
        }

        .header .navbar-nav > li > a {
            color: #eee;
        }

        ul.nav li a {
            color: white;
            text-decoration: underline;
        }

        ul.navbar-nav > li > a:hover,
        ul.navbar-nav > .active > a {
            color: #264071;
            background-color: white;
        }

        .big-first-letter:first-letter {
            font-size: 50px;
        }

        #quotation-form {
            background-color: white;
            width: 80%;
            margin: 0 auto;
            padding: 15px 10px;
        }

        #quotation-form label {
            color: black;
        }

        .header .logo {
            height: auto;
        }

        .header .logo img {
            margin: 0;
        }

        .form-group {
            margin-bottom: 5px;
        }
    </style>
</head>

<body>
<div class="wrapper page-option-v1">
    <!--=== Header ===-->
    <div class="header">
        <div class="container" style="margin-bottom: 0;">
            <!-- Logo -->
            <a class="logo" href="/">
                <img src="${global}/icon/banner.png" style="height: 70px;"
                     alt="Logo">
            </a>
            <!-- End Logo -->

            <h1 style="color:#0004fd;margin:0;font-size:60px;line-height: 1;">GOSHIPSURVEY</h1>

            <!-- Toggle get grouped for better mobile display -->
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target=".navbar-responsive-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="fa fa-bars"></span>
            </button>
            <!-- End Toggle -->

        </div>

        <!--/end container-->
    </div>
    <!--=== End Header ===-->

    <!--=== Service Block ===-->
    <div class="container-fluid content-sm box-shadow" style="background-color: #264071;">
        <div class="collapse navbar-collapse mega-menu navbar-responsive-collapse">
            <div class="container">
                <ul class="nav navbar-nav" style="margin-top: -60px;float: right;color: white;">
                    <li>
                        <a href="/">
                            Home
                        </a>
                    </li>
                    <%--<li>--%>
                    <%--<a href="/">--%>
                    <%--Quotation--%>
                    <%--</a>--%>
                    <%--</li>--%>
                    <li>
                        <a href="/static/html/reports.html">
                            Our reports
                        </a>
                    </li>
                    <li>
                        <a href="/static/html/surveyors.html">
                            Our surveyors
                        </a>
                    </li>
                    <li>
                        <a href="/static/html/about_us.html">
                            About us
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div style="width: 80%;margin: -30px auto 10px;padding: 0; color: white;">
            <h1 style="color: white;font-size: 50px">Your quotation</h1>
            <h3 style="color: white;font-size: 25px">We are calculating for you, and price will be sent to your email
                within <span style="font-size: 50px;font-style: italic;color: greenyellow;font-weight: 700;">24 </span>
                hours.Please note and check your email.</h3>
        </div>

        <div class="row">
            <form class="form-horizontal" id="quotation-form" role="form" style="font-size: 25px;">
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">Ship's name:</label>
                    <label class="control-label col-md-7"
                           style="text-align: left;font-style: italic;">${quotation.shipName}</label>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">IMO:</label>
                    <label class="control-label col-md-7"
                           style="text-align: left;font-style: italic;">${quotation.imo}</label>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">Port:</label>
                    <label class="control-label col-md-7"
                           style="text-align: left;font-style: italic;">${quotation.port}</label>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">Estimated Date:</label>
                    <label class="control-label col-md-7" style="text-align: left;font-style: italic;">
                        <fmt:formatDate value="${quotation.estimatedDate}" pattern="yyyy-MM-dd"/>
                    </label>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">Inspection type:</label>
                    <label class="control-label col-md-7"
                           style="text-align: left;font-style: italic;">${quotation.inspectionType}</label>
                </div>
                <c:if test="${!empty quotation.delivery}">
                    <div class="form-group">
                        <label class="control-label col-md-5" style="font-weight: 100;">Place of delivery:</label>
                        <label class="control-label col-md-7"
                               style="text-align: left;font-style: italic;">${quotation.delivery}</label>
                    </div>
                </c:if>
                <c:if test="${!empty quotation.reDelivery}">
                    <div class="form-group">
                        <label class="control-label col-md-5" style="font-weight: 100;">Place of re-delivery:</label>
                        <label class="control-label col-md-7"
                               style="text-align: left;font-style: italic;">${quotation.reDelivery}</label>
                    </div>
                </c:if>
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">Your email:</label>
                    <label class="control-label col-md-7"
                           style="text-align: left;font-style: italic;">${quotation.email}</label>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">Your role:</label>
                    <label class="control-label col-md-7"
                           style="text-align: left;font-style: italic;">${quotation.role}</label>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-5" style="font-weight: 100;">Special Requirement:</label>
                    <label class="control-label col-md-7"
                           style="white-space: pre-wrap;word-wrap: break-word;text-align: left;font-style: italic;">${quotation.specialRequirement}</label>
                </div>
                <a class="btn" href="/"
                   style="background-color: #264071;color: white;display: block;margin: 0 auto;width: 150px;"> &lt; Back
                </a>
            </form>
        </div>
        <!--/row-->
    </div>
    <!--/container-->
    <!--=== End Service Block ===-->
    <div class="row margin-bottom-15" style="background-color: white;text-align: center">
        <h1 style="text-align: center;color: black">Please register to enjoy the best service</h1>
        <a class="btn-u btn-u-blue" href="/"
           style="color: white;margin-right:20px;width: 150px; "> Register
        </a>
        <a class="btn-u" href="/login_toLogin"
           style="color: white;margin-left:20px;width: 150px;"> Login
        </a>
    </div>
    <!--=== Footer Version 1 ===-->
    <div class="footer-v1">
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-12" style="text-align: center;">
                        <p>Aoyang TC Email:
                            <a href="mailto:service@goshipyard.com" style="color:#3598DC;" class="">service@goshipgroup.com</a>
                        <p>
                        <p>Copyright &copy; 2016 - 2017 goshipyard.All Rights Reserved.</p>
                    </div>
                </div>
            </div>
        </div>
        <!--/copyright-->
    </div>
    <!--=== End Footer Version 1 ===-->
</div>
<!--/wrapper-->

<!-- JS Global Compulsory -->
<script type="text/javascript"
        src="${global}/unify/assets/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript"
        src="${global}/unify/assets/js/plugins/jquery.validate.min.js"></script>
<script type="text/javascript"
        src="${global}/unify/assets/plugins/jquery/jquery-migrate.min.js"></script>
<script type="text/javascript"
        src="${global}/unify/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<!--<script type="text/javascript" src="${global}/unify/assets/plugins/back-to-top.js"></script>-->
<!--<script type="text/javascript" src="${global}/unify/assets/plugins/smoothScroll.js"></script>
<script type="text/javascript" src="${global}/unify/assets/plugins/jquery.parallax.js"></script>
<script type="text/javascript" src="${global}/unify/assets/plugins/fancybox/source/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="${global}/unify/assets/plugins/owl-carousel/owl-carousel/owl.carousel.js"></script>
<script type="text/javascript" src="${global}/unify/assets/plugins/revolution-slider/rs-plugin/js/jquery.themepunch.tools.min.js"></script>
<script type="text/javascript" src="${global}/unify/assets/plugins/revolution-slider/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
<script type="text/javascript" src="${global}/unify/assets/js/custom.js"></script>
<script type="text/javascript" src="${global}/unify/assets/js/app.js"></script>
<script type="text/javascript" src="${global}/unify/assets/js/plugins/fancy-box.js"></script>
<script type="text/javascript" src="${global}/unify/assets/js/plugins/owl-carousel.js"></script>
<script type="text/javascript" src="${global}/unify/assets/js/plugins/revolution-slider.js"></script>
<script type="text/javascript" src="${global}/unify/assets/js/plugins/style-switcher.js"></script>-->

<!--[if lt IE 9]>
<script src="${global}/unify/assets/plugins/respond.js"></script>
<script src="${global}/unify/assets/plugins/html5shiv.js"></script>
<script src="${global}/unify/assets/plugins/placeholder-IE-fixes.js"></script>
<![endif]-->

</body>

</html>