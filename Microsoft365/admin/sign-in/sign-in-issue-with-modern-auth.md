---
title: Troubleshoot sign-in issues with modern authentication when use AD FS
description: Discusses how to troubleshoot issues  that affect the ability to sign in to Office apps that are enabled for modern authentication.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Azure Active Directory
ms.date: 03/31/2022
---

# Troubleshoot sign-in issues with Office modern authentication when you use AD FS

## Introduction 

This article contains information about how to troubleshoot problems that affect the ability to sign in to Microsoft Office 2016 apps and Microsoft Office 2013 apps that are enabled for modern authentication. This article also contains resources for IT administrators to address reports about Active Directory Federation Services (AD FS) issues that are specific to Office for Windows platforms.

The following table lists known issues and recommended solutions.

|Issue|Recommendation|
|---|---|
|"An error occurred. Contact your administrator" message when you try to sign in to an Office 2016 or Office 2013 modern authentication app|To resolve this issue, contact your administrator and refer to this article.|
|Desktop single sign-on (SSO) with AD FS fails|To resolve this issue, contact your administrator and refer to this article.|

If you have an issue that's not listed in this article, go to the following Microsoft TechNet wiki page. The wiki page lists other known issues and workarounds.

[Office 2013 and Microsoft 365 Apps for enterprise modern authentication: Things to know before onboarding](https://social.technet.microsoft.com/wiki/contents/articles/30214.office-2013-and-office-365-proplus-modern-authentication-things-to-know-before-onboarding.aspx)

## More information 

### Issue: "An error occurred. Contact your administrator" when you try to sign in to an Office 2016 or Office 2013 modern authentication app

Users can't sign in if the Microsoft 365 organization uses AD FS and forms-based authentication is turned off on the AD FS server. In this situation, users receive the following error message:

```output
An error occurred 

An error occurred. Contact your administrator for more information. 

Error details 

- Activity ID: 00000000-0000-0000-c32d-00800000005e    
- Relying party: Microsoft Office 365 Identity Platform    
- Error time: <Date> <Time>    
- Cookie: enabled    
- User agent string: Mozilla/5.0 (Windows NT 6.3;WOW64) 
  AppleWebKit/537.36 (KHTML, like Gecko) 
  Chrome/38.0.2125.111 Safari/537.36
```
    
In certain AD FS configurations, the administrator may not have forms-based authentication enabled on the AD FS server. This prevents Windows clients that are running Office from logging in as required by the authentication process. 

To resolve this issue, set up AD FS to use forms-based authentication as the secondary form of authentication. To do this, follow the appropriate steps for the version that you use. 

> [!NOTE]
> The currently configured authentication methods can remain unchanged. For example, if Windows Integrated Authentication is configured as the primary authentication method, it can remain configured this way.

#### If you use AD FS 2.0
 
Enable forms-based authentication by using the steps in [AD FS 2.0: How to Change the Local Authentication Type](https://social.technet.microsoft.com/wiki/contents/articles/1600.ad-fs-2-0-how-to-change-the-local-authentication-type.aspx).

#### If you use AD FS in Windows Server 2012 R2

Follow these steps: 

1. In Server Manager on the AD FS 3.0 server, click **Tools**, and then click **AD FS Management**.   
2. In the AD FS snap-in, click **Authentication Policies**.   
3. In the **Primary Authentication** section, click **Edit** next to **Global Settings.**   
4. In the **Edit Global Authentication Policy** dialog box, click the **Primary** tab.   
5. In the **Extranet** and **Intranet** sections, select the **Forms Authentication** check box.

   :::image type="content" source="media/sign-in-issue-with-modern-auth/enable-global-authentication-policy.png" alt-text="Screenshot of the Edit Global Authentication Policy dialog box, showing the Forms Authentication check boxes.":::

### Issue: Desktop single sign-on (SSO) with AD FS fails

Desktop SSO is the process that's used to obtain seamless sign-in to Microsoft 365 resources through AD FS from a domain-joined computer that's inside a company network. When desktop SSO fails, users may be unable to activate Microsoft 365 Apps for enterprise or users may be prompted for forms-based logon even though they are using domain joined-computers from inside the company network. 

Modern authentication (ADAL) with AD FS requires the /adfs/services/trust/13/windowstransport endpoint to be enabled.

To enable the endpoint, run the following Windows PowerShell command on the AD FS server:

```powershell
Enable-AdfsEndpoint -TargetAddressPath "/adfs/services/trust/13/windowstransport"
```

## References 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/)
