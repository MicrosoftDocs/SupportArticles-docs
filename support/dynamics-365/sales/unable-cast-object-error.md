---
title: Unable to cast object error
description: Fixes an communication issue that occurs when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Unable to cast object error when configuring Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a solution to an error that occurs when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics CRM 2016, Microsoft CRM client for Microsoft Office Outlook, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 3182511

## Symptoms

When attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error:

> "There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.

> Unable to cast object of type 'System.Int32' to type 'System.String'. at Microsoft.Crm.Application.Outlook.Config.OutlookCRMDatastoreInstaller.GetAllCRMOrgsInOutlookProfile()..."

## Cause

This error can occur if a prior configuration attempt partially created a CRM data file in Outlook.

## Resolution

Follow the steps below to remove the incomplete CRM data file in Outlook:

1. Open the Control Panel in Windows. If you can't locate Control Panel, select **Start** and search for **Control Panel**.
2. Use the **Search** textbox to search for **mail**.
3. Select **Mail**.
4. Select the **Data Files** button.
5. If a row appears with the name of Microsoft Dynamics CRM Database, select it and then select **Remove**.
6. Select **Yes** when prompted to confirm.
7. Close the **Data Files** dialog.
8. Attempt to configure CRM for Outlook again.

If you still meet issues installing, enabling, or connecting CRM for Outlook with a CRM Online organization, run the [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant).

## More information

The error found in the log file contains the following detail:

> Error| Exception : Unable to cast object of type 'System.Int32' to type 'System.String'. at Microsoft.Crm.Application.Outlook.Config.OutlookCRMDatastoreInstaller.GetAllCRMOrgsInOutlookProfile()  
 at Microsoft.Crm.Application.Outlook.Config.ConfigInfo..ctor()  
 at Microsoft.Crm.Application.Outlook.Config.MainForm..ctor()  
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.CreateAndShowForm(Boolean runInsideOutlook)  
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.AddDeployment_FullUI(Boolean runInsideOutlook)  
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.Run(Boolean runInsideOutlook)  
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.Start(String[] args, Boolean runInsideOutlook)
