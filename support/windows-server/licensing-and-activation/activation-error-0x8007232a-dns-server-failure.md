---
title: Error 0x8007232A "DNS server failure" when you activate Windows
description: Discusses how to resolve error 0x8007232A ("DNS server failure"). This error occurs if Windows can't contact a DNS server to resolve the Key Management Services (KMS) host address during activation.
ms.date: 05/13/2026
ms.collection: windows
ai.usage: ai-assisted
ms.reviewer: cwhitley, scotro, v-leedennis, kaushika, v-appelgatet
ms.custom: 
  - sap:Windows Activation\Windows activation issues
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Error 0x8007232A "DNS server failure" when you activate Windows

## Summary

This article helps you resolve error 0x8007232A ("DNS server failure"). This error occurs if Windows can't contact a DNS server to resolve the Key Management Services (KMS) host address during activation. The article provides resolution steps for both physical computers and Azure Virtual Machines (VMs), including options to activate or troubleshoot that are specific to VMs.

## Symptoms

When you try to activate a Windows system, you see the following error message in Windows Script Host:

```output
**Error: 0x8007232A** DNS server failure.
```

## Cause

This error occurs if Windows can't contact a DNS server to resolve the Key Management Services (KMS) host address. Unlike error code 0x8007232B (the DNS name doesn't exist), this error code indicates that the DNS query itself failed because the DNS server is unreachable or not responding.

On Azure VMs, this error typically occurs in the following scenarios:

- The VM's DNS configuration points to a custom DNS server that's down or unreachable.
- Network Security Group (NSG) rules block outbound DNS traffic (User Datagram Protocol (UDP)/Transmission Control Protocol (TCP) port 53).
- The VM is in a virtual network without a DNS resolution path to the KMS host.
- A network virtual appliance (NVA) or firewall intercepts and drops DNS traffic.
- The VM's network adapter has an incorrect or empty DNS server configuration.

## Resolution

If the affected computer is a physical Windows Server-based or Windows Client-based computer, see detailed troubleshooting instructions at [Guidelines for troubleshooting DNS-related activation issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns). For more general help to troubleshoot DNS issues, see [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md).

If the affected computer is an Azure VM, install the [PsPing](/sysinternals/downloads/psping) tool on the VM.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

For a VM, the following troubleshooting options are available before you have to resort to complex DNS troubleshooting:

- If you want to activate the VM without addressing the DNS issue, see [Azure method 1: Activate the VM without using DNS](#azure-method-1-activate-the-vm-without-using-dns).
- If you want to troubleshoot the VM's connection to the Azure DNS infrastructure, see [Azure method 2: Troubleshoot the connection to Azure DNS](#azure-method-2-troubleshoot-the-connection-to-azure-dns).
- If your VM connects to custom DNS servers, but it could use Azure DNS instead, see [Azure method 3: Reconfigure the VM to use Azure DNS](#azure-method-3-reconfigure-the-vm-to-use-azure-dns).
- If your VM connects to custom DNS servers, and you have to maintain that configuration, see [Azure method 4: Troubleshoot a VM that uses custom DNS](#azure-method-4-troubleshoot-a-vm-that-uses-custom-dns).

### Azure method 1: Activate the VM without using DNS

If you want to only activate the VM and not troubleshoot the DNS issue, follow these steps:

Open an administrative Command Prompt window on the affected VM, and then run the following commands:

```cmd
cscript c:\windows\system32\slmgr.vbs /skms 20.118.99.224:1688
cscript c:\windows\system32\slmgr.vbs /ato
```

> [!NOTE]  
> If the `20.118.99.224` address doesn't work, try `40.83.235.53`. These IP addresses are the ones that are available for the Azure KMS service.

### Azure method 2: Troubleshoot the connection to Azure DNS

This method checks whether your VM connects correctly to the Azure DNS infrastructure.

1. On the affected VM, open an administrative Command Prompt window.

1. To check the VM's DNS configuration, run the following command:

   ```cmd
   ipconfig /all
   ```

   The output of this command should resemble the following example:

   ```output
   DNS Servers . . . . . . . . . . . : 168.63.129.16
   ```

   > [!NOTE]  
   > In this example, `168.63.129.16` is the IP address that VMs use when they connect to the Azure DNS infrastructure. For more information, see [Azure IP address 168.63.129.16 overview](/azure/virtual-network/what-is-ip-address-168-63-129-16).

1. If `168.63.129.16` isn't the first DNS server in the list, or if the list is empty, check the DNS configuration of the virtual network. In the [Azure portal](https://portal.azure.com), go to **Virtual network** > **DNS servers**. The selected option should be **Default (Azure-provided)**.

   > [!NOTE]  
   > It's possible to configure a custom DNS server for a particular network interface. If the virtual network already uses the default DNS configuration, check the VM's network interface.

1. If the DNS server isn't already set to **Default (Azure-provided)**, select **Change**, and then select **Default (Azure-provided)**.

1. Restart the VM.

1. On the VM, open an administrative Command Prompt window, and then run the following command:

   ```cmd
   ipconfig /flushdns
   ```

   This command flushes and rebuilds the DNS cache.

1. To try again to activate Windows, run the following command at the command prompt:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. If the VM still can't connect to Azure DNS, see [Troubleshoot Azure IP connectivity](/azure/virtual-network/what-is-ip-address-168-63-129-16#troubleshoot-azure-ip-connectivity).

### Azure method 3: Reconfigure the VM to use Azure DNS

1. In the [Azure portal](https://portal.azure.com), go to **Virtual network** > **DNS servers**.

1. Select **Change** > **Default (Azure-provided)**.

1. Restart the VM.

1. On the VM, open an administrative Command Prompt window, and then run the following command:

   ```cmd
   ipconfig /flushdns
   ```

   This command flushes the DNS cache.

1. To try again to activate Windows, run the following command at the command prompt:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. If the VM still can't connect to Azure DNS, see [Troubleshoot Azure IP connectivity](/azure/virtual-network/what-is-ip-address-168-63-129-16#troubleshoot-azure-ip-connectivity).

### Azure method 4: Troubleshoot a VM that uses custom DNS

If your VM uses a custom or hybrid DNS structure, the issue becomes more complicated to resolve. The following steps help you troubleshoot common DNS issues that Azure VMs might experience. They also refer you to more advanced troubleshooting for DNS issues that might affect activation.

#### Step 1: Make sure that the VM uses the correct IP addresses for the DNS servers

1. To check the VM's DNS configuration, run the following command:

   ```cmd
   ipconfig /all
   ```

   The output of this command should resemble the following example:

   ```output
   DNS Servers . . . . . . . . . . . : 10.0.3.5
                                       10.0.3.4
                                       168.63.129.16
   ```

   > [!NOTE]  
   > In this example, `168.63.129.16` is the IP address that VMs use when they connect to the Azure DNS infrastructure. The other IP addresses represent custom DNS servers. For more information about custom DNS configurations, see the following articles:
   >
   > - [Azure IP address 168.63.129.16 overview](/azure/virtual-network/what-is-ip-address-168-63-129-16)
   > - [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)

1. Verify that each of the DNS server addresses is correct. If you have to change any of the addresses, go to the VM's virtual network or network interface page in the Azure portal.

   > [!IMPORTANT]  
   > When you use custom DNS servers for VMs, don't configure the DNS server settings on the VM itself. Specify DNS servers at the level of the network interface or the virtual network.

#### Step 2: Make sure that DNS traffic can pass between the VM and the DNS servers

1. To verify that DNS traffic can pass from the VM to the DNS server, run the following command at the command prompt on the VM:

   ```cmd
   psping <dns-server-ip>:53
   ```

1. If `psping` fails, follow these steps:

   1. Check any network security groups (NSGs) that might affect the VM (such as NSGs that are set at the network interface, subnet, or virtual network level). Make sure that any NSG allows traffic between the VM and the DNS server on UDP/TCP port 53.

   1. Make sure that any firewall (including Windows Firewall on the VM) allows traffic between the VM and the DNS server on UDP/TCP port 53.

   1. To verify that traffic is unblocked, run `psping` again.

   1. To flush and rebuild the DNS cache, run the following command:

   ```cmd
   ipconfig /flushdns
   ```

1. To try again to activate Windows, run the following command at the command prompt:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

#### Step 3: Troubleshoot the general DNS server issue

If the DNS server failure persists, see the following articles for more information about how to troubleshoot DNS:

- [Guidelines for troubleshooting DNS-related activation issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns)
- [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)

## References

- [Troubleshoot Azure Windows virtual machine activation problems](../../azure/virtual-machines/windows/troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
- [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
- [Azure IP address 168.63.129.16 overview](/azure/virtual-network/what-is-ip-address-168-63-129-16)
