---
title: Microsoft Exchange Server 2013 Managed Availability Diagnostic collects information
description: Describes information that Microsoft Exchange Server 2013 Managed Availability Diagnostic may collect from your computer and the names of the output files.
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
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Information collected by Microsoft Exchange Server 2013 Managed Availability Diagnostic

_Original KB number:_ &nbsp;2884666

## Summary

The Microsoft Exchange Server 2013 Managed Availability Diagnostic collects comprehensive information to help troubleshoot Managed Availability and Active Monitoring issues in Microsoft Exchange Server 2013.

This article describes information that the Microsoft Exchange Server 2013 Managed Availability Diagnostic may collect from your computer. This article also describes the names of the output files. The information that's collected depends on the installed roles, features, and configuration. The following tables list the collected information.

> [!NOTE]
> The Managed Availability and Active Monitoring event logs can be large, and can take significant time to collect and compress for upload.

## Additional information

| Description| File name |
|---|---|
|Volume Shadow Copy Service (VSS) information via vssadmin utility output|{*ComputerName}_VSSAdmin.TXT*|

## Devices and drivers

| Description| File name |
|---|---|
|Fibre Channel Information Tool (FCInfo) output|*{ComputerName}_FCInfo.txt*|

## Event Logs - Exchange Server

| Description| File name |
|---|---|
|Event Log-Exchange Active Monitoring|*{ComputerName}_evt_ExchangeActiveMonitoring-MonitorDefinition.evtx*|
|Event Log-Exchange Active Monitoring|*{ComputerName}_evt_ExchangeActiveMonitoring-ProbeDefinition.evtx*|
|Event Log-Exchange Active Monitoring|*{ComputerName}_evt_ExchangeActiveMonitoring-ProbeResult.evtx*|
|Event Log-Exchange Active Monitoring|*{ComputerName}_evt_ExchangeActiveMonitoring-ResponderDefinition.evtx*|
|Event Log-Exchange High Availability|*{ComputerName}_evt_ExchangeHighAvailability-Operational.evtx*|
|Event Log-Exchange MDB Failure Items|*{ComputerName}_evt_ExchangeMailboxDatabaseFailureItems-Operational.evtx*|
|Event Log-Exchange Managed Availability|*{ComputerName}_evt_ExchangeManagedAvailability-RecoveryActionLogs.evtx*|
|Event Log-Exchange Managed Availability|*{ComputerName}_evt_ExchangeManagedAvailability-RecoveryActionResults.evtx*|
|Event Log-Exchange Managed Availability|*{ComputerName}_evt_ExchangeManagedAvailability-RemoteActionLogs.evtx*|

## Event Logs - Windows

| Description| File name |
|---|---|
|Event log - Application (.csv .evtx)|*{ComputerName}_evt_Application.**|
|Event log - System (.csv .evtx)|*{ComputerName}_evt_System.**|
|Microsoft-Windows-FailoverClustering* (.csv .evtx .txt)|*{ComputerName}_evt_FailoverClustering.**|

## Exchange Mailbox Server Role

| Description| File name |
|---|---|
|AddressBook Service logs from past 1 day|*{ComputerName}_Logs_AddressBook Service.zip*|
|BE_Agent logs from past 1 day|*{ComputerName}_Logs_BE_Agent.zip*|
|BE_Routing logs from past 1 day|*{ComputerName}_Logs_BE_Routing.zip*|
|`Get-ActiveSyncVirtualDirectory` cmdlet output|*{ComputerName}_ActiveSyncVirtualDirectory*.txt*|
|`Get-AutodiscoverVirtualDirectory` cmdlet output|*{ComputerName}_AutodiscoverVirtualDirectory*.txt*|
|`Get-ChildItem -Path` output foreach database file path|*{ComputerName}\_DBMb_[mailboxDatabase.Name]_EDBFilePath_Contents*.txt*|
|`Get-ChildItem -Path` output foreach database log folder path|*{ComputerName}\_DBMb_[mailboxDatabase.Name]_LogFolderPath*.txt*|
|`Get-DatabaseAvailabilityGroup` cmdlet output|*{ComputerName}\_DAG_[DAG.Name]*.txt*|
|`Get-DatabaseAvailabilityGroupNetwork` cmdlet output|*{ComputerName}_DAGNetworks*.txt*|
|`Get-EcpVirtualDirectory` cmdlet output|*{ComputerName}_EcpVirtualDirectory*.txt*|
|`Get-EdgeSyncServiceConfig` cmdlet output|*{ComputerName}_EdgeSyncServiceConfig*.txt*|
|`Get-ImapSettings` cmdlet output|*{ComputerName}_ImapSettings*.txt*|
|`Get-MailboxDatabase` cmdlet output foreach database|*{ComputerName}\_DBMb_[mailboxDatabase.Name]*.txt*|
|`Get-MailboxDatabaseCopyStatus` cmdlet output|*{ComputerName}_MailboxDatabaseCopyStatus*.txt*|
|`Get-MailboxServer` cmdlet output|*{ComputerName}_MailboxServer*.txt*|
|`Get-MailboxTransportService` cmdlet output|*{ComputerName}_MailboxTransportService*.txt*|
|`Get-OabVirtualDirectory` cmdlet output|*{ComputerName}_OabVirtualDirectory*.txt*|
|`Get-OutlookAnywhere` cmdlet output|*{ComputerName}_OutlookAnywhere*.txt*|
|`Get-OwaVirtualDirectory` cmdlet output|*{ComputerName}_OwaVirtualDirectory*.txt*|
|`Get-PopSettings` cmdlet output|*{ComputerName}_PopSettings*.txt*|
|`Get-PowerShellVirtualDirectory` cmdlet output|*{ComputerName}_PowerShellVirtualDirectory*.txt*|
|`Get-Queue` cmdlet output|*{ComputerName}_Queue*.txt*|
|`Get-ReceiveConnector` cmdlet output|*{ComputerName}_ReceiveConnector*.txt*|
|`Get-StoreUsageStatistics` cmdlet output|*{ComputerName}_StoreUsageStatistics*.txt*|
|`Get-TransportAgent` cmdlet output|*{ComputerName}_TransportAgent*.txt*|
|`Get-TransportPipeline` cmdlet output|*{ComputerName}_TransportPipeline*.txt*|
|`Get-TransportService` cmdlet output|*{ComputerName}_TransportService*.txt*|
|`Get-UMService` cmdlet output|*{ComputerName}_UMService*.txt*|
|`Get-WebServicesVirtualDirectory` cmdlet output|*{ComputerName}_WebServicesVirtualDirectory*.txt*|
|HKLM:SOFTWARE\Microsoft\Rpc\RpcProxy registry key and subkey values|*{ComputerName}_REG_RPCPROXY*.txt*|
|MessageTracking logs from past 1 day|*{ComputerName}_Logs_MessageTracking.zip*|
|QueueViewer logs from past 1 day|*{ComputerName}_Logs_QueueViewer.zip*|
|RPC Client Access logs from past 1 day|*{ComputerName}_Logs_RPC Client Access.zip*|
|RpcHttp logs from past 1 day|*{ComputerName}_Logs_RpcHttp.zip*|
|Update-HybridConfiguration logs from past 1 day|*{ComputerName}_Logs_Update-HybridConfiguration.zip*|

## Exchange Server and Organization Baseline

| Description| File name |
|---|---|
|All Exchange Servers - Versions and Roles|*{ComputerName}_AllExchangeServers*.txt*|
|`Get-AcceptedDomain` cmdlet output|*{ComputerName}_AcceptedDomain*.txt*|
|`Get-ActiveSyncDeviceAutoblockThreshold` cmdlet output|*{ComputerName}_ActiveSyncDeviceAutoblockThreshold*.txt*|
|`Get-ActiveSyncMailboxPolicy` cmdlet output|*{ComputerName}_ActiveSyncMailboxPolicy*.txt*|
|`Get-App` cmdlet output|*{ComputerName}_App*.txt*|
|`Get-AvailabilityAddressSpace` cmdlet output|*{ComputerName}_AvailabilityAddressSpace*.txt*|
|`Get-AvailabilityConfig` cmdlet output|*{ComputerName}_AvailabilityConfig*.txt*|
|`Get-DataClassification` cmdlet output|*{ComputerName}_DataClassification*.txt*|
|`Get-DlpPolicy` cmdlet output|*{ComputerName}_DlpPolicy*.txt*|
|`Get-DlpPolicyTemplate` cmdlet output|*{ComputerName}_DlpPolicyTemplate*.txt*|
|`Get-EdgeSubscription` cmdlet output|*{ComputerName}_EdgeSubscription*.txt*|
|`Get-EdgeSyncServiceConfig` cmdlet output|*{ComputerName}_EdgeSyncServiceConfig*.txt*|
|`Get-EmailAddressPolicy` cmdlet output|*{ComputerName}_EmailAddressPolicy*.txt*|
|`Get-ExchangeCertificate` cmdlet output|*{ComputerName}_ExchangeCertificate*.txt*|
|`Get-ExchangeServer` cmdlet output|*{ComputerName}_ExchangeServer*.txt*|
|`Get-FederatedOrganizationIdentifier` cmdlet output|*{ComputerName}_FederatedOrganizationIdentifier*.txt*|
|`Get-FederationTrust` cmdlet output|*{ComputerName}_FederationTrust*.txt*|
|`Get-MalwareFilteringServer` cmdlet output|*{ComputerName}_MalwareFilteringServer*.txt*|
|`Get-MalwareFilterPolicy` cmdlet output|*{ComputerName}_MalwareFilterPolicy*.txt*|
|`Get-MobileDeviceMailboxPolicy` cmdlet output|*{ComputerName}_MobileDeviceMailboxPolicy*.txt*|
|`Get-OrganizationConfig` cmdlet output|*{ComputerName}_OrganizationConfig*.txt*|
|`Get-OrganizationRelationship` cmdlet output|*{ComputerName}_OrganizationRelationship*.txt*|
|`Get-OutlookProvider` cmdlet output|*{ComputerName}_OutlookProvider*.txt*|
|`Get-PolicyTipConfig` cmdlet output|*{ComputerName}_PolicyTipConfig*.txt*|
|`Get-PowerShellVirtualDirectory` cmdlet output|*{ComputerName}_PowerShellVirtualDirectory*.txt*|
|`Get-RemoteDomain` cmdlet output|*{ComputerName}_RemoteDomain*.txt*|
|`Get-ResourcePolicy` cmdlet output|*{ComputerName}_ResourcePolicy*.txt*|
|`Get-SendConnector` cmdlet output|*{ComputerName}_SendConnector*.txt*|
|`Get-ServerHealth` cmdlet output|*{ComputerName}_ServerHealth*.txt*|
|`Get-ServerComponentState` cmdlet output|*{ComputerName}_ServerComponentState*.txt*|
|`Get-SiteMailboxProvisioningPolicy` cmdlet output|*{ComputerName}_SiteMailboxProvisioningPolicy.txt*|
|`Get-ThrottlingPolicy` cmdlet output|*{ComputerName}_ThrottlingPolicy*.txt*|
|`Get-UMAutoAttendant (AfterHoursKeyMapping)` cmdlet output|*{ComputerName}_UMAutoAttendant\_[UMAutoAttendant.Name]_AfterHoursKeyMapping.txt*|
|`Get-UMAutoAttendant (BusinessHoursKeyMapping)` cmdlet output|*{ComputerName}_UMAutoAttendant\_[UMAutoAttendant.Name]_BusinessHoursKeyMapping.txt*|
|`Get-UMAutoAttendant` cmdlet output|*{ComputerName}_UMAutoAttendant*.txt*|
|`Get-UMDialPlan (ConfiguredInternationalGroups)` cmdlet output|*{ComputerName}_UMDialPlan\_[DialPlan.Name]_InternationalGroups.txt*|
|`Get-UMDialPlan (InCountryOrRegionGroups)` cmdlet output|*{ComputerName}_UMDialPlan\_[DialPlan.Name]_CountryOrRegionGroups.txt*|
|`Get-UMDialPlan` cmdlet output|*{ComputerName}_UMDialPlan*.txt*|
|`Get-UMHuntGroup` cmdlet output|*{ComputerName}_UMHuntGroup*.txt*|
|`Get-UMMailboxPolicy` cmdlet output|*{ComputerName}_UMMailboxPolicy*.txt*|
|`Get-UserPrincipalNamesSuffix` cmdlet output|*{ComputerName}_UserPrincipalNamesSuffix*.txt*|
|`Get-WorkloadManagementPolicy` cmdlet output|*{ComputerName}_WorkloadManagementPolicy*.txt*|
|`Get-WorkloadPolicy` cmdlet output|*{ComputerName}_WorkloadPolicy*.txt*|
|Test-FederationTrustCertificate cmdlet output|*{ComputerName}_FederationTrustCertificate*.txt*|

## Exchange Server IIS information

