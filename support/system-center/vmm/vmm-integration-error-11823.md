---
title: Error 11823 integrating VMM with Operations Manager
description: Describes an error (11823) issue that occurs when you try to integrate VMM with System Center Operations Manager. A resolution is provided.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Error 11823 when Operations Manager integration is refreshed from the VMM 2012 console

This article fixes an issue in which you receive error 11823 when you try to integrate System Center Virtual Machine Manager with System Center Operations Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager, Microsoft System Center 2012 Operations Manager, Microsoft System Center 2012 Operations Manager Service Pack 1, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 3040764

## Symptoms

When you try to integrate System Center Virtual Machine Manager (VMM 2012 or VMM 2012 R2) with System Center Operations Manager (OpsMgr 2012 or OpsMgr 2012 R2), the operation fails and the following error is returned:

> Error (11823)
>
> One or more of the Virtual Machine Manager objects monitored by Operations Manager could not be discovered. This might be caused by a missing or outdated version of the System Center Virtual Machine Manager management pack in Operations Manager.

You receive this error if more than one Virtual Machine Manager server is integrated with the same Operations Manager management group.

## Cause

The issue is caused by the following unsupported configuration of the Virtual Machine Manager-SCOM integration setup:

- Virtual Machine Manager server 1 is running in Hyper-V and is managing Hyper-V hosts 1A, 1B, and 1C.
- Virtual Machine Manager server 2 is running as a virtual machine on Hyper-V host 1A and managing Hyper-V hosts 2A and 2B.
- Both the Virtual Machine Manager servers are integrated with the same SCOM management group.

In this scenario, OpsMgr integration on Virtual Machine Manager server 2 functions normally, however OpsMgr integration on Virtual Machine Manager server 1 fails with error 11823.

## Resolution

To resolve this issue, move the virtual machine that's running Virtual Machine Manager server 2 from Hyper-V Host 1A to Hyper-V Host 2A.

## More Information

In the Virtual Machine Manager debug log trace, you will see the following exception:

> [2]0288.1208::‎2014‎-‎11‎-‎08 09:04:55.977 [Microsoft-VirtualMachineManager-Debug]4,2,Discovery.cs,784,ArgumentException [ex#e12] caught by SubmitSnapshotDiscovery MOMDebug: Exception: The object with ID 5a17baf4-7755-8d63-b037-97f577da39a2 is not of a valid class for insertion. (catch Exception) [[(ArgumentException#34c55a1) System.ArgumentException: The object with ID 5a17baf4-7755-8d63-b037-97f577da39a2 is not of a valid class for insertion. at Microsoft.EnterpriseManagement.Common.CreatableEnterpriseManagementRelationshipObject.SetTarget(EnterpriseManagementObject enterpriseManagementObject) at Microsoft.VirtualManager.EnterpriseManagement.Monitoring.CustomMonitoringRelationshipObjectOM10.SetTarget(MonitoringObject monitoringObject) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.DiscoveredObjects.AddContainmentRelationship(ManagedObject selectedObject, MonitoringObject proExternalObject, Boolean isV1Object) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.DiscoveredObjects.AssociateVMMAndPROObjects(MonitoringClass PROTargetClass, MonitoringClassProperty nameProperty, MonitoringClassProperty vmmServerProperty, Dictionary`2 discoveredObjectIdNameMapping) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.DiscoveredObjects.LoadExternalPROV2Objects() at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.Discovery.SubmitExternalObjects(ManagementGroup managementGroup) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.Discovery.SubmitSnapshotDiscovery(TimeSpan intervalBetweenConnectorDiscoveries, Boolean canCauseFailover)]],{00000000-0000-0000-0000-000000000000}
>
> [2]0288.1208::‎2014‎-‎11‎-‎08 09:04:55.977 [Microsoft-VirtualMachineManager-Debug]12,1,ExceptionHelper.cs,150,MOM Discovery: Exception. Message: The object with ID 5a17baf4-7755-8d63-b037-97f577da39a2 is not of a valid class for insertion. Inner Exception: Stack: at Microsoft.EnterpriseManagement.Common.CreatableEnterpriseManagementRelationshipObject.SetTarget(EnterpriseManagementObject enterpriseManagementObject) at Microsoft.VirtualManager.EnterpriseManagement.Monitoring.CustomMonitoringRelationshipObjectOM10.SetTarget(MonitoringObject monitoringObject) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.DiscoveredObjects.AddContainmentRelationship(ManagedObject selectedObject, MonitoringObject proExternalObject, Boolean isV1Object) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.DiscoveredObjects.AssociateVMMAndPROObjects(MonitoringClass PROTargetClass, MonitoringClassProperty nameProperty, MonitoringClassProperty vmmServerProperty, Dictionary`2 discoveredObjectIdNameMapping) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.DiscoveredObjects.LoadExternalPROV2Objects() at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.Discovery.SubmitExternalObjects(ManagementGroup managementGroup) at Microsoft.VirtualManager.Engine.MOMDataAccessLayer.Discovery.SubmitSnapshotDiscovery(TimeSpan intervalBetweenConnectorDiscoveries, Boolean canCauseFailover),{00000000-0000-0000-0000-000000000000}

The object GUID in this exception is an instance of the `Microsoft.SystemCenter.VirtualMachineManager.ProDiagnostics.2012.Target` class in Operations Manager.
