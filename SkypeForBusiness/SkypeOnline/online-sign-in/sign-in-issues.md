---
title: How to troubleshoot sign-in issues in Skype for Business Online
description: Discusses how to troubleshoot sign-in issues in Skype for Business Online.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
---

# How to troubleshoot sign-in issues in Skype for Business Online

## Introduction 

This guide should be used to help troubleshoot and diagnose Skype for Business Online (formerly Lync Online) sign-in and authentication issues. If Skype for Business Online users are receiving a specific error message, see the [Skype for Business Online sign-in error messages](#skype-for-business-online-sign-in-error-messages) table in the “More Information” section for the best recommended strategy.

## Procedure 

The "Skype for Business Online Sign-In Guided Walkthroughs" help with identifying and resolving the main causes of sign-in issues. Before you read any further in this article or contact Technical Support, you should consult one of the following guided walkthroughs. To do this, click the appropriate link: 
 
- [Troubleshooting Skype for Business Online sign-in for users](https://support.microsoft.com/help/10054)

 Generally, Skype for Business Online sign-in problems can be broken up into four categories:  

|Category |Issue |Possible causes |
|-|-|-|
|Computer or Lync client issues|These issues typically occur for a specific user or for a small group of users who have similarly configured computers or devices.|Out-of-date client version, missing operating system or product hotfix, out-of-sync computer clock, incorrect cached credentials |
|Authentication and provisioning issues|These issues typically occur for specific kinds of users (for example, federated users or users who are on a specific domain) or for a specific user who may not be entering his or her sign-in address or password correctly.|Incorrect password or sign-in address, unlicensed user, Active Directory Federation Services (AD FS) not working correctly |
|Networking issues|These problems can affect large groups of users at a specific site or network location. They can also affect users who have a specific domain.|Domain Name System (DNS) for AutoDiscover not set up, proxy or firewall exceptions |
|Service-related issues|Typically, during service-related issues, all users in a tenant are affected, but not always. Service-related issues can affect certain kinds of users (for example, users in a specific geographic region or users on a specific Lync server).|Skype for Business Online service down, tenant subscription expired, Azure AD Authentication service down |
    
If the guided walkthrough doesn’t resolve the sign-in issue, review the table in the following section for explanations and common resolutions to each error message. Additional resources for specific sign-in related issues are also listed later in this article. 

## More information

### Skype for Business Online sign-in error messages

After you scope the problem by using the table that appears in the "Procedure" section, use either the **Error message** or **Type** column in the following table to narrow the troubleshooting steps.  

|Error message |Cause |Type| Resolution |
|-|-|-|-|
| The server is temporarily unavailable. Or we're having trouble connecting to the server. If this continues, please contact your support team.|No DNS record found, or Lync server isn't responding.|Network|**Admins:** Verify the Lync AutoDiscover DNS records. **Lync users:** Manually configure the Lync client as a temporary workaround. * |
|Lync couldn’t find a Lync Server for contoso.com. There might be an issue with the Domain Name System (DNS) configuration for your domain.|No DNS record. AutoDiscover fails.|Network|**Lync admins:** Verify the Lync AutoDiscover DNS records. **Lync users:** Manually configure the Lync client as a temporary workaround. * |
| You may have entered your sign-in address, user name, or password incorrectly, or the authentication service may be incompatible with this version of the program.|Wrong version of the Lync 2010 or Lync 2013 client.|Client|Verify that the Lync client is up to date and that the credentials are entered correctly. * |
| To sign in, additional software is required. Download and install now?|The Microsoft Online Services Sign-In Assistant isn't installed on the computer that has Lync 2010 installed.|Client|Run Office 365 Desktop Setup, or install the latest version of the Microsoft Online Services Sign-In Assistant. * |
| Cannot sign in to Lync because your computer clock is not set correctly. To check your computer clock settings, open Date and Time in the Control Panel.|The time or date is set incorrectly on the device.|Client|The system time or date is more than five minutes off from the time or date of the Lync server. * |
| There was a problem acquiring a personal certificate required to sign in. If the problem continues, please contact your support team.|Cached certificate or credentials are expired or corrupted.|Client|Clear cached credentials and certificates. Flush DNS. * |
| Sign-in address was not found.|User isn't licensed for Skype for Business Online.|Authentication|Verify that the user is licensed for Skype for Business Online. Verify that the sign-in address (SIP) is entered correctly. * |
| The username, password or domain appears to be incorrect.|Wrong user name, sign-in address, or password|Authentication|Verify that the SIP is correct. Check for a disjointed SIP or UPN scenario. **Note** Apostrophes (') aren’t supported in a SIP address. For more information about unsupported characters, see the "Directory object and attribute preparation" section of the following Microsoft website: [Prepare to provision users through directory synchronization to Office 365](https://support.office.com/article/prepare-to-provision-users-through-directory-synchronization-to-office-365-01920974-9e6f-4331-a370-13aea4e82b3e). |
| The server is not responding or cannot be reached. Sign-in may be delayed while we retry the connection.|Can't contact the authentication service. AD FS 2.0 or Azure AD isn't available.|Authentication|Lync admins: Verify AD FS capabilities. |
| There was a problem verifying the certificate from the server. Sign-in may be delayed while we retry the connection.|Can't verify the certificate chain from the AD FS 2.0 server.|Authentication|Lync admins: Verify that clients have trusted root certification authority (CA) installed. |
    
> [!NOTE]
> The resolutions that are marked with an asterisk (*) are included in the guided walkthrough. 

### Skype for Business Online sign-in resources

**Resources and solutions for Skype for Business Online users**  

- [Office.com](https://office.microsoft.com/redir/ha102758577.aspx) Troubleshooting Skype for Business Online Sign-in Errors    
- [2629861](https://support.microsoft.com/help/2629861) Troubleshoot sign-in issues with Lync for Mac 2011    
- [2531068](https://support.microsoft.com/help/2531068) "Lync cannot verify that the server is trusted for your sign-in address." message when you sign in to Lync 2010 by authenticating to Skype for Business Online    
- [2459899](https://support.microsoft.com/help/2459899) Lync 2010 requires additional software to sign in to Skype for Business Online    
- [2604176](https://support.microsoft.com/help/2604176) After a server-side operation or update, Skype for Business Online users can’t sign in because of certificate-related errors    
- [2868219](https://support.microsoft.com/help/2868219) "You can’t sign-in with this version of Lync. Please install Lync 2010" error after Lync Mobile 2013 is installed    
- [2581291](https://support.microsoft.com/help/2581291) Skype for Business Online sign-in error if settings such as the computer time, date, user name, and password are incorrect    

**Resources and solutions for Skype for Business Online admins**  

- [2705378](https://support.microsoft.com/help/2705378) Error message when you try to sign in to Skype for Business Online: "Cannot sign in to Lync because this sign-in address was not found"  
- [2757450](https://support.microsoft.com/help/2757450) Users can't sign in to Skype for Business Online in a hybrid deployment of Lync Server 2013    
- [2839539](https://support.microsoft.com/help/2839539) Enterprise single sign-on users in Office 365 can't sign in to Skype for Business Online from inside their corporate network    
- [2636329](https://support.microsoft.com/help/2636329) "Cannot connect to the server" error message when Skype for Business Online users try to sign in to the Lync 2010 mobile client on a mobile device    
- [2806012](https://support.microsoft.com/help/2806012) Users can't sign in to Skype for Business Online by using Lync Mobile 2013    
- [2526143](https://support.microsoft.com/help/2526143) You can't sign in to Skype for Business Online by using a domain that is configured for full redelegation    
- [2866501](https://support.microsoft.com/help/2866501) "Can't connect to the server" error message when a Skype for Business Online user tries to sign in to Lync Mobile 2010 on Windows Phone 7  
- [2773530](https://support.microsoft.com/help/2773530) Users can't sign in to Lync Mobile on Apple iOS-based devices because of certificate errors    
- [2566790](https://support.microsoft.com/help/2566790) Troubleshooting Skype for Business Online DNS configuration issues in Office 365    
- [2769142](https://support.microsoft.com/help/2769142) Lync 2013 or Lync 2010 can't connect to the Skype for Business Online service because a proxy is blocking connections from MSOIDSVC.exe    
- [2409256](https://support.microsoft.com/help/2409256) You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection    
- [2430520](https://support.microsoft.com/help/2430520) Error in the Office 365 portal: "Value of msRTCSIP-PrimaryUserAddress or the SIP address in the ProxyAddresses field in your local Active Directory is not unique"    
- [2254265](https://support.microsoft.com/help/2254265) The "500" error code is returned when you send an HTTP SOAP request to the "/adfs/services/trust/mex" endpoint on a computer that is running Windows Server 2008 R2 or Windows Server 2008    

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).