---
title: Error 2912 adding a cluster to SCVMM 
description: Fixes an issue in which you can't add a cluster to System Center Virtual Machine Manager and receive error 2912 (unknown error (0x800007d0)).
ms.date: 04/09/2024
ms.reviewer: wenca, markstan
---
# Adding a cluster to SCVMM fails with error 2912 (unknown error (0x800007d0))

This article fixes an issue in which you can't add a cluster to System Center Virtual Machine Manager and receive error 2912 (unknown error (0x800007d0)).

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2686573

## Symptoms

Consider the following scenario:

1. You are using System Center Virtual Machine Manager (VMM) to manage a cluster resource.
2. One node of the cluster displays a status of **Needs Attention**.
3. Viewing the properties of the node displays a connection status of **Not Responding** on the **Status** tab.
4. Remove and attempting to re-add the cluster back again fails with the following error:

   > Error (2912)  
   > An internal error has occurred trying to contact an agent on the *node1.servername* server.  
   > (Unknown error (0x800007d0))  
   >
   > Recommended Action  
   > Ensure the agent is installed and running. Ensure the WS-Management service is installed and running, then restart the agent.

5. The other nodes can be added successfully, but when the cluster refreshes you receive the following message:

   > Warning (13926)  
   >
   > Host cluster <*name*> was not fully refreshed because not all of the nodes could be contacted. Highly available storage and virtual network information reported for this cluster might be inaccurate.  
   >
   > Recommended Action  
   >
   > Ensure that all the nodes are online and do not have Not Responding status in Virtual Machine Manager. Then refresh the host cluster again.

## Cause

This can occur if the performance counters on the node are corrupt.

## Resolution

To resolve this issue, complete the steps below:

1. Test using the following commands in an elevated command prompt (run a CMD prompt as administrator):

   ```console
   winrm e wmi/root/cimv2/Win32_PerfRawData_Tcpi
   ```

   Examine the result:

   > p_NetworkInterface  
   > WSManFault  
   > Message  
   > ProviderFault  
   > WSManFault  
   > Message = HRESULT = 0x800007D0  
   >
   > Error number: -2147023537 0x8007054F  
   > An internal error occurred.

   ```console
   wmic path Win32_PerfRawData_Tcpip_NetworkInterface get *
   ```

   Examine the result:

   > ERROR:  
   > Description =

2. Perform the steps documented in the following knowledge base article to rebuild the performance counters:

   [2554336](https://support.microsoft.com/help/2554336) How to manually rebuild Performance Counters for Windows Server 2008 64bit or Windows Server 2008 R2 systems

3. Remove the partially added cluster and re-add the same cluster once again.

At this point all nodes should be added successfully.
