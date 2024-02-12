---
title: Can't create Virtual switch in Hyper-V
description: Address an issue in which you receive an error when you create Hyper-V virtual switch in Windows Server 2019 (Build 17763).
ms.date: 11/15/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-switch-manager-vmswitch, csstroubleshoot
---
# You receive "Error applying virtual switch properties changes" error on a Windows Server 2019 (Build 17763)-based Hyper-V server

This article solves an error "Error applying virtual switch properties changes" that occurs when you create Hyper-V virtual switch in Windows Server 2019 (Build 17763).

_Applies to:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4492254

## Symptoms

When you try to create Hyper-V virtual switch in Windows Server 2019 (Build 17763), you receive the following error message:

:::image type="content" source="media/error-applying-virtual-switch-properties-changes/fail-add-virtual-ethernet-switch-error.png" alt-text="Screenshot of the error message which shows Error applying Virtual Switch Properties changes.":::  

> The Virtual Machine Management Service failed to setup the listen socket for Virtual Machine migration connections for address \<IP address>: %%2147952449 (0x80072741).  
 **OS Name Microsoft Windows Server 2019 Standard**  
 **Version 10.0.17763 Build 17763**  

Additionally, the following event logs are received.

 > [7]0E08.0F10::02/21/19-20:42:08.9726563 [Microsoft-Windows-Hyper-V-VMMS-Admin] The Virtual Machine Management Service failed to setup the listen socket for Virtual Machine migration connections for address\<IP address>: %%2147952449 (0x80072741).  
 >
 > [6]0E08.1C10::02/21/19-20:42:20.1233454 [Microsoft-Windows-Hyper-V-VMMS-Networking] Failed to connect Ethernet switch port (switch name = '\<SwitchName>', port name = '\<PortName>', adapter GUID = '{\<AdapterGUID>}'): %%2147942402 (0x80070002).  
 >
 > [3]0E08.0F10::02/21/19-20:42:20.3394763 [Microsoft-Windows-Hyper-V-VMMS-Admin] The Virtual Machine Management Service failed to setup the listen socket for Virtual Machine migration connections for address \<IP address>: %%2147952449 (0x80072741).  
 >
 > [1]0E08.1C10::02/21/19-20:42:20.5624912 [Microsoft-Windows-Hyper-V-VMMS-Analytic] Failed to complete resource post-processing (optype = AddVirtualSwitchResourcesOperation, error = 0x80070002) Failed to complete resource post-processing (optype = AddVirtualSwitchResourcesOperation, error = 0x80070002), - , 2949152, 0x800000020  
 >
 > [1]0E08.1C10::02/21/19-20:42:20.5624912 [Microsoft-Windows-Hyper-V-VMMS-Analytic] Failed to complete resource post-processing (optype = AddVirtualSwitchResourcesOperation, error = 0x80070002) Failed to complete resource post-processing (optype = AddVirtualSwitchResourcesOperation, error = 0x80070002), - , 2949152, 0x800000020  
 >
 > [1]0E08.1C10::02/21/19-20:42:20.5625542 [Microsoft-Windows-Hyper-V-VMMS-Networking] Failed while adding virtual Ethernet switch connections.  
 >
 > [13]0E08.0F10::02/21/19-20:42:20.5712564 [Microsoft-Windows-Hyper-V-VMMS-Admin] The Virtual Machine Management Service failed to setup the listen socket for Virtual Machine migration connections for address \<IP address> : %%2147952449 (0x80072741).  

## Cause

The network interface card driver Hewlett Packard Enterprise (HPE) Ethernet 1 Gb 4-port 369i Adapter (Intel 369i or Intel 350i) can cause the issue. Visual switch creation splits into two parts: the creation part and the binding part. When the issue occurs, the creation part succeeded but the binding part failed.

## Resolution

To fix this issue, update the driver from Intel website directly instead of from HPE.
