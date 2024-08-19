---
title: Info about AllowAdalForNonLyncIndependentOfLync setting
description: Describes the AllowAdalForNonLyncIndependentOfLync setting in Skype for Business, Lync 2013, and Exchange Online in Microsoft 365.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
  - Skype for Business 2015
  - Exchange Online
  - Microsoft Lync 2013
  - Skype for Business Online
ms.date: 03/31/2022
---

# Info about AllowAdalForNonLyncIndependentOfLync setting in Skype for Business, Lync 2013, and Exchange Online

## Introduction

This article contains information about the **AllowAdalForNonLyncIndependentOfLync** setting in Skype for Business 2016, Skype for Business 2015, Lync 2013, and Exchange Online. This article also describes which Exchange Online and Skype for Business deployments require this setting.  

## More information

The information in this article helps IT and Microsoft 365 administrators in the following scenarios: 
 
- Setting up Lync 2013 and Skype for Business users to be homed on Skype for Business Server 2015 or Lync Server 2013 on-premises.    
- Setting up mailboxes in Exchange Online in Microsoft 365 by using Modern Authentication and Multi-factor Authentication (MFA) with OAuth.    
 
In these scenarios, the available functionality in the previous environment is as follows: 
 
- The Skype for Business Desktop and Lync 2013 clients connect to Skype for Business Server by using NTLM or the Kerberos authentication protocol, a user name and password, or Windows Integrated Authentication.     
- After you sign in, Skype for Business or Lync 2013 connects to the user's mailbox in Exchange Online by using Exchange Web Services (EWS). Although the EWS service advertises OAuth settings (the authorization URI), the client ignores this and falls back to a non-MFA sign-in by using an OrgID channel. This limits sign-in protocols to a user name and password or to Windows Integrated Authentication.    
 
The new **AllowAdalForNonLyncIndependentOfLync** setting lets Skype for Business Desktop or Lync 2013 clients unblock MFA in Exchange Online in situations in which the IT administrator must enforce MFA on Exchange Online. You can apply this new setting by using Group Policy in the Windows registry or as an in-band endpoint policy setting on the Skype for Business server.

After you apply this setting to the client computer, the environment functionality is as follows: 
 
- The Skype for Business Desktop or Lync 2013 clients connects to Skype for Business Server by using NTLM or the Kerberos authentication protocol. Specifically, a user name and password or Windows Integrated Authentication will be required for a successful connection (as it was previously).    
- After you sign in, Skype for Business or Lync 2013 connects to Exchange Web Services (EWS). If the EWS service advertises OAuth settings (authorization URI), the client uses MFA. Additionally, if a credentials refresh is necessary, the user will be prompted through the Modern Authentication dialog box.    
 
> [!NOTE]
> This setting is not required for cloud-only topologies or if Exchange and Skype for Business are both configured for a hybrid environment that has Modern Authentication enabled. For detailed information about the topologies, see [Skype for Business topologies supported with Modern Authentication](/skypeforbusiness/plan-your-deployment/modern-authentication/topologies-supported).  

In some cases (specifically, Mixed 1, Mixed 3, and Mixed 5 topologies as described in [Skype for Business topologies supported with Modern Authentication](/skypeforbusiness/plan-your-deployment/modern-authentication/topologies-supported)), you have to set the **AllowADALForNonLynIndependentOfLync** registry key correctly for Windows desktop clients.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Use either of the following methods to apply the **AllowAdalForNonLyncIndependentOfLync** setting. 

### Method 1: Use Group Policy
 
> [!NOTE]
> The option to enable this setting through Group Policy is available only after you apply the July 2015 Public Update (PU). 

For Skype for Business or Lync 2013 clients 15.0* (available from the September 2015 PU only):

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Lync** 
 
For Skype for Business or Lync 2013 clients 16.0*: 

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Lync** 
 
Then, apply the **AllowAdalForNonLyncIndependentOfLync** registry key setting:  

"**AllowAdalForNonLyncIndependentOfLync**"=**dword**:**00000001**
 
### Method 2: As an in-band setting on the Lync server
 
> [!NOTE]
> This option is available through the September PU only. 

To enable the in-band setting on the Lync server, run the following cmdlet:   

```powershell
$a = New-CsClientPolicyEntry -name AllowAdalForNonLyncIndependentOfLync -value "True" 
Set-CsClientPolicy -Identity Global -PolicyEntry @{Add=$a} 
```

> [!IMPORTANT]
> To enable Modern Authentication for Office 2013 applications on a Windows-based device, you must set the following additional registry key.

|Registry key |Type| Value |
|-|-|-|
|`HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Identity\EnableADAL`|REG_DWORD|1 |
|`HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Identity\Version`|REG_DWORD|1 |

For more information about the EnableADAL setting, go to the following Microsoft website: 

[Enable Modern Authentication for Office 2013 on Windows devices](https://support.office.com/article/enable-modern-authentication-for-office-2013-on-windows-devices-7dc1c01a-090f-4971-9677-f1b192d6c910) 

For more information about the Skype for Business Desktop client version for Modern Authentication flow (July update), see the following Knowledge Base article: 

[3054946](https://support.microsoft.com/help/3054946) July 14, 2015, update for Lync 2013 (Skype for Business) (KB3054946)

**Notes** 
 
- Method 2 is available to customers who have the Lync 2013 (Skype for Business) update published in or after September 2015.    
- The same September update (or a later version) has more Modern Authentication-related fixes. Customers should plan to upgrade to it after it is published.    

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
