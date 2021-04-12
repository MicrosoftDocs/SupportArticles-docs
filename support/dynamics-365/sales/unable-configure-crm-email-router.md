---
title: Unable to configure CRM E-mail Router
description: Provides a solution to an error that occurs when you're unable to configure the Microsoft Dynamics CRM E-mail Router against an OnPremise deployment.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to configure the Microsoft Dynamics CRM E-mail Router

This article provides a solution to an error that occurs when you're unable to configure the Microsoft Dynamics CRM E-mail Router against an OnPremise deployment.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2501732

## Symptoms

Unable to configure the Microsoft Dynamics CRM E-mail Router against an OnPremise deployment. The following error is returned:

> The E-mail Router Configuration Manager was unable to retrieve user and queue information form the Microsoft Dynamics CRM server. This may indicate that the Microsoft Dynamics CRM server is busy. Verify that URL `https://crmservername/orgname` is correct. Additionally, this problem can occur if specified access credentials are insufficent. To try again, click Load Data. (The provided uri did not return any Service Endpoints!)

## Cause

Microsoft Dynamics CRM 2011 uses WCF endpoints for client communications. The WCF endpoints can't support more than one binding per Protocol.

If the CRM website has more than one http or more than one https binding, the E-mail Router will fail to configure.

## Resolution

Open IIS Manager and limit the CRM Website to one http and (or) one https binding.

1. Select **Start**, select **Run**, and Type in **inetmgr**.
2. Expand **Sites** and select the **Microsoft Dynamics CRM** website.
3. In the **Actions** Pane, select **Bindings**.
4. In the **Site Bindings** window, ensure that you only have one http and/or only have one https binding type. If you have multiple http and/or multiple https bindings, they need to be removed.

> [!NOTE]
>
> - The binding that should remain is the binding that is defined in the Deployment Manager. To check the urls, open Deployment Manager, right-click on **Microsoft Dynamics CRM** and choose **Properties**, select the **Web Address** tab.
> - If IFD is used, the Certificate matching your IFD settings should be kept.
