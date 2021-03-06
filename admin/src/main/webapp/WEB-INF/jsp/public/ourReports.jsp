<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="go" uri="http://www.ctoangels.com/jsp/jstl/common" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="global" value="https://shipinfo.oss-cn-shanghai.aliyuncs.com"/>
<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<head>
    <title>Reports</title>

    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Favicon -->
    <link rel="shortcut icon" href="${global}/icon/icon.ico">

    <!-- Web Fonts -->
    <%--<link rel='stylesheet' type='text/css'--%>
          <%--href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600&subset=cyrillic,latin'>--%>

    <!-- CSS Global Compulsory -->
    <link rel="stylesheet"
          href="${global}/unify/assets/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${global}/unify/assets/css/style.css">

    <!-- CSS Header and Footer -->
    <link rel="stylesheet"
          href="${global}/unify/assets/css/headers/header-default.css">
    <link rel="stylesheet" href="${global}/unify/assets/css/footers/footer-v1.css">

    <!-- CSS Jquery UI -->
    <link rel="stylesheet"
          href="${global}/metronic/global/plugins/jquery-ui/jquery-ui.min.css">

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

    </style>
</head>

<body>

<div class="wrapper page-option-v1">
    <!--=== Header ===-->
    <jsp:include page="../include/header.jsp"/>
    <!--=== End Header ===-->

    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left">Our Reports</h1>
            <ul class="pull-right breadcrumb">
                <li><a href="/">Home</a></li>
                <li class="active"><a href="/public/ourReports">Our Reports</a></li>
            </ul>
        </div>
    </div>
    <!--/breadcrumbs-->
    <!--=== Service Block ===-->
    <div class="container-fluid content-sm box-shadow" style="background-color: #264071;">
        <!--=== Content Part ===-->
        <div class="container content">
            <div class="row portfolio-item ">
                <!--Condition Survey -->
                <div class="col-md-6">
                    <div class="carousel slide carousel-v1" id="condition-survey">
                        <div class="carousel-inner">
                            <div class="item active">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/ConditionSurvey/0.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Condition Survey</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/ConditionSurvey/1.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Condition Survey</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/ConditionSurvey/2.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Condition Survey</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/ConditionSurvey/3.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Condition Survey</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-arrow">
                            <a data-slide="prev" href="portfolio_old_item.html#condition-survey"
                               class="left carousel-control">
                                <i class="fa fa-angle-left"></i>
                            </a>
                            <a data-slide="next" href="portfolio_old_item.html#condition-survey"
                               class="right carousel-control">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </div>
                    </div>
                    <h3 style="text-align: center" class="color-light">Condition Survey
                        <a href="${global}/downloadCenter/SampleReports/ConditionSurvey.pdf"
                           target="_blank">Download sample</a></h3>
                </div>
                <!-- End Condition Survey -->

                <!--On Hire -->
                <div class="col-md-6">
                    <div class="carousel slide carousel-v1" id="on-hire">
                        <div class="carousel-inner">
                            <div class="item active">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OnHire/0.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>On Hire</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OnHire/1.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>On Hire</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OnHire/2.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>On Hire</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OnHire/3.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>On Hire</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-arrow">
                            <a data-slide="prev" href="portfolio_old_item.html#on-hire"
                               class="left carousel-control">
                                <i class="fa fa-angle-left"></i>
                            </a>
                            <a data-slide="next" href="portfolio_old_item.html#on-hire"
                               class="right carousel-control">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </div>
                    </div>
                    <h3 style="text-align: center" class="color-light">On Hire
                        <a href="${global}/downloadCenter/SampleReports/OnHire.pdf"
                           target="_blank">Download sample</a></h3>
                </div>
                <!-- End On Hire -->

                <!--Off Hire -->
                <div class="col-md-6">
                    <div class="carousel slide carousel-v1" id="off-hire">
                        <div class="carousel-inner">
                            <div class="item active">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OffHire/0.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Off Hire</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OffHire/1.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Off Hire</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OffHire/2.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Off Hire</p>
                                </div>
                            </div>
                            <div class="item">
                                <img alt=""
                                     src="${global}/downloadCenter/samplereportimg/OffHire/3.jpg?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071">
                                <div class="carousel-caption">
                                    <p>Off Hire</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-arrow">
                            <a data-slide="prev" href="portfolio_old_item.html#off-hire"
                               class="left carousel-control">
                                <i class="fa fa-angle-left"></i>
                            </a>
                            <a data-slide="next" href="portfolio_old_item.html#off-hire"
                               class="right carousel-control">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </div>
                    </div>
                    <h3 style="text-align: center" class="color-light">Off Hire
                        <a href="${global}/downloadCenter/SampleReports/OffHire.pdf"
                           target="_blank">Download sample</a></h3>
                </div>
                <!-- End Off Hire -->
                <!--wait for more samples-->
                <div class="col-md-6">
                    <img class="wow zoomInLeft img-responsive"
                         src="${global}/downloadCenter/samplereportimg/moresamples.png?x-oss-process=image/resize,m_pad,h_400,w_600,color_264071"
                         alt="" style="visibility: visible; animation-name: zoomInLeft;">
                    <span class="wow zoomInLeft"
                          style="display:block;width:100%;position: absolute;margin-left: -15px;top:65px;text-align: center;font-size: 30px;color:white;visibility: visible; animation-name: zoomInLeft;">
                        More samples coming soon!</span>
                </div>

            </div><!--/row-->
            <div class="clearfix"></div>

        </div><!--/container-->
        <!--=== End Content Part ===-->
        <!--/row-->
    </div>
    <!--/container-->
    <!--=== End Service Block ===-->

    <!--=== Footer Version 1 ===-->
    <jsp:include page="../include/footer.jsp"/>
    <!--=== End Footer Version 1 ===-->
</div>
<!--/wrapper-->

<!-- JS Global Compulsory -->
<script src="${global}/unify/assets/plugins/jquery/jquery.min.js"></script>
<script src="${global}/metronic/global/plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="${global}/unify/assets/js/plugins/jquery.validate.min.js"></script>
<script src="${global}/unify/assets/plugins/jquery/jquery-migrate.min.js"></script>
<script src="${global}/unify/assets/plugins/bootstrap/js/bootstrap.min.js"></script>

<!--<script  src="${global}/metronic/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>-->
<!--<script  src="${global}/unify/assets/plugins/back-to-top.js"></script>-->
<!--<script src="${global}/unify/assets/plugins/smoothScroll.js"></script>-->
<!--<script src="${global}/unify/assets/plugins/jquery.parallax.js"></script>-->
<!--<script src="${global}/unify/assets/plugins/fancybox/source/jquery.fancybox.pack.js"></script>-->
<!--<script src="${global}/unify/assets/plugins/owl-carousel/owl-carousel/owl.carousel.js"></script>-->
<!--<script src="${global}/unify/assets/plugins/revolution-slider/rs-plugin/js/jquery.themepunch.tools.min.js"></script>-->
<!--<script src="${global}/unify/assets/plugins/revolution-slider/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>-->
<!--<script src="${global}/unify/assets/js/custom.js"></script>-->
<!--<script src="${global}/unify/assets/js/app.js"></script>-->
<!--<script src="${global}/unify/assets/js/plugins/fancy-box.js"></script>-->
<!--<script src="${global}/unify/assets/js/plugins/owl-carousel.js"></script>-->
<!--<script src="${global}/unify/assets/js/plugins/revolution-slider.js"></script>-->
<!--<script src="${global}/unify/assets/js/plugins/style-switcher.js"></script>-->
<script src="${global}/unify/assets/plugins/wow-animations/js/wow.min.js"></script>
<!--[if lt IE 9]>
<script src="${global}/unify/assets/plugins/respond.js"></script>
<script src="${global}/unify/assets/plugins/html5shiv.js"></script>
<script src="${global}/unify/assets/plugins/placeholder-IE-fixes.js"></script>
<![endif]-->
<script type="text/javascript">
    jQuery(document).ready(function () {
        new WOW().init();
    });
</script>
</body>

</html>