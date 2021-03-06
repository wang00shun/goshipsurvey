package com.ctoangels.goshipsurvey.common.modules.wechat.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.entity.Inspection;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.entity.Quotation;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.entity.QuotationApplication;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.service.IDictService;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.service.IInspectionService;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.service.IQuotationApplicationService;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.service.IQuotationService;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.entity.Surveyor;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.service.ISurveyorService;
import com.ctoangels.goshipsurvey.common.modules.sys.controller.BaseController;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.User;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.UserSurveyor;
import com.ctoangels.goshipsurvey.common.modules.sys.service.IUserSurveyorService;
import com.ctoangels.goshipsurvey.common.modules.sys.service.UserService;
import com.ctoangels.goshipsurvey.common.util.Const;
import com.ctoangels.goshipsurvey.common.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * Created by zhen_Tomcat on 2018/04/02.
 */
@Controller
@RequestMapping(value = "wx/surveyor/quotation")
public class WxSurveyorQuotationController extends BaseController {

    @Autowired
    IQuotationService quotationService;

    @Autowired
    IDictService dictService;

    @Autowired
    IQuotationApplicationService quotationApplicationService;

    @Autowired
    private IInspectionService inspectionService;

    @Autowired
    private IUserSurveyorService userSurveyorService;

    @Autowired
    private ISurveyorService surveyorService;

    @Autowired
    private UserService userService;

    @Autowired
    private Template template;


    @RequestMapping(value = "/list")
    @ResponseBody
    public JSONObject getQuotation(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        int start = 0;
        int length = 10;
        if (request.getParameter(Const.LENGTH) != null) {
            start = Integer.parseInt(request.getParameter(Const.START));
        }
        if (request.getParameter(Const.LENGTH) != null) {
            length = Integer.parseInt(request.getParameter(Const.LENGTH));
        }
        List<Quotation> canGet = quotationService.getQuotationList(surveyorUId, start, length);

        for (Quotation q : canGet) {
            setInspectionStringType(q);
        }
        jsonObject.put("canGet", canGet);



        /*正在申请验船*/
        EntityWrapper<QuotationApplication> ew = getEntityWrapper();
        ew.addFilter("user_id = {0}  and application_status = {1}", surveyorUId, Const.QUO_APPLY_ING);
        ew.orderBy("update_date", false);
        List<QuotationApplication> wait = quotationApplicationService.selectPage(getPage(), ew).getRecords();
        for (QuotationApplication application : wait) {
            Quotation quotation = quotationService.selectById(application.getQuotationId());
            application.setQuotation(quotation);
            setInspectionStringType(quotation);
        }

        jsonObject.put("wait", wait);



        /*正在验船*/

        EntityWrapper<Inspection> ew1 = getEntityWrapper();
        ew1.addFilter("inspection_status != {0} and company_id = {1}", Const.INSPECTION_END, surveyorUId);
        List<Inspection> ing = inspectionService.selectPage(getPage(), ew1).getRecords();
        for (Inspection inspection : ing) {
            Quotation quotation =quotationService.selectById(inspection.getQuotationId());
            inspection.setQuotation(quotation);
            setInspectionStringType(quotation);

        }
        jsonObject.put("ing", ing);

        /*已经完成验船完成*/
        EntityWrapper<Inspection> ew2 = getEntityWrapper();
        ew2.addFilter("inspection_status = {0} and company_id = {1}", Const.INSPECTION_END, surveyorUId);
        List<Inspection> complete = inspectionService.selectPage(getPage(), ew2).getRecords();
        for (Inspection inspection : complete) {
            Quotation quotation =quotationService.selectById(inspection.getQuotationId());
            inspection.setQuotation(quotation);
            setInspectionStringType(quotation);
        }

        jsonObject.put("complete", complete);
        return jsonObject;
    }

    @RequestMapping(value = "/canGet")
    @ResponseBody
    public JSONObject canGet(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        int start = 0;
        int length = 10;
        if (request.getParameter(Const.LENGTH) != null) {
            start = Integer.parseInt(request.getParameter(Const.START));
        }
        if (request.getParameter(Const.LENGTH) != null) {
            length = Integer.parseInt(request.getParameter(Const.LENGTH));
        }
        List<Quotation> canGet = quotationService.getQuotationList(surveyorUId, start, length);
        for (Quotation q : canGet) {
            setInspectionStringType(q);
        }
        jsonObject.put("start", start);
        jsonObject.put("length", length);
        jsonObject.put("data", canGet);

        return jsonObject;
    }

    @RequestMapping(value = "/wait")
    @ResponseBody
    public JSONObject wait(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        /*正在申请验船*/
        EntityWrapper<QuotationApplication> ew = getEntityWrapper();
        ew.addFilter("user_id={0}  and application_status={1}", surveyorUId, Const.QUO_APPLY_ING);
        ew.orderBy("update_date", false);
        Page<QuotationApplication> page = quotationApplicationService.selectPage(getPage(), ew);
        for (QuotationApplication application : page.getRecords()) {
            Quotation quotation = quotationService.selectById(application.getQuotationId());
            application.setQuotation(quotation);
            setInspectionStringType(quotation);
        }
        jsonObject.put("data", page.getRecords());
        jsonObject.put("start", page.getCurrent());
        jsonObject.put("length", page.getSize());

        return jsonObject;
    }

