---
title: Microsoft Azure IaaS VM logs
description: Lists the Microsoft Azure IaaS VM logs and diagnostic information that's collected during troubleshooting by Microsoft Support.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.custom: linux-related-content
ms.collection: windows
---
# Microsoft Azure IaaS VM logs

This article lists the Microsoft Azure IaaS VM logs and diagnostic information that's collected during troubleshooting by Microsoft Support.

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 3137442

With your consent, Microsoft Support will collect files from your Azure IaaS virtual machines (VMs) to troubleshoot your issue. These files will include common log files, configuration files, diagnostic information, system-generated event logs, and debug logs.

## Log collections lists

Microsoft Support tries to collect only the data that's needed for troubleshooting your scenario. This section lists the full set of files that may be collected from your VMs during the troubleshooting process across VM scenarios.

## Files for Windows IaaS VM disks

Information about Windows VMs will include the files listed below in addition to basic partition data, file system formats, operation system version, and registry key settings that are integral to correct functioning of remote desktop connections.

### Files that may be collected for Windows IaaS VM disks

| /AzureData/CustomData.bin |
|---|
| /Packages/Plugins/_/_/config.txt |
| /Packages/Plugins/_/_/HandlerEnvironment.json |
| /Packages/Plugins/_/_/HandlerManifest.json |
| /Packages/Plugins/_/_/PackageInformation.txt |
| /Packages/Plugins/_/_/RuntimeSettings/*.settings |
| /Packages/Plugins/_/_/Status/*.status |
| /Packages/Plugins/_/_/Status/HeartBeat.Json |
| /Packages/Plugins/ESET.FileSecurity/*/agent_version.txt |
| /Packages/Plugins/ESET.FileSecurity/*/extension_version.txt |
| /Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/_/_.config |
| /Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/AnalyzerConfigTemplate.xml |
| /Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/Logs/_DiagnosticsPlugin_.log |
| /Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/_/schema/wad_.json |
| /Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/StatusMonitor/ApplicationInsightsPackagesVersion.json |
| /Packages/Plugins/Microsoft.Azure.RecoveryServices.VMSnapshot/*/SeqNumber.txt |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Microsoft.WindowsAzure.Storage.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/AsmExtensionMonitoringConfig_.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/ASM.Azure.OSBaseline.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/AsmExtensionSecurityPackStartupConfig.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/AsmScan.log |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/AsmScannerConfiguration.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/Azure.Common.scm.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/SecurityPackStartup.log |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/SecurityScanLoggerManifest.man |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/AgentStandardEvents.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/AgentStandardEventsMin.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/AgentStandardExtensions.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/AntiMalwareEvents.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/MonitoringEwsEvents.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/MonitoringEwsEventsCore.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/MonitoringEwsRootEvents.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/MonitoringStandardEvents.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/MonitoringStandardEvents2.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/MonitoringStandardEvents3.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/SecurityStandardEvents.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/SecurityStandardEvents2.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/_/Monitoring/agent/initconfig/_/Standard/SecurityStandardEvents3.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/MonAgent-Pkg-Manifest.xml |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/MonitoringAgentCertThumbprints.txt |
| /Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/MonitoringAgentScheduledService.txt |
| /Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/InstallUtil.InstallLog |
| /Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/current.config |
| /Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/InfrastructureManifest.template.xml |
| /Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/ServiceFabricNodeBootstrapAgent.InstallLog |
| /Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/ServiceFabricNodeBootstrapAgent.InstallState |
| /Packages/Plugins/Microsoft.Compute.BGInfo/*/BGInfo.def.xml |
| /Packages/Plugins/Microsoft.Compute.BGInfo/*/config.bgi |
| /Packages/Plugins/Microsoft.Compute.BGInfo/*/emptyConfig.bgi |
| /Packages/Plugins/Microsoft.Compute.BGInfo/*/PluginManifest.xml |
| /Packages/Plugins/Microsoft.Powershell.DSC/*/DSCVersion.xml |
| /Packages/Plugins/Microsoft.Powershell.DSC/_/DSCWork/_.dpx |
| /Packages/Plugins/Microsoft.Powershell.DSC/_/DSCWork/_.dsc |
| /Packages/Plugins/Microsoft.Powershell.DSC/_/DSCWork/_.log |
| /Packages/Plugins/Microsoft.Powershell.DSC/*/DSCWork/HotfixInstallInProgress.dsc |
| /Packages/Plugins/Microsoft.Powershell.DSC/*/DSCWork/PreInstallDone.dsc |
| /Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/*/config.txt |
| /Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/*/HandlerEnvironment.json |
| /Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/*/HandlerManifest.json |
| /Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/*/PackageDefinition.xml |
| /Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/_/RuntimeSettings/_.settings |
| /Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/_/Status/_.status |
| /Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/*/Status/HeartBeat.Json |
| /Program Files/Microsoft SQL Server/_/MSSQL/Log/_.* |
| /unattend.xml |
| /Windows/debug/DCPROMO.LOG |
| /Windows/debug/dcpromoui.log |
| /Windows/debug/mrt.log |
| /Windows/debug/netlogon.log |
| /Windows/debug/NetSetup.LOG |
| /Windows/debug/PASSWD.LOG |
| /Windows/Inf/netcfg*.*etl |
| /Windows/Inf/setupapi.dev.log |
| /Windows/Panther/FastCleanup/setupact.log |
| /Windows/Panther/setupact.log |
| /Windows/Panther/setuperr.log |
| /Windows/Panther/unattend.xml |
| /Windows/Panther/UnattendGC/setupact.log |
| /Windows/Panther/WaSetup.log |
| /Windows/Panther/WaSetup.xml |
| /Windows/Setup/State/state.ini |
| /Windows/System32/config/SOFTWARE |
| /Windows/System32/config/SYSTEM |
| /Windows/System32/Sysprep/ActionFiles/Generalize.xml |
| /Windows/System32/Sysprep/ActionFiles/Respecialize.xml |
| /Windows/System32/Sysprep/ActionFiles/Specialize.xml |
| /Windows/System32/Sysprep/Panther/IE/setupact.log |
| /Windows/System32/Sysprep/Panther/IE/setuperr.log |
| /Windows/System32/Sysprep/Panther/setupact.log |
| /Windows/System32/Sysprep/Panther/setuperr.log |
| /Windows/System32/Sysprep/Sysprep_succeeded.tag |
| /Windows/System32/winevt/Logs/Application.evtx |
| /Windows/System32/winevt/Logs/Application.evtx |
| /Windows/System32/winevt/Logs/MicrosoftAzureRecoveryServices-Replication.evtx |
| /Windows/System32/winevt/Logs/Microsoft-ServiceFabric%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-ServiceFabric%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-ServiceFabric-Lease%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-ServiceFabric-Lease%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4Bootstrapper.evtx |
| /Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4GuestAgent.evtx |
| /Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4Heartbeat.evtx |
| /Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4Runtime.evtx |
| /Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Status%4GuestAgent.evtx |
| /Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Status%4Plugins.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-CAPI2%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-DSC%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-Kernel-PnP%4Configuration.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-Kernel-PnPConfig%4Configuration.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-NdisImPlatform%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-NetworkLocationWizard%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-NetworkProfile%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-NetworkProvider%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-NlaSvc%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-RdpCoreTS%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-RdpCoreTS%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-RemoteDesktopSessionManager%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-SessionServices%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-Resource-Exhaustion-Detector%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-ServerManager%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-SmbClient%4Connectivity.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-SMBClient%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-SMBServer%4Connectivity.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-SMBServer%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TCPIP%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-LocalSessionManager%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-LocalSessionManager%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-PnPDevices%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-PnPDevices%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-RDPClient%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-SessionBroker-Client%4Admin.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-SessionBroker-Client%4Operational.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-UserPnp%4DeviceInstall.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-Windows Firewall With Advanced Security%4ConnectionSecurity.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-Windows Firewall With Advanced Security%4Firewall.evtx |
| /Windows/System32/winevt/Logs/Microsoft-Windows-WindowsUpdateClient%4Operational.evtx |
| /Windows/System32/winevt/Logs/Security.evtx |
| /Windows/System32/winevt/Logs/Setup.evtx |
| /Windows/System32/winevt/Logs/System.evtx |
| /Windows/System32/winevt/Logs/System.evtx |
| /Windows/System32/winevt/Logs/Windows Azure.evtx |
| /WindowsAzure/config/*.xml |
| /WindowsAzure/Logs/AggregateStatus/aggregatestatus*.json |
| /WindowsAzure/Logs/AppAgentRuntime.log |
| /WindowsAzure/Logs/MonitoringAgent.log |
| /WindowsAzure/Logs/Plugins/_/_/CommandExecution.log |
| /WindowsAzure/Logs/Plugins/_/_/Heartbeat.log |
| /WindowsAzure/Logs/Plugins/_/_/Install.log |
| /WindowsAzure/Logs/Plugins/_/_/Update.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/_/_/Configuration/Checkpoint.txt |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/_/_/Configuration/MaConfig.xml |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/_/_/Configuration/MonAgentHost.*.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/DiagnosticsPlugin.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/DiagnosticsPluginLauncher.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.RecoveryServices.VMSnapshot/_/IaaSBcdrExtension_.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.Security.IaaSAntimalware/*/AntimalwareConfig.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.Security.Monitoring/*/AsmExtension.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/_/FabricMSIInstall_.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/InfrastructureManifest.xml |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/TempClusterManifest.xml |
| /WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/_/VCRuntimeInstall_.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Compute.BGInfo/_/BGInfo_.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Compute.JsonADDomainExtension/*/ADDomainExtension.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Compute.VMAccessAgent/*/JsonVMAccessExtension.log |
| /WindowsAzure/Logs/Plugins/Microsoft.EnterpriseCloud.Monitoring.MicrosoftMonitoringAgent/*/0.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Powershell.DSC/_/DscExtensionHandler_.log |
| /WindowsAzure/Logs/Plugins/Microsoft.Powershell.DSC/_/DSCLOG_.json |
| /WindowsAzure/Logs/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/_/CommandExecution_.log |
| /WindowsAzure/Logs/Plugins/Symantec.SymantecEndpointProtection/*/sepManagedAzure.txt |
| /WindowsAzure/Logs/Plugins/TrendMicro.DeepSecurity.TrendMicroDSA/_/_.log |
| /WindowsAzure/Logs/SqlServerLogs/_._ |
| /WindowsAzure/Logs/Telemetry.log |
| /WindowsAzure/Logs/TransparentInstaller.log |
| /WindowsAzure/Logs/WaAppAgent.log |
||

## Files for Linux IaaS VM disks

Information about Linux VMs will include the files listed below in addition to basic partition data, disk space, file system formats, and the Linux distribution name and version. Because of differences across Linux distributions, it is unlikely that all the files listed below will be present on a single VM.

### Files that may be collected for Linux IaaS VM disks

| /etc/hostname |
|---|
| /boot/grub*/grub.c* |
| /boot/grub*/menu.lst |
| /etc/network/interfaces |
| /etc/network/interfaces.d/*.cfg |
| /etc/sysconfig/iptables |
| /etc/sysconfig/network |
| /etc/sysconfig/network/ifcfg-eth* |
| /etc/sysconfig/network/routes |
| /etc/sysconfig/network-scripts/ifcfg-eth* |
| /etc/sysconfig/network-scripts/route-eth* |
| /etc/sysconfig/SuSEfirewall2 |
| /etc/ufw/ufw.conf |
| /var/lib/dhcp/dhclient.eth0.leases |
| /var/log/cloud-init* |
| /var/log/dpkg* |
| /var/log/kern* |
| /var/log/rsyslog* |
| /var/log/sa/sar* |
| /var/log/syslog* |
| /var/log/yum* |
| /etc/udev/rules.d |
||

### Directories that may be listed for Linux IaaS VM disks

| /etc/udev/rules.d |
|---|
| /var/log/sa |
||

## Files for FreeBSD VM disks

Information about FreeBSD VMs will include the files listed below in addition to basic partition data, file system formats, and the operating system version.

### Files that may be collected for FreeBSD VM disks

| /boot/loader.conf |
|---|
| /etc/*-release |
| /etc/dhclient.conf |
| /etc/fstab |
| /etc/networks |
| /etc/nsswitch.conf |
| /etc/rc.conf |
| /etc/resolv.conf |
| /etc/ssh/ssh_host_key_ |
| /etc/ssh/sshd_config |
| /etc/syslog.conf |
| /etc/waagent.conf |
| /var/lib/waagent/*.xml |
| /var/lib/waagent/_/config/_.settings |
| /var/lib/waagent/_/status/_.status |
| /var/lib/waagent/ExtensionsConfig.*.xml |
| /var/lib/waagent/provisioned |
| /var/log/auth* |
| /var/log/azure/_/_/* |
| /var/log/boot* |
| /var/log/dmesg* |
| /var/log/messages* |
| /var/log/secure* |
| /var/log/waagent* |
||  

### Directories that may be listed for F** reeBSD VM disks

| /etc/rc.d |
|---|
| /var/lib/waagent |
| /var/log |
||

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
