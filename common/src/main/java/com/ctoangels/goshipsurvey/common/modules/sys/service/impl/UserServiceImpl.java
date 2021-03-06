package com.ctoangels.goshipsurvey.common.modules.sys.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.framework.service.impl.SuperServiceImpl;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.entity.Surveyor;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.mapper.SurveyorMapper;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.Role;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.User;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.UserSurveyor;
import com.ctoangels.goshipsurvey.common.modules.sys.mapper.UserMapper;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.entity.Company;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.mapper.CompanyMapper;
import com.ctoangels.goshipsurvey.common.modules.sys.mapper.RoleMapper;
import com.ctoangels.goshipsurvey.common.modules.sys.mapper.UserRoleMapper;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.UserRole;
import com.ctoangels.goshipsurvey.common.modules.sys.mapper.UserSurveyorMapper;
import com.ctoangels.goshipsurvey.common.modules.sys.service.UserService;
import com.ctoangels.goshipsurvey.common.util.Const;
import com.ctoangels.goshipsurvey.common.util.StringUtils;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author Sun.Han
 * @version 1.0
 * @FileName UserServiceImpl.java
 * @Description:
 * @Date 2015年5月9日
 */
//@Transactional(readOnly = true)
@Service
public class UserServiceImpl extends SuperServiceImpl<UserMapper, User> implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private CompanyMapper companyMapper;

    @Autowired
    private SurveyorMapper surveyorMapper;

    @Autowired
    private UserSurveyorMapper userServeyorMapper;


    public List<Role> getRoles(Integer userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("del_flag", 0);
        map.put("allocatable", 1);
        List<Role> roles = roleMapper.selectByMap(map);
        map = new HashMap<>();
        map.put("user_id", userId);
        List<UserRole> userRoles = userRoleMapper.selectByMap(map);
        for (Role role : roles) {
            for (UserRole userRole : userRoles) {
                if (role.getId().equals(userRole.getRoleId())) {
                    role.setChecked(true);
                    break;
                }
            }
        }
        return roles;
    }

    public void editRole(User user) {
        String roleIds = user.getRoleIds();
        if (roleIds != null && roleIds.trim().length() > 0) {
            List<UserRole> list = new ArrayList<>();
            Integer userId = user.getId();
            String[] roleIdArr = roleIds.split(",");
            for (String roleId : roleIdArr) {
                UserRole userRole = new UserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(Integer.valueOf(roleId));
                list.add(userRole);
            }
            Map<String, Object> map = new HashMap<>();
            map.put("user_id", userId);
            userRoleMapper.deleteByMap(map);
            userRoleMapper.insertBatch(list);
        }
    }

    public boolean isNameExist(String loginName) {
        User user = new User();
        user.setLoginName(loginName);
        user.setDelFlag(Const.DEL_FLAG_NORMAL);
        int count = userMapper.selectCount(user);
        return count > 0;
    }

    public JSONObject editPassword(String password, String oldPassword) {
        JSONObject result = new JSONObject();
        Subject subject = SecurityUtils.getSubject();
        User sessionUser = (User) subject.getSession().getAttribute(Const.SESSION_USER);

        User user = userMapper.selectById(sessionUser.getId());
        String loginName = user.getLoginName();
        String encodePwd = new SimpleHash("SHA-1", loginName, oldPassword).toString();
        if (user.getPassword().equals(encodePwd)) {
            User newer = new User();
            newer.setPassword(new SimpleHash("SHA-1", loginName, password).toString());
            newer.setId(sessionUser.getId());
            userMapper.updateSelectiveById(newer);
            result.put("status", 1);
        } else {
            result.put("status", 0);
            result.put("msg", "原密码错误");
        }
        return result;
    }

    @Override
    public User getTryUser() {
        User user = new User();
        boolean flag = false;
        String userName = "";
        while (!flag) {
            userName = StringUtils.getUUID32();
            user.setName(userName);
            user.setLoginName(userName);
            User u = userMapper.selectOne(user);
            flag = (u == null);
        }

        Company company = new Company();
        company.setName("测试公司");
        company.setDelFlag(Const.DEL_FLAG_NORMAL);
        companyMapper.insert(company);

        String passwd = new SimpleHash("SHA-1", userName, "123456").toString(); // 密码加密
        user.setPassword(passwd);
        user.setCompanyId(company.getId());
        user.setDelFlag(Const.DEL_FLAG_NORMAL);
        userMapper.insert(user);

        UserRole userRole = new UserRole();
        userRole.setUserId(user.getId());
        userRole.setRoleId(4);
        userRoleMapper.insert(userRole);

        return user;
    }

    @Override
    public List<Integer> getAllId(Integer role) {
        return userMapper.getAllId(role);
    }

    @Override
    public List<User> getSurveyorList(String keyword) {
        EntityWrapper<User> ew = new EntityWrapper<>();
        ew.addFilter("(type = {0} or type={1} )", Const.USER_TYPE_SURVEYOR_COMPANY, Const.USER_TYPE_ADMIN);
        if (!StringUtils.isEmpty(keyword)) {
            ew.addFilter("CONCAT(name,email) like {0}", "%" + keyword + "%");
        }
        ew.setSqlSelect("id,name,email");
        Page p = new Page<>(1, 10);
        return userMapper.selectPage(p, ew);
    }

    @Override
    public User getUserByUnionId(String unionId) {
        User u = new User();
        u.setUnionId(unionId);
        u.setDelFlag(Const.DEL_FLAG_NORMAL);
        return userMapper.selectOne(u);
    }

    @Override
    public User registerWeiXinUser(WxMpUser wxMpUser) {
        User user = new User();
        String name = StringUtils.filterEmoji(wxMpUser.getNickname());
        user.setLoginName(name);
        user.setPassword("WeiXinUser");
        user.setName(name);
        user.setOpenId(wxMpUser.getOpenId());
        user.setLastLogin(new Date());
        user.setHeadImgUrl(wxMpUser.getHeadImgUrl());
        user.setUnionId(wxMpUser.getUnionId());
        user.setCreateDate(new Date());
        user.setUpdateDate(new Date());
        user.setDelFlag(Const.DEL_FLAG_NORMAL);
        userMapper.insert(user);
        UserRole ur = new UserRole();
        ur.setUserId(user.getId());
        ur.setRoleId(Const.USER_TYPE_OP);
        userRoleMapper.insert(ur);
        return user;
    }

    @Override
    public boolean existUnionId(String unionId) {
        User u = new User();
        u.setUnionId(unionId);
        u.setDelFlag(Const.DEL_FLAG_NORMAL);
        return userMapper.selectOne(u) != null;
    }

    @Transactional
    @Override
    public Boolean insertByInfo(JSONObject jsonObject, Surveyor surveyor, WxMpUser wxMpUser) {
        if (surveyor.getEmail() != null &&
                !surveyor.getEmail().trim().equals("") &&
                surveyor.getTel() != null &&
                !surveyor.getTel().trim().equals("")) {
            Surveyor sy = surveyorMapper.selectByTelAndEmail(surveyor.getEmail(), surveyor.getTel());
            if (sy == null) {
                setJsonObject("数据库暂时没有该验船师，请联系相关部门", 1, jsonObject);
                return false;
            }
            UserSurveyor us = userServeyorMapper.selectBySurveyorId(sy.getId());
            if (us != null) {
                setJsonObject("该用户已经被绑定了，请重新输入信息", 2, jsonObject);
                return false;
            }
            //插入用户
            User user = new User();
            String passwd = new SimpleHash("SHA-1", surveyor.getEmail(), surveyor.getTel()).toString(); // 密码加密
            user.setName(surveyor.getEmail());
            user.setLoginName(surveyor.getEmail());
            user.setEmail(surveyor.getEmail());
            user.setPhone(surveyor.getTel());
            user.setPassword(passwd);
            user.setType(4);
            user.setDelFlag(Const.DEL_FLAG_NORMAL);
            int a = userMapper.insert(user);

            //插入角色
            UserRole userRole = new UserRole();
            userRole.setUserId(user.getId());
            userRole.setRoleId(4);
            userRoleMapper.insert(userRole);

            String gzhOpenId = wxMpUser.getOpenId();
            String unionId = wxMpUser.getUnionId();
            Integer userId = user.getId();
            Integer surveyorId = sy.getId();

            UserSurveyor userServeyor = new UserSurveyor();
            userServeyor.setGzhOpenId(gzhOpenId);
            userServeyor.setUnionId(unionId);
            userServeyor.setUserId(userId);
            userServeyor.setSurveyorId(surveyorId);
            int c = userServeyorMapper.insert(userServeyor);
            if (a > 0 && c > 0) {
                setJsonObject("数据绑定成功", 3, jsonObject);
                return true;
            }
        }
        setJsonObject("数据绑定失败", 4, jsonObject);
        return false;

    }

    @Override
    public User getUserBySurveyorId(Integer surveyor_id) {
        return userMapper.getUserBySurveyorId(surveyor_id);
    }

    private void setJsonObject(String mes, Integer delFlag, JSONObject jsonObject) {
        jsonObject.put("mes", mes);
        jsonObject.put("delFlag", delFlag);
    }

    @Override
    public User getUserByUnionIdForXCX(String unionId) {
        UserSurveyor userSurveyor = userServeyorMapper.selectByUnionId(unionId);
        if (userSurveyor != null) {
            return userMapper.selectById(userSurveyor.getUserId());
        }
        return null;
    }
}
