---
title: Error 0xC004F074 No Key Management Service (KMS) could be contacted
description: Learn how to resolve the 0xC004F074 error scenario that occurs when you try to activate an Azure Windows virtual machine (VM).
ms.date: 02/15/2024
ms.service: virtual-machines
ms.subservice: vm-windows-activation
ms.collection: windows
author: naqviadilmicrosoft
ms.author: v-naqviadil
editor: v-jsitser
ms.topic: troubleshooting-problem-resolution
ms.reviewer: cwhitley, v-leedennis
---
# Error 0xC004F074 "No Key Management Service (KMS) could be contacted"

This article discusses how to resolve the 0xC004F074 error that occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions//ff793433(v=technet.10)) (*slmgr.vbs*) script
- The [PsPing](/sysinternals/downloads/psping) tool

## Symptoms

When you try to activate an Azure Windows VM, you encounter the following error message in Windows Script Host:

> **Error: 0xC004F074** The Software Licensing Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.

## Cause

The VM can't connect to the KMS service for activation. If an Azure KMS is used for activation (the default selection), the activation request must originate from an Azure public IP address. The possible causes for this connectivity failure include:

- Forced tunneling, in which all traffic is routed outside Azure (typically to an on-premises environment) by using either Azure ExpressRoute or a network virtual appliance

- Traffic that's blocked by either a network virtual appliance or a standard internal load balancer

## Investigation

To determine the specific cause of the problem, follow the three-part procedure in the following sections.

### Part 1: Configure the appropriate KMS client setup key

> [!NOTE]
> This part isn't required for VMs that run Windows 10 Enterprise multi-session (also known as Windows 10 Enterprise for Virtual Desktops) in [Azure Virtual Desktop](/azure/virtual-desktop/overview)).
>
> To determine whether your VM is running the multi-session edition, run the following Software License Manager script command:
>
> ```cmd
> slmgr.vbs /dlv
> ```
>
> If the output contains the `Name: Windows(R), ServerRdsh edition` string, then the VM is running the multi-session edition, and you can skip the rest of this part.

> [!NOTE]
> If you deploy a Windows 10 Enterprise multi-session VM and then update the product key to another edition, you can't revert the VM to Windows 10 Enterprise multi-session. Instead, you have to redeploy the VM. For more information, see [Can I upgrade a Windows VM to Windows Enterprise multi-session?](/azure/virtual-desktop/windows-multisession-faq#can-i-upgrade-a-windows-vm-to-windows-enterprise-multi-session)

For the VM that's created from a custom image, you must configure the appropriate KMS client setup key for the VM. Follow these steps:

1. In an elevated Command Prompt window, run the following Software License Manager script command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /dlv
   ```

1. Check the `Description` value in the output to determine whether the VM was created from retail (`RETAIL` channel) or volume (`VOLUME_KMSCLIENT`) license media.

1. If the previous command output indicates the `RETAIL` channel, run the following Software License Manager script commands. The first command sets the [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for the version of Windows Server that's used, and the second command forces another activation attempt.

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

   For example, if you're using Windows Server 2016 Datacenter, the first command would appear as follows:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk CB7KF-BWN84-R7R2Y-793K2-8XDDG
   ```

### Part 2: Check whether the VM is behind a Standard SKU internal load balancer

Follow these steps to check whether the VM is behind a Standard SKU internal load balancer that blocks outbound internet traffic by default:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machines**.

1. In the list of virtual machines, select the name of your VM.

1. In the menu pane for your VM, locate the **Networking** heading, and then select **Load balancing**. If you see a message that states **No load balancing resources to display**, then the VM isn't behind any load balancer. In this case, you can proceed to [Part 3: Verify the connectivity between the VM and Azure KMS service](#part-3-verify-the-connectivity-between-the-vm-and-azure-kms-service).

1. If you see a load balancer resource, select the name of the load balancer to go to the load balancer's **Overview** page.

1. In the menu pane of the load balancer, select **Properties**.

