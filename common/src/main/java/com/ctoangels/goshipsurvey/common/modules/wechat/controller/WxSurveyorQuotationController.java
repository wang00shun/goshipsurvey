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
import com.ctoangels.goshipsurvey.common.modules.sys.controller.BaseController;
import com.ctoangels.goshipsurvey.common.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        /*for (Quotation q : list) {
            int shipType = Integer.parseInt(q.getShipType());
            q.setShipType(getShipTypeDict().get(shipType - 1).getDes());
        }*/
        jsonObject.put("canGet",canGet);



        /*正在申请验船*/
        EntityWrapper<QuotationApplication> ew =getEntityWrapper();
        ew.addFilter("user_id={0}  and application_status={1}", surveyorUId,Const.QUO_APPLY_ING);
        ew.orderBy("update_date", false);
        List<QuotationApplication> wait = quotationApplicationService.selectPage(getPage(),ew).getRecords();
        for (QuotationApplication application : wait) {
            application.setQuotation(quotationService.selectById(application.getQuotationId()));
        }
        jsonObject.put("wait",wait);



        /*正在验船*/

        EntityWrapper<Inspection> ew1 =getEntityWrapper();
        ew1.addFilter("inspection_status!={0} and company_id={1}",Const.INSPECTION_END,surveyorUId);
        List<Inspection> ing=inspectionService.selectPage(getPage(),ew1).getRecords();
        for (Inspection inspection:ing){
            inspection.setQuotation(quotationService.selectById(inspection.getQuotationId()));
        }
        jsonObject.put("ing",ing);

        /*已经完成验船完成*/
        EntityWrapper<Inspection> ew2 =getEntityWrapper();
        ew2.addFilter("inspection_status={0} and company_id={1}",Const.INSPECTION_END,surveyorUId);
        List<Inspection> complete=inspectionService.selectPage(getPage(),ew2).getRecords();
        for (Inspection inspection:complete){
            inspection.setQuotation(quotationService.selectById(inspection.getQuotationId()));
        }

        jsonObject.put("complete",complete);
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
        /*for (Quotation q : list) {
            int shipType = Integer.parseInt(q.getShipType());
            q.setShipType(getShipTypeDict().get(shipType - 1).getDes());
        }*/
        jsonObject.put("start",start);
        jsonObject.put("length",length);
        jsonObject.put("canGet",canGet);

        return jsonObject;
    }
    @RequestMapping(value = "/wait")
    @ResponseBody
    public JSONObject wait(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        /*正在申请验船*/
        EntityWrapper<QuotationApplication> ew =getEntityWrapper();
        ew.addFilter("user_id={0}  and application_status={1}", surveyorUId,Const.QUO_APPLY_ING);
        ew.orderBy("update_date", false);
        Page<QuotationApplication> page= quotationApplicationService.selectPage(getPage(),ew);
        for (QuotationApplication application : page.getRecords()) {
            application.setQuotation(quotationService.selectById(application.getQuotationId()));
        }
        jsonObject.put("wait",page.getRecords());
        jsonObject.put("start",page.getCurrent());
        jsonObject.put("length",page.getSize());

        return jsonObject;
    }
    @RequestMapping(value = "/ing")
    @ResponseBody
    public JSONObject ing(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        /*正在验船*/

        EntityWrapper<Inspection> ew1 =getEntityWrapper();
        ew1.addFilter("inspection_status!={0} and company_id={1}",Const.INSPECTION_END,surveyorUId);
        Page<Inspection> page=inspectionService.selectPage(getPage(),ew1);
        for (Inspection inspection:page.getRecords()){
            inspection.setQuotation(quotationService.selectById(inspection.getQuotationId()));
        }
        jsonObject.put("ing",page.getRecords());
        jsonObject.put("start",page.getCurrent());
        jsonObject.put("length",page.getSize());

        return jsonObject;
    }
    @RequestMapping(value = "/complete")
    @ResponseBody
    public JSONObject complete(@RequestParam(required = true) Integer surveyorUId) {
        JSONObject jsonObject = new JSONObject();
        /*已经完成验船完成*/
        EntityWrapper<Inspection> ew2 =getEntityWrapper();
        ew2.addFilter("inspection_status={0} and company_id={1}",Const.INSPECTION_END,surveyorUId);
        Page<Inspection> page=inspectionService.selectPage(getPage(),ew2);
        for (Inspection inspection:page.getRecords()){
            inspection.setQuotation(quotationService.selectById(inspection.getQuotationId()));
        }

        jsonObject.put("complete",page.getRecords());
        jsonObject.put("start",page.getCurrent());
        jsonObject.put("length",page.getSize());

        return jsonObject;
    }
}