---
title: The database file cannot be found when configuring CRM for Outlook
description: Provides a solution to an error that occurs when configuring Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# The database file cannot be found error when you configure Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a solution to an error that occurs when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 3091650

## Symptoms

When you try to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error message:

> "There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator."

When you select details, the following additional detail is shown:

> The database file cannot be found. Check the path to the database. [ Data Source = C:\Users\\*\<user>*\AppData\Local\Microsoft\MSCRM\Client\MetadataCache-93d47f8c-8eb3-45a6-98c8-d668f4ff9b4c.sdf ] at System.Data.SqlServerCe.SqlCeConnection.Open(Boolean silent)  
 at System.Data.SqlServerCe.SqlCeConnection.Open()  
 at Microsoft.Crm.Application.SMWrappers.CrmSqlCeConnection.Open()  
 at Microsoft.Crm.Application.SMWrappers.CrmSqlCeConnection.ExecuteInNewConnection[TReturn](String connectionString, Func\`2 actions, Func\`2 exceptionHandler, Boolean disposeConnection)  
 at Microsoft.Crm.Application.Outlook.ClientMetadataCache.SqlCeManager.GetObjectsReader(MetadataCollectionInfo info, IList\`1 requiredValues)  
 at Microsoft.Crm.Application.Outlook.ClientMetadataCache.SqlCeManager.GetObjectsReader(MetadataCollectionInfo info)  
 at Microsoft.Crm.Application.Outlook.ClientMetadataCache.MetadataCacheManager.GetObjectsDataReader(MetadataCollectionInfo info)  
 at Microsoft.Crm.Application.Outlook.ClientMetadataCache.Collections.OnDemandMetadataCollection\`1.CreateEnumerator()  
 at Microsoft.Crm.Application.Outlook.ClientMetadataCache.Collections.OnDemandBaseCollection\`1.System.Collections.IEnumerable.GetEnumerator()  
 at Microsoft.Crm.Caching.UserEntityUISettingsCache.LookupEntries(Guid userId, IOrganizationContext context, DynamicMetadataCache cache)  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.InitializeMapiStoreForFirstTime()  
 at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler)  
 at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)

## Cause

Microsoft is aware of a scenario where this error may occur after configuring Microsoft Dynamics CRM for Microsoft Office Outlook and then deleting that configuration.

## Resolution

Close the Microsoft Dynamics CRM for Outlook Configuration Wizard and attempt the configuration again.

If you're still meeting issues connecting CRM for Outlook to your CRM Online organization, [a diagnostic tool](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant) is available to help diagnose the issue.
