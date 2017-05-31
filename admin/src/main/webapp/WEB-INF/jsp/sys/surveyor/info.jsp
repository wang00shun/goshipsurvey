<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="go" uri="http://www.ctoangels.com/jsp/jstl/common" %>
<style>
    .well h4 {
        color: #3598dc;
    }
</style>
<h1 style="text-align: center;background-color: #3598dc;color: white;margin-top: 0">Surveyor Curriculum Vitae</h1>
<div class="row">
    <div class="col-md-12">
        <div class="profile-sidebar">
            <div class="portlet light profile-sidebar-portlet ">
                <div class="profile-userpic">
                    <img onerror="nofind(2)" src="${surveyor.portraitUrl}" id="head-img"
                         class="img-responsive" alt=""></div>
                <div class="profile-usertitle">
                    <div class="profile-usertitle-name">
                        ${surveyor.firstName}&nbsp;${surveyor.lastName}
                    </div>
                    <div class="profile-usertitle-job">

                    </div>
                </div>
            </div>
        </div>
        <div class="profile-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light ">
                        <div class="portlet-body">
                            <div class="well">
                                <h4>Nationality</h4>
                                ${surveyor.firstName}
                            </div>
                            <div class="well">
                                <h4>Available port</h4>
                                ${surveyor.firstName}
                            </div>
                            <div class="well">
                                <h4>Surveyor's profile</h4>
                                ${surveyor.surveyorProfile}
                            </div>
                            <div class="well">
                                <h4>Surveyor's experience</h4>
                                <div class="form-group col-md-12">
                                    <table class="table  table-checkable table-bordered"
                                           id="experience_table">
                                        <thead>
                                        <tr>
                                            <th width="25%">Time</th>
                                            <th width="15%">Ship type</th>
                                            <th width="15%">Company</th>
                                            <th width="45%">Work content</th>
                                        </tr>
                                        <tbody>
                                        <c:forEach items="${surveyor.experienceList}" var="e">
                                            <tr>
                                                <td><fmt:formatDate value="${e.startDate}" pattern="yyyy-MM-dd"></fmt:formatDate>
                                                    to
                                                    <fmt:formatDate value="${e.endDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                                                <td>${e.shipType}</td>
                                                <td>${e.company}</td>
                                                <td>${e.workContent}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
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
