---
title: Azure Stack Edge support package and device logs
description: Provides guidance for capturing diagnostic information from Azure Stack Edge.
ms.date: 05/30/2023
ms.service: azure-stack
ms.author: genli
author: genlin
ms.reviewer: Andrew.Brenner
---

# Azure Stack Edge support package and device logs

## Summary

The **Azure Stack Edge** support package contains all the relevant logs that can assist Microsoft Support team with troubleshooting issues. These logs are collected either automatically during the support ticket submission, or they can be submitted manually.

For more information on how to manually submit the support package for Azure Stack Edge, see [Collect Support package](/azure/databox-online/azure-stack-edge-troubleshoot#collect-support-package).

## Memory Dumps

Microsoft can collect support logs and memory dumps to help troubleshoot device issues with your Azure Stack Edge device. You can provide your consent to allow access to the general support logs when you create the Support ticket.

Additionally, for logs containing memory dumps, you can use **Customer Lockbox** to review and approve or reject these requests.

For more information on how to use Customer Lockbox for your organization, see [Customer Lockbox for Microsoft Azure](/azure/security/fundamentals/customer-lockbox-overview).

## Information collected by the Azure Stack Edge support package

The following sections shares list of information which may be collected as part of the support package.

> [!NOTE]
> This is a representative set of logs. There might be more files which can be collected.

### Registry subkeys

- HKEY_LOCAL_MACHINE\HARDWARE\DEVICEMAP\Scsi
- HKEY_LOCAL_MACHINE \Software\Microsoft\CDMInfra
- HKEY_LOCAL_MACHINE \SYSTEM\CurrentControlSet\Control\SecureBoot\State

### Full, Mini, Stack & Kernel dump (*.dmp)

- Process dumps
- OS memory dumps

## Trace dump of the commands

|Type|Commands|
|--|--|
|Cluster|Get-Cluster<br>Get-ClusterAffinityRule<br>Get-ClusterGroup<br>Get-ClusterNetwork<br>Get-ClusterNetworkInterface<br>Get-ClusterNode<br>Get-ClusterResource|
|Compute|Get-AzureDataBoxEdgeRole<br>Get-HcsComputeInfo<br>Get-HcsKubeClusterInfo<br>Get-HcsKubeNodeInfo<br>Get-VM<br>Test-AzureDataBoxEdgeRole|
|Configuration|Get-BitLockerVolume<br>Get-HcsAlerts -ShowConditions<br>Get-HcsAlerts -ShowEvents<br>Get-HcsApplianceInfo<br>Get-HcsApplianceSetupInformation<br>Get-HcsApplianceStartupError<br>Get-HcsCertificateConfiguration<br>Get-HcsCloudBandwidth<br>Get-HcsCloudBandwidthSchedule<br>Get-HcsConfiguration -JsonFormat<br>Get-HcsControllerSetupInformation<br>Get-HcsCounterConfigInfo<br>Get-HcsDataContainer<br>Get-HcsExternalVirtualSwitch<br>Get-HcsFileServer<br>Get-HcsHardwareComponent<br>Get-HcsIpAddress<br>Get-HcsIpmiEntity<br>Get-HcsIpmiSensor<br>Get-HcsModel<br>Get-HcsNetInterface<br>Get-HcsNodeInformation<br>Get-HcsSetupDesiredStateResult<br>Get-HcsShare<br>Get-HcsStorageAccountCredential<br>Get-HcsSystemConfiguration -Config CertificateConfiguration -Details<br>Get-HcsTimeSettings<br>Get-HcsUpdateJob<br>Get-HcsUser<br>Get-HcsWebProxy<br>Get-NetFirewallRule -Name torSimpleLocalUiHttp<br>Get-NetFirewallRule -Name StorSimpleLocalUiHttps<br>Get-NFSShare<br>Get-NFSSharePermission<br>Get-NFSShare<br>Get-PcsvDevice<br>Get-PnpDevice<br>Get-Process<br>Get-Service<br>Get-Tpm<br>Get-WmiObject Win32_PnPSignedDriver select devicename, driverversion|
|Defender|Get-MpComputerStatus<br>Get-MpPreference<br>Get-MpThreat<br>Get-MpThreatDetection|
|MEC|Get-MecInformation -skipRegKey 1<br>Get-MecServiceConfig<br>Get-MecVirtualMachine<br>Get-MecVnf|
|Network|Arp -a<br>Get-NetAdapter<br>Get-NetAdapterAdvancedProperty -RegistryKeyword RDMAMode<br>Get-NetAdapterHardwareInfo<br>Get-NetAdapterRdma<br>Get-NetAdapterSriov<br>Get-NetIPAddress<br>Get-NetIPInterface  Select ifIndex, InterfaceAlias, AddressFamily, ConnectionState, Forwarding<br>Get-NetNat<br>Get-NetNatExternalAddress<br>Get-PnpDevice   { $_.FriendlyName -Like 'Qlogic'}<br>Get-VMNetworkAdapter -All<br>Get-VMSwitch<br>Ipconfig -All<br>Route -print|
|Object Store|Get-AcsHealthStatus<br>Get-HcsDataBoxAccount<br>Get-HcsRestEndpoint|
|Storage|Get-Disk<br>Get-MaskingSet<br>Get-Partition<br>Get-PhysicalDisk<br>Get-StorageReliabilityCounter<br>Get-PhysicalDisk<br>Get-PhysicalDiskStorageNodeView<br>Get-ResiliencySetting<br>Get-SmbClientConfiguration<br>Get-SmbClientNetworkInterface<br>Get-SmbConnection<br>Get-SmbMapping<br>Get-SmbMultichannelConnection<br>Get-SmbMultichannelConstraint<br>Get-SmbOpenFile<br>Get-SmbServerConfiguration<br>Get-SmbServerNetworkInterface<br>Get-SmbSession<br>Get-SmbShare<br>Get-StorageNode<br>Get-StoragePool<br>Get-StorageProvider<br>Get-StorageSetting<br>Get-StorageSubSystem<br>Get-StorageTier<br>Get-VirtualDisk<br>Get-Volume|

## Sample support package content including logs

- ArmConfig.txt
- ArmConfigScriptOutput.txt
- CBS.log
- ClusterManagement.log
- DeliverOptimization.log
- DeliverOptimizationCmdledOutput.txt
- DumpStack.log.tmp
- HardwareComponentInfo.json
- HWIntrusion.txt
- pfirewall.log
- SmbWmiAnalytic.etl
- symbols.txt
- tsr.zip
- WindowsUpdate.log
- WindowsUpdateLogCmdOutput.txt

### Additional content

<details>
  <summary>cmdlets</summary>

- bcdedit
  - bcdeditVerbose.txt
  - bcdeditAll.txt
- BitLocker
  - manage_bde_status.txt
- Cluster
  - Get-CimInstance -ClassName ClusPortDeviceInformation -Namespace rootWMI.txt
  - Get-Cluster.txt
  - Get-ClusterAffinityRule.txt
  - Get-ClusterGroup.txt
  - Get-ClusterNetwork.txt
  - Get-ClusterNetworkInterface.txt
  - Get-ClusterNode.txt
  - Get-ClusterResource  Get-ClusterParameter.txt
  - Get-ClusterResource.txt
- Compute
  - Get-AcsComputeClusterHostReservation -ClusterName (Get-Cluster).Name
ForEach- Object  {$_.key; $_.Value}.txt
  - Get-AcsComputeClusterReservation -ClusterName (Get-Cluster).Name
% {$_.key; $_.value; $_.value.AvailabilitySet; }.txt
  - Get-AzureDataBoxEdgeComputeAccelCards -Scope System.txt
  - Get-AzureDataBoxEdgeComputeAccelCards.txt
  - Get-AzureDataBoxEdgeComputeAccelDiagnosticsHealth.txt
  - Get-AzureDataBoxEdgeComputeAccelEndpoints -Scope System.txt
  - Get-AzureDataBoxEdgeComputeAccelEndpoints.txt
  - Get-AzureDataBoxEdgeFpgaWireserverConfig.txt
  - Get-AzureDataBoxEdgeRole.txt
  - Get-AzureDataBoxEdgeRoleImage.txt
  - Get-AzureDataBoxEdgeRoleStorageEndpoints.txt
  - Get-AzureDataBoxEdgeRoleTrigger.txt
  - Get-AzureDataBoxEdgeRoleTriggerSinks.txt
  - Get-AzureDataBoxEdgeRoleTriggerSources.txt
  - Get-AzureDataBoxEdgeRoleTriggerTopicSinksList.txt
  - Get-HcsComputeInfo.txt
  - Get-HcsKubeClusterInfo.txt
  - Get-HcsKubeNodeInfo.txt
  - Get-HcsKubernetesClusterDSC -JsonFormat.txt
  - Get-VM  Get-VMAssignableDevice.txt
  - Get-VM.txt
  - Get-VMHostAssignableDevice.txt
  - Test-AzureDataBoxEdgeRole.txt
  - Test-HcsKubernetesStatus.txt
- Configuration
  - Get-BitLockerVolume.txt
  - Get-HcsAlerts -ShowConditions.txt
  - Get-HcsAlerts -ShowEvents.txt
  - Get-HcsApplianceInfo.txt
  - Get-HcsApplianceSetupInformation.txt
  - Get-HcsApplianceStartupError.txt
  - Get-HcsCertificateConfiguration.txt
  - Get-HcsCloudBandwidth.txt
  - Get-HcsCloudBandwidthSchedule.txt
  - Get-HcsConfiguration -JsonFormat.txt
  - Get-HcsControllerSetupInformation.txt
  - Get-HcsCounterConfigInfo.txt
  - Get-HcsDataContainer.txt
  - Get-HcsExternalVirtualSwitch.txt
  - Get-HcsFileServer.txt
  - Get-HcsHardwareComponent.txt
  - Get-HcsIpAddress.txt
  - Get-HcsIpmiEntity.txt
  - Get-HcsIpmiSensor.txt
  - Get-HcsModel.txt
  - Get-HcsNetInterface.txt
  - Get-HcsNodeInformation.txt
  - Get-HcsSetupDesiredStateResult.txt
  - Get-HcsShare.txt
  - Get-HcsStorageAccountCredential.txt
  - Get-HcsSystemConfiguration -Config CertificateConfiguration -Details.txt
  - Get-HcsTimeSettings.txt
  - Get-HcsUpdateJob.txt
  - Get-HcsUser.txt
  - Get-HcsWebProxy.txt
  - Get-NetFirewallRule -Name StorSimpleLocalUiHttp.txt
  - Get-NetFirewallRule -Name StorSimpleLocalUiHttps.txt
  - Get-NFSShare  Get-NFSSharePermission.txt
  - Get-NFSShare.txt
  - Get-PcsvDevice.txt
  - Get-PcsvDeviceLog  select -Last 50.txt
  - Get-PnpDevice.txt
  - Get-Process.txt
  - Get-Service.txt
  - Get-Tpm.txt
  - Get-WmiObject Win32_PnPSignedDriver select devicename, driverversion.txt
- Defender for Cloud
  - Get-MpComputerStatus.txt
  - Get-MpPreference.txt
  - Get-MpThreat.txt
  - Get-MpThreatDetection.txt
- DeviceGuard
  - Get-CimInstance -ClassName win32_deviceguard -Namespace
rootMicrosoftWindowsDeviceGuard.txt
- Mec
  - Get-MecInformation -skipRegKey 1.txt
  - Get-MecServiceConfig.txt
  - Get-MecVirtualMachine.txt
  - Get-MecVnf.txt
- Netsh
  - Netsh Http Show Cacheparam.txt
  - Netsh Http Show Cachestate.txt
  - Netsh Http Show Iplisten.txt
  - Netsh Http Show Servicestate.txt
  - Netsh Http Show Setting.txt
  - Netsh Http Show Sslcert.txt
  - Netsh Http Show Timeout.txt
  - Netsh Http Show Urlacl.txt
- Network
  - arp_a.txt
  - Get-NetAdapter.txt
  - Get-NetAdapterAdvancedProperty -RegistryKeyword RDMAMode.txt
  - Get-NetAdapterHardwareInfo.txt
  - Get-NetAdapterRdma.txt
  - Get-NetAdapterSriov.txt
  - Get-NetIPAddress.txt
  - Get-NetIPInterface  Select ifIndex, InterfaceAlias, AddressFamily, ConnectionState,
Forwarding.txt
  - Get-NetNat.txt
  - Get-NetNatExternalAddress.txt
  - Get-PnpDevice   { $_.FriendlyName -Like 'Qlogic'}.txt
  - Get-VMNetworkAdapter -All.txt
  - Get-VMSwitch.txt
  - Ipconfig_All.txt
  - Route_print.txt
- ObjStore
  - Get-AcsHealthStatus.txt
  - Get-HcsDataBoxAccount.txt
  - Get-HcsRestEndpoint.txt
- Platform
  - HardwareList.hwlist
  - systeminfo.txt
- Storage
  - Get-Disk.txt
  - Get-MaskingSet.txt
  - Get-Partition.txt
  - Get-PhysicalDisk  Get-StorageReliabilityCounter.txt
  - Get-PhysicalDisk.txt
  - Get-PhysicalDiskStorageNodeView.txt
  - Get-ResiliencySetting.txt
  - Get-SmbClientConfiguration.txt
  - Get-SmbClientNetworkInterface.txt
  - Get-SmbConnection.txt
  - Get-SmbMapping.txt
  - Get-SmbMultichannelConnection.txt
  - Get-SmbMultichannelConstraint.txt
  - Get-SmbOpenFile.txt
  - Get-SmbServerConfiguration.txt
  - Get-SmbServerNetworkInterface.txt
  - Get-SmbSession.txt
  - Get-SmbShare.txt
  - Get-StorageNode.txt
  - Get-StoragePool.txt
  - Get-StorageProvider.txt
  - Get-StorageSetting.txt
  - Get-StorageSubSystem.txt
  - Get-StorageTier.txt
  - Get-VirtualDisk.txt
  - Get-Volume.txt

</details>

<details>
  <summary>ComputeRolesLogs</summary>

- IotRole- HostPlatform- namespace- cm
  - Describe-asecerts.txt
  - Describe-local-path-config.txt
  - Get-asecerts.txt
  - Get-local-path-config.txt
- IotRole- HostPlatform- namespace- pod
  - Describe-backup-1615680000-s6llz.txt
  - Describe-local-path-provisioner-6b76f6cf7f-dw2lc.txt
  - Describe-smb-flexvol-installer-bhlpx.txt
  - Describe-voyager-5558c96f57-q5mch.txt
  - Get-backup-1615680000-s6llz.txt
  - Get-backup-1615708800-m4c7g.txt
  - Get-backup-1615737600-7h84b.txt
  - Get-local-path-provisioner-6b76f6cf7f-dw2lc.txt
  - Get-smb-flexvol-installer-bhlpx.txt
  - Get-voyager-5558c96f57-q5mch.txt
  - Logs-backup-1615680000-s6llz.txt
  - Logs-backup-1615708800-m4c7g.txt
  - Logs-backup-1615737600-7h84b.txt
  - Logs-local-path-provisioner-6b76f6cf7f-dw2lc.txt
  - Logs-smb-flexvol-installer-bhlpx.txt
  - Logs-voyager-5558c96f57-q5mch.txt
- IotRole- HostPlatform- K8S-`<cluster>`
  - arp-a.2021-03-14-11-39-36.log
  - certificates.2021-03-14-11-39-41.log
  - chronycsources.2021-03-14-11-39-38.log
  - chronyctracking.2021-03-14-11-39-40.log
  - df.2021-03-14-11-39-12.log
  - dmesg.2021-03-14-11-39-11.log
  - free.2021-03-14-11-39-44.log
  - ifconfig.2021-03-14-11-39-33.log
  - iproute.2021-03-14-11-39-34.log
  - journalctl.2021-03-14-11-39-06.log
  - lsmod.2021-03-14-11-39-14.log
  - lsof.2021-03-14-11-39-15.log
  - lspci.2021-03-14-11-39-13.log
  - lsusb.2021-03-14-11-39-30.log
  - meminfo.2021-03-14-11-39-42.log
  - nslookup.2021-03-14-11-39-35.log
  - nvidia-bug-report.2021-03-14-11-39-18.log.gz
  - smb-driver.2021-03-14-11-39-29.log
  - syslog
  - syslog.1
  - vmstat.2021-03-14-11-39-43.log
  - webrequestmsftwebsite.2021-03-14-11-39-37.log
- IotRole- Role- IotEdge- Nodes
  - Describe-k8s-`<clus>`-`<node>`.txt
  - Describe-k8s-`<clus>`-m0.txt
  - Get-k8s-`<clus>`-`<node>`.txt
  - Get-k8s-`<clus>`-m0.txt
- IotRole- Role- IotEdge- IotEdge- pod
  - Describe-edgeagent-7648c457df-c7gqk.txt
  - Describe-iotedged-55fdb7b5c6-cx7kk.txt
  - Get-edgeagent-7648c457df-c7gqk.txt
  - Get-iotedged-55fdb7b5c6-cx7kk.txt
  - Logs-edgeagent-7648c457df-c7gqk.txt
  - Logs-iotedged-55fdb7b5c6-cx7kk.txt

</details>

<details>
  <summary>Etw</summary>

- Application.evtx
- Microsoft-AzureStack-BlobService.Admin.evtx
- Microsoft-AzureStack-BlobService.Debug.evtx
- Microsoft-AzureStack-BlobService.Diagnostic.evtx
- Microsoft-AzureStack-BlobService.Operational.evtx
- Microsoft-AzureStack-BlobService.Security.evtx
- Microsoft-AzureStack-StorageService.Admin.evtx
- Microsoft-AzureStack-StorageService.Diagnose.evtx
- Microsoft-AzureStack-StorageService.Operational.evtx
- Microsoft-AzureStack-StorageService.Security.evtx
- Microsoft-AzureStack-StorageService.StorageAccount.evtx
- Microsoft-IIS-Logging.Logs.evtx
- Microsoft-Research-Catapult.Operational.evtx
- Microsoft-Windows-BitLocker-Driver-Performance.Operational.evtx
- Microsoft-Windows-BitLocker.BitLocker Management.evtx
- Microsoft-Windows-BitLocker.BitLocker Operational.evtx
- Microsoft-Windows-BitLocker.Tracing.evtx
- Microsoft-Windows-CodeIntegrity.Operational.evtx
- Microsoft-Windows-FailoverClustering-CsvFs.Diagnostic.evtx
- Microsoft-Windows-FailoverClustering-CsvFs.Operational.evtx
- Microsoft-Windows-FailoverClustering-NetFt.Diagnostic.evtx
- Microsoft-Windows-FailoverClustering-NetFt.Operational.evtx
- Microsoft-Windows-HCS-Dvfilter-Events.Admin.evtx
- Microsoft-Windows-HCS-Dvfilter-Events.Analytic.evtx
- Microsoft-Windows-HCS-Dvfilter-Events.Debug.evtx
- Microsoft-Windows-HCS-Dvfilter-Events.Operational.evtx
- Microsoft-Windows-Hyper-V-VMMS-Admin.evtx
- Microsoft-Windows-Hyper-V-VMMS-Analytic.evtx
- Microsoft-Windows-Hyper-V-VMMS-Networking.evtx
- Microsoft-Windows-Hyper-V-VMMS-Operational.evtx
- Microsoft-Windows-Hyper-V-VMMS-Storage.evtx
- Microsoft-Windows-Hyper-V-Worker-Admin.evtx
- Microsoft-Windows-Hyper-V-Worker-Analytic.evtx
- Microsoft-Windows-Hyper-V-Worker-Operational.evtx
- Microsoft-Windows-Hyper-V-Worker-VDev-Analytic.evtx
- Microsoft-Windows-Policy.Operational.evtx
- Microsoft-Windows-ReFS.Operational.evtx
- Microsoft-Windows-ServicesForNFS-Portmapper.Admin.evtx
- Microsoft-Windows-ServicesForNFS-Server.Admin.evtx
- Microsoft-Windows-ServicesForNFS-Server.IdentityMapping.evtx
- Microsoft-Windows-ServicesForNFS-Server.Operational.evtx
- Microsoft-Windows-SMBClient.Analytic.evtx
- Microsoft-Windows-SmbClient.Audit.evtx
- Microsoft-Windows-SmbClient.Connectivity.evtx
- Microsoft-Windows-SmbClient.Diagnostic.evtx
- Microsoft-Windows-SMBClient.HelperClassDiagnostic.evtx
- Microsoft-Windows-SMBClient.ObjectStateDiagnostic.evtx
- Microsoft-Windows-SMBClient.Operational.evtx
- Microsoft-Windows-SmbClient.Security.evtx
- Microsoft-Windows-SMBDirect.Admin.evtx
- Microsoft-Windows-SMBDirect.Debug.evtx
- Microsoft-Windows-SMBDirect.Netmon.evtx
- Microsoft-Windows-SMBServer.Analytic.evtx
- Microsoft-Windows-SMBServer.Audit.evtx
- Microsoft-Windows-SMBServer.Connectivity.evtx
- Microsoft-Windows-SMBServer.Diagnostic.evtx
- Microsoft-Windows-SMBServer.Operational.evtx
- Microsoft-Windows-SMBServer.Performance.evtx
- Microsoft-Windows-SMBServer.Security.evtx
- Microsoft-Windows-SMBWitnessClient.Admin.evtx
- Microsoft-Windows-SMBWitnessClient.Informational.evtx
- Microsoft-Windows-SMBWitnessServer.Admin.evtx
- Microsoft-Windows-Storage-Storport.Health.evtx
- Microsoft-Windows-Storage-Storport.Operational.evtx
- Microsoft-Windows-StorageManagement.Operational.evtx
- Microsoft-Windows-StorageSpaces-Api.Operational.evtx
- Microsoft-Windows-StorageSpaces-Driver.Diagnostic.evtx
- Microsoft-Windows-StorageSpaces-Driver.Operational.evtx
- Microsoft-Windows-StorageSpaces-Driver.Performance.evtx
- Microsoft-Windows-StorageSpaces-ManagementAgent.WHC.evtx
- Microsoft-Windows-StorageSpaces-SpaceManager.Diagnostic.evtx
- Microsoft-Windows-StorageSpaces-SpaceManager.Operational.evtx
- Microsoft-Windows-Windows Defender.Operational.evtx
- Microsoft-Windows-Windows Firewall With Advanced Security.Firewall.evtx
- Microsoft-Windows-Windows Firewall With Advanced
Security.FirewallDiagnostics.evtx
- Microsoft-Windows-Windows Firewall With Advanced Security.FirewallVerbose.evtx
- Microsoft-Windows-WindowsUpdateClient.Analytic.evtx
- Microsoft-Windows-WindowsUpdateClient.Operational.evtx
- Microsoft-WindowsAzure-Frontdoor.Debug.evtx
- Microsoft-WindowsAzure-Frontdoor.Operational.evtx
- Security.evtx
- System.evtx
- SystemEventsBroker.evtx

</details>

<details>
  <summary>LocaleMetaData</summary>

- Application_1033.MTA
- Microsoft-AzureStack-BlobService.Admin_1033.MTA
- Microsoft-AzureStack-BlobService.Debug_1033.MTA
- Microsoft-AzureStack-BlobService.Diagnostic_1033.MTA
- Microsoft-AzureStack-BlobService.Operational_1033.MTA
- Microsoft-AzureStack-BlobService.Security_1033.MTA
- Microsoft-AzureStack-StorageService.Admin_1033.MTA
- Microsoft-AzureStack-StorageService.Diagnose_1033.MTA
- Microsoft-AzureStack-StorageService.Operational_1033.MTA
- Microsoft-AzureStack-StorageService.Security_1033.MTA
- Microsoft-AzureStack-StorageService.StorageAccount_1033.MTA
- Microsoft-IIS-Logging.Logs_1033.MTA
- Microsoft-Research-Catapult.Operational_1033.MTA
- Microsoft-Windows-BitLocker-Driver-Performance.Operational_1033.MTA
- Microsoft-Windows-BitLocker.BitLocker Management_1033.MTA
- Microsoft-Windows-BitLocker.BitLocker Operational_1033.MTA
- Microsoft-Windows-BitLocker.Tracing_1033.MTA
- Microsoft-Windows-CodeIntegrity.Operational_1033.MTA
- Microsoft-Windows-FailoverClustering-CsvFs.Diagnostic_1033.MTA
- Microsoft-Windows-FailoverClustering-CsvFs.Operational_1033.MTA
- Microsoft-Windows-FailoverClustering-NetFt.Diagnostic_1033.MTA
- Microsoft-Windows-FailoverClustering-NetFt.Operational_1033.MTA
- Microsoft-Windows-HCS-Dvfilter-Events.Admin_1033.MTA
- Microsoft-Windows-HCS-Dvfilter-Events.Analytic_1033.MTA
- Microsoft-Windows-HCS-Dvfilter-Events.Debug_1033.MTA
- Microsoft-Windows-HCS-Dvfilter-Events.Operational_1033.MTA
- Microsoft-Windows-Hyper-V-VMMS-Admin_1033.MTA
- Microsoft-Windows-Hyper-V-VMMS-Analytic_1033.MTA
- Microsoft-Windows-Hyper-V-VMMS-Networking_1033.MTA
- Microsoft-Windows-Hyper-V-VMMS-Operational_1033.MTA
- Microsoft-Windows-Hyper-V-VMMS-Storage_1033.MTA
- Microsoft-Windows-Hyper-V-Worker-Admin_1033.MTA
- Microsoft-Windows-Hyper-V-Worker-Analytic_1033.MTA
- Microsoft-Windows-Hyper-V-Worker-Operational_1033.MTA
- Microsoft-Windows-Hyper-V-Worker-VDev-Analytic_1033.MTA
- Microsoft-Windows-Policy.Operational_1033.MTA
- Microsoft-Windows-ReFS.Operational_1033.MTA
- Microsoft-Windows-ServicesForNFS-Portmapper.Admin_1033.MTA
- Microsoft-Windows-ServicesForNFS-Server.Admin_1033.MTA
- Microsoft-Windows-ServicesForNFS-Server.IdentityMapping_1033.MTA
- Microsoft-Windows-ServicesForNFS-Server.Operational_1033.MTA
- Microsoft-Windows-SMBClient.Analytic_1033.MTA
- Microsoft-Windows-SmbClient.Audit_1033.MTA
- Microsoft-Windows-SmbClient.Connectivity_1033.MTA
- Microsoft-Windows-SmbClient.Diagnostic_1033.MTA
- Microsoft-Windows-SMBClient.HelperClassDiagnostic_1033.MTA
- Microsoft-Windows-SMBClient.ObjectStateDiagnostic_1033.MTA
- Microsoft-Windows-SMBClient.Operational_1033.MTA
- Microsoft-Windows-SmbClient.Security_1033.MTA
- Microsoft-Windows-SMBDirect.Admin_1033.MTA
- Microsoft-Windows-SMBDirect.Debug_1033.MTA
- Microsoft-Windows-SMBDirect.Netmon_1033.MTA
- Microsoft-Windows-SMBServer.Analytic_1033.MTA
- Microsoft-Windows-SMBServer.Audit_1033.MTA
- Microsoft-Windows-SMBServer.Connectivity_1033.MTA
- Microsoft-Windows-SMBServer.Diagnostic_1033.MTA
- Microsoft-Windows-SMBServer.Operational_1033.MTA
- Microsoft-Windows-SMBServer.Performance_1033.MTA
- Microsoft-Windows-SMBServer.Security_1033.MTA
- Microsoft-Windows-SMBWitnessClient.Admin_1033.MTA
- Microsoft-Windows-SMBWitnessClient.Informational_1033.MTA
- Microsoft-Windows-SMBWitnessServer.Admin_1033.MTA
- Microsoft-Windows-Storage-Storport.Health_1033.MTA
- Microsoft-Windows-Storage-Storport.Operational_1033.MTA
- Microsoft-Windows-StorageManagement.Operational_1033.MTA
- Microsoft-Windows-StorageSpaces-Api.Operational_1033.MTA
- Microsoft-Windows-StorageSpaces-Driver.Diagnostic_1033.MTA
- Microsoft-Windows-StorageSpaces-Driver.Operational_1033.MTA
- Microsoft-Windows-StorageSpaces-Driver.Performance_1033.MTA
- Microsoft-Windows-StorageSpaces-ManagementAgent.WHC_1033.MTA
- Microsoft-Windows-StorageSpaces-SpaceManager.Diagnostic_1033.MTA
- Microsoft-Windows-StorageSpaces-SpaceManager.Operational_1033.MTA
- Microsoft-Windows-Windows Defender.Operational_1033.MTA
- Microsoft-Windows-Windows Firewall With Advanced
Security.FirewallDiagnostics_1033.MTA
- Microsoft-Windows-Windows Firewall With Advanced
Security.FirewallVerbose_1033.MTA
- Microsoft-Windows-Windows Firewall With Advanced Security.Firewall_1033.MTA
- Microsoft-Windows-WindowsUpdateClient.Analytic_1033.MTA
- Microsoft-Windows-WindowsUpdateClient.Operational_1033.MTA
- Microsoft-WindowsAzure-Frontdoor.Debug_1033.MTA
- Microsoft-WindowsAzure-Frontdoor.Operational_1033.MTA
- Security_1033.MTA
- SystemEventsBroker_1033.MTA
- System_1033.MTA

</details>

<details>
  <summary>hcslogs</summary>

- ControllerComponentProvider-HardwareComponentInfo.json
- hcsedgeagentreader.Primary_2021-03-11_09-57-17-PM_14628.hcsml
- hcsedgeagentwriter.Primary_2021-03-11_09-57-30-PM_04280.hcsml
- hcsedgecontroller.Primary_2021-03-11_09-57-30-PM_09704.hcsml
- hcshealthmonitor.Primary_2021-03-11_09-57-21-PM_14652.hcsml
- hcsmgmt.Primary_2021-03-11_09-57-13-PM_07504.hcsml
- hcsnode.Primary_2021-03-11_09-57-10-PM_12940.hcsml
- hcssetupservice.Primary_2021-03-11_09-56-47-PM_14092.hcsml
- hcsvmagent.Primary_2021-03-12_02-22-51-AM_14864.hcsml
- hcs_log_snapshot.log
- Microsoft.Hcs.LocalUi.Primary_2021-03-11_11-54-09-PM_13264.hcsml
- nodeservice.Primary_2021-03-11_08-42-53-PM_07628.hcsml
- nodesetupservice.Primary_2021-03-11_08-40-46-PM_07676.hcsml
- NoOpComponentProvider-HardwareComponentInfo.json
- powershell.Primary_2021-03-11_08-45-00-PM_03196.hcsml
- wsmprovhost.Primary_2021-03-11_08-51-59-PM_07288.hcsml

</details>

<details>
  <summary>Etl</summary>

- FveApi.etl
- HcsCore.etl
- HcsHealthPlugin.etl
- HcsPerfCounter.etl
- mispace.etl
- SedEncMgr.etl
- spaces.etl
- wastorage.etl

</details>

<details>
  <summary>Firmware</summary>

- hcs_firmware.log

</details>

<details>
  <summary>Setup</summary>

- BiosConfigJobInfo-intra
- BiosConfigJobInfo-post
- BiosConfigJobInfo-pre
- BIOSUpdate-intra.json
- BIOSUpdate-post.json
- BIOSUpdate-pre.json
- BootDriveBitLockerRecKeyEnc.txt
- DeviceInfo.json
- FirmwareUpdate.json
- FirmwareUpdateCompleted
- HcsNodePostClusterSetupEnd.log
- HcsPostClusterSetupEnd.log
- HcsPreClusterSetupEnd.log
- HcsPreClusterSetupStart.log
- hcssetupreturncode.log
- hcs_setup.log
- HWBB1T2-secarchive.dbenc
- IDModuleUpdate.json
- IdModuleUpdateCompleted
- TpmRestartTriggere

</details>

<details>
  <summary>IntelNvmeDiskLogs</summary>

- IntelNvmeNLogLog_BTLN846006RZ1P6AGN.bin
- IntelNvmeNLogLog_BTLN846006U51P6AGN.bin
- IntelNvmeNLogLog_BTLN846006UZ1P6AGN.bin
- IntelNvmeNLogLog_BTLN8460079F1P6AGN.bin
- IntelNvmeNLogLog_BTLN846007CP1P6AGN.bin
- IntelNvmeSmartLog_BTLN846006RZ1P6AGN.txt
- IntelNvmeSmartLog_BTLN846006U51P6AGN.txt
- IntelNvmeSmartLog_BTLN846006UZ1P6AGN.txt
- IntelNvmeSmartLog_BTLN8460079F1P6AGN.txt
- IntelNvmeSmartLog_BTLN846007CP1P6AGN.txt

</details>

<details>
  <summary>LocalUILogs</summary>

- W3SVC1
  - u_ex210311.log
- W3SVC2
  - u_ex210311.log
- W3SVC3
  - u_ex210311.log

</details>

<details>
  <summary>ObjStore</summary>

- AgentLogs
  - rdagent.exe-2021.03.12-01.20.10.129.log
- blob
  - WossErrorWarning_BlobService.exe_000000.log
  - WossVerbose_BlobService.exe_000000.bin
- blob- Csblobsvc.exe
  - WossErrorWarning_blobsvc.exe_000000.log
  - WossVerbose_blobsvc.exe_000000.bin
- CsProtocolDBE- Cshcsedgeagentreader.exe
  - WossErrorWarning_hcsedgeagentreader.exe_000000.log
  - WossVerbose_hcsedgeagentreader.exe_000000.bin
- DiskResourceProvider
  - WossVerbose_DiskResourceProvider.exe_000000.bin
- Etl
  - AzureStack.CPI_000015.etl
  - AzureStack.CRP_DRP_000015.etl
  - AzureStack.NCHostAgent_000015.etl
  - AzureStack.NRP_000015.etl
  - AzureStack.OvsDBClient_000015.etl
- FrontEnd.Blob
  - WossVerbose_FrontEnd.Blob.exe_000000.bin
- LocalTableServer
  - WossInfo_LocalTableServer.exe_000000.log
  - WossVerbose_LocalTableServer.exe_000000.bin
- Settings
  - WossVerbose_Settings.exe_000000.bin
- StorageResourceProvider
  - WossVerbose_StorageResourceProvider.exe_000000.bin
- WAC
  - WossVerbose_WAC.exe_000000.bin
- WireServerLogs
  - REST-2021.03.12-01.20.11.184.log
  - WireMarshal-2021.03.12-01.20.10.495.log
  - WireServer-2021.03.12-01.20.10.487.log

</details>

<details>
  <summary>PeriodicLogs</summary>

- 210311-1843.zip
- 210312-0043.zip
- 210312-0643.zip

</details>

<details>
  <summary>Registry</summary>

- HKLM-HARDWARE-DEVICEMAP-Scsi.txt
- HKLM-SYSTEM-CurrentControlSet-Control-SecureBoot-State.txt

</details>

<details>
  <summary>SddcLogs</summary>

- SDDCLogs_HWBB1T2-HWBB1T2CL-20210314-1139.ZIP
- SDDCOutputCommand_HWBB1T2.txt

</details>

<details>
  <summary>Statslogs</summary>

- HcsStatsCollector_03130645.blg
- hcs_dvfilter_active.log
- hcs_dvfilter_cover.log
- hcs_stats.log

</details>

<details>
  <summary>StorageDiagnosticInfoLogs</summary>

- Get-StorageDiagnosticsInfo.txt
- `<Hostname>`
  - OperationalLog.evtx
- `<Hostname>`- LocaleMetaData
  - OperationalLog_0.MTA

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
