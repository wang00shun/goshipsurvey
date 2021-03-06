package com.ctoangels.goshipsurvey.common.util;

import com.ctoangels.goshipsurvey.common.modules.go.entity.PublicShip;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.entity.EmailQuotation;
import com.ctoangels.goshipsurvey.common.modules.goshipsurvey.entity.InspectionTypePrice;
import com.ctoangels.goshipsurvey.common.modules.sys.entity.MailAuthenticator;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.IOException;
import java.io.InputStream;
import java.security.Security;
import java.util.*;

/**
 * Created by lenovo on 2017/3/20.
 */
public class MailUtil {

    private static String sitePath;

    private static String fromAddress;

    private static String fromPassword;

    private static String mailSmtpHost;

    private static String mailSmtpPort;

    private static String effectiveTime;

    static {
        Properties prop = new Properties();
        InputStream in = MailUtil.class.getResourceAsStream("/override.properties");
        try {
            prop.load(in);
            sitePath = prop.getProperty("site_path");
            fromAddress = prop.getProperty("fromAddress");
            fromPassword = prop.getProperty("fromPassword");
            mailSmtpHost = prop.getProperty("mail.smtp.host");
            mailSmtpPort = prop.getProperty("mail.smtp.port");
            effectiveTime = prop.getProperty("effectiveTime");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    //发送邮件 1.收件人 2.信息 3.标题 4.附件
    public static void sendEmail(String toAddress, String text, String subject, Multipart multipart) {
        Properties props = new Properties();
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
        props.put("mail.smtp.host", mailSmtpHost); //smtp服务器地址
        props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
        props.put("mail.smtp.socketFactory.fallback", "false");
        props.put("mail.smtp.port", mailSmtpPort);
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.auth", true);  //是否需要认证
        MailAuthenticator myauth = new MailAuthenticator(fromAddress, fromPassword);
        //获得一个带有authenticator的session实例
        javax.mail.Session session = javax.mail.Session.getInstance(props, myauth);
        session.setDebug(true);//打开debug模式，会打印发送细节到console
        Message message = new MimeMessage(session); //实例化一个MimeMessage集成自abstract Message 。参数为session
        try {
            message.setFrom(new InternetAddress(fromAddress)); //设置发出方,使用setXXX设置单用户，使用addXXX添加InternetAddress[]
            if (text != null) {
                message.setContent(text, "text/html;charset=utf-8"); //设置文本内容 单一文本使用setText,Multipart复杂对象使用setContent
            }
            if (multipart != null) {
                message.setContent(multipart);
            }
            message.setSubject(subject); //设置标题
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress)); //设置接收方
            Transport.send(message); //使用Transport静态方法发送邮件
        } catch (MessagingException e) {
            //此处处理MessagingException异常 [The base class for all exceptions thrown by the Messaging classes ]
            e.printStackTrace();
        }
    }

    //发送邮件 1.收件人 2.信息 3.标题 4.附件
    public static void sendEmail(String[] toAddress, String text, String subject, Multipart multipart) {
        Properties props = new Properties();
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
        props.put("mail.smtp.host", mailSmtpHost); //smtp服务器地址
        props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
        props.put("mail.smtp.socketFactory.fallback", "false");
        props.put("mail.smtp.port", mailSmtpPort);
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.auth", true);  //是否需要认证

        MailAuthenticator myauth = new MailAuthenticator(fromAddress, fromPassword);
        //获得一个带有authenticator的session实例
        javax.mail.Session session = javax.mail.Session.getInstance(props, myauth);
        session.setDebug(true);//打开debug模式，会打印发送细节到console
        Message message = new MimeMessage(session); //实例化一个MimeMessage集成自abstract Message 。参数为session
        try {
            message.setFrom(new InternetAddress(fromAddress)); //设置发出方,使用setXXX设置单用户，使用addXXX添加InternetAddress[]
            if (text != null) {
                message.setContent(text, "text/html;charset=utf-8"); //设置文本内容 单一文本使用setText,Multipart复杂对象使用setContent
            }
            if (multipart != null) {
                message.setContent(multipart);
            }
            message.setSubject(subject); //设置标题
            InternetAddress[] addresses = new InternetAddress[toAddress.length];
            for (int i = 0; i < toAddress.length; i++) {
                addresses[i] = new InternetAddress(toAddress[i]);
            }
            message.addRecipients(Message.RecipientType.TO, addresses);
            Transport.send(message); //使用Transport静态方法发送邮件
        } catch (MessagingException e) {
            //此处处理MessagingException异常 [The base class for all exceptions thrown by the Messaging classes ]
        }
    }

