package com.ctoangels.goshipsurvey.common.modules.go.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ctoangels.goshipsurvey.common.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ctoangels.goshipsurvey.common.modules.go.mapper.PublicShipMapper;
import com.ctoangels.goshipsurvey.common.modules.go.entity.PublicShip;
import com.ctoangels.goshipsurvey.common.modules.go.service.IPublicShipService;
import com.baomidou.framework.service.impl.SuperServiceImpl;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * PublicShip 表数据服务层接口实现类
 */
@Service
public class PublicShipServiceImpl extends SuperServiceImpl<PublicShipMapper, PublicShip> implements IPublicShipService {

    @Autowired
    PublicShipMapper publicShipMapper;

    @Override
    public List<PublicShip> getSearchList(String keyword) {
        EntityWrapper<PublicShip> ew = new EntityWrapper<>();
        if (!StringUtils.isEmpty(keyword)) {
            ew.like("name", keyword);
            ew.or("imo like {0}", "%" + keyword + "%");
            ew.or("callsign like {0}", "%" + keyword + "%");
        }
        ew.setSqlSelect("id,name,imo,dwt,callsign");
        Page p = new Page<>(1, 10);
        return publicShipMapper.selectPage(p, ew);
    }

    @Override
    public List<PublicShip> getSearchListByColumns(String keyword, String[] columns) {
        EntityWrapper<PublicShip> ew = new EntityWrapper<>();
        if (!StringUtils.isEmpty(keyword) && columns != null && columns.length > 0) {
            String searchParams = "concat(";
            for (String column : columns) {
                searchParams += column + ",";
            }
            searchParams = searchParams.substring(0, searchParams.length() - 1);
            searchParams += ") like {0}";
            ew.addFilter(searchParams, "%" + keyword + "%");
        }
        ew.setSqlSelect("id,name,imo,dwt,callsign,type_id");
        Page p = new Page<>(1, 10);
        return publicShipMapper.selectPage(p, ew);
    }

    @Override
    public PublicShip getById(int id) {
        return publicShipMapper.selectById(id);
    }

    @Override
    public List<PublicShip> getListByIMO(String imo) {
        EntityWrapper<PublicShip> ew = new EntityWrapper<>();
        ew.where("imo={0}", imo);
        return publicShipMapper.selectList(ew);
    }

}