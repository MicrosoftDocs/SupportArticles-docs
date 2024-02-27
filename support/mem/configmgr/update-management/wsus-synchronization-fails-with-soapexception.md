---
title: WSUS synchronization fails with SoapException
description: Fixes an issue in which WSUS synchronization fails because of a decommissioned endpoint.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# WSUS synchronization fails with SoapException

This article helps you fix an issue where Windows Server Update Services (WSUS) synchronization fails because of a decommissioned endpoint.

_Original product version:_ &nbsp; WSUS - All versions, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 4482416

## Symptoms

WSUS synchronization fails, and you receive the following error message:

> SoapException: Fault occurred  
at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
   at System.Web.Services.Protocols.SoapHttpClientProtocol.Invoke(String methodName, Object[] parameters)  
   at Microsoft.UpdateServices.ServerSyncWebServices.ServerSync.ServerSyncProxy.GetUpdateData(Cookie cookie, UpdateIdentity[] updateIds)  
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.WebserviceGetUpdateData(UpdateIdentity[] updateIds, List\`1 allMetadata, List\`1 allFileUrls, Boolean isForConfig)  
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.GetUpdateDataInChunksAndImport(List\`1 neededUpdates, List\`1 allMetadata, List\`1 allFileUrls, Boolean isConfigData)  
   at Microsoft.UpdateServices.ServerSync.Cat

Additionally, an error message that resembles the following is logged in the WSUS log file (`%ProgramFiles%\Update Services\LogFiles\SoftwareDistribution.log`) on the WSUS server:

```output
<Date> <Time> Error WsusService.25 SoapUtilities.LogException USS ThrowException: Actor = https://fe2.update.microsoft.com/v6/ServerSyncWebService/ServerSyncWebService.asmx, Method = "http://www.microsoft.com/SoftwareDistribution/GetUpdateData", ID=<ID>, ErrorCode=InternalServerError, Message=  
   at Microsoft.UpdateServices.Internal.SoapUtilities.LogException(SoapException e)
   at Microsoft.UpdateServices.Internal.WebServiceCommunicationHelper. ProcessWebServiceProxyException(SoapHttpClientProtocol& webServiceObject, Exception exceptionInfo)
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.WebserviceGetUpdateData(UpdateIdentity[] updateIds, List\1 allMetadata, List\1 allFileUrls, List\`1& updatesWithSecureFileData, Boolean isForConfig)
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.GetUpdateDataInChunksAndImport(List\1 neededUpdates, List\1 allMetadata, List\1 allFileUrls, Boolean isConfigData)
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.GetAndSaveUpdateMetadata(List\1 updates)
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.ExecuteSyncProtocol(Boolean allowRedirect)  
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.CatalogSyncThreadProcess()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
   at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
   at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state)
   at System.Threading.ThreadHelper.ThreadStart()
<Date> <Time> Error WsusService.25 SoapUtilities.LogException USS ThrowException: Actor = https://fe2.update.microsoft.com/v6/ServerSyncWebService/ServerSyncWebService.asmx, Method = "http://www.microsoft.com/SoftwareDistribution/GetUpdateData", ID=\<ID>, ErrorCode=InternalServerError, Message=  
   at Microsoft.UpdateServices.Internal.SoapUtilities.LogException(SoapException e)
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.ExecuteSyncProtocol(Boolean allowRedirect)
   at Microsoft.UpdateServices.ServerSync.CatalogSyncAgentCore.CatalogSyncThreadProcess()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
   at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
   at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state)
   at System.Threading.ThreadHelper.ThreadStart()
```

## Cause

This issue occurs if the WSUS servers are configured to use the old synchronization endpoint, `https://fe2.update.microsoft.com/v6`. This endpoint was fully decommissioned and is no longer reachable after July 8, 2019.

## Resolution

To fix the issue, change the synchronization endpoint in WSUS configuration to `https://sws.update.microsoft.com`.

To do this, follow these steps on the topmost WSUS server that connects directly to Microsoft Update, such as the root WSUS server in a WSUS hierarchy:

1. Close all WSUS consoles.
2. At an elevated PowerShell command prompt, run the following PowerShell scripts.

   > [!NOTE]
   > Don't run the scripts on a WSUS server that's not the topmost server. If the server isn't connected to the Internet, synchronization may fail.

   **For WSUS version 3.x:**

   ```powershell
   [void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
   $server = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer()
   $config = $server.GetConfiguration()
   # Check current settings before you change them
   $config.MUUrl
   $config.RedirectorChangeNumber
   # Update the settings if MUUrl is https://fe2.update.microsoft.com/v6
   $config.MUUrl = "https://sws.update.microsoft.com"
   $config.RedirectorChangeNumber = 4002
   $config.Save();
   iisreset
   Restart-Service *Wsus* -v
   ```

   WSUS servers that are running Windows Server 2008 (without the latest update) or earlier versions may be using the `https://update.microsoft.com/v6` or `https://www.update.microsoft.com` synchronization endpoints. Because these versions of Windows don't support SHA256 certificate authentication, use the following settings in the PowerShell scripts:

   ```powershell
   $config.MUUrl = " https://sws1.update.microsoft.com"
   $config.RedirectorChangeNumber = 3011
   ```

   **For WSUS on Windows Server 2012 and later versions:**

    ```powershell
    $server = Get-WsusServer
    $config = $server.GetConfiguration()
    # Check current settings before you change them 
    $config.MUUrl
    $config.RedirectorChangeNumber
    # Update the settings if MUUrl is https://fe2.update.microsoft.com/v6
    $config.MUUrl = "https://sws.update.microsoft.com"
    $config.RedirectorChangeNumber = 4002
    $config.Save()
    iisreset
    Restart-Service *Wsus* -v
    ```  

3. Verify that WSUS synchronization succeeds.

## More information

For more information about how to run PowerShell scripts, see [What is PowerShell?](/powershell/scripting/overview).