    // 船东需要验船时 发送给内部的邮件
    public static void sendEmailQuotationInner(EmailQuotation emailQuotation) {
        StringBuilder sb = new StringBuilder();
        sb.append("Ship name : ").append(emailQuotation.getShipName()).append("<br>");
        sb.append("Imo : ").append(emailQuotation.getImo()).append("<br>");
        sb.append("Inspection type : ").append(emailQuotation.getInspectionType()).append("<br>");
        if (StringUtils.isNotEmpty(emailQuotation.getDelivery())) {
            sb.append("Place of delivery: ").append(emailQuotation.getDelivery()).append("<br>");
        }
        if (StringUtils.isNotEmpty(emailQuotation.getReDelivery())) {
            sb.append("Place of re-delivery: ").append(emailQuotation.getReDelivery()).append("<br>");
        }
        sb.append("Port : ").append(emailQuotation.getPort()).append("<br>");
        sb.append("Estimated Date : ").append(DateUtil.formatDate(emailQuotation.getEstimatedDate(), "yyyy-MM-dd")).append("<br>");
        sb.append("Email : ").append(emailQuotation.getEmail()).append("<br>");
        sb.append("Role : ").append(emailQuotation.getRole()).append("<br>");
        sb.append("Special requirement :<br><label style='white-space: pre-wrap;word-wrap: break-word; '>").append(emailQuotation.getSpecialRequirement()).append("</label><br>");
        sb.append("Remote ip : ").append(emailQuotation.getRemoteIp()).append("<br>");

        sb.append("<br><br>-------------------------------------<br><br>");
        PublicShip ship = emailQuotation.getPublicShip();
        if (ship == null) {
            sb.append("数据库中没有这条船的信息");
        } else {
            sb.append("Ship name : ").append(ship.getName()).append("<br>");
            sb.append("Imo : ").append(ship.getImo()).append("<br>");
            sb.append("Dwt : ").append(ship.getDwt()).append("<br>");
            sb.append("BuilderYear : ").append(ship.getBuildyear()).append("<br>");
            sb.append("Flag : ").append(ship.getFlag()).append("<br>");
            sb.append("Class : ").append(ship.getClasss()).append(", SS(m/y) : ").append(ship.getNextSs()).append("<br>");
            sb.append("LOA : ").append(ship.getLoa()).append(", Beam : ").append(ship.getBeam()).append(", Draft : ").append(ship.getDraft()).append("<br>");
            sb.append("Maker/Type : ").append(ship.getEngine()).append(", BHP/RPM : ").append(ship.getHp()).append(", Cyl.bore : ").append(ship.getMcyl()).append("<br>");
        }
        sendEmail(fromAddress, sb.toString(), "有船船要进行检验(role : " + emailQuotation.getRole() + ")", null);
    }