1. On the **Properties** page, locate the values for **SKU** and **Load Balancing Type**, and then see the following table for conclusions.

   | Values of **SKU** and **Load Balancing Type** | Conclusion |
   |--|--|
   | The SKU value is **Standard**, and the **Load Balancing Type** value is **Private**. | The VM is behind a Standard SKU internal load balancer that blocks outbound internet traffic by default. To enable outbound connectivity, see [Solution 2: (For standard internal load balancer) Use an NAT gateway or a standard public load balancer](#solution-2-for-standard-internal-load-balancer-use-an-nat-gateway-or-a-standard-public-load-balancer). |
   | The SKU value isn't **Standard**, and the **Load Balancing Type** value is **Public**. | The VM isn't behind a Standard SKU internal load balancer, and outbound internet traffic isn't blocked by default. Continue to [Part 3: Verify the connectivity between the VM and Azure KMS service](#part-3-verify-the-connectivity-between-the-vm-and-azure-kms-service). |

### Part 3: Verify the connectivity between the VM and Azure KMS service

1. Make sure that the VM is configured to use the correct Azure KMS server. To do this, run the following Software License Manager script command:

   ```powershell
   Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /skms azkms.core.windows.net:1688"
   ```

   This command should return the following text:

   > Key Management Service machine name set to azkms.core.windows.net:1688 successfully.

1. Make sure that the firewall in the VM doesn't block outbound network traffic to the KMS endpoint on port 1688. To do this, apply one of the following options:

   - Check connectivity by running the [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) cmdlet in PowerShell:

     ```powershell
     Test-NetConnection azkms.core.windows.net -port 1688
     ```

     If the connection attempt is permitted, the cmdlet displays "TcpTestSucceeded: True" in the output text.

   - Check connectivity by running the PsPing tool:

     ```cmd
     .\psping.exe azkms.core.windows.net:1688
     ```

     In the command output, the second-to-last line should resemble the following text:

     `Sent = 4, Received = 4, Lost = 0 (0% loss)`

     If `Lost` is greater than 0 (zero), the VM doesn't have connectivity to the KMS server. In this situation, if the VM is in a virtual network and has a custom DNS server specified, you must make sure that the DNS server can resolve the `azkms.core.windows.net` domain name. If it can't, change the DNS server to one that can resolve `azkms.core.windows.net`.

     > [!NOTE]
     > If you remove all DNS servers from a virtual network, VMs use Azure's internal DNS service. This service can resolve `kms.core.windows.net`.

1. Use an [Azure Network Watcher next hop](/azure/network-watcher/network-watcher-next-hop-overview) test to verify that the next hop type is **Internet** from the affected VM to particular destinations. To apply the next hop test, follow these steps:

   1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machines**.
   1. In the list of virtual machines, select the name of your VM.
   1. In the menu pane of your VM, locate the **Help** heading, and then select **Connection troubleshoot**.
   1. On the **Connection troubleshoot** page of your VM, specify the following field values.

      | Field | Value |
      |--|--|
      | **Destination type** | **Specify manually** |
      | **URI, FQDN, or IP address** | *20.118.99.224*, *40.83.235.53* (for `azkms.core.windows.net`), or the IP of the appropriate KMS endpoint that applies to your region |
      | **Destination port** | *1688* |
      | **Source port** | *1688* |
      | **Diagnostic tests** | **Next hop** |

   1. Select the **Run diagnostic tests** button.
   1. After the diagnostic tests finish, review the **Results** box that appears below the button. The **Next hop (from source)** test should have a **Status** value of **Success**, and the **Details** value should include **Next hop type: Internet** in the text. If the next hop type is **Internet**, repeat the next hop test for each of the remaining IPs. However, if the next hop type is shown as **VirtualAppliance**, **VirtualNetworkGateway**, or anything other than **Internet**, one of the following scenarios is probably occurring:

      - A default route exists that routes the traffic outside Azure before the traffic is sent to the Azure KMS endpoint.

      - Traffic is blocked somewhere along the path.

      For these scenarios, see [Solution 1: (For forced tunneling) Use the Azure custom route to route activation traffic to the Azure KMS server](#solution-1-for-forced-tunneling-use-the-azure-custom-route-to-route-activation-traffic-to-the-azure-kms-server).

1. After you verify that a connection to `azkms.core.windows.net` is successful, run the following command at that elevated Windows PowerShell prompt. This command tries to activate the Windows VM several times:

   ```powershell
   1..12 | ForEach-Object {
       Invoke-Expression "$env:windir\system32\cscript.exe $env:windir\system32\slmgr.vbs /ato";
       Start-Sleep 5
   }
   ```

   If the activation attempt is successful, the command displays a message that resembles the following text:

   > Activating Windows(R), Server Datacenter edition (\<kms-client-product-key>) ... Product activated successfully.

## Solution 1: (For forced tunneling) Use the Azure custom route to route activation traffic to the Azure KMS server

If the cause is a forced tunneling scenario in which traffic is routed outside Azure, work with your network administrator to determine the correct course of action. One possible solution is described in the *Solution* section of [Windows activation fails in forced tunneling scenario](./custom-routes-enable-kms-activation.md). Apply this solution if it's consistent with your organization's policies.

## Solution 2: (For standard internal load balancer) Use an NAT gateway or a standard public load balancer

If a standard internal load balancer blocks traffic, there are two different approaches to fix the problem, as described in [Use Source Network Address Translation (SNAT) for outbound connections](/azure/load-balancer/load-balancer-outbound-connections):

- [Associate a network address translation (NAT) gateway to the subnet](/azure/load-balancer/load-balancer-outbound-connections#2-associate-a-nat-gateway-to-the-subnet).

- [Change to a standard public load balancer and define outbound rules](/azure/load-balancer/load-balancer-outbound-connections#outboundrules).

We recommend that you use an Azure Virtual Network NAT configuration for outbound connectivity in production deployments. For more information about Azure NAT Gateway, see [What is Azure NAT Gateway?](/azure/nat-gateway/nat-overview)

However, if there's a requirement to block all internet traffic, make sure that you deny outbound internet access by using a network security group (NSG) rule on the subnet of the VM that you have to activate. Notice that operating system activation traffic to the KMS IPs on port 1688 remains enabled because of platform internal rules.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
