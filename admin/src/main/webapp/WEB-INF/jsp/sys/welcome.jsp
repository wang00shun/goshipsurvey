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
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
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
    <title>GOSHIPSURVEY</title>

    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="keywords" content="">
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
    <%--<link rel="stylesheet" href="${global}/unify/assets/css/headers/header-v4.css">--%>
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
        .header, .breadcrumbs {
            background-color: #f3f2f1;
        }

        #quotation-form label {
            color: black;
        }

        .help-block {
            margin-top: 0;
            margin-bottom: 0;
            padding-top: 10px;
        }

        label.required::after {
            content: " *";
            color: red;
        }

        .checkbox-inline + .checkbox-inline, .radio-inline + .radio-inline {
            margin-top: 0;
            margin-left: 0;
        }

        .checkbox-inline, .radio-inline {
            margin-right: 10px
        }

        #quotation-form {
            width: 100%;
            margin: 0 auto;
            padding: 15px 10px;
        }

        .quotation, .login, .welcome {
            background: white;
            background-clip: content-box;
            padding: 5px;
        }

        .login .content, .welcome .content {
            padding: 15px 10px;
        }

        .reg-block-header h2 {
            text-align: center;
            margin-bottom: 15px;
        }

        .reg-block-header h2 {
            font-size: 28px;
        }

        .reg-block .input-group-addon {
            color: #bbb;
            background: none;
            min-width: 40px;
        }


        @media screen and (max-width: 768px) {
            .breadcrumbs {
                display: none;
            }

            .header .logo{
                font-size: 10px !important;
            }
        }

    </style>
</head>

<body>

<div class="wrapper page-option-v1">
    <!--=== Header ===-->
    <jsp:include page="../include/header.jsp"/>
    <!--=== End Header ===-->

    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left">Best Shipping Service Through Internet</h1>
            <ul class="pull-right breadcrumb">
                <li><a href="/" class="active">Home</a></li>
            </ul>
        </div>
    </div>
    <!--/breadcrumbs-->

    <!--=== Service Block ===-->
    <div class="container-fluid content-sm box-shadow" style="background-color: #264071;padding: 20px 15px">

        <div class="quotation col-md-8">
            <form class="form-horizontal" id="quotation-form" method="post" action="emailQuotation/addEmailQuotation"
                  role="form">
                <h1 style="margin-bottom: 20px;font-size: 35px; text-align: center;">In
                    Need Of A
                    Survey?</h1>
                <div class="form-group">
                    <label class="control-label col-md-3 required" for="shipName" style="font-weight: 100;">Enter ship
                        name</label>
                    <div class="col-md-6">
                        <input class="form-control " name="shipName" id="shipName"/>
                    </div>
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 required" for="imo" style="font-weight: 100;">Enter IMO
                        number</label>
                    <div class="col-md-6">
                        <input class="form-control" name="imo" id="imo"/>
                    </div>
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 required" style="font-weight: 100;">Select
                        inspection type</label>
                    <div class="col-md-6">
                        <c:forEach items="${emailQuotationTypeDict}" var="dict">
                            <label class="checkbox-inline"><input type="checkbox" name="inspectionType"
                                                                  value="${dict.value}"/>${dict.des}</label>
                        </c:forEach>
                    </div>
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 required" for="port" style="font-weight: 100;">Enter
                        port</label>
                    <div class="col-md-6">
                        <input class="form-control" name="port" id="port" value="${param.port}"/>
                    </div>
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 required" style="font-weight: 100;">Select date range</label>
                    <div class="input-group input-large date-picker input-daterange col-md-6"
                         data-date-format="mm/dd/yyyy" style="padding: 0 15px;float: left;">
                        <input type="text" class="form-control" name="startDate" id="startDate" autocomplete="false" readonly>
                        <span class="input-group-addon"> to </span>
                        <input type="text" class="form-control" name="endDate" id="endDate" autocomplete="false" readonly>
                    </div>
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 required" for="email" style="font-weight: 100;">Enter your
                        email</label>
                    <div class="col-md-6">
                        <input class="form-control" name="email" id="email"/>
                    </div>
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3 required" style="font-weight: 100;">Select your role</label>
                    <div class="col-md-6 ">
                        <label class="radio-inline">
                            <input type="radio" name="role" value="Charterers"> Charterers
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="role" value="Owners"> Owners
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="role" value="Buyers"> Buyers
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="role" value="Others" id="roleOther"> Others <input
                                onkeyup="changeRoleOther(this)"
                                placeholder=" Please specify" style="line-height: normal">
                        </label>
                    </div>
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3" for="specialRequirement" style="font-weight: 100;">Special
                        Requirement&nbsp;(If any)</label>
                    <div class="col-md-6">
                        <textarea class="form-control" name="specialRequirement" id="specialRequirement"
                                  style="resize: vertical"></textarea>
                    </div>
                    <span class="help-block"></span>
                </div>
                <button class="btn" data-loading-text="Loading..." id="submitBtn"
                        style="background-color: #264071;color: white;display: block;margin: 0 auto;width: 150px;">GET
                    QUOTATION
                </button>
            </form>

        </div>
        <div class="login col-md-4" style="display: <c:if test="${!empty sessionScope.sessionUser}">none</c:if>">
            <div class="content">
                <div class="reg-block">
                    <div class="reg-block-header">
                        <h2>Sign In</h2>
                        <%--<p>Don't Have Account? Click <a class="color-green" href="page_registration1.html">Sign Up</a>--%>
                        <%--to registration.</p>--%>
                    </div>

                    <div class="input-group margin-bottom-20">
                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                        <input type="text" class="form-control" placeholder="Username" id="loginName">
                    </div>
                    <div class="input-group margin-bottom-20">
                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                        <input type="text" class="form-control" placeholder="Password" id="password">
                    </div>

                    <div class="input-group margin-bottom-20">
                        <input class="form-control" placeholder="VerifyCode" type="text"
                               id="code" name="code" style="width: 40%; float: left;">
                        <img id="codeImg" alt="Click to change"
                             title="Click to change"
                             style="width: 40%; height: 34px; margin-left: 12px;" src="">
                    </div>

                    <div class="row">
                        <div class="col-md-10 col-md-offset-1">
                            <button class="btn-u btn-block" type="button" onclick="severCheck()" id="loginBtn"
                                    data-loading="Log in....">Log In
                            </button>
                        </div>
                    </div>
                </div>
            </div><!--/container-->
        </div>
        <div class="welcome col-md-4" <%--style="display: <c:if test="${empty sessionScope.sessionUser}">none</c:if>"--%>>
            <div class="content">
                <div class="headline"><h2>Welcome To GoShipSurvey</h2></div>
                <div class="row">
                    <div class="col-sm-6">
                        <img class="img-responsive margin-bottom-20"
                             src="${global}/icon/icon.ico" alt="">
                    </div>
                    <div class="col-sm-6">
                        <p>Our Advantages.</p>
                        <ul class="list-unstyled margin-bottom-20">
                            <li><i class="fa fa-check color-green"></i> Fast</li>
                            <li><i class="fa fa-check color-green"></i> Convenient</li>
                            <li><i class="fa fa-check color-green"></i> Efficient</li>
                        </ul>
                    </div>
                </div>
            </div><!--/container-->
        </div>
        <div class="clearfix"></div>
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
<script type="text/javascript"
        src="${global}/unify/assets/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript"
        src="${global}/metronic/global/plugins/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
        src="${global}/unify/assets/js/plugins/jquery.validate.min.js"></script>
