package com.ctoangels.goshipsurvey.common.modules.prepurchase.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.entity.*;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.mapper.GalleriesMapper;
import com.ctoangels.goshipsurvey.common.modules.prepurchase.service.*;
import com.ctoangels.goshipsurvey.common.util.Const;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ctoangels.goshipsurvey.common.modules.prepurchase.mapper.GradeMapper;
import com.baomidou.framework.service.impl.SuperServiceImpl;

import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * Grade 表数据服务层接口实现类
 *
 */
@Service
public class GradeServiceImpl extends SuperServiceImpl<GradeMapper, Grade> implements IGradeService {

    @Autowired
    private IGradeModelService gradeModelService;

    @Autowired
    private GradeMapper gradeMapper;

    @Autowired
    private IPurchaseInspectionService purchaseInspectionService;

    @Autowired
    private IInspectionReportService iInspectionReportService;

    @Autowired
    private GalleriesMapper galleriesMapper;

    @Autowired
    private IMediaService mediaService;

    @Override
    public List<Grade> selectListGrade(Integer reportId) {
        EntityWrapper<Grade> ew=new EntityWrapper<>();
        ew.addFilter("inspection_report_id={0}",reportId);
        List<Grade>grades=gradeMapper.selectList(ew);

        return grades;
    }

    @Override
    public List<Double> updateGradeById(Grade grade) {
        Grade grade1=gradeMapper.selectById(grade.getId());
        InspectionReport report=iInspectionReportService.selectById(grade1.getInspectionReportId());
        if(report.getSubmitStatus2()==0){
            report.setSubmitStatus2(Const.REPORT_SUBMIT);
            iInspectionReportService.updateById(report);
        }
        if(grade.getFileName()!=null){
            grade1.setFileName(grade.getFileName());
            grade1.setSitePhoto(grade.getSitePhoto());
            gradeMapper.updateById(grade1);

            if(!grade.getFileName().equals("")){
                Galleries galleries=galleriesMapper.selectByReportIdAndAlbum(grade1.getInspectionReportId(),"Grade");
                galleries.setNumber(galleries.getNumber()+1);
                Media media=new Media();
                media.setFileName(grade.getFileName());
                media.setGalleriesId(galleries.getId());
                media.setFileUrl(grade.getSitePhoto());
                media.setCreateDate(new Date());
                media.setDelFlag(Const.DEL_FLAG_NORMAL);

                galleriesMapper.updateById(galleries);
                mediaService.insert(media);

                List<Double> number=new ArrayList<>();
                number.add(Double.valueOf(galleries.getId()));
                number.add(Double.valueOf(galleries.getNumber()));
                return number;

            }

            return null;
        }else {

        }
        if(grade.getGrade()!=null){
            grade1.setGrade(grade.getGrade());
            gradeMapper.updateById(grade1);
            List<Double> totalGrades=calculateGrade(grade1);
            return totalGrades;

        }
        if(grade.getRemark()!=null){
            grade1.setRemark(grade.getRemark());
            gradeMapper.updateById(grade1);
            return null;
        }


        return null;
    }

    private List<Double> calculateGrade(Grade grade){
        String parentItem=grade.getParentItem();
        Integer parentRank=grade.getRank()-1;
        Integer reportId=grade.getInspectionReportId();
        int count=0;
        double totalGrade=0.0;
        List<Double> totalGrades=new ArrayList<>();

        while (true){
            count++;
            double avgGrade=0.0;
            double groupGrade=0.0;
            double weightNum=0.0;
            List<Grade> grades=gradeMapper.selectGradesByParentItem(parentItem,reportId);
            for(Grade g:grades){
                if(g.getGrade()!=null){
                    groupGrade+= g.getGrade()*g.getWeight();
                    weightNum+=g.getWeight();
                }
            }

            //保留double数据小数点后四位
            avgGrade  = (double)(groupGrade / weightNum);
            BigDecimal b = new BigDecimal  (avgGrade);
            double f1=b.setScale(4,BigDecimal.ROUND_HALF_UP).doubleValue();
            totalGrades.add(f1);

            if(count!=3){
                Grade grade1=gradeMapper.selectGradeByItem(parentItem,reportId,parentRank);
                grade1.setGrade(avgGrade);
                gradeMapper.updateById(grade1);
                parentItem=grade1.getParentItem();
                parentRank=grade1.getRank()-1;
            }
            if(count==3){
                totalGrade=avgGrade;
                reportId=grade.getInspectionReportId();
                PurchaseInspection inspection=purchaseInspectionService.selectByReportId(reportId);
                inspection.setTotalGrade(totalGrade);
                purchaseInspectionService.updateById(inspection);
                break;
            }
        }
        return totalGrades;

    }
}