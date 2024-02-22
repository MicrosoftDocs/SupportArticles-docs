---
title: SharePoint Designer 2013 login Issues in a cloud scenario
description: Describes the login issues in a cloud scenario of SharePoint Designer 2013.
author: helenclu
ms.author: luche
ms.reviewer: joergsi
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: sap:spsexperts, CSSTroubleshoot
appliesto: 
  - SharePoint Designer 2013
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Designer 2013 login Issues in a cloud scenario

This article was written by [Joerg Sinemus](https://social.msdn.microsoft.com/profile/Joerg+Sinemus), Escalation Engineer.

Microsoft SharePoint Designer 2013 can be used to create workflows, change design of classic pages and do much more. When you work SharePoint Designer 2013 with Microsoft 365 SharePoint Online, you may get some login issues. To avoid login issues, make sure that SharePoint Designer 2013 and Office are up to date by using Windows Update.

## Symptoms

Assume that you install SharePoint Designer 2013 on Windows Server 2012 R2, Windows Server 2016, or Windows 10. You may also install Office 2013 or Office 2016. You open a SharePoint Site such as "https://contoso.sharepoint.de" by using SharePoint Designer 2013, the following sign-in dialog box may appear:

:::image type="content" source="media/login-issues-in-a-cloud-scenario/type-email-signin-dialog.png" alt-text="Screenshot of the sign in dialog: Type the email of the account you would like to use to open https://contoso.sharepoint.de." border="false":::

When you click **Next** and type the password in the prompt dialog box, you receive the following error:

**There is a problem with your account. Please try again later.**

:::image type="content" source="media/login-issues-in-a-cloud-scenario/signin-error.png" alt-text="Screenshot of the error after type the password." border="false":::

This issue may occur when you work with SharePoint Server on-premises and modern authentication.

## Cause

Office 2013, including SharePoint Designer 2013, is not configured to use ADAL. You may find the ADAL.DLL (current build version 1.0.2019.909) in the folder "C:\Program Files (x86)\Common Files\Microsoft Shared\OFFICE15\ " or similar, depending on 32-bit or 64-bit of Windows or SharePoint Designer 2013. However, that DLL won't be loaded when you have a look by using [ProcessExplorer](/sysinternals/downloads/process-explorer).

## Resolution

To fix this issue, set the value of the **EnableADAL** registry key to 1 and check the **Version** registry key. For the two registry keys, see [Enable Modern Authentication for Office 2013 on Windows devices](/office365/admin/security-and-compliance/enable-modern-authentication).

After you set the registry key, restart SharePoint Designer 2013. Then the sign-in dialog box will be displayed as follows:

:::image type="content" source="media/login-issues-in-a-cloud-scenario/microsoft-account-signin-dialog.png" alt-text="Screenshot of the sign-in dialog for entering the account name and password of your Microsoft account." border="false":::

This issue occurs with tests in the Microsoft Cloud Germany (MCG) (also called Microsoft Cloud Deutschland (MCD)).

### Connection issues

If SharePoint Designer is experiencing connection issues to SharePoint sites, try the following common solutions.

1. Verify that SharePoint Designer 2013 is updated with [SharePoint Designer Service Pack 1](https://support.microsoft.com/help/2817441) and the [August 2, 2016, Update for SharePoint Designer 2013](https://support.microsoft.com/help/3114721).

2. Clear the local cache files:

   1. Close SharePoint Designer 2013.
   2. On the local computer, remove all files found in each of the following folders.

       > %APPDATA%\Microsoft\Web Server Extensions\Cache  
       %APPDATA%\Microsoft\SharePoint Designer\ProxyAssemblyCache  
       %USERPROFILE%\AppData\Local\Microsoft\WebsiteCache

   3. Open SharePoint Designer 2013 and enter the account again to see if it works.

3. [Enable Modern Authentication for Office 2013 on Windows Devices](/microsoft-365/admin/security-and-compliance/enable-modern-authentication).

4. Administrators will need to **Allow Custom Script** in the SharePoint Admin Center settings to allow the SharePoint Designer connection. See [Allow or prevent custom script](/sharepoint/allow-or-prevent-custom-script) for more information.

## More information

If all related products are installed correctly and registry keys are set, but the login still doesn't work and you see earlier build numbers than those in the following screenshot, make sure that your Office and SharePoint Designer 2013 are up to date by using Windows Update.

:::image type="content" source="media/login-issues-in-a-cloud-scenario/build-number.png" alt-text="Screenshot of the build number: Microsoft SharePoint Designer 2013 (15.0.4849.1000) MSO (15.0.4919.1002) 64-bit." border="false":::

You can also install the latest updates for  SharePoint Designer 2013 and Office 2013 that contain ADAL.LL manually to troubleshoot this issue.

> [!NOTE]
> The latest ADAL.DLL may be available in [July 5, 2016, update for Office 2013 (KB3085565)](https://support.microsoft.com/help/3085565). And the latest SharePoint Designer 2013 update may be [August 2, 2016, update for SharePoint Designer 2013 (KB3114721)](https://support.microsoft.com/help/3114721).