---
title: Event ID 106
description: Describes an issue in Windows Server 2012 or Windows Server 2012 in which Event ID 106 is logged.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ajayps, tode, gsilva
ms.custom: sap:hyper-v-network-virtualization-hnv, csstroubleshoot
---
# Event ID 106 when a Hyper-V virtual switch is bound to an LBFO team

This article helps to resolve the event ID 106 when a Hyper-V virtual switch is bound to an LBFO team.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2974384

## Symptoms

Consider the following scenario:  

- You have a Windows Server 2012-based or Windows Server 2012 R2-based computer that is configured together with one or more load balancing and failover (LBFO) teams.
- A Hyper-V virtual switch is bound to one of the LBFO teams.  

In this scenario, one of the following events is logged intermittently.

## Cause

If Error 106 says, "Reason: The processor sets overlap when LBFO is configured with sum-queue mode," you have to use the Set-NetAdapterVmq Windows PowerShell command to configure each network adapter in your team to use different processors. (Because LBFO teaming is set up for Sum of Queues, the network adapters in the team have to use nonoverlapping processor sets.)

If Error 106 says, "Reason: The processor sets are not identical when LBFO is configured with min-queue mode," you have to use the Set-NetAdapterVmq  Windows PowerShell command to configure each network adapter in your team to use the same processors. (Because LBFO teaming is set up for Min Queue mode, the network adapters in the team have to use overlapping processor sets.)  

## Resolution

If Error 106 says, "Reason: The processor sets overlap when LBFO is configured with sum-queue mode," you can use the following example Windows PowerShell commands to separate the processors so that each network adapter uses different processors for virtual machine queue (VMQ). Also, you need to install the hotfix in [KB article 3031598](https://support.microsoft.com/help/3031598)  to resolve other known issues after making these configuration changes.  

These ones are example commands. You can vary the BaseProcessorNumber and MaxProcessors  settings based on how many processors the server has and which processors you don't want to use for VMQ.  
  
`Set-NetAdapterVmq -Name NIC1 -BaseProcessorNumber 2 -MaxProcessors 2`  
>[!NOTE]
>This network adapter would use processor 2 and 3 for VMQ.

`Set-NetAdapterVmq -Name NIC2 -BaseProcessorNumber 4 -MaxProcessors 2`  
>[!NOTE]
>This network adapter would use processor 4 and 5 for VMQ.

If the server has processor Hyper Threading enabled, you must modify how you set the BaseProcessorNumber and MaxProcessors settings to fix the Error 106 in sum-queue mode.

If you are unsure whether Hyper Threading is enabled on the server, one easy way to determine it is to run the Get-NetAdapterRSS  Windows PowerShell cmdlet and then look at the output line for RssProcessorArray. If it says 0:0/0 0:1/0 0:2/0....., then Hyper Threading is OFF. If it says 0:0/0 0:2/0 0:4/0..., then Hyper Threading is ON. RSS and VMQ only use core processors when Hyper Threading is ON, so that means the even-numbered processors.  

So, if you are setting the previously mentioned commands on a Hyper-Threaded server, you can only set the BaseProcessorNumber to an even number. Also, MaxProcessors must be set to the number of processors to use, that VMQ can use.  

For example, if you have (two) six core processors and Hyper Threading enabled, you will see 24 processors in Windows tools that show you processors, such as Task Manager. VMQ can only use 12 of those ones, since it only uses the even-numbered processors. To split these processors across two NICs and fix the Error 106, you would use the following commands to set each NIC to use different processors for VMQ:  
Set-NetAdapterVMQ -Name NIC1 -BaseProcessorNumber 0 -MaxProcessors 6 (so this NIC would use processor 0,2,4,6,8,10 for VMQ)  
Set-NetAdapterVMQ -Name NIC2 -BaseProcessorNumber 12 -MaxProcessors 6 (so this NIC would use processor 12,14,16,18,20,22 for VMQ)  

If Error 106 says, "Reason: The processor sets are not identical when LBFO is configured with min-queue mode," you can use the following example Windows PowerShell commands so that each network adapter uses the same processors for VMQ.

These ones are example commands. You can vary the BaseProcessorNumber and MaxProcessors  settings based on how many processors the server has and which processors you don't want to use for VMQ.  

`Set-NetAdapterVmq -Name NIC1 -BaseProcessorNumber 2 -MaxProcessors 4`  

>[!NOTE]
>This network adapter would use processor 2, 3, 4, and 5 for VMQ  

`Set-NetAdapterVmq -Name NIC2 -BaseProcessorNumber 2 -MaxProcessors 4`  
>[!NOTE]
>This network adapter would also use processor 2, 3, 4, and 5 for VMQ

After setting the VMQ processors correctly so all network adapters use the same processors for VMQ, you may still get the Error 106 "Reason: The processor sets are not identical when LBFO is configured with min-queue mode" if you have also adjusted the "Preferred NUMA node" setting for any network adapters to use a specific NUMA node. The default setting for it is "System Default" and is the preferred setting when using VMQ. If you set a specific Preferred NUMA node, and the NUMA nodes are different on the network adapters, then the network adapters are not using the same processors for VMQ.

Example: In the above example, you set NIC1 and NIC2 to both use processors 2, 3, 4, and 5. If your server has eight NUMA nodes with four processors in each NUMA node, and you set NIC1 to Preferred NUMA node 0 and you set NIC2 to Preferred NUMA node 1, then you are actually setting NIC1 to use processors 2 and 3 and NIC2 to use processors 4 and 5 because processors 2, 3, 4, and 5 are split across two NUMA nodes representing processors 0, 1, 2, 3 and 4, 5, 6, 7.

## More information

[Blog that discusses VMQ and LBFO settings for different LBFO configurations](https://blogs.technet.com/b/networking/archive/2013/09/24/vmq-deep-dive-2-of-3.aspx)  
[Blog that discusses VMQ CPU assignment](https://blogs.technet.com/b/networking/archive/2016/01/05/virtual-machine-queue-vmq-cpu-assignment-tips-and-tricks.aspx)
