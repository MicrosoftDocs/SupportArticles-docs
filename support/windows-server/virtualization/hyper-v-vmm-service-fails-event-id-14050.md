---
title: Hyper-V VMM service fails with event ID 14050
description: Discusses that Hyper-V VMM service fails and Event ID 14050 is logged when the dynamicportrange setting is changed in Windows Server 2012. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits, robertvi
ms.custom: sap:Virtualization and Hyper-V\Installation and configuration of Hyper-V, csstroubleshoot
---
# Hyper-V VMM service fails and Event ID 14050 is logged when dynamicportrange is changed

This article provides a solution to issues where Hyper-V VMM service fails and event ID 14050 is logged when the dynamicportrange setting is changed.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2761899

## Symptoms

Assume that you have a computer that is running Windows Server 2012 with Hyper-V installed. If you try to manage the Hyper-V hosts either by using System Center Virtual Machine Manager 2012 Service Pack 1 (SP1) or remotely by using Hyper-V Manager, the attempt fails. Additionally, an event may be logged in the event log that resembles the following:

> Log Name: Microsoft-Windows-Hyper-V-VMMS-Admin  
> Source: Microsoft-Windows-Hyper-V-VMMS  
> Date: \<Date> \<Time>  
> Event ID: 14050  
> Level: Error  
> Description: Failed to register service principal name.  
> Event Xml: ...  
> \<Parameter0>Hyper-V Replica Service\</Parameter0>  

## Cause

This problem may occur if the TCP dynamic port range is out of the default range. The Virtual Management Service (Vmms.exe) of Hyper-V uses Windows Service Hardening, and it limits itself to the dynamic port range.

To determine the TCP dynamic port range, run the following command at an elevated command prompt:

```console
C:\>netsh int ipv4 show dynamicportrange tcp Protocol tcp Dynamic Port Range --------------------------------- Start Port : 49152 Number of Ports : 16384
```

This problem may also occur if the NTDS port has been restricted to a specific port on your domain controllers. If this selected NTDS port is not within the default ranges, you must add this port by running the script in the "Resolution" section on every Hyper-V host.

For more information, click the following article number to go to the article in the Microsoft Knowledge Base:

[224196](https://support.microsoft.com/help/224196) Restricting Active Directory replication traffic and client RPC traffic to a specific port

## Resolution

To resolve this problem, run the following script one time on each affected Hyper-V host. This script adds a custom port range to enable Vmms.exe to communicate over an additional port range of 9000 to 9999. The script can be modified as necessary.  

To configure a script to add the custom port range, follow these steps:  

1. Start a text editor, such as Notepad.
2. Copy the following code, and then paste the code into the text file:

    ```vbscript

    'This VBScript adds a port range from 9000 to 9999 for outgoing traffic  
    'run as cscript addportrange.vbs on the hyper-v host

    option explicit

    'IP protocols
    const NET_FW_IP_PROTOCOL_TCP = 6
    const NET_FW_IP_PROTOCOL_UDP = 17

    'Action
    const NET_FW_ACTION_BLOCK = 0
    const NET_FW_ACTION_ALLOW = 1

    'Direction
    const NET_FW_RULE_DIR_IN = 1
    const NET_FW_RULE_DIR_OUT = 2

    'Create the FwPolicy2 object.
    Dim fwPolicy2
    Set fwPolicy2 = CreateObject("HNetCfg.FwPolicy2")'Get the Service Restriction object for the local firewall policy.
    Dim ServiceRestriction
    Set ServiceRestriction = fwPolicy2.ServiceRestriction

    'If the service requires sending/receiving certain type of traffic, then add "allow" WSH rules as follows
    'Get the collection of Windows Service Hardening networking rules

    Dim wshRules
    Set wshRules = ServiceRestriction.Rules

    'Add outbound WSH allow rules
    Dim NewOutboundRule
    Set NewOutboundRule = CreateObject("HNetCfg.FWRule")
    NewOutboundRule.Name = "Allow outbound traffic from service to TCP 9000 to 9999"
    NewOutboundRule.ApplicationName = "%systemDrive%\WINDOWS\system32\vmms.exe"
    NewOutboundRule.ServiceName = "vmms"
    NewOutboundRule.Protocol = NET_FW_IP_PROTOCOL_TCP
    NewOutboundRule.RemotePorts = "9000-9999"
    NewOutboundRule.Action = NET_FW_ACTION_ALLOW
    NewOutboundRule.Direction = NET_FW_RULE_DIR_OUT
    NewOutboundRule.Enabled = true
    wshRules.Add NewOutboundRule

    'end of script
    ```

3. Save the file as "Addportrange.vbs" (including the quotation marks). This correctly creates the file as having the .vbs extension. The file icon changes from a Notepad icon to a script icon.
4. Run the script as cscript.

## References

[970923](https://support.microsoft.com/help/970923) Unable to add a managed host in SCVMM 2008 and SCVMM 2012, Error 2927 (0x8033809d)

[929851](https://support.microsoft.com/help/929851) The default dynamic port range for TCP/IP has changed in Windows Vista and in Windows Server 2008