| Description| File name |
|---|---|
|IIS W3SVC Logs foreach site from past 1 day|*{ComputerName}_W3SVC[n]LogFiles.zip*|

## FailoverCluster feature

| Description| File name |
|---|---|
|Basic Failover Cluster information via clusmps.exe utility (on operating Systems earlier than Windows Server 2008 R2)|*{ComputerName}_cluster_mps_information.txt*|
|Basic Failover Cluster information, including information from existing resources and groups via FailoverCluster PowerShell cmdlets (Windows Server 2008 R2 and newer)|*resultreport.xml*<br/>|
|Cluster Dependency Report generated by `Get-ClusterResourceDependencyReport` PowerShell cmdlet on Windows Server 2008 or newer|*{ComputerName}_DependencyReport.mht*|
|Cluster Logs generated by `Get-ClusterLog` PowerShell cmdlet on Windows Server 2008 R2, cluster.exe utility or from \windows\cluster\cluster.log on previous versions of Windows|*{ComputerName}_cluster.log*|
|Cluster Resources information from cluster.exe utility|*{ComputerName}_ClusterResources.txt*|
|Cluster resources properties using PowerShell `Get-ClusterResource` cmdlet or cluster.exe utility on previous versions of Windows|*{ComputerName}_ClusterProperties.txt*|

## General information

| Description| File name |
|---|---|
|List of Installed Updates and Hotfixes installed|*{ComputerName}_Hotfixes.**|
|List of User Rights (privileges) using showpriv.exe tool|*{ComputerName}_UserRights.txt*|
|List of user SID, group memberships, and privileges via the 'Whoami /all' output|*{ComputerName}_Whoami.txt*|
|Resultant Set of Policy (RSoP) generated by gpresult.exe utility|*{ComputerName}_GPResult.**|
|System Information - MSInfo32 tool output|*{ComputerName}_msinfo32.nfo*<br/>*{ComputerName}_msinfo32.txt*|

## iSCSI information

| Description| File name |
|---|---|
|iSCSI Information based on iscsicli.exe output|*{ComputerName}_iSCSIInfo.txt*|

## RPC

| Description| File name |
|---|---|
|*HKLM\Software\Microsoft\Rpc*<br/>*HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper*<br/>*HKLM\SYSTEM\CurrentControlSet\Services\RpcLocator*<br/>*HKLM\SYSTEM\CurrentControlSet\Services\RpcSs*|*{ComputerName}_RPC_reg_output.TXT*|
|RPC information from netsh rpc output|*{ComputerName}_RPC_netsh_output.TXT*|

## Storage information

| Description| File name |
|---|---|
|Storage and SAN information via San.exe utility output|*{ComputerName}_Storage_Information.txt*|

## TCPIP

| Description| File name |
|---|---|
|*HKLM\SOFTWARE\Policies\Microsoft\Windows\TCPIP*<br/>*HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc*<br/>*HKLM\SYSTEM\CurrentControlSet\services\TCPIP*<br/>*HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6*<br/>*HKLM\SYSTEM\CurrentControlSet\Services\tcpipreg*|*{ComputerName}_TCPIP_reg_output.TXT*|
|Microsoft-Windows-Iphlpsvc/Operational|*{ComputerName}__evt_*.**|
|TCP OFFLOAD information from netstat output|*{ComputerName}_TCPIP_OFFLOAD.TXT*|
|TCPIP Information from commands: hostname,ipconfig,route,netstat etc.|*{ComputerName}_TCPIP_info.TXT*|
|TCPIP information from netsh output|*{ComputerName}_TCPIP_netsh_info.TXT*|
|TCPIP Services File located at: *windir\system32\drivers\etc\services*|*{ComputerName}_TCPIP_ServicesFile.TXT*|
|W8/WS2012 PowerShell output for TCPIP|*{ComputerName}_TCPIP_info_pscmdlets_net.TXT*|

In addition to collecting the information that's described earlier, this diagnostic package can detect one or more of the following symptoms:

- Check if cluster groups are in Offline or Failed state.
- Check for errors gathering cluster information via `Get-ClusterNode` cmdlet.
- Check if the state of one or more cluster nodes is down or paused.
- Check if Cluster service isn't running or offline.
- Event Logs Messages.

## References

For more information about the Microsoft Automated Troubleshooting Services and the Support Diagnostics Platform, see the following Microsoft Knowledge Base article:

[2598970](https://support.microsoft.com/help/2598970) Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform
