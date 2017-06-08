package com.ctoangels.goshipsurvey.common.modules.prepurchase.service;

import com.ctoangels.goshipsurvey.common.modules.prepurchase.entity.PurchaseInspection;
import com.baomidou.framework.service.ISuperService;

import java.util.List;

/**
 * PurchaseInspection 表数据服务层接口
 */
public interface IPurchaseInspectionService extends ISuperService<PurchaseInspection> {

    List<PurchaseInspection> selectByInspection(Integer id);

    boolean initInspection(int quotationId, int applicationId);

    List<PurchaseInspection> selectByOpInspection(Integer id);

    PurchaseInspection selectByReportId(Integer reportId);

    List<PurchaseInspection> getOPRecordList(Integer opId, Integer start, Integer length);

    List<PurchaseInspection> getCompanyRecordList(Integer companyId, Integer start, Integer length);

    int getRecordTotal(Integer opId, Integer companyId);


}