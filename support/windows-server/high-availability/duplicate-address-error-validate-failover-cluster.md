---
title: Validation fails when you run a cluster validation wizard for a Windows Server 2008 cluster
description: Describes a problem in which a duplicate address error occurs when you validate a Windows Server 2008 failover cluster. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-when-running-the-validation-wizard, csstroubleshoot
---
# The validation fails when you run a cluster validation wizard for a Windows Server 2008 cluster

This article provides a resolution for a problem in which a duplicate address error occurs when you validate a Windows Server 2008 failover cluster.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 969256

## Symptoms

When you run a cluster validation wizard for a Windows Server 2008 cluster, the validation fails. Additionally, you may receive an error that resembles the following error message:

> Verifying that there are no duplicate IP addresses between any pair of nodes.
>
> Found duplicate physical address 02-10-18-39-6D-38 on node `servername.domainname.com` adapter Local Area Connection 19 and node `server2name.domainname.com` adapter Local Area Connection 19.
>
> Found duplicate IP address fe80::100:7f:fffe%14 on node `servername.domainname.com` adapter Local Area Connection 11 and node `server2name.domainname.com` adapter Local Area Connection 11."

## Cause

This problem occurs when only one of the following conditions is true:

- The Teredo transition technology is enabled on a Windows Server 2008 cluster node. Teredo allows IPv6 communications to pass through IPv4 NATs and IPv4 servers. However, Teredo gives the same IPv6 address to its network interfaces. Failover clustering flags this as an error because it requires unique IP addresses.
- The referenced servers are built from the same image and automatically create the Cluster NetFT adapter on each node with an identical MAC address. Failover clustering flags this as an error because it requires unique physical addresses.

## Resolution

There are two possible solutions, depending on the combination of error messages that you receive.

### Issue 1

If the error message doesn't include a reference to a "duplicate physical address," Teredo is most likely the cause of the problem. To resolve this problem, disable Teredo by using one of the following two methods.

> [!NOTE]
> The failover cluster validation tests have been changed in Windows Server 2008 SP2 and later and Windows Server 2008 R2 so that the Teredo addresses will not cause the test to issue a failure or a warning.

#### Method 1: Turn off Teredo by using a Netsh command

1. Click **Start**, click **All Programs**, click **Accessories**, right-click
 **Command Prompt**, and then click **Run as administrator**.

    > [!NOTE]
    > If the **User Account Control** dialog box appears, confirm that the action that the dialog box displays is what you want, and then click **Continue**.
2. At the command prompt, type the following lines (press ENTER after each line):  

    ```console
    netsh
    interface
    teredo
    set state disabled
    ```

3. Close the command prompt.

#### Method 2: Turn off Teredo by specifying a registry setting in Windows Server 2008

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. For best results, close all programs on the computer on which you're changing the registry setting.
2. Click **Start**, click **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.

    > [!NOTE]
    > If the **User Account Control** dialog box appears, confirm that the action that the dialog box displays is what you want, and then click **Continue**.
3. Type `regedit` at the command line.
4. Locate to the following registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6`  

5. Right-click **Parameters**, click **New**, click **DWORD**, and then type the name DisabledComponents for the new value. Make sure that you type the name exactly as shown, including capitalization. Then, click **Enter**.
6. Double-click **DisabledComponents**.
7. In the **Edit DWORD Value** dialog box, click **Hexadecimal** under the **Base** field, and then type 8 in the **Value data** field.
8. Click **OK**.
9. Restart the computer.
    > [!NOTE]
    > You can also disable Teredo by using Device Manager. However, this only disables the Teredo adapter so that the system does not show the adapter anymore. This does not disable the underlying logic for Teredo. This could cause issues later. Therefore, we recommend that you disable Teredo through the command line or through the registry entry.

### Issue 2

If the error message includes a reference to a "duplicate physical address," the problem most likely occurs because the referenced servers are based from the same image. To resolve this issue, remove and then reinstall the Failover Cluster feature. To do this, follow these steps:

1. Remove the Failover Cluster feature. To do this, follow these steps:

    1. Open Server Manager.
    2. In the navigation pane, click **Features**, and then click **Remove Features**.
    3. Click to clear the **Failover Clustering** check box.
    4. Review the warning dialog box to make sure that you're prepared to continue. Click **Yes**, and then click **Next**.
    5. Verify that the options that you want are being removed, click **Remove**, and then click **Close**.
2. Reinstall the Failover Cluster feature. To do this, follow these steps:

    1. Open Server Manager.
    2. In the navigation pane, click **Features**, and then click **Add Features**.
    3. Click to select the **Failover Clustering** check box, and then click **Next**.
    4. Verify that the options that you want are being added, click **Install**, and then **Close**.

> [!NOTE]
> The Sysprep command is not supported when an image is captured after you add the Failover Clustering feature. If you install the Failover Clustering feature, and then you run the sysprep command on the image, the virtual adapter for all the nodes will have the same MAC address. The virtual network adapter (NetFT) takes a MAC address based from one of the addresses of the physical network interface cards (NICs) when the Failover Clustering feature is installed.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section of this article.  

For more information about the Teredo transition technology, visit the following Web sites:

[Internet Protocol Version 6, Teredo, and Related Technologies in Windows Vista](https://technet.microsoft.com/library/cc722030.aspx)  

For more information about how to run the cluster validation wizard for a failover cluster in Windows Server 2008, visit the following Web site:

 [Failover Cluster Step-by-Step Guide: Validating Hardware for a Failover Cluster](https://technet.microsoft.com/library/cc732035.aspx#bkmk_how_to_run)
