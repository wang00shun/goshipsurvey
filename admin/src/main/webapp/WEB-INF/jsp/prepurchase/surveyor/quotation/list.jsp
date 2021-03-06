<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="go" uri="http://www.ctoangels.com/jsp/jstl/common" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    table th, td {
        text-align: center;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <div class="portlet light bordered">
            <div class="portlet-body">
                <div class="table-toolbar">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption col-md-8">
                                        <i class="icon-social-dribbble font-blue-soft"></i>
                                        <span class="caption-subject font-blue-soft bold uppercase">Available vessels</span>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <%--<div class="caption col-md-8 margin-bottom-15">--%>
                                    <%--<span class="caption-subject font-blue-soft bold uppercase">Applied</span>--%>
                                    <%--</div>--%>
                                    <div class="tab-pane fade active in" id="tab_1_1">
                                        <table class="table table-striped table-bordered table-hover table-checkable order-column"
                                               id="pre_surveyor_quotation_table">
                                            <thead>
                                            <tr>
                                                <th width="9%">Public date</th>
                                                <th width="9%">Ship name</th>
                                                <th width="9%">IMO</th>
                                                <th width="9%">Ship Type</th>
                                                <th width="9%">Inspection port</th>
                                                <th width="9%">Inspection date(LMT)</th>
                                                <th width="9%">Consignor</th>
                                                <th width="9%">Price</th>
                                                <th width="9%">Surveyor</th>
                                                <th width="9%">Apply</th>
                                                <th width="9%">More detail</th>
                                            </tr>
                                            <tbody></tbody>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<a id="goToSurveyorInfo" data-url="" style="display: none" onclick="showModelForm(this)">a</a>
<div id="modal_form" class="modal fade" role="dialog" aria-hidden="true"></div>
<a id="modal_form_switch" data-toggle="modal" href="#modal_form" style="display: none">a</a>
<script>
    function showModelForm(obj) {
        var url = $(obj).attr("data-url");
        var md = $(obj).attr("md");
        if (md == 'ajax') {
        } else {
            $("#modal_form").load(url);
            $("#modal_form_switch").click();
        }
        return false;
    }


    var quotationTable;//
    var surveyList;
    var surveyorSelectHtml;
    $(document).ready(function () {
        drawTable();
    })

    //绘制页面表格
    function drawTable() {
        quotationTable = $('#pre_surveyor_quotation_table').DataTable({
            "ordering": false,
            "pagingType": "simple_numbers",
            "processing": true,
            "autoWidth": false,
            "serverSide": true,
            'bStateSave': true,
            "ajax": {
                "url": "prepurchase/surveyor/quotation/list",
                "type": "post",
                "data": function (data) {
                    data.keyword = $("#keyword").val();
                }
            },
//            "language": {
//                "url": "https://windyeel.oss-cn-shanghai.aliyuncs.com/global/plugins/datatables/cn.txt"
//            },
            "lengthMenu": [[5, 40, 60], [5, 40, 60]],
            "columns": [
                {
                    "data": "createDate",
                    "render": function (data) {
                        return new Date(data).Format("yyyy-MM-dd");
                    }
                },
                {
                    "data": "shipDetail.shipName",
                },
                {
                    "data": "shipDetail.imo",
                },
                {
                    "data": "shipDetail.shipType",
                },
                {
                    "data": "location",
                },
                {
                    "data": "startDate",
                },
                {
                    "data": "createBy",
                },
                {
                    "data": "application.totalPrice",
                    "render": function (data) {
                        return "$" + ( data || "");
                    }
                },
                {
                    "data": "application.surveyor",
                    "render": function (data) {
                        if (data != null) {
                            return data.firstName + " " + data.lastName;
                        }
                        return "";
                    }
                },
            ],
            "columnDefs": [{
                "targets": 5,
                "render": function (data, type, row) {
                    var startDate = new Date(row.startDate).Format("yyyy-MM-dd");
                    var endDate = new Date(row.endDate).Format("yyyy-MM-dd");
                    return startDate + " to " + endDate;
                }
            }, {
                "targets": 9,
                "render": function (data, type, row) {
                    var application = row.application;
                    var quoStatus = row.publicStatus;
                    if (application != null && quoStatus != 3) {
                        var status = application.applicationStatus;
                        if (status == 0) {
                            return "<button type='button' class='btn yellow' >Applying</button>";
                        }
                        if (status == 1) {
                            return "<button type='button' class='btn green' >Success</button>";
                        }
                        if (status == 2) {
                            return "<button type='button' class='btn red' >Failure</button>";
                        }
                    }
                    if (quoStatus == 1) {
                        return "<button type='button' class='btn default' onclick='addApplication(this," + row.id + ")'>Apply</button>";
                    }
                    if (quoStatus == 2) {
                        return "<button type='button' class='btn default'>END</button>";
                    }
                    if (quoStatus == 3) {
                        return "<button type='button' class='btn default'>CANCELED</button>";
                    }
                }
            }, {
                "targets": 10,
                "class": "details-control",
                "render": function (data, type, row) {
                    return "<a href='javascript:void(0)'>VIEW</a>"
                }
            }
            ],
            "initComplete": function () {
                getSurveyor();
            }
        });

        quotationTable.on('click', 'td.details-control', function () {
            var tr = $(this).closest('tr');
            var row = quotationTable.row(tr);
            var flag = tr.attr("data-not-first");
            if (flag) {
                tr.next().toggle();
            } else {
                row.child(moreInfo(row.data())).show();
                tr.next().addClass("detail-row");
                tr.attr("data-not-first", true);
            }
        });
    }


    function getSurveyor() {
        $.ajax({
            type: "GET",
            url: "surveyor/getSurveyors",
            success: function (data) {
                surveyList = data.list;
                surveyorSelectHtml = "";
                surveyorSelectHtml += '<select  class="form-control surveyor-select">';
                surveyorSelectHtml += '<option value="0">Please choose surveyor</option>';
                $(surveyList).each(function () {
                    surveyorSelectHtml += '<option value="' + this.id + '">' + this.firstName + " " + this.lastName + '</option>';
                })
                surveyorSelectHtml += '</select>';
            }
        })
    }

    function moreInfo(data) {
        var html = '';
        var shipDetail = data.shipDetail;
        //Agency details and loiship detail
        html += '<div class="col-md-3">';
        html += '<label class="col-md-6 text-right">Ship name:</label><label class="col-md-6 text-left">' + shipDetail.shipName + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">IMO:</label><label class="col-md-6 text-left">' + shipDetail.imo + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Type:</label><label class="col-md-6 text-left">' + shipDetail.shipType + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">ex.Name:</label><label class="col-md-6 text-left">' + shipDetail.exName + '&nbsp;</label>';
        html += '<label class="col-md-6 text-right">Class:</label><label class="col-md-6 text-left">' + shipDetail.shipClass + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Flag:</label><label class="col-md-6 text-left">' + shipDetail.flag + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Build Year:</label><label class="col-md-6 text-left">' + shipDetail.buildYear + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Builder:</label><label class="col-md-6 text-left">' + shipDetail.builder + '&nbsp</label>';
        html += "</div>";
        html += '<div class="col-md-3">';
        html += '<label class="col-md-6 text-right">LOA(m):</label><label class="col-md-6 text-left">' + shipDetail.loa + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Beam(m):</label><label class="col-md-6 text-left">' + shipDetail.beam + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Dwt(ton):</label><label class="col-md-6 text-left">' + shipDetail.dwt + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Draft(m):</label><label class="col-md-6 text-left">' + shipDetail.draft + '&nbsp;</label>';
        html += '<label class="col-md-6 text-right">GT:</label><label class="col-md-6 text-left">' + shipDetail.ggt + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">LDT(ton):</label><label class="col-md-6 text-left">' + shipDetail.ldt + '&nbsp</label>';
        html += '<label class="col-md-6 text-right">Call Sign:</label><label class="col-md-6 text-left">' + shipDetail.callSign + '&nbsp</label>';
        html += "</div>";
        //Agency details and loi
        var application = data.application;
        html += '<div class="col-md-3">';
        html += '<label class="col-md-12 text-left">Agency details:</label>';
        html += '<div class="col-md-12 text-left" style="padding-left:30px; ">Cannot be show,until apply success</div>';
//        html += '<div class="col-md-12 text-left" style="padding-left:30px; ">' + data.agencyDetail + '</div>';
//        var agencyUrl = data.agencyUrl;
//        if (agencyUrl != null && agencyUrl != "") {
//            html += '<a target="_blank" style="float: left;margin-left:10px" href="' + agencyUrl + '" class="btn green">View</a>';
//        }
        html += '<label class="col-md-12 text-left margin-top-10">Loi:</label>';
        html += '<div class="col-md-12 text-left" style="padding-left:30px; ">Cannot be show,until apply success</div>';
//        var loiUrl = data.loiUrl;
//        if (loiUrl != null && loiUrl != "") {
//            html += '<a target="_blank"  style="float: left;margin-left:10px" href="' + loiUrl + '" class="btn green">View</a>';
//        }
        html += "</div>";
        html += '<div class="col-md-3">';
        html += '<label class="col-md-12 text-left">Our price & surveyor:</label>';
        if (application == null) {
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5">Price:$ </label> <div class="input-group col-md-7"> <input type="text" class="form-control price-input"> </div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">Surveyor:</label> <div class="input-group col-md-7"> ';
            html += surveyorSelectHtml;
            html += ' </div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">SurveyorCV:</label>  <a class="col-md-3" href="javascript:void(0)" onclick="goToViewSurveyor(this)"  style="padding-top: 8px; vertical-align: middle">VIEW</a></div>';
        } else {
            var surveyor = application.surveyor;
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5">Price:</label> <div class="input-group col-md-7">$  ' + application.totalPrice + '</div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">Surveyor:</label> <div style="padding-top: 8px" class="input-group col-md-7">' + surveyor.firstName + " " + surveyor.lastName + '</div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">SurveyorCV:</label>  <a class="col-md-7" onclick="showModelForm(this)"  data-url="surveyor/edit?dialog=1&id=' + surveyor.id + '" style="padding-top: 8px; vertical-align: middle">VIEW</a></div>';
        }
        html += "</div>";
        return html;
    }

    //提交申请
    function addApplication(obj, quotationId) {
        var price = "";
        var tr = $(obj).closest('tr');
        var detail = tr.next(".detail-row");
        if (detail.length == 0) {
            $(obj).tips({
                side: 1,
                msg: "Please input price and choose surveyor",
                bg: '#FF5080',
                time: 5,
            });
            return;
        }

        var priceInput = detail.find(".price-input");
        var totalPrice = priceInput.val();
        if (totalPrice == null || (totalPrice.trim() == "") || (isNaN(totalPrice)) || totalPrice < 0) {
            priceInput.tips({
                side: 1,
                msg: "Please input price",
                bg: '#FF5080',
                time: 5,
            });
            return;
        }
        var surveyorSelect = detail.find(".surveyor-select");
        var surveyId = surveyorSelect.val();
        if (surveyId == 0) {
            surveyorSelect.tips({
                side: 1,
                msg: "Please choose surveyor",
                bg: '#FF5080',
                time: 5,
            });
        }


        $.ajax({
            url: "surveyor/quotationApplication/add",
            type: "post",
            data: {quotationId: quotationId, totalPrice: totalPrice, type: 2, surveyId: surveyId},
            success: function (data) {
                if (data.success) {
                    quotationTable.draw();
                } else {
                    alert("addApplication error");
                }
            },
            error: function () {
                alert("addApplication error");
            },
        })
    }

    function goToViewSurveyor(obj) {
        var select = $(obj).parent().parent().find(".surveyor-select");
        var id = select.val();
        if (id == 0) {
            select.tips({
                side: 1,
                msg: "Please choose surveyor",
                bg: '#FF5080',
                time: 5,
            });
        } else {
            $("#goToSurveyorInfo").attr("data-url", "surveyor/edit?dialog=1&id=" + id).click();
        }
    }
</script>




