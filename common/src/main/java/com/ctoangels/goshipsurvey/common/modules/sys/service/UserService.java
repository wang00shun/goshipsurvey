package com.ctoangels.goshipsurvey.common.modules.sys.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.framework.service.ISuperService;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.Role;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.User;

import java.util.List;

/**
 * Created by dongs on 2016/11/21.
 */
public interface UserService extends ISuperService<User> {
    List<Role> getRoles(Integer userId);

    void editRole(User user);

    boolean isNameExist(String loginName);

    JSONObject editPassword(String password, String oldPassword);

    User getTryUser();

}
