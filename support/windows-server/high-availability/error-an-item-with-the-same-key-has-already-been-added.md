---
title: Error "An item with the same key has already been added"
description: Helps to fix the error "An item with the same key has already been added"
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-when-running-the-validation-wizard, csstroubleshoot
---
# Error: "An item with the same key has already been added"

This article helps to fix the error "An item with the same key has already been added".

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2002405

## Symptoms

When you run the Validate a Configuration wizard for Windows Server 2008 Failover Cluster, you may receive the following error:  
 **"An error occurred while executing the test.  There was an error verifying the firewall configuration.  An item with the same key has already been added."**  

## Cause

This error is reported if any network adapters have the same Globally Unique Identifier (GUID) across any nodes in the cluster.  This can be determined by running the following WMI query on each node in the cluster and comparing the results -  

For example, from inside PowerShell, run: - Get-WMIObject Win32_NetworkAdapter | fl Name, Guid  

A sample output for an adapter would look like this -  

 **Name : Intel(R) PRO/1000 MT Desktop Adapter  
GUID: {7488FB48-851A-40B6-AB47-1EA7408C762F}** 
 
> [!Note]
> This scenario typically occurs if an operating system image is being used to deploy cluster nodes and that image was not correctly prepared for deployment by running sysprep.

## Resolution

To resolve this issue the network interface GUID's on each of the nodes must be unique. One node can be left unchanged. But the following process must be performed against the remaining nodes.  

1. Download and then install the latest version of the network adapter driver on the computer.
2. Click **Start**, click **Run**, type regedit, and then click **OK**.
3. Locate and then delete the following registry subkey: 
  **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Network\Config**  

4. If your server is a domain controller, go to step 5. If your server is not a domain controller, delete the following registry subkeys:  
 **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Adapters\ {GUID}**  
 **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\\{GUID}**  
5. Click **Start**, click **Run**, type sysdm.cpl, and then click **OK**.
6. In the **Systems Properties** dialog box, click the **Hardware** tab, and then click **Device Manager**.
7. In Device Manager, expand **Network adapters**, right-click the network adapter that you want, and then click **Uninstall**.
8. Restart the computer.  

To verify that the network interface GUID was updated, use one of the following methods.  
Method 1: Perform the following:  
**Get-WMIObject Win32_NetworkAdapter | fl Name, Guid**  
Method 2: Run Failover Cluster's Validate a Configuration wizard, and make sure that the error does not occur.
