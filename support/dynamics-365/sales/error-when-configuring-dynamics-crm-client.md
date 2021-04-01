---
title: Error when configuring Dynamics CRM client
description: Provides a solution to an error that occurs when you configure the Microsoft Dynamics CRM client for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# There is a problem communicating with the Microsoft Dynamics CRM server error message displays when you configure the Microsoft Dynamics CRM client for Outlook

This article provides a solution to an error that occurs when you configure the Microsoft Dynamics CRM client for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2834554

## Symptoms

When you're trying to configure the Microsoft Dynamics CRM client for Microsoft Office Outlook, you receive the following error message:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.

Error in the Crm50ClientConfig.log file:

> Error| Exception : An error has occurred. Try this action again. If the problem continues, check the Microsoft Dynamics CRM Community for solutions or contact your organization's Microsoft Dynamics CRM Administrator. Finally, you can contact Microsoft Support. at Microsoft.Crm.MapiStore.DataStore.WaitInitialized()  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.InitializeMapiStoreForFirstTime()  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler)  
 at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)  
Error| Exception : Server was unable to process request.

## Cause

This error can occur if you try to configure the Microsoft Dynamics CRM client for Outlook against a Microsoft Dynamics CRM server that has an incorrect entry in the ConfigSettings table of the MSCRM_Config database for the HelpServerUrl column.

## Resolution

Update the HelpServerUrl setting to a valid http address

1. Open SQL Server Management Studio, and connect with the instance hosting Microsoft Dynamics CRM 2011.
2. Select new query and run a select statement to check the HelpServerUrl setting on the MSCRM_Config database for the configsettings table:

    ```sql
    Use MSCRM_CONFIG
    go
    select HelpServerUrl from configsettings 
    ```

    If the results aren't in an http format, make a backup of the MSCRM_config database and then update the setting with a query such as below:

    ```sql
    Use MSCRM_Config
    go
    update ConfigSettings set HelpServerUrl = 'https://<crmserver>/'
    ```
