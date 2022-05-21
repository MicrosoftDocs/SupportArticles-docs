---
title: VM Inspector for Azure Virtual Machines (Preview)
description: Describes the VM Inspector tool for Azure virtual machines for troubleshooting issues on Windows or Linux virtual machines.
documentationcenter: ''
author: genlin
manager: dcscontentpm
ms.service: virtual-machines
ms.topic: troubleshooting
ms.date: 04/20/2022
ms.author: genli

---
# VM Inspector for Azure virtual machines (Preview)

The VM Inspector tool helps you troubleshoot OS-related issues that can affect a Window or Linux virtual machine (VM). It's designed as a self-help diagnostic tool that lets customers, support agents, or third-party personnel who have privileged access collect logs and configuration files directly on the OS disk of an Azure VM. VM Inspector is a fast and secure way for an authorized user to retrieve well-known log files from a VM OS disk to diagnose Guest OS issues.

We recommend that you run VM Inspector and review the diagnostics data before you contact Microsoft Support.

## Supported operating systems

VM Inspector is supported on the following operating systems:

### Windows

- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2012
- Windows Server 2008 R2
- Windows Server 2008
- Windows 10
- Windows 8.1
- Windows 8
- Windows 7

### Linux

- CentOS
- CoreOS
- Debian
- Flatcar Container Linux by Kinvolk
- Oracle Linux Server
- RHEL
- SLES
- OpenSUSE
- Ubuntu

[Linux distributions endorsed on Azure](/azure/virtual-machines/linux/endorsed-distros)

## Supported regions

VM Inspector is supported for the following Azure regions:

- Australia East
- East US
- East US2
- North Europe
- SouthCental US
- SouthEast Asia
- UK South
- WestCentral US
- West Europe
- West US2

## Unsupported scenarios

- Unmanaged OS disks and VMs
- Encrypted OS disks and VMs
- Ephemeral OS disks and VMs

## How VM Inspector works

VM Inspector uses the Microsoft Compute Diagnostic resource provider, a back-end Microsoft service that collects useful event logs, configurations, settings, and registry keys from your VM OS disk for diagnostics. The customer starts by granting access to VM Inspector and running a diagnostic against your selected VM. VM Inspector then makes a connection to the VM-managed disk in Azure blob storage, and uses a predefined manifest to do file collection on the OS disk. After the inspection is finished, the collected files are packed into a .zip file, and returned to customer's storage account for safe keeping.

For more information about the anatomy of an Azure VM on Windows, see [Run a Windows VM on Azure - Azure Reference Architectures](/azure/architecture/reference-architectures/n-tier/windows-vm).

For more information about the anatomy of an Azure VM on Linux, see [Run a Linux VM on Azure - Azure Reference Architectures](/azure/architecture/reference-architectures/n-tier/linux-vm).

