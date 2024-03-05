---
title: Creating V-switches within the hyper-V environment fails
description: Provides workarounds for an issue where creating V-switches within the hyper-V environment fails.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-switch-manager-vmswitch, csstroubleshoot
---
# Creating V-switches within the hyper-V environment fails

This article provides workarounds for an issue where creating V-switches within the hyper-V environment fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2486812

## Symptoms

When trying to create a virtual switch from the Virtual Network Manager, you receive an error message while applying the new virtual network changes. The error message states: "Setup switch failed. Cannot bind to \<name of network adapter> because it is already bound to another virtual network."

When creating the virtual switch via a script, you may receive an error similar to one of the following:
> Creating Net2New-VirtualNetwork : VMM cannot complete the Hyper-V operation on server ... (Error ID: 12700, Detailed Error: Unknown error (0x8005))

Or:
> Remove-VirtualNetwork : A Hardware Management error has occurred trying to contact server `k9-campos7000-5.ad.iss-eps.net`.(Error ID: 2927, Detailed Error: Unknown error (0x80338029))

There are many possible error codes depending on the script, but in general the errors may not directly point back to a switch.

## Cause

The network adapter has the protocol used by the Hyper-V virtual switch still bound to it. This is called the vms_pp binding. (Microsoft Virtual Network Switch Protocol)

> [!Note]
> This issue is not currently known to be specific to a particular network adapter or hardware platform.

## Workaround

Two tools are provided by Microsoft to work around this problem.

NVSPbind is a tool for modifying network binding from the command line. It is especially useful in Server Core environments with the Hyper-V role enabled. This tool is the least invasive and preferred method to work around the issue. This tool can be [downloaded from here](/samples/browse/).

Instructions for using NVSPbind to resolve the issue:

1. **Command Prompt** > `nvspbind`

    This will produce a list of all the network adapters, as well as the bindings for each one. Find the adapter the error occurred on, and see if the vms_pp binding is enabled. In the sample output below, the friendly name of the adapter with the error is "Friendly NIC Name."
    > {6B360F51-C6C4-4EA0-AFEF-E4D1056B498E}  
    "pci\\ven_14e4&dev_1600&subsys_3015103c"  
    "Friendly NIC Name"  
    "Local Area Connection":  
    disabled: ms_netbios (NetBIOS Interface)  
    disabled: ms_server (File and Printer Sharing for Microsoft Networks)  
    disabled: ms_pacer (QoS Packet Scheduler)  
    disabled: ms_ndiscap (NDIS Capture LightWeight Filter)  
    disabled: ms_wfplwf (WFP Lightweight Filter)  
    disabled: ms_msclient (Client for Microsoft Networks)  
    disabled: ms_tcpip6 (Internet Protocol Version 6 (TCP/IPv6))  
    disabled: ms_netbt (WINS Client(TCP/IP) Protocol)  
    disabled: ms_smb (Microsoft NetbiosSmb)  
    disabled: ms_tcpip (Internet Protocol Version 4 (TCP/IPv4))  
    disabled: ms_lltdio (Link-Layer Topology Discovery Mapper I/O Driver)  
    disabled: ms_rspndr (Link-Layer Topology Discovery Responder)  
    disabled: ms_pppoe (Point to Point Protocol Over Ethernet)  
    disabled: ms_ndisuio (NDIS Usermode I/O Protocol)  
    enabled: vms_pp (Microsoft Virtual Network Switch Protocol)

2. To disable the vms_pp binding:

    **Command Prompt** > `nvspbind /u "Friendly NIC Name"`

Using NVSPscrub.js to resolve the issue:

NVSPscrub.js (also [available from here](/samples/browse/)) is a tool for removing all Hyper-V Virtual Networking Configurations from the parent partition. This tool is more invasive, and will completely remove the configuration, as opposed to just the binding. It should be used only if NVSPbind is unsuccessful at resolving the issue.
