<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tab-pane fade" id="step3">
    <div class="row">
        <div class="col-md-2">
            <div class="portlet light portlet-fit">
                <div class="portlet-body">
                    <div class="timeline">
                        <div class="timeline-item">
                            <div class="timeline-badge">
                                <div class="timeline-icon selected">
                                    <div class="timeline-content">ship details</div>
                                </div>
                            </div>
                            <div class="margin-bottom-40"></div>
                            <div class="timeline-badge">
                                <div class="timeline-icon selected">
                                    <div class="timeline-content">data & location</div>
                                </div>
                            </div>
                            <div class="margin-bottom-40"></div>
                            <div class="timeline-badge">
                                <div class="timeline-icon selected">
                                    <div class="timeline-content">agency</div>
                                </div>
                            </div>
                            <div class="margin-bottom-40"></div>
                            <div class="timeline-badge">
                                <div class="timeline-icon">
                                    <div class="timeline-content">public</div>
                                </div>
                            </div>
                            <div class="margin-bottom-40"></div>
                            <div class="timeline-badge">
                                <div class="timeline-icon">
                                    <div class="timeline-content">price choose</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-10">
            <div class="portlet box green quotation-content">
                <div class="portlet-title">
                    <div class="caption">
                        Agency & LOI
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-body">
                        <div class="row">
                            <div class=" col-md-6">
                                <label class="col-md-12" style="color: #888">Agency details</label>
                                <textarea class="form-control" name="agencyDetail"
                                          style="height:200px;resize: none;"></textarea>
                                <div style="margin-top: 5px">
                                    <button type="button" id="agencyBtn"
                                            class="btn btn-sm blue col-sm-3">
                                        <i class="fa fa-upload"></i>
                                        Upload
                                    </button>


                                    <div class="btn-group upload-file-div col-sm-5" style="display: none">
                                        <input type="hidden" name="agencyUrl" class="uploadUrl" id="agencyUrl">
                                        <a class="btn btn-sm green"
                                           target="_blank"
                                           href=";">View</a>
                                        <span class="input-group-btn">
                                            <button class="btn red btn-sm" type="button" title="delete"
                                                    onclick="delFileAndInput(this)">
                                                <i class="fa fa-ban"></i></button>
                                         </span>
                                    </div>

                                </div>
                            </div>
                            <div class=" col-md-6">
                                <label class="col-md-12" style="color: #888">LOI</label>
                                <div>
                                    <button id="loiBtn" type="button" class="col-sm-3 btn btn-sm blue"><i
                                            class="fa fa-upload"></i>
                                        Upload
                                    </button>
                                    <div class="btn-group upload-file-div col-sm-5" style="display: none">
                                        <input type="hidden" name="loiUrl" class="uploadUrl" id="loiUrl">
                                        <a class="btn btn-sm green"
                                           target="_blank"
                                           href=";">View</a>
                                        <span class="input-group-btn">
                                            <button class="btn red btn-sm" type="button" title="delete"
                                                    onclick="delFileAndInput(this)">
                                                <i class="fa fa-ban"></i></button>
                                         </span>
                                    </div>
                                </div>
                                <div class="notice" style="margin: 80px 0px 0 50px;">
                                    Notice:
                                    <hr style="margin: 10px 0;">
                                    This information can't be read by surveyor,until chosen surveyor/company.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions right">
                        <a data-toggle="tab" href="#step2"
                           class="btn default btn-back">Back</a>
                        <a data-toggle="tab" href="#step4"
                           class="btn default">Next</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        initUploaders_purchase_op_agency_loi("agencyBtn", "shipinfo", "${staticPath}/");
        initUploaders_purchase_op_agency_loi("loiBtn", "shipinfo", "${staticPath}/");
    })

    function delFileAndInput(obj) {
        var div = $(obj).parent().parent();
        div.find("input").val("");
        div.find("a").attr("href", "");
        div.css("display", "none");
    }
</script>