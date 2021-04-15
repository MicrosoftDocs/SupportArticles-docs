---
title: Couldn't load file
description: Provides a solution to errors that occur when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Error messages display when you configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a solution to errors that occur when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2013 Service Pack 1  
_Original KB number:_ &nbsp; 3090728

## Symptoms

When you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.

When you select **details**, the following additional detail is displayed:

> Could not load file or assembly 'System.Data.SqlServerCe, Version=4.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' or one of its dependencies. The system cannot find the file specified.    at Microsoft.Crm.Application.SMWrappers.CrmSqlCeDatabase.CreateDatabase(Boolean force)  
   at Microsoft.Crm.Application.SMWrappers.CrmSqlCeDatabase.Initialize()  
   at Microsoft.Crm.Application.SMWrappers.CrmSqlCeDatabase.get_ConnectionString()  
   at Microsoft.Crm.Application.Outlook.ClientMetadataCache.ClientMetadataSync.GetDataWriteFactoryInstance()  
   at Microsoft.Crm.Application.Outlook.ClientMetadataCache.ClientMetadataSync.CreateDataWriter[TReturn](Func\`2 action)  
   at Microsoft.Crm.Application.Outlook.ClientMetadataCache.ClientMetadataSync.get_IsValid()  
   at Microsoft.Crm.Application.Outlook.ClientMetadataCache.ClientDynamicMetadataCache.<>c__DisplayClass1d.<.ctor>b__1a()  
   at Microsoft.Crm.Application.Outlook.ClientMetadataCache.DeferredMetadataCacheManager.ExecuteWaitUntilReady(Guid organizationId, Action action)  
   at Microsoft.Crm.Application.Outlook.ClientMetadataCache.ClientDynamicMetadataCache..ctor(IOrganizationContext context, Boolean reloadAsynchronously)  
   at Microsoft.Crm.Application.Outlook.ClientMetadataCache.ClientDynamicMetadataCache.LoadCache(IOrganizationContext context, Boolean unusedHere)  
   at Microsoft.Crm.Metadata.MetadataCache.GetInstance(IOrganizationContext context)  
   at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.InitializeMapiStoreForFirstTime()  
   at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler  
   at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)

## Cause

Microsoft SQL Server Compact 4.0 SP1 isn't installed.

## Resolution

Install [Microsoft® SQL Server® Compact 4.0 SP1](https://www.microsoft.com/download/details.aspx?id=30709).

## More information

If you're still coming with issues connecting CRM for Outlook to your CRM Online organization, [CRM for Outlook Configuration Diagnostic](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant) is available to help diagnose the issue.
