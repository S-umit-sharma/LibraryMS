package utils;

public class MessageTemplate {
    public static String getSignupSuccessMessage(){
        String signupSuccess = "Your sign up is successfull, Please verify your email+\n+Then Click on the login button";

        return signupSuccess;
    }

    public static String getEmailVerificationSuccessMessage(){
        String emailVerifcationSuccess = "Your email is success fully Verified please go back and Click on login Button";

        return emailVerifcationSuccess;
    }

    public static String getIncorrectEmailMessage(){
        String incorrectMessage = "Your email is incorrect";

        return incorrectMessage;
    }

    public static String getIncorrectPasswordMessage(){
        String invalidPassword = "Invlaid Password... Try Again...!! ";

        return invalidPassword;
    }

    public static String getIncompleteEmailVerificationMessage(String email){
        String incompleteEmailVerfication = "Your Email Verification is Incomplete... please Click Over the Link :<a href='resend_verification_mail.do'>Resend Verfication Mail</a>"+
        "We have Send a mail To your This Email"+AppUtils.printEmailPattern(email);

        return incompleteEmailVerfication;
    }

    public static String getIncompleteManualVerificationMessage(){
        String manulaMsg = "Your Manual Verfication is Under Process It take upto 2-3 working days";

        return manulaMsg;
    }
}