    // 船东需要验船时 发送给船东的邮件
    public static void sendEmailQuotationOuter(EmailQuotation emailQuotation, List<InspectionTypePrice> prices) {
        StringBuilder sb = new StringBuilder();
        sb.append("<style>table,th,td{border:1px solid lightgray;text-align:center;vertical-align:middle;}</style>");
        sb.append("From <a href='www.goshipsurvey.com'>www.goshipsurvey.com</a>").append("<br><br>");
        sb.append("Ship name: ").append(emailQuotation.getShipName()).append("<br>");
        sb.append("Imo: ").append(emailQuotation.getImo()).append("<br>");
        sb.append("Inspection type: ").append(emailQuotation.getInspectionType()).append("<br>");
        if (StringUtils.isNotEmpty(emailQuotation.getDelivery())) {
            sb.append("Place of delivery: ").append(emailQuotation.getDelivery()).append("<br>");
        }
        if (StringUtils.isNotEmpty(emailQuotation.getReDelivery())) {
            sb.append("Place of re-delivery: ").append(emailQuotation.getReDelivery()).append("<br>");
        }
        sb.append("Port: ").append(emailQuotation.getPort()).append("<br>");
        sb.append("Estimated Date: ").append(DateUtil.formatDate(emailQuotation.getEstimatedDate(), "yyyy-MM-dd")).append("<br>");
        sb.append("Email: ").append(emailQuotation.getEmail()).append("<br>");
        sb.append("Role: ").append(emailQuotation.getRole()).append("<br>");
        sb.append("Special requirement: <label style='white-space: pre-wrap;word-wrap: break-word; '>").append(emailQuotation.getSpecialRequirement()).append("</label><br>");

        sb.append("<br><br>");


        // 价格表

        sb.append("Dear Sirs,").append("<br>");
        sb.append("Thanks for your enquiry.").append("<br>");
        sb.append("Pls find below our quotation for 2018").append("<br>");
        sb.append("<table>");
        sb.append("<tr>");
        sb.append("</tr>");

        for (InspectionTypePrice price : prices) {
            sb.append("<tr><td>");
            sb.append(price.getTypesText());
            sb.append("</td><td>");
            sb.append(price.getUnit()).append(price.getPrice());
            sb.append("</td></tr>");
        }

        sb.append("</table>");
//        sb.append("We herewith offer USD 1500 as the lumpsum fee for the pre-purchase inspection in ").append(emailQuotation.getPort()).append(" port.").append("<br>");
//        sb.append("Please confirm in order by providing the agent details and get the owners' approval/loi for our inspector to go on board the vessel for inspection. ").append("<br>");
//        sb.append("The details of the inspector will be provided to you within 24 hours.").append("<br>");
//        sb.append("After inspection, we will provide the access user id & passward together with the link for you to download  the survey report & photos once the full payment is receieved.").append("<br>");
//        sb.append("Our account details is to be advised with the signed loi.").append("<br>");

        sb.append("<br><br>--------------------<br><br>");

        sb.append("Thanks in advance!").append("<br>");

        sb.append("Best Rgds!").append("<br>");
        sb.append("PIC: Capt Shen").append("<br>");
        sb.append("Goship Group Company Limited").append("<br>");
        sb.append("Tel: +86 21 6841 6768").append("<br>");
        sb.append("Mobile: +86 139 1584 8533  (24HOURS)").append("<br>");
        sb.append("Email: <a href='mailto:survey@goshipgroup.com'>survey@goshipgroup.com</a>").append("<br>");
        sb.append("Website: <a href='www.goshipsurvey.com'>www.goshipsurvey.com</a>").append("<br>");

        String subject = "MV " + emailQuotation.getShipName() + " Quotation " + emailQuotation.getInspectionType()
                + " in " + emailQuotation.getPort() + " port "
                + DateUtil.formatDate(emailQuotation.getEstimatedDate(), "yyyy/MM/dd") + ")";

        sendEmail(emailQuotation.getEmail(), sb.toString(), subject, null);
    }


    //发送注册时的验证邮件
    public static void sendActivateEmail(String toAddress, String validateCode) {
        StringBuffer sb = new StringBuffer();
        sb.append("<html>");
        sb.append("<head>");
        sb.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>");
        sb.append("<title>Daily Report</title>");

        sb.append("<style>");
        sb.append(" a:hover img {  -webkit-transform: scale(1.5, 1.5);  -moz-transform: scale(1.5, 1.5);  -transform: scale(1.5, 1.5);  }");
        sb.append("</style>");

        sb.append("</head>");
        sb.append("<body>");
        sb.append("点击下面链接激活账号，").append(effectiveTime).append("分钟生效，否则重新注册账号，链接只能使用一次，请尽快激活!");
        sb.append("<br>");
        String href = sitePath + "/register/activate?action=activate&email=" + toAddress + "&validateCode=" + validateCode;
//        sb.append(sitePath + "/register/activate?action=activate&email=");
//        sb.append(toAddress);
//        sb.append("&validateCode=");
//        sb.append(validateCode);
        sb.append("<a href='").append(href).append("'>").append("点击进行激活").append("</a>");

        sb.append("<br>=================================<br>");
        String imgPath = "https://zhstatic.zhihu.com/eDM/roundtable/chunjiyundong.jpg";

        sb.append("<a href='").append(imgPath).append("'>");
        sb.append("<img id='img1' src='").append(imgPath).append("' />");
        sb.append("</a>");

        sb.append("</body>");
        sb.append("</html>");

        MailUtil.sendEmail(toAddress, sb.toString(), "欢迎注册", null);
    }
}