    @RequestMapping(value = "/ing")
    @ResponseBody
    public JSONObject ing(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        /*正在验船*/

        EntityWrapper<Inspection> ew1 = getEntityWrapper();
        ew1.addFilter("inspection_status!={0} and company_id={1}", Const.INSPECTION_END, surveyorUId);
        Page<Inspection> page = inspectionService.selectPage(getPage(), ew1);
        for (Inspection inspection : page.getRecords()) {
            Quotation quotation =quotationService.selectById(inspection.getQuotationId());
            inspection.setQuotation(quotation);
            setInspectionStringType(quotation);
        }
        jsonObject.put("data", page.getRecords());
        jsonObject.put("start", page.getCurrent());
        jsonObject.put("length", page.getSize());

        return jsonObject;
    }

    @RequestMapping(value = "/complete")
    @ResponseBody
    public JSONObject complete(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        /*已经完成验船完成*/
        EntityWrapper<Inspection> ew2 = getEntityWrapper();
        ew2.addFilter("inspection_status={0} and company_id={1}", Const.INSPECTION_END, surveyorUId);
        Page<Inspection> page = inspectionService.selectPage(getPage(), ew2);
        for (Inspection inspection : page.getRecords()) {
            Quotation quotation = inspection.getQuotation();
            setInspectionStringType(quotation);
            inspection.setQuotation(quotationService.selectById(inspection.getQuotationId()));
        }

        jsonObject.put("data", page.getRecords());
        jsonObject.put("start", page.getCurrent());
        jsonObject.put("length", page.getSize());

        return jsonObject;
    }

    @RequestMapping(value = "/apply")
    @ResponseBody
    public JSONObject apply(@RequestParam(required = true) Integer surveyorUId, @RequestParam(required = true) Integer quotationId) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.selectById(surveyorUId);

        QuotationApplication qa = new QuotationApplication();
        qa.setUserId(user.getId());
        qa.setCreateDate(new Date());
        qa.setUpdateDate(new Date());
        qa.setCreateInfo(user.getLoginName());
        qa.setType(Const.PROJECT_TYPE_HIRE);
        qa.setDelFlag(Const.DEL_FLAG_NORMAL);
        qa.setApplicationStatus(Const.QUO_APPLY_ING);
        UserSurveyor userSurveyor = userSurveyorService.selectByUserId(surveyorUId);
        Surveyor surveyor = surveyorService.selectById(userSurveyor.getSurveyorId());
        qa.setSurveyId(surveyor.getId());
        qa.setQuotationId(quotationId);

        Quotation quotation = quotationService.selectById(quotationId);
        if (quotation.getTotalPrice() != null) {
            qa.setTotalPrice(quotation.getTotalPrice());
        }

        if (quotationApplicationService.insert(qa)) {
            String gzhOpenId= userSurveyor.getGzhOpenId();
            template.infomationNotice(gzhOpenId, Const.CHECK_REMIND,"pages/home/home","您好：",
                    "您申请的船舶检验，正在处理","待审核","点击此条消息查看更详细的信息");
            jsonObject.put("success", true);
        } else {
            jsonObject.put("success", false);
        }

        return jsonObject;
    }

    @RequestMapping(value = "/cancelApply")
    @ResponseBody
    public JSONObject cancelApply(@RequestParam(required = true) Integer surveyorUId, @RequestParam(required = true) Integer applicationId) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.selectById(surveyorUId);
        if (user == null) {
            jsonObject.put("errMsg", "请登录或绑定后进行操作");
            return jsonObject;
        }
        QuotationApplication qa = new QuotationApplication();
        qa.setId(applicationId);
        qa.setDelFlag(Const.DEL_FLAG_DELETE);
        qa.setUpdateInfo(user.getLoginName());
        if (quotationApplicationService.updateSelectiveById(qa)) {
            UserSurveyor userSurveyor= userSurveyorService.selectByUserId(surveyorUId);
            String gzhOpenId= userSurveyor.getGzhOpenId();
            String keyword1="您已经取消了该船舶的检验申请";
            String keyword2="岙洋船务";
            template.infomationNotice(gzhOpenId, Const.CHECK_REMIND,"pages/home/home","您好：",keyword1,keyword2,"点击此条消息查看更详细的信息");
            jsonObject.put("errMsg", "");
        } else {
            jsonObject.put("errMsg", "撤销失败");
        }
        return jsonObject;
    }

    @RequestMapping(value = "/completeInspection")
    @ResponseBody
    public JSONObject completeInspection(@RequestParam(required = true) Integer surveyorUId, @RequestParam(required = true) Integer inspectionId) {
        JSONObject jsonObject = new JSONObject();
        User user = userService.selectById(surveyorUId);
        if (user == null) {
            jsonObject.put("errMsg", "请登录或绑定后进行操作");
            return jsonObject;
        }
        Inspection inspection = inspectionService.selectById(inspectionId);
        inspection.setInspectionStatus(Const.INSPECTION_END);
        if (inspectionService.updateById(inspection)) {
            UserSurveyor userSurveyor= userSurveyorService.selectByUserId(surveyorUId);
            String gzhOpenId= userSurveyor.getGzhOpenId();
            String keyword1="您已经完成了该船舶的检验";
            String keyword2="岙洋船务";
            template.infomationNotice(gzhOpenId, Const.CHECK_REMIND,"pages/home/home","您好：",keyword1,keyword2,"点击此条消息查看更详细的信息");
            jsonObject.put("errMsg", "");
        } else {
            jsonObject.put("errMsg", "提交完成失败!");
        }
        return jsonObject;
    }

    public void  setInspectionStringType(Quotation q){
            q.setInspectionType(Tools.transferValuesToDes(q.getInspectionType(), getInspectionTypeDict()));
            q.setShipType(Tools.transferValuesToDes(q.getShipType(), getShipTypeDict()));
    }
}
