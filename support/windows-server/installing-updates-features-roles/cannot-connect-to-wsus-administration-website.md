---
title: Unable to connect to WSUS Administration Website
description: Provides a solution to an issue where you're unable to connect to WSUS Administration website.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Unable to connect to WSUS Administration Website

This article provides a solution to an issue where you're unable to connect to WSUS Administration website.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2737219

## Symptoms

- You are unable to connect to **WSUS Administration** website while opening "**Windows Server Update Service**"
- In addition to this when you open Windows Small Business Server Console you get error message "**An error occurred while retrieving updates information**" under "**Updates**" tab.

**You see HTTP Error 500 in IIS log file for WSUS Administration Website:**  
> *\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 GET /selfupdate/iuident.cab - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 - 500 24 50 3715  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /reportingwebservice/reportingwebservice.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+2.0.50727.4927) 500 24 50 422  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /ApiRemoting30/WebService.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+2.0.50727.4927) 500 24 50 6  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /ServerSyncWebService/serversyncwebservice.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+2.0.50727.4927) 500 24 50 601  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /ClientWebService/Client.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+2.0.50727.4927) 500 24 50 508  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /ReportingWebService/ReportingWebService.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Windows-Update-Agent 500 24 50 12078  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /SimpleAuthWebService/SimpleAuth.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+2.0.50727.4927) 500 24 50 547  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /DssAuthWebService/DssAuthWebService.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+2.0.50727.4927) 500 24 50 483  
*\<DateTime>* fe80::e3a4:2b81:92b4:c6e7%11 POST /ApiRemoting30/WebService.asmx - 8530 - fe80::e3a4:2b81:92b4:c6e7%11 Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+4.0.30319.1) 500 24 50 8  

 **After enabling Failed Request Tracing on "WSUS Administration" and "ApiRemoting30" Websites  for Http status code 500, results in the following errors.**  
> `http://<ServerName>:8530/ApiRemoting30/WebService.asmx`
>
> App Pool WsusPool
Authentication NOT_AVAILABLE  
User from token  
Activity ID {00000000-0000-0000-9000-0080000000D3}  
>
> Site 1572271583  
Process 6860  
Failure Reason STATUS_CODE  
Trigger Status 500.24  
Final Status 500.24  
Time Taken 16 msec  
>
> ModuleName ConfigurationValidationModule  
Notification 1  
HttpStatus 500  
HttpReason Internal Server Error  
HttpSubStatus 24  
ErrorCode 2147942450  
ConfigExceptionInfo  
Notification BEGIN_REQUEST  
ErrorCode The request is not supported. (0x80070032)  

### Errors in Application Logs

> Log Name:      Application  
Source:        Windows Server Update Services  
Date:          *\<DateTime>*  
Event ID:      7053  
Task Category: None  
Level:         Error  
Keywords:      Classic  
User:          N/A  
Computer:      ServerName.domain.local  
Description:  
The WSUS administration console has encountered an unexpected error. This may be a transient error; try restarting the administration console. If this error persists,
Try removing the persisted preferences for the console by deleting the wsus file under %appdata%\Microsoft\MMC\\.  
>
> System.InvalidOperationException -- Client found response content type of 'text/html; charset=utf-8', but expected 'text/xml'.  
The request failed with the error message:  
.  
.  
.  
Source  
System.Web.Services  
Stack Trace:  
   at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
   at System.Web.Services.Protocols.SoapHttpClientProtocol.Invoke(String methodName, Object[] parameters)  
   at Microsoft.UpdateServices.Internal.ApiRemoting.ExecuteSPGetUpdateServerStatus(Int32 updateSources, Boolean includeDownstreamComputers, String updateScopeXml, String computerTargetScopeXml, String preferredCulture, Int32 publicationState, Int32 propertiesToGet)  
   at Microsoft.UpdateServices.Internal.DatabaseAccess.AdminDataAccessProxy.  ExecuteSPGetUpdateServerStatus(UpdateSources updateSources, Boolean includeDownstreamComputers, String updateScopeXml, String computerTargetScopeXml, String preferredCulture, ExtendedPublicationState publicationState, UpdateServerStatusPropertiesToGet propertiesToGet)  
   at Microsoft.UpdateServices.Internal.BaseApi.UpdateServer.GetStatus(UpdateSources updateSources, Boolean includeDownstreamComputers, UpdateScope updatesToInclude, ComputerTargetScope computersToInclude, UpdateServerStatusPropertiesToGet propertiesToGet)
   at Microsoft.UpdateServices.Internal.BaseApi.UpdateServer.GetReplicaStatus(UpdateSources updateSources)  
   at Microsoft.UpdateServices.UI.SnapIn.Common.CachedUpdateServerStatus.GetFreshObjectForCache()  
   at Microsoft.UpdateServices.UI.AdminApiAccess.CachedObject.GetFromCache()  
   at Microsoft.UpdateServices.UI.SnapIn.Pages.ServerSummaryPage.backgroundWorker_DoWork(Object sender, DoWorkEventArgs e)  

## Cause

The above behavior is experienced due to incorrect settings on the WSUS Administration Website. By default we do not have "`ASP.NET Impersonation`" **Enabled** for any of the **WSUS Administration** Websites.

## Resolution

Open IIS Console  

- Highlight WSUS Administration Website
- Double-click "**Authentication**"
- Highlight **`ASP.NET Impersonation`**, on the right under "**Action**" pane click on "**Disable**"
- Check the following websites under WSUS Administration and make sure **`ASP.NET Impersonation`** is **Disabled.** If any of the below Web Applications have **`ASP.NET Authentication`** Enabled,** then disable them.
  - ApiRemoting30
  - ClientWebService
  - Content
  - DssAuthWebService
  - Inventory
  - ReportingWebService
  - Selfupdate
  - ServerSyncWebService
  - SipleAuthWebService
- Restart IIS

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
