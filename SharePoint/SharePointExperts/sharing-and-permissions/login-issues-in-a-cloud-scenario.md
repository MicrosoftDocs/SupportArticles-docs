---
title: SharePoint Designer 2013 login Issues in a cloud scenario
author: AmandaAZ
ms.author: joergsi
manager: joergsi
audience: ITPro
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
---

# SharePoint Designer 2013 login Issues in a cloud scenario

Microsoft SharePoint Designer 2013 can be used to create workflows, change design of classic pages and do much more. When you work SharePoint Designer 2013 with Office 365 SharePoint Online, you may get some login issues. To avoid login issues, make sure that SharePoint Designer 2013 and Office are up to date by using Windows Update.

## Issue

Assume that you install SharePoint Designer 2013 on Windows Server 2012 R2, Windows Server 2016, or Windows 10. You may also install Office 2013 or Office 2016. You open a SharePoint Site such as "https://contoso.sharepoint.de" by using SharePoint Designer 2013, the following sign-in dialog box may appear:

![the signinone dialog box](./media/login-issues-in-a-cloud-scenario/signinone.png)

When you click **Next** and type the password in the prompt dialog box, you receive the following error:

**There is a problem with your account. Please try again later.**

![the signintwo dialog box](./media/login-issues-in-a-cloud-scenario/signintwo.png)

This issue may occur when you work with SharePoint Server on-premises and modern authentication.

## Cause

Office 2013, including SharePoint Designer 2013, is not configured to use ADAL. You may find the ADAL.DLL (current build version 1.0.2019.909) in the folder "C:\Program Files (x86)\Common Files\Microsoft Shared\OFFICE15\ " or similar, depending on 32-bit or 64-bit of Windows or SharePoint Designer 2013. However, that DLL won't be loaded when you have a look by using [ProcessExplorer](https://technet.microsoft.com/en-us/sysinternals/processexplorer.aspx).

## Solution

To fix this issue, set the value of the **EnableADAL** registry key to 1 and check the **Version** registry key. For the two registry keys, see [Enable Modern Authentication for Office 2013 on Windows devices](https://docs.microsoft.com/en-us/office365/admin/security-and-compliance/enable-modern-authentication?redirectSourcePath=%252fen-us%252farticle%252fEnable-Modern-Authentication-for-Office-2013-on-Windows-devices-7dc1c01a-090f-4971-9677-f1b192d6c910&view=o365-worldwide).

After you set the registry key, restart SharePoint Designer 2013. Then the sign-in dialog box will be displayed as follows:

![the signinthree dialog box](./media/login-issues-in-a-cloud-scenario/signinthree.png)

This issue occurs with tests in the Microsoft Cloud Germany (MCG) (also called Microsoft Cloud Deutschland (MCD)).

## More information

If all related products are installed correctly and registry keys are set, but the login still doesn't work and you see earlier build numbers than those in the following screenshot, make sure that your Office and SharePoint Designer 2013 are up to date by using Windows Update.

![the signinfour dialog box](./media/login-issues-in-a-cloud-scenario/signinfour.png)

You can also install the latest updates for  SharePoint Designer 2013 and Office 2013 that contain ADAL.LL manually to troubleshoot this issue.

> [!NOTE]
> The latest ADAL.DLL may be available in [July 5, 2016, update for Office 2013 (KB3085565)](https://support.microsoft.com/en-US/help/3085565). And the latest SharePoint Designer 2013 update may be [August 2, 2016, update for SharePoint Designer 2013 (KB3114721)](https://support.microsoft.com/en-US/help/3114721).