---
title: Post-Deployment Configuration task fails
description: Helps fix an issue where the Post-Deployment Configuration task fails after you install the Windows Server Essentials Experience role.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.subservice: deployment
---
# The Post-Deployment Configuration task may fail after you install the Windows Server Essentials Experience role

This article provides a solution to an issue where the Post-Deployment Configuration task fails after you install the Windows Server Essentials Experience role.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2914651

## Symptoms

After you install the Windows Server Essentials Experience role on Windows Server 2012 R2, the Post-Deployment Configuration task may fail. Additionally, you receive the following error:  

> Configuration encountered some issues  
Please Click Retry. If the issue still exists, please refer to the help link for more troubleshooting steps.  

You may also receive one of the following error messages in the System log:  

> Log Name: System  
 Source: Service Control Manager  
 Event ID: 7000  
 Task Category: None  
 Level: Error  
 Keywords: Classic  
 User: N/A  
 Description:  
 The Windows Server Essentials Management Service service failed to start due to the following error:  
 The service did not start due to a logon failure.  

-or-  

> Log Name: System  
 Source: Service Control Manager  
 Event ID: 7041  
 Task Category: None  
 Level: Error  
 Keywords: Classic  
 User: N/A  
 Description:  
 The WseMgmtSvc service was unable to log on as CONTOSO.local\\**ServerAdmin$** with the currently configured password due to the following error:  
 Logon failure: the user has not been granted the requested logon type at this computer.  
>
> Service: WseMgmtSvc  
 Domain and account: CONTOSO.local\\**ServerAdmin$**  
>
> This service account does not have the required user right "Log on as a service."  

-or-  

> Log Name: System  
 Source: Service Control Manager  
 Event ID: 7041  
 Task Category: None  
 Level: Error  
 Keywords: Classic  
 User: N/A  
 Description:  
 The WseMediaSvc service was unable to log on as CONTOSO.local\\**MediaAdmin$** with the currently configured password due to the following error:  
 Logon failure: the user has not been granted the requested logon type at this computer.  
>
> Service: WseMediaSvc  
> Domain and account: CONTOSO.local\\**MediaAdmin$**  
>
> This service account does not have the required user right "Log on as a service."  

> [!NOTE]
> The service account names that are mentioned in these errors can sometimes have an additional number added if the account was already present in Active Directory. For example, **ServerAdmin1$** or **MediaAdmin2$** may be added. You should note these service account names because you will use the same account name in the "Resolution" section.  

## Cause

This behavior can occur if your environment has the "Log on as a Service" Group Policy setting configured.

While the Post-Deployment Configuration task is running, the Windows Server Essentials Management Service is configured to use the **ServerAdmin$** account to log on as a service and perform the task. After the Essentials Configurations are complete, the service is configured to use the **Local System** account.  

Similarly, the Windows Server Essentials Media Streaming Service is configured to use the **MediaAdmin$** account.  

## Resolution

To resolve this issue, follow these steps to add the service accounts that are mentioned in Event ID 7041 (that is, **DOMAIN\ServerAdmin$** and **DOMAIN\MediaAdmin$**) to the "Log on as a Service" Group Policy setting.  

1. Start Group Policy Management Console (GPMC). To do this, take one of the following actions: Press the Windows logo key + R to open the **RUN** dialog box, type **gpmc.msc** in the text box, and then click **OK** or press Enter. Or, click **Start**, click in the **Start Search** box, type **gpmc.msc**, and then press Enter.
2. Right-click **Default Domain Controllers Policy**, and then click **Edit**.
3. Browse to Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment.
4. In the details pane, double-click **Log on as a service**.
5. Make sure that the **Define these policy settings** check box is selected, and then click **Add User or Group**.
6. Type the name of the service account that is mentioned in Event ID 7041 For example, type **DOMAIN\ServerAdmin$** or **DOMAIN\MediaAdmin$**. Or, click **Browse** to locate the account with the **Select Users, Computers, or Groups** dialog box, and then click **OK**.
7. After you have the account name entered, click **OK** in the **Add User or Group** dialog box, and then click **OK** in the **Allow log on locally Properties** dialog box.
8. To update the modified Group Policy manually, at command prompt, type **gpupdate**, and then press Enter.
9. Rerun the Post-Deployment Configuration task.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
