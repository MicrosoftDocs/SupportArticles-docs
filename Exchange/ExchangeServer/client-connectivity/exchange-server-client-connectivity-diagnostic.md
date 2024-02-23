---
title: Exchange Server Client Connectivity Diagnostic
description: Describes the Exchange Server Client Connectivity Diagnostic and the information that it collects.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: brianpr, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Service Pack 1
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Service Pack 3
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Server Client Connectivity Diagnostic

_Original KB number:_ &nbsp; 2973478

The Microsoft Exchange Server Client Connectivity Diagnostic collects comprehensive information that can be used to troubleshoot client connectivity issues. Use this Support Diagnostics Platform (SDP) manifest on an affected server that is running Exchange Server and that has the Client Access server role.

## More information

This article describes information that the Exchange Server Client Connectivity Diagnostic may collect from your computer. This article also describes the names of the output files and supported versions of Exchange Server.

> [!NOTE]
> The information that will be collected depends on the installed version, roles, features, and configuration.

## Information collected

### Event logs

| Description| File name |
|---|---|
|Event Logs -Application and System (.csv and .evtx)|{ComputerName}_evt_Application.\*<br/>{ComputerName}_evt_System.\*|

### Exchange Server and organization baseline

| Description| File name |
|---|---|
|All Exchange Servers - Versions and Roles|{ComputerName}_AllExchangeServers*.txt|
|Get-ExchangeServer -Status cmdlet output|{ComputerName}_ExchangeServer_FL.txt|
|Get-OrganizationConfig cmdlet output|{ComputerName}_OrganizationConfig_FL.txt|
|Get-OutlookProvider cmdlet output|{ComputerName}_OutlookProvider_FL.txt|
|Get-PowerShellVirtualDirectory cmdlet output|{ComputerName}_PowerShellVirtualDirectory_FL.txt|
|Get-ExchangeCertificate cmdlet output|{ComputerName}_ExchangeCertificate_FL.txt|
|Get-UserPrincipalNamesSuffix cmdlet output|{ComputerName}_UserPrincipalNamesSuffix_FL.txt|
|Get-ActiveSyncMailboxPolicy cmdlet output|{ComputerName}_ActiveSyncMailboxPolicy_FL.txt|
|Get-MalwareFilteringServer cmdlet output|{ComputerName}_MalwareFilteringServer_FL.txt|
|Get-ServerHealth cmdlet output|{ComputerName}_ServerHealth_FL.txt|
|Get-ServerComponentState cmdlet output|{ComputerName}_ServerComponentState_FL.txt|
|Get-WorkloadManagementPolicy cmdlet output|{ComputerName}_WorkloadManagementPolicy_FL.txt|
|Get-WorkloadPolicy cmdlet output|{ComputerName}_WorkloadPolicy_FL.txt|
|Get-ResourcePolicy cmdlet output|{ComputerName}_ResourcePolicy_FL.txt|
|Get-SiteMailboxProvisioningPolicy cmdlet output|{ComputerName}_SiteMailboxProvisioningPolicy_FL.txt|

### Exchange Client Access server role

| Description| File name |
|---|---|
|Get-ClientAccessServer cmdlet output|{ComputerName}_ClientAccessServer_FL.txt|
|Get-PopSettings cmdlet output|{ComputerName}_PopSettings_FL.txt|
|Get-ImapSettings cmdlet output|{ComputerName}_ImapSettings_FL.txt|
|Get-OutlookAnywhere cmdlet output|{ComputerName}_OutlookAnywhere_FL.txt|
|Get-ActiveSyncVirtualDirectory cmdlet output|{ComputerName}_ActiveSyncVirtualDirectory_FL.txt|
|Get-AutodiscoverVirtualDirectory cmdlet output|{ComputerName}_AutodiscoverVirtualDirectory_FL.txt|
|Get-OabVirtualDirectory cmdlet output|{ComputerName}_OabVirtualDirectory_FL.txt|
|Get-OwaVirtualDirectory cmdlet output|{ComputerName}_OwaVirtualDirectory_FL.txt|
|Get-WebServicesVirtualDirectory cmdlet output|{ComputerName}_WebServicesVirtualDirectory_FL.txt|
|Get-EcpVirtualDirectory cmdlet output|{ComputerName}_EcpVirtualDirectory_FL.txt|
|HKLM: SOFTWARE\Microsoft\Rpc\RpcProxy* registry keys, values|{ComputerName}_REG_RPCPROXY.txt|

