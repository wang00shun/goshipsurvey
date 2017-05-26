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
                                    <div class="caption col-md-8 margin-bottom-15">
                                        <span class="caption-subject font-blue-soft bold uppercase">Applied</span>
                                    </div>
                                    <div class="tab-pane fade active in" id="tab_1_1">
                                        <table class="table table-striped table-bordered table-hover table-checkable order-column"
                                               id="quotation_table">
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
<a id="goToSurveyorInfo" style="display: none" data-target="navTab"></a>
<script>
    var quotationTable = $("#quotation_table");//已申请的quotation表格
    var surveyList;
    var surveyorSelectHtml;
    $(document).ready(function () {
        drawTable();
    })

    //绘制页面表格
    function drawTable() {
        quotationTable = $('#quotation_table').DataTable({
            "ordering": false,
            "pagingType": "simple_numbers",
            "processing": true,
            "autoWidth": false,
            "serverSide": true,
            "ajax": {
                "url": "prepurchase/surveyor/quotation/list",
                "type": "post",
                "data": function (data) {
                    data.keyword = $("#keyword").val();
                }
            },
//            "language": {
//                "url": "http://windyeel.oss-cn-shanghai.aliyuncs.com/global/plugins/datatables/cn.txt"
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
                },
                {
                    "data": "application.surveyor.lastName"
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
                    if (application == null) {
                        return "<button type='button' class='btn default' onclick='addApplication(this," + row.id + ")'>Apply</button>";
                    }
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
                    return "";
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
                surveyorSelectHtml += '<option value="0">请选择验船师</option>';
                $(surveyList).each(function () {
                    surveyorSelectHtml += '<option value="' + this.id + '">' + this.lastName + '</option>';
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
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5">Price:</label> <div class="input-group col-md-7"> <input type="text" class="form-control price-input"> </div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">Surveyor:</label> <div class="input-group col-md-7"> ';
            html += surveyorSelectHtml;
            html += ' </div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">SurveyorCV:</label>  <a class="col-md-3" href="javascript:void(0)" onclick="goToViewSurveyor(this)"  style="padding-top: 8px; vertical-align: middle">VIEW</a></div>';
        } else {
            var surveyor = application.surveyor;
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5">Price:</label> <div class="input-group col-md-7"> ' + application.totalPrice + '</div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">Surveyor:</label> <div class="input-group col-md-7">' + surveyor.lastName + '</div></div>';
            html += '<div class="col-md-12 form-group form-md-line-input "><label class="control-label col-md-5 " style="padding-top: 5px">SurveyorCV:</label>  <a class="col-md-7" data-target="navTab" href="surveyor/info?id=' + surveyor.id + '" style="padding-top: 8px; vertical-align: middle">VIEW</a></div>';
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
                msg: "请输入正确的金额和验船师",
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
                msg: "请输入正确的金额",
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
                msg: "请选择验船师",
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
                msg: "请选择验船师",
                bg: '#FF5080',
                time: 5,
            });
        } else {
            $("#goToSurveyorInfo").attr("href", "surveyor/info?id=" + id).click();
        }
    }
</script>



