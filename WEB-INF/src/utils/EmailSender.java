package utils;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;
import javax.mail.Message.RecipientType;
public class EmailSender {
  public static String fromEmail;
  public static String fromPass;
  public static class EmailAuthenticator extends Authenticator{
    public PasswordAuthentication getPasswordAuthentication(){
        return new PasswordAuthentication(fromEmail,fromPass);
    }
  }

  public static void sendEmail(String to,String subject,String emailContent){
    Properties prop = new Properties();

    prop.put("mail.transport.protocol","smtp");
    prop.put("mail.smtp.host","smtp-mail.outlook.com");
    prop.put("mail.smtp.port","587");
    prop.put("mail.smtp.auth","true");
    prop.put("mail.smtp.starttls.enable","true");

    Session mailSession = Session.getInstance(prop,new EmailAuthenticator());

    MimeMessage msg = new MimeMessage(mailSession);

    try{
      msg.setFrom(fromEmail);
      msg.setRecipients(RecipientType.TO,to);
      msg.setSubject(subject);
      msg.setContent(emailContent,"text/html");

      Transport.send(msg);
    }catch(MessagingException e){
      e.printStackTrace();
    }


  }
}