### Exchange Client Access Web Configuration files

| Description| File name |
|---|---|
|ClientAccess_Autodiscover_Web.Config (.zip)|{ComputerName}_ClientAccess_Autodiscover_Web_Config.zip|
|ClientAccess_Sync_Web.Config (.zip):|{ComputerName}_ClientAccess_Sync_Web_Config.zip|

### Exchange logging

| Description| File name |
|---|---|
|Logging\EWS (1 day)|{ComputerName}_Logs_EWS.zip|
|Logging\RPC Client Access (1 day)|{ComputerName}_Logs_RPC_Client_Access.zip|
|Logging\Autodiscover (1 day)|{ComputerName}_Logs_Autodiscover.zip|
|Logging\HttpProxy\EWS (1 day)|{ComputerName}_Logs_HttpProxy_EWS.zip|
|Logging\HttpProxy\EAS (1 day)|{ComputerName}_Logs_HttpProxy_EAS.zip|
|Logging\HttpProxy\Ecp (1 day)|{ComputerName}_Logs_HttpProxy_Ecp.zip|
|Logging\HttpProxy\Mapi (1 day)|{ComputerName}_Logs_HttpProxy_Mapi.zip|
|Logging\HttpProxy\Mapi\HTTP (1 day)|{ComputerName}_Logs_HttpProxy_MapiHTTP.zip|
|Logging\HttpProxy\OWA (1 day)|{ComputerName}_Logs_HttpProxy_OWA.zip|
|Logging\HttpProxy\RPCHTTP (1 day)|{ComputerName}_Logs_HttpProxy_RPCHTTP.zip|
|Logging\HttpProxy\Autodiscover (1 day)|{ComputerName}_Logs_HttpProxy_Autodiscover.zip|
|Logging\MAPI Address Book Service (1 day)|{ComputerName}_Logs_MAPIAddressBookService.zip|
|Logging\MAPI Client Access (1 day)|{ComputerName}_Logs_MAPIClientAccess.zip|
|Logging\RpcHttpW3SVC1 (1 day)|{ComputerName}_Logs_RpcHttp_W3SVC1.zip|
|Logging\RpcHttp\W3SVC2 (1 day)|{ComputerName}_Logs_RpcHttp_W3SVC2.zip|
|Logging\Diagnostics\DailyPerformanceLogs (2 days)|{ComputerName}_Logs_Diagnostics_DailyPerformanceLogs.zip|
|Logging\ADDriver\*.RpcClientAccess.Service* (newest20)|{ComputerName}_Logs_ADDriver_RpcClientAccess.zip|
|Logging\ADDriver\*.Directory.TopologyService* (newest 20)|{ComputerName}_Logs_ADDriver_TopologyService.zip|
|Logging\ADDriver\w3wp.exe_AirSync* (newest 20)|{ComputerName}_Logs_ADDriver_w3wp.exe_AirSync.zip|
|Logging\ADDriver\w3wp.exe_AutoDisc* (newest 20)|{ComputerName}_Logs_ADDriver_w3wp.exe_AutoDisc.zip|
|Logging\ADDriver\w3wp.exe_EWS* (newest 20)|{ComputerName}_Logs_ADDriver_w3wp.exe_EWS.zip|
|Logging\ADDriver\w3wp.exe_OWA* (newest 20)|{ComputerName}_Logs_ADDriver_w3wp.exe_OWA.zip|

### Exchange Server IIS information

|Description|File name|
|---|---|
|W3SVC logs for each site from the past two days|{ComputerName}_IISLogs_W3SVC[n].zip|

In addition to collecting the information that is described in these tables, this diagnostic package can detect one or more of the following symptoms:

- Event log messages

## References

For more information about the Microsoft Automated Troubleshooting Services and about the Support Diagnostics Platform, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).