For general information about OS disks, see [Introduction to Azure managed disks, OS disk](/azure/virtual-machines/managed-disks-overview#os-disk).

## Get access to VM Inspector

A user who has Owner-level access must grant access to VM Inspector before diagnostics can be run on the VM. The VM Inspector must have at least the Disk Backup Reader role to be able to do disk inspection of the managed OS disk on your VM. If you have Owner-level access, and you're running VM Inspector for the first time on your VM, you'll be prompted to automatically grant VM Inspector the Disk Backup Reader role. If you have a lower access role, such as Contributor, Reader, or User Access Administrator, you must manually update your access level to that of Owner on the VM to proceed.

For more information about the Disk Backup Reader role, see [Azure built-in roles - Disk Backup Reader](/azure/role-based-access-control/built-in-roles#disk-backup-reader).

For more information about general Azure built-in RBAC roles, see [Azure built-in roles - All](/azure/role-based-access-control/built-in-roles#all) and 
[Azure built-in roles - Azure RBAC](/azure/role-based-access-control/built-in-roles#general).

:::image type="content" source="media/vm-inspector-azure-virtual-machines/azure-built-in-roles.png" alt-text="A list of built-in-roles for Azure, including Contributor, Owner, Reader, and User Access Administrator.":::

### Register the preview feature

To register the preview feature of VM Inspector, follow the steps that are described in [set up preview features in Azure subscription](/azure/azure-resource-manager/management/preview-features?tabs=azure-portal) and select **VM Inspection**. After the registration, you have to wait for approximately 30 minutes before you try out the feature.

## Run VM Inspector on your VM

VM Inspector is available to run for both Windows and Linux VMs. To run VM Inspector, follow these steps:

1. In the left-side column of commands, select **Virtual machines**.
1. In the list of VM names, select the VM on which you want to run VM Inspector.
1. In the right-side column of commands, select **VM Inspector**.

   :::image type="content" source="media/vm-inspector-azure-virtual-machines/vm-inspector-selection.png" alt-text="Screenshot of the VM Inspector selection in the right-hand column of commands.":::

1. Select a storage account:

   - If you want to use an existing single storage account to store reports from VM Inspector for multiple VMs, select an existing storage account in the list.
   - If you want to use a new storage account, select **Create new**, and configure the new storage account in the right-side panel.

      :::image type="content" source="media/vm-inspector-azure-virtual-machines/select-storage-account.png" alt-text="Screenshot of the storage account selection within the storage account creation process.":::

     > [!NOTE]
     > If the **Create new** option isn't available to select, this is because you don't have the correct level of access to run VM Inspector. You must have at least the Contributor role to run VM Inspector successfully.

   - (Preview Feature): In the public preview phase, Microsoft is offering an experience so that you don't need to select the storage account again after the first time that you use VM Inspector. This feature pins a given storage account at subscription level with regional affinity. All supported resource types within the same subscription and the same region will share the same storage account, after the account is configured. Any changes to the storage configuration entry will affect all supported resource types within the same subscription and the same region.

     Unless you want to change the storage account, all diagnostic reports will be saved in the first-time storage account that you selected. As a best practice, Microsoft recommends that you choose the storage account in the same region of the compute resources.

1. Select the **Run Inspector** button or **Browse Inspector Report** button:

   1. To run a new diagnostic report, select the **Run Inspector** button.

      A notification is displayed as VM Inspector starts to run.

      > [!NOTE]
      > If you can't select and run VM Inspector successfully in this step, refer to the "FAQ" section of this article.

      After the inspector runs, you see a notification that indicates that the inspection run finished. The inspector report will appear automatically in the blade view and will be uploaded to the Azure table in the specified storage account, as follows:

      - The **Start Time** that the VM Inspector report runs.
      - An output compressed (.zip) file named *DiskInspection_yyyy-MM-dd time* listed under **Diagnostics Report** that can be downloaded directly from the portal.
      - The **Size** of the report in MB.
      - The **Action** button, to download the report.

         :::image type="content" source="media/vm-inspector-azure-virtual-machines/diagnostics-report.png" alt-text="Screenshot of the diagnostics report, including start time, a link to the report, the size of the report, and a link to download the report.":::

   1. To view existing reports in the selected diagnostics storage account, select the **Browse Diagnostic Reports** option.

      :::image type="content" source="media/vm-inspector-azure-virtual-machines/browse-diagnostic-reports.png" alt-text="Screenshot of the option to browse diagnostic reports, including the Browse Diagnostic Reports button.":::

1. Change a storage account (optional):

   To change a diagnostic storage account, select the **Settings** button on the toolbar, select the storage account, and then select **OK**. For more information, see the **Change VM Inspector settings** section.

## Select an analysis scenario to run

The following analysis scenarios are available to run from the Azure portal. Based on the logs and issues that you're experiencing, choose an analysis to run. For a link to the GitHub documentation of the full list analysis logs and information, see [Manifest Content](https://github.com/Azure/azure-diskinspect-service/blob/master/docs/manifest_content.md).

<details>
<summary>Windows diagnostics</summary>

|Analysis Name|File Name|
|--|--|
|diagnostic|`/Windows/System32/config/SOFTWARE`|
|diagnostic|`/Windows/System32/config/SYSTEM`|
|diagnostic|`/Windows/System32/winevt/Logs/System.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Application.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-ServiceFabric%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-ServiceFabric%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-ServiceFabric-Lease%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-ServiceFabric-Lease%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Windows Azure.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-CAPI2%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-Kernel-PnPConfig%4Configuration.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-Kernel-PnP%4Configuration.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-NdisImPlatform%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-NetworkLocationWizard%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-NetworkProfile%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-NetworkProvider%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-NlaSvc%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-RdpCoreTS%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-RdpCoreTS%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-RemoteDesktopSessionManager%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-RemoteDesktopServices-SessionServices%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-Resource-Exhaustion-Detector%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-SmbClient%4Connectivity.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-SMBClient%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-SMBServer%4Connectivity.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-SMBServer%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-ServerManager%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TCPIP%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-LocalSessionManager%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-LocalSessionManager%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-PnPDevices%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-PnPDevices%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-RDPClient%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-SessionBroker-Client%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-TerminalServices-SessionBroker-Client%4Admin.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-UserPnp%4DeviceInstall.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-Windows Firewall With Advanced Security%4ConnectionSecurity.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-Windows Firewall With Advanced Security%4Firewall.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-WindowsUpdateClient%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4GuestAgent.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4Heartbeat.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4Runtime.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Diagnostics%4Bootstrapper.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Status%4GuestAgent.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-WindowsAzure-Status%4Plugins.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/MicrosoftAzureRecoveryServices-Replication.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Security.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Setup.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-DSC%4Operational.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-BitLocker%4BitLocker Management.evtx`|
|diagnostic|`/Windows/System32/winevt/Logs/Microsoft-Windows-BitLocker-DrivePreparationTool%4Operational.evtx`|
|diagnostic|`/AzureData/CustomData.bin`|
|diagnostic|`/Windows/Setup/State/State.ini`|
|diagnostic|`/Windows/Panther/WaSetup.xml`|
|diagnostic|`/Windows/Panther/WaSetup.log`|
|diagnostic|`/Windows/Panther/VmAgentInstaller.xml`|
|diagnostic|`/Windows/Panther/unattend.xml`|
|diagnostic|`/unattend.xml`|
|diagnostic|`/Windows/Panther/setupact.log`|
|diagnostic|`/Windows/Panther/setuperr.log`|
|diagnostic|`/Windows/Panther/UnattendGC/setupact.log`|
|diagnostic|`/Windows/Panther/FastCleanup/setupact.log`|
|diagnostic|`/Windows/System32/Sysprep/ActionFiles/Generalize.xml`|
|diagnostic|`/Windows/System32/Sysprep/ActionFiles/Specialize.xml`|
|diagnostic|`/Windows/System32/Sysprep/ActionFiles/Respecialize.xml`|
|diagnostic|`/Windows/System32/Sysprep/Panther/setupact.log`|
|diagnostic|`/Windows/System32/Sysprep/Panther/IE/setupact.log`|
|diagnostic|`/Windows/System32/Sysprep/Panther/setuperr.log`|
|diagnostic|`/Windows/System32/Sysprep/Panther/IE/setuperr.log`|
|diagnostic|`/Windows/System32/Sysprep/Sysprep_succeeded.tag`|
|diagnostic|`/Windows/INF/netcfg*.*etl`|
|diagnostic|`/Windows/INF/setupapi.dev.log`|
|diagnostic|`/Windows/debug/netlogon.log`|
|diagnostic|`/Windows/debug/NetSetup.LOG`|
|diagnostic|`/Windows/debug/mrt.log`|
|diagnostic|`/Windows/debug/DCPROMO.LOG`|
|diagnostic|`/Windows/debug/dcpromoui.log`|
|diagnostic|`/Windows/debug/PASSWD.LOG`|
|diagnostic|`/Windows/Microsoft.NET/Framework/v4.0.30319/Config/machine.config`|
|diagnostic|`/Windows/Microsoft.NET/Framework64/v4.0.30319/Config/machine.config`|
|diagnostic|`/WindowsAzure`|
|diagnostic|`/Packages/Plugins`|
|diagnostic|`/WindowsAzure/Logs/Telemetry.log`|
|diagnostic|`/WindowsAzure/Logs/TransparentInstaller.log`|
|diagnostic|`/WindowsAzure/Logs/WaAppAgent.log`|
|diagnostic|`/WindowsAzure/config/*.xml`|
|diagnostic|`/WindowsAzure/Logs/AggregateStatus/aggregatestatus*.json`|
|diagnostic|`/WindowsAzure/Logs/AppAgentRuntime.log`|
|diagnostic|`/WindowsAzure/Logs/MonitoringAgent.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/*/*/CommandExecution.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/*/*/Install.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/*/*/Update.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/*/*/Heartbeat.log`|
|diagnostic|`/Packages/Plugins/*/*/config.txt`|
|diagnostic|`/Packages/Plugins/*/*/HandlerEnvironment.json`|
|diagnostic|`/Packages/Plugins/*/*/HandlerManifest.json`|
|diagnostic|`/Packages/Plugins/*/*/RuntimeSettings/*.settings`|
|diagnostic|`/Packages/Plugins/*/*/Status/HeartBeat.Json`|
|diagnostic|`/Packages/Plugins/*/*/PackageInformation.txt`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/*/Configuration/Checkpoint.txt`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/*/Configuratoin/MaConfig.xml`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/*/Configuratoin/MonAgentHost.*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/DiagnosticsPlugin.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/DiagnosticsPluginLauncher.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.Security.IaaSAntimalware/*/AntimalwareConfig.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.Security.Monitoring/*/AsmExtension.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/FabricMSIInstall*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/InfrastructureManifest.xml`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/TempClusterManifest.xml`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/VCRuntimeInstall*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Compute.BGInfo/*/BGInfo*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Compute.JsonADDomainExtension/*/ADDomainExtension.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Compute.VMAccessAgent/*/JsonVMAccessExtension.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.EnterpriseCloud.Monitoring.MicrosoftMonitoringAgent/*/0.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Powershell.DSC/*/DSCLOG*.json`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Powershell.DSC/*/DscExtensionHandler*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Symantec.SymantecEndpointProtection/*/sepManagedAzure.txt`|
|diagnostic|`/WindowsAzure/Logs/Plugins/TrendMicro.DeepSecurity.TrendMicroDSA/*/*.log`|
|diagnostic|`/Packages/Plugins/ESET.FileSecurity/*/agent_version.txt`|
|diagnostic|`/Packages/Plugins/ESET.FileSecurity/*/extension_version.txt`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/AnalyzerConfigTemplate.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/*.config`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/Logs/*DiagnosticsPlugin*.log`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/schema/wad*.json`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Diagnostics.IaaSDiagnostics/*/StatusMonitor/ApplicationInsightsPackagesVersion.json`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.RecoveryServices.VMSnapshot/*/SeqNumber.txt`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Microsoft.WindowsAzure.Storage.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/AsmExtensionMonitoringConfig*.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/ASM.Azure.OSBaseline.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/AsmExtensionSecurityPackStartupConfig.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/AsmScan.log`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/AsmScannerConfiguration.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/Azure.Common.scm.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/SecurityPackStartup.log`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/Extensions/AzureSecurityPack/SecurityScanLoggerManifest.man`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/AgentStandardEvents.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/AgentStandardEventsMin.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/AgentStandardExtensions.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/AntiMalwareEvents.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/MonitoringEwsEvents.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/MonitoringEwsEventsCore.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/MonitoringEwsRootEvents.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/MonitoringStandardEvents.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/MonitoringStandardEvents2.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/MonitoringStandardEvents3.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/SecurityStandardEvents.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/SecurityStandardEvents2.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/initconfig/*/Standard/SecurityStandardEvents3.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/Monitoring/agent/MonAgent-Pkg-Manifest.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/MonitoringAgentCertThumbprints.txt`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.Security.Monitoring/*/MonitoringAgentScheduledService.txt`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/InstallUtil.InstallLog`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/current.config`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/InfrastructureManifest.template.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/ServiceFabricNodeBootstrapAgent.InstallLog`|
|diagnostic|`/Packages/Plugins/Microsoft.Azure.ServiceFabric.ServiceFabricNode/*/Service/ServiceFabricNodeBootstrapAgent.InstallState`|
|diagnostic|`/Packages/Plugins/Microsoft.Compute.BGInfo/*/BGInfo.def.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Compute.BGInfo/*/PluginManifest.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Compute.BGInfo/*/config.bgi`|
|diagnostic|`/Packages/Plugins/Microsoft.Compute.BGInfo/*/emptyConfig.bgi`|
|diagnostic|`/Packages/Plugins/Microsoft.Powershell.DSC/*/DSCWork/*.dsc`|
|diagnostic|`/Packages/Plugins/Microsoft.Powershell.DSC/*/DSCWork/*.log`|
|diagnostic|`/Packages/Plugins/Microsoft.Powershell.DSC/*/DSCWork/*.dpx`|
|diagnostic|`/Packages/Plugins/Microsoft.Powershell.DSC/*/DSCVersion.xml`|
|diagnostic|`/Packages/Plugins/Microsoft.Powershell.DSC/*/DSCWork/HotfixInstallInProgress.dsc`|
|diagnostic|`/Packages/Plugins/Microsoft.Powershell.DSC/*/DSCWork/PreInstallDone.dsc`|
|diagnostic|`/Packages/Plugins/Microsoft.SqlServer.Management.SqlIaaSAgent/*/PackageDefinition.xml`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.NetworkWatcher.Edp.NetworkWatcherAgentWindows/*/*.txt`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.NetworkWatcher.Edp.NetworkWatcherAgentWindows/*/*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.NetworkWatcher.NetworkWatcherAgentWindows/*/*.txt`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.NetworkWatcher.NetworkWatcherAgentWindows/*/*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.ManagedIdentity.ManagedIdentityExtensionForWindows/*/RuntimeSettings/*.xml`|
|diagnostic|`/WindowsAzure/GuestAgent*/CommonAgentConfig.config`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Compute.CustomScriptExtension/*/*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.CPlat.Core.RunCommandWindows/*/*.log`|
|diagnostic|`/WindowsAzure/Logs/Plugins/Microsoft.Azure.ActiveDirectory.AADLoginForWindows/*/*.log`|
|diagnostic|`/Windows/servicing/sessions/sessions.xml|
</details>

<details>
<summary>Linux diagnostics</summary>

|Analysis Name|File Name|
|--|--|
|diagnostic|`/var/log`|
|diagnostic|`/var/lib/cloud`|
|diagnostic|`/run/cloud-init`|
|diagnostic|`/var/lib/waagent`|
|diagnostic|`/etc/udev/rules.d`|
|diagnostic|`/var/log/cloud-init*`|
|diagnostic|`/etc/cloud/cloud.cfg`|
|diagnostic|`/etc/cloud/cloud.cfg.d/*.cfg`|
|diagnostic|`/run/cloud-init/cloud.cfg`|
|diagnostic|`/run/cloud-init/ds-identify.log`|
|diagnostic|`/run/cloud-init/result.json`|
|diagnostic|`/run/cloud-init/status.json`|
|diagnostic|`/var/log/waagent*`|
|diagnostic|`/etc/waagent.conf`|
|diagnostic|`/var/lib/waagent/provisioned`|
|diagnostic|`/var/lib/waagent/waagent_status.json`|
|diagnostic|`/var/lib/waagent/*/error.json`|
|diagnostic|`/var/lib/waagent/*.manifest.xml`|
|diagnostic|`/var/lib/waagent/*/config/*.settings`|
|diagnostic|`/var/lib/waagent/*/config/HandlerState`|
|diagnostic|`/var/lib/waagent/*/config/HandlerStatus`|
|diagnostic|`/var/lib/waagent/*/status/*.status`|
|diagnostic|`/var/lib/waagent/ExtensionsConfig.*.xml`|
|diagnostic|`/var/lib/waagent/GoalState.*.xml`|
|diagnostic|`/var/lib/waagent/HostingEnvironmentConfig.xml`|
|diagnostic|`/var/lib/waagent/Incarnation`|
|diagnostic|`/var/lib/waagent/ManagedIdentity-*.json`|
|diagnostic|`/var/lib/waagent/SharedConfig.xml`|
|diagnostic|`/var/lib/waagent/history/*.zip`|
|diagnostic|`/run/systemd/netif/leases/*`|
|diagnostic|`/var/lib/NetworkManager/*.lease`|
|diagnostic|`/var/lib/NetworkManager/*.leases`|
|diagnostic|`/var/lib/wicked/lease*`|
|diagnostic|`/var/lib/dhclient/*.lease`|
|diagnostic|`/var/lib/dhclient/*.leases`|
|diagnostic|`/var/lib/dhcp/*.lease`|
|diagnostic|`/var/lib/dhcp/*.leases`|
|diagnostic|`/run/cloud-init/dhclient.hooks/*.json`|
|diagnostic|`/etc/netplan/*.yaml`|
|diagnostic|`/etc/dhcp/*.conf`|
|diagnostic|`/etc/network/interfaces`|
|diagnostic|`/etc/network/interfaces.d/*.cfg`|
|diagnostic|`/etc/ufw/ufw.conf`|
|diagnostic|`/etc/ssh/sshd_config`|
|diagnostic|`/etc/nsswitch.conf`|
|diagnostic|`/etc/resolv.conf`|
|diagnostic|`/run/systemd/resolve/*.conf`|
|diagnostic|`/run/resolvconf/*.conf`|
|diagnostic|`/usr/lib/NetworkManager/*.conf`|
|diagnostic|`/usr/lib/NetworkManager/conf.d/*.conf`|
|diagnostic|`/run/NetworkManager/*.conf`|
|diagnostic|`/run/NetworkManager/conf.d/*.conf`|
|diagnostic|`/etc/NetworkManager/*.conf`|
|diagnostic|`/etc/NetworkManager/conf.d/*.conf`|
|diagnostic|`/var/lib/NetworkManager/*.conf`|
|diagnostic|`/var/lib/NetworkManager/conf.d/*.conf`|
|diagnostic|`/var/lib/NetworkManager/*.state`|
|diagnostic|`/etc/sysconfig/network/dhcp`|
|diagnostic|`/etc/sysconfig/network`|
|diagnostic|`/etc/sysconfig/network-scripts/ifcfg-*`|
|diagnostic|`/etc/sysconfig/network-scripts/route-*`|
|diagnostic|`/etc/sysconfig/network/config`|
|diagnostic|`/etc/sysconfig/network/ifcfg-*`|
|diagnostic|`/etc/sysconfig/network/routes`|
|diagnostic|`/etc/sysconfig/iptables`|
|diagnostic|`/etc/sysconfig/SuSEfirewall2`|
|diagnostic|`/etc/wicked/*.xml`|
|diagnostic|`/var/log/dpkg*`|
|diagnostic|`/var/log/yum*`|
|diagnostic|`/var/log/dnf*`|
|diagnostic|`/var/log/syslog*`|
|diagnostic|`/var/log/rsyslog*`|
|diagnostic|`/var/log/messages*`|
|diagnostic|`/var/log/kern*`|
|diagnostic|`/var/log/dmesg*`|
|diagnostic|`/var/log/boot*`|
|diagnostic|`/var/log/auth*`|
|diagnostic|`/var/log/secure*`|
|diagnostic|`/var/log/azure/*/*`|
|diagnostic|`/var/log/azure/*/*/*`|
|diagnostic|`/var/log/azure/custom-script/handler.log`|
|diagnostic|`/var/log/azure/run-command/handler.log`|
|diagnostic|`/var/log/azure/cluster-provision.log`|
|diagnostic|`/etc/fstab`|
|diagnostic|`/boot/grub*/grub.c*`|
|diagnostic|`/boot/grub*/menu.lst`|
|diagnostic|`/etc/*-release`|
|diagnostic|`/etc/HOSTNAME`|
|diagnostic|`/etc/hostname`|
</details>

## Change the VM Inspector settings

Reopen the VM Inspector page to change a storage account to run a new VM Inspector report or to view an existing VM Inspector report that's stored in other storage accounts. Use the same storage account for multiple VMs that run VM Inspector. The old reports aren't deleted when you change the storage account. However, they'll no longer be displayed in the Inspector reports list view.

:::image type="content" source="media/vm-inspector-azure-virtual-machines/inspector-reports-list.png" alt-text="Screenshot of the dropdown list of current inspector reports within the inspector reports view.":::

## Manage and view the VM Inspector report

Each VM Inspector report might contain multiple files and logs for your troubleshooting. For more information, see the complete list of all the collected VM Inspector report data for [Windows](https://github.com/Azure/azure-diskinspect-service/blob/master/docs/manifest_content.md#windows) or [Linux](https://github.com/Azure/azure-diskinspect-service/blob/master/docs/manifest_content.md#linux). To download and review the full diagnostics report, select the specific report, and then select **Download report** to download a .zip file that contains all the logs and files within the report.

:::image type="content" source="media/vm-inspector-azure-virtual-machines/download-report.png" alt-text="Screenshot of the existing reports in the selected diagnostics storage account, including the Download Report option.":::

To delete one or more VM Inspector reports, select **Delete report**.

:::image type="content" source="media/vm-inspector-azure-virtual-machines/delete-report-button.png" alt-text="Screenshot of the Delete Report button in the menu of the VM Inspector window, and the Yes and No buttons for the request to delete the report.":::

## Frequently Asked Questions (FAQ)

**Q1. Where are the VM Inspector reports stored?**

**A1.** All VM Inspector reports are stored in your own storage account. To view the storage account information, use the **Setting** button on the toolbar.

**Q2. How do I submit the feedback for VM Inspector?**

**A2.** To submit feedback, select the **Feedback** button on the toolbar, and then select the **Smile** or **Frown** icon, or provide extra feedback to us.

**Q3. I ran VM Inspector. Why don't I see any error messages?**

**A3.** If you don't see error messages when you run VM inspector, you don't have the minimum access level of **Owner** to run the tool. To get access, refer to the **Get access to VM Inspector** section.

**Q4. Why do I have to provide consent to be able to run VM Inspector successfully?**

**A4.** The disk doesn't have the **Disk Backup Reader Access** role to enable VM Inspector to run successfully. Select the check box for **Consent to assign Disk Backup Reader access to Compute Recommendation Service** to grant access to the service for **Disk Backup Reader Access**.

**Q5. Does VM Inspector use Credential Scanner to redact any secrets from the logs?**

**A5.** Yes. If you want to be excluded from the redaction, submit your request or reach out to <vminspector@microsoft.com>.

## Resources

- [VM Inspector error messages](vm-inspector-error-messages.md)

## Next steps

If you need more help with any of the content in this article, or if you have any feedback regarding this feature, contact the Azure experts at <vminspector@microsoft.com>.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