<script type="text/javascript"
        src="${global}/unify/assets/plugins/jquery/jquery-migrate.min.js"></script>
<script type="text/javascript"
        src="${global}/unify/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
        src="${global}/metronic/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script src="${global}/unify/assets/js/plugins/jquery.form.min.js"></script>
<script src="/static/js/jquery.tips.js"></script>
<%--<script src="/static/js/jquery.cookie.js"></script>--%>
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
<script type="text/javascript">
    $(document).ready(function () {
        changeCode();
    })

    if (jQuery().datepicker) {
        $('.date-picker').datepicker({
            startDate: new Date(),
            orientation: "left",
            autoclose: true,
            todayBtn: 'linked',
            format: 'yyyy-mm-dd',
        });
    }

    $('#quotation-form').validate({
        errorElement: 'span',
        //				onfocusout: function(element) {
        //					$(element).valid();
        //				},
        focusInvalid: true,
        rules: {
            shipName: {
                required: true,
            },
            imo: {
                required: true,
            },
            inspectionType: {
                required: true,
            },
            port: {
                required: true,
            },
            startDate: {
                required: true,
            },
            email: {
                required: true,
                email: true
            },
            role: {
                required: true
            }
        },
        messages: {
            shipName: {
                required: "Ship name is required",
            },
            imo: {
                required: "IMO number is required",
            },
            inspectionType: {
                required: "Inspection type is required",
            },
            port: {
                required: "Port is required",
            },
            startDate: {
                required: "Start date is required",
            },
            email: {
                required: "Email is required",
                email: "Incorrect email format",
            },
            role: {
                required: "Role is required",
            },
        },

        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error');
        },

        success: function (label) {
            console.log(label);
            label.closest('.form-group').removeClass('has-error');
            //label.parents('.form-group').find('.help-block').html('<span style="color:green">ok</span>');
            label.parents('.form-group').find('.help-block').html('');
        },

        errorPlacement: function (error, element) {
            element.parents('.form-group').find('.help-block').html(error);
        },
        submitHandler: function (form) {
            $("#submitBtn").button("loading");
            $(form).ajaxSubmit({
                success: function (data) {
                    if (data.success) {
                        window.location.href = "emailQuotation/detail";
                    } else {
                        console.log("failure");
                        $("#submitBtn").button("reset");
                    }
                },
                error: function (data) {
                    console.log("error");
                    $("#submitBtn").button("reset");
                }
            });
        }
    });


    $("#shipName,#imo").autocomplete({
        minChars: 0,
        width: 310,
        autoFill: false,
        source: function (request, response) {
            $.ajax({
                type: "post",
                url: "publicShip/searchListByColumn",
                dataType: "json",
                data: {
                    keyword: request.term,
                    columns: ["name", "imo"]
                },
                success: function (data) {
                    response($.map(data.list, function (item) {
                        return { //lable为下拉列表显示数据源。value为选中放入到文本框的值，这种方式可以自定义显示
                            label: item.name + " / " + item.imo + " / " + item.shipType,
                            imo: item.imo,
                            shipName: item.name,
                        }
                    }));
                }
            });
        },
        select: function (event, ui) {
            event.preventDefault();
            $("#shipName").val(ui.item.shipName);
            $("#imo").val(ui.item.imo);
        }
    });

    $("#port").autocomplete({
        minChars: 0,
        width: 310,
        autoFill: false,
        source: function (request, response) {
            $.ajax({
                url: 'https://sjtu.goshipyard.com/port/list',
                type: "post",
                data: {
                    sqlWhere: "port_en like '%" + request.term + "%' and del_flag = 0",
                },
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                async: false,
                success: function (data) {
                    response($.map(data.data, function (item) {
                        return { //label为下拉列表显示数据源。value为选中放入到文本框的值，这种方式可以自定义显示
                            label: item.portEn + " / " + item.countryCode,
                        }
                    }));
                }
            });
        }
    });

    function changeRoleOther(obj) {
        $('#roleOther').val($(obj).val());
    }

    function genTimestamp() {
        var time = new Date();
        return time.getTime();
    }

    function changeCode() {
        $("#codeImg").attr("src", "code?t=" + genTimestamp());
    }

    function severCheck() {
        $("#loginBtn").button("loading");
        if (check()) {
            var loginName = $("#loginName").val();
            var password = $("#password").val();
            var code = "ksbadmtn1f2izwqy" + loginName + ",00," + password
                    + "ipvb5cxat0zn9eg7" + ",00," + $("#code").val();
            $.ajax({
                type: "POST",
                url: 'login_login',
                data: {
                    keyData: code,
                    tm: new Date().getTime()
                },
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if ("success" == data.result) {
//                        $.cookie('isLogin', 1);
//                        saveCookie();
                        // var proType = $("#proType").val();
//                        var proType = $('#system-select-div label.active').attr('data-sys');
                        window.location.href = "onoffindexindex";
//                        if (proType == 1) {
//                            window.location.href = "onoffindex";
//                        }
//                        else if (proType == 2) {
//                            window.location.href = "";
//                        } else {
//                            window.location.href = "";
//                        }
                    } else if ("user error" == data.result) {
                        $("#loginName").tips({
                            side: 3,
                            msg: "Incorrect Username or Password",
                            bg: '#FF5080',
                            time: 15
                        });
                        $("#loginName").focus();
                    } else if ("code error" == data.result) {
                        $("#code").tips({
                            side: 3,
                            msg: "Incorrect Verify Code",
                            bg: '#FF5080',
                            time: 15
                        });
                        changeCode();
                        $("#code").focus();
                    } else {
                        $("#loginName").tips({
                            side: 3,
                            msg: "Lack of Parameter",
                            bg: '#FF5080',
                            time: 15
                        });
                        $("#loginName").focus();
                    }
                }
            });
        }
        $("#loginBtn").button("reset");
    }

    function check() {
        if ($("#loginName").val() == "") {

            $("#loginName").tips({
                side: 3,
                msg: "Username can't be empty",
                bg: '#AE81FF',
                time: 3
            });
            $("#loginName").focus();
            return false;
        } else {
            $("#loginName").val(jQuery.trim($('#loginName').val()));
        }
        if ($("#password").val() == "") {

            $("#password").tips({
                side: 3,
                msg: "Password can't be empty",
                bg: '#AE81FF',
                time: 3
            });
            $("#password").focus();
            return false;
        }
        if ($("#code").val() == "") {
            $("#code").tips({
                side: 3,
                msg: "Verifycode can't be empty",
                bg: '#AE81FF',
                time: 3
            });
            $("#code").focus();
            return false;
        }
        return true;
    }
</script>
<!--[if lt IE 9]>
<script src="${global}/unify/assets/plugins/respond.js"></script>
<script src="${global}/unify/assets/plugins/html5shiv.js"></script>
<script src="${global}/unify/assets/plugins/placeholder-IE-fixes.js"></script>
<![endif]-->

</body>

</html>