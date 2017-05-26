package com.ctoangels.goshipsurvey.common.modules.prepurchase.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.toolkit.CollectionUtil;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.entity.Port;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.service.IPortService;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.entity.Surveyor;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.service.ISurveyorService;
import com.ctoangels.goshipsurvey.common.modules.sys.controller.BaseController;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.User;
import com.ctoangels.goshipsurvey.common.modules.sys.service.UserService;
import com.ctoangels.goshipsurvey.common.util.Const;
import com.ctoangels.goshipsurvey.common.util.DateUtil;
import com.ctoangels.goshipsurvey.common.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * Surveyor 控制层
 */
@Controller
@RequestMapping(value = "surveyor")
public class SurveyorController extends BaseController {

    @Autowired
    ISurveyorService surveyorService;

    @Autowired
    UserService userService;

    @Autowired
    IPortService portService;


    @RequestMapping
    public String surveyor(ModelMap map) {
        return "sys/surveyor/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject getList(@RequestParam(required = false) String name,
                              @RequestParam(required = false) String port,
                              @RequestParam(required = false) Date startDate,
                              @RequestParam(required = false) Date endDate) {
        EntityWrapper<Surveyor> ew = getEntityWrapper();
        ew.addFilter("company_id={0} and del_flag={1}", getCurrentUser().getId(), Const.DEL_FLAG_NORMAL);
        if (StringUtils.isNotEmpty(name)) {
            ew.like("first_name", name);
            ew.or("last_name like {0}", "%" + name + "%");
        }
        if (StringUtils.isNotEmpty(port)) {
            ew.addFilter("( survey_port ={0} or survey_port REGEXP \"(^" + port + ",)|(," + port + "$)|(," + port + ",)\")", port);
        }
        if (startDate != null) {
            ew.addFilter("survey_time_start <={0}", DateUtil.formatDate(startDate, "yyyy-MM-dd"));
        }
        if (endDate != null) {
            ew.addFilter("survey_time_end >={0}", DateUtil.formatDate(endDate, "yyyy-MM-dd"));
        }

        List<Port> allPort = portService.selectList(new EntityWrapper<>());
        Page<Surveyor> page = surveyorService.selectPage(getPage(), ew);
        for (Surveyor s : page.getRecords()) {
            String portValue = "";
            String portString = s.getSurveyPort();
            String[] userPorts;
            if (StringUtils.isNotEmpty(portString)) {
                userPorts = portString.split(",");
                for (String p : userPorts) {
                    portValue += allPort.get(Integer.parseInt(p) - 1).getPortEn() + ",";
                }
                portValue.substring(0, portValue.length() - 2);
            }
            s.setSurveyPort(portValue);
        }
        return jsonPage(page);
    }


    @RequestMapping(value = "/batchDelete")
    @ResponseBody
    public JSONObject batchDelete(@RequestParam String ids) {
        JSONObject result = new JSONObject();
        if (!StringUtils.isEmpty(ids)) {
            List<Surveyor> list = surveyorService.selectBatchIds(Arrays.asList(ids.split(",")));
            for (Surveyor s : list) {
                s.setDelFlag(Const.DEL_FLAG_DELETE);
                s.setUpdateInfo(getCurrentUser().getName());
            }
            surveyorService.updateBatchById(list);
        }
        result.put("status", 1);
        return result;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(ModelMap map) {
        map.put("shipType", getShipTypeDict());
        return "sys/surveyor/add";
    }

    @RequestMapping(value = "/addComplete", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addComplete(Surveyor surveyor) {
        JSONObject jsonObject = new JSONObject();
        surveyor.setCompanyId(getCurrentUser().getId());
        surveyor.setCreateInfo(getCurrentUser().getName());
        jsonObject.put("success", surveyorService.insert(surveyor));
        return jsonObject;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String edit(ModelMap map, @RequestParam(required = false) int id) {
        Surveyor surveyor = surveyorService.selectById(id);
        String userShipType = surveyor.getShipType();
        String[] userShipTypes = null;
        if (StringUtils.isNotEmpty(userShipType)) {
            userShipTypes = userShipType.split(",");
        }
        String portString = surveyor.getSurveyPort();
        String[] userPorts;
        List<Port> portList = new ArrayList<>();
        if (StringUtils.isNotEmpty(portString)) {
            userPorts = portString.split(",");
            portList = portService.selectBatchIds(Arrays.asList(userPorts));
        }

        map.put("userShipTypes", userShipTypes);
        map.put("surveyor", surveyor);
        map.put("shipType", getShipTypeDict());
        map.put("portList", portList);
        return "sys/surveyor/edit";
    }

    @RequestMapping(value = "/editComplete", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject editComplete(Surveyor surveyor) {
        JSONObject jsonObject = new JSONObject();
        surveyor.setUpdateInfo(getCurrentUser().getName());
        jsonObject.put("success", surveyorService.updateById(surveyor));
        return jsonObject;
    }

    @RequestMapping(value = "/info", method = RequestMethod.GET)
    public String info(ModelMap map, @RequestParam(required = false) int id) {
        Surveyor surveyor = surveyorService.selectById(id);
        String userShipType = surveyor.getShipType();
        String[] userShipTypes = null;
        if (StringUtils.isNotEmpty(userShipType)) {
            userShipTypes = userShipType.split(",");
        }
        map.put("userShipTypes", userShipTypes);
        map.put("surveyor", surveyor);
        map.put("company", userService.selectById(surveyor.getCompanyId()));
        map.put("shipType", getShipTypeDict());
        return "sys/surveyor/info";
    }


    @RequestMapping(value = "/getSurveyors", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject getSurveyors(ModelMap map) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("list", surveyorService.getSurveyorsByCompanyId(getCurrentUser().getId()));
        return jsonObject;
    }


}