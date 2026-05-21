---
title: Event 8198, error 0xC0020017 or 0x8007139F when activating Windows
description: Discusses how to troubleshoot and resolve error . The steps apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.
ms.date: 05/23/2026
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

# Event 8198, error 0xC0020017 or 0x8007139F "KMS contact failure" when activating Windows

This article explains how to resolve the 0xC0020017 or 0x8007139F error that occurs if a Windows virtual machine (VM) in Microsoft Azure can't contact the Key Management Service (KMS) for activation. You typically see this error in the Application Event Log as Event ID 8198 from the **Security-SPP** (Software Protection Platform) source instead of through the standard `slmgr.vbs` output.

The troubleshooting steps in this article walk you through the most common causes, including DNS configuration issues, incorrect KMS host settings, and network connectivity problems. The steps apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.

## Symptoms

When you try to activate a Windows system, the standard `slmgr.vbs /ato` command returns a generic failure code. However, the actual error is recorded in the application log, as Event ID 8198. The event content resembles following example:

```output
Source: Security-SPP
Event ID: 8198
Error code: <ErrorCode>
Description: License Activation failed. The Software Protection service reported that the computer couldn't be activated.
```

> [!NOTE]  
> In the event output, \<ErrorCode> represents one of several error codes. For the issue discussed in this article, the error code is either `0xC0020017` or `0x8007139F`.

To view this event, open a Windows PowerShell Command Prompt on the client, and then run the following cmdlet:

```powershell
Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 5 | Format-List TimeCreated, Message
```

## Cause

Error `0xC0020017` indicates that the Software Protection Platform (SPP) service on the KMS client can't contact the KMS host. This error is functionally similar to error [0xC004F074](../../azure/virtual-machines/windows/windows-vm-activation-error-0xc004f074.md), but comes from a different code path. The SPP event pipeline reports this error instead of the System-Level Cache (SLC) API.

This issue can occur under the conditions that include the following scenarios:

- **Firewall blocks KMS traffic**: Firewall rules or Network Security Group (NSG) rules block traffic to the KMS host or service.
- **Forced tunneling**: All outbound traffic is routed through a VPN or similar technology, bypassing the KMS endpoint. For example, if you implement DirectAccess, Always On VPN, or Azure ExpressRoute gateway, you might encounter this issue.
- **DNS resolution failure**: The KMS client can't connect to a DNS server, or the DNS server can't resolve the address of the KMS host (or Azure KMS service, for Azure VMs).
- **Wrong KMS target**: The client was configured to use a specific KMS host, but the KMS host name was incorrect or invalid.
- **SPP service issue**: the SPP service itself might be in a stuck state.

## Resolution

Use the following steps to troubleshoot and fix the issue. To get the best results from these procedures, install the [PsPing](/sysinternals/downloads/psping) tool on the affected computer. If you have a self-hosted KMS server, install the PSPing tool on that computer also.

You should also be familiar with the [`slmgr` script](/windows-server/get-started/activation-slmgr-vbs-options).

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

### Step 1: Activate by using a particular KMS host

To bypass the automatic discovery process, you can use the `slmgr` script to specify a KMS host:

1. Open an administrative Command Prompt window on the client.

1. To clear any existing KMS host setting, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ckms
   ```

1. To specify a KMS host for activation, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms <KMSHost_fqdn>:<KMSHost_Port>
   ```

   > [!NOTE]  
   >
   > - In this command, \<KMSHost_fqdn> represents the fully qualified domain name (FQDN) of the KMS host, and \<KMSHost_Port> represents the port that the KMS host uses.
   > - To activate an Azure VM by using the Azure KMS service, use `azkms.core.windows.net` for \<KMSHost_fqdn>, and use `1688` for \<KMSHost_Port.

1. To try again to activate, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. To check whether the issue recurs, run the following command at the PowerShell command prompt:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 1 | Format-List TimeCreated, Message
   ```

If the activation process still generates Event ID 8198 (error code `0xC0020017` or `0x8007139F`), continue to Step 2.

### Step 2: Check the VPN, Direct Access, forced tunneling, or similar configuration

If your virtual network routes all client traffic through a gateway (forced tunneling), you must exempt KMS traffic.

1. Review your tunneling configuration, and make sure that activation traffic can pass directly over port 1688 between clients and the KMS host.

   For example, for Azure VMs that use Azure KMS, add a user-defined route (UDR) that sends traffic for the Azure KMS IP addresses directly to the internet. For information about how to configure this exemption for Azure, see [Windows activation fails in forced tunneling scenario](../../azure/virtual-machines/windows/custom-routes-enable-kms-activation.md).

1. To try again to activate Windows, run the following command at the command prompt on the client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. To check whether the issue recurs, run the following command at the PowerShell command prompt:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 1 | Format-List TimeCreated, Message
   ```

If the activation process still generates Event ID 8198 (error code `0xC0020017` or `0x8007139F`), continue to Step 3.

### Step 3: Restart the SPP service

In some cases, the SPP service itself might be in a stuck state.

1. To restart the SPP service, run the following command at the PowerShell command prompt on the client:

   ```powershell
   Restart-Service sppsvc -Force
   ```

1. Wait 30 seconds.

1. To try again to activate Windows, run the following command at the command prompt on the client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. To check whether the issue recurs, run the following command at the PowerShell command prompt:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 1 | Format-List TimeCreated, Message
   ```

If the activation process still generates Event ID 8198 (error code `0xC0020017` or `0x8007139F`), continue to Step 4.

### Step 4: Make sure that activation traffic can pass between the client and the KMS host

1. Run the following command at the command prompt on the client:

   ```cmd
   psping <KMSHost-ip>:1688
   ```

   > [!NOTE]  

   > - In this command, \<KMSHost_ip> represents the IP address of the KMS host.
   > - If the client is an Azure VM, and you're using the Azure KMS service for activation, use `20.118.99.224` or `40.83.235.53` for \<KMSHost-ip>.

1. If you're using a self-hosted KMS host, open an administrative Command Prompt window on the KMS host, and then run the following command:

   ```cmd
   psping <KMSClient-ip>:1688
   ```

   > [!NOTE]  
   > In this command, \<KMSClient_ip> represents the IP address of the client.

1. If `psping` fails in either case, follow these steps:

   1. For an Azure VM, check any network security groups (NSGs) that might affect the VM (such as NSGs that are set at the network interface, subnet, or virtual network level). Make sure that any NSG allows traffic between the VM and the DNS server on UDP/TCP port 53.

   1. Make sure that any firewall (including Windows Firewall on the client) allows traffic between the client and the KMS server on UDP/TCP port 1688.

   1. To verify that traffic is unblocked, run `psping` again.

1. To try again to activate Windows, run the following command at the command prompt on the client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. To check whether the issue recurs, run the following command at the PowerShell command prompt:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 1 | Format-List TimeCreated, Message
   ```

If the activation process still generates Event ID 8198 (error code `0xC0020017` or `0x8007139F`), continue to Step 5.

### Step 5: Check the DNS configuration

1. To check the DNS configuration, run the following command at the command prompt on the client:

   ```cmd
   nslookup <KMSHost_fqdn> <intendedDNS_name>
   ```

   > [!NOTE]  
   >
   > - In this command, \<KMSHost_fqdn> represents the FQDN of the KMS host, and \<intendedDNS_name> represents the FQDN or IP address of the DNS server that the client should use to contact the host.
   > - If the client is an Azure VM that uses the Azure DNS service, use `168-63-129-16` for \<intendedDNS_name>.

1. If the client is an Azure VM, and you're using the Azure KMS service, and the `nslookup` command failed, see the following articles to troubleshoot your DNS configuration:
   - [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)
   - [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)

1. On the KMS host, open an administrative Command Prompt window, and then run the following command:

   ```cmd
   ipconfig /all
   ```

   The output of this command should resemble the following examples:

   ```output
   DNS Servers . . . . . . . . . . . : 168.63.129.16
   ```

   ```output
   DNS Servers . . . . . . . . . . . : 10.0.3.5
                                       10.0.3.4
   ```

   > [!NOTE]  
   > In this example, `168.63.129.16` is the IP address that Azure VMs use when they connect to the Azure DNS infrastructure. The other IP addresses represent custom DNS servers.

1. Verify that each of the DNS server addresses is correct.

   > [!IMPORTANT]  
   > When you use custom DNS servers for Azure VMs, don't configure the DNS server settings on the VM itself. Specify DNS servers at the level of the network interface or the virtual network.

1. If the list of DNS server addresses is empty or doesn't include the correct addresses, see the following articles for more information:

   - Azure VMs: [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
   - [Guidelines for troubleshooting DNS-related activation issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns)
   - [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)

1. If you change any DNS settings, restart the KMS host.

1. After the KMS host restarts, open an administrative Command Prompt window, and then run the following command:

   ```cmd
   ipconfig /flushdns
   ```

   This command flushes and rebuilds the DNS cache.

1. To try again to activate Windows, run the following command at the command prompt on the client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. To check whether the issue recurs, run the following command at the PowerShell command prompt:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 1 | Format-List TimeCreated, Message
   ```

If the activation process still generates Event ID 8198 (error code `0xC0020017` or `0x8007139F`), contact Microsoft Support.

## References

- [Windows activation fails in forced tunneling scenario](../../azure/virtual-machines/windows/custom-routes-enable-kms-activation.md)
- [Error 0xC004F074 - No KMS could be contacted](../../azure/virtual-machines/windows/windows-vm-activation-error-0xc004f074.md)
- [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)
- [Guidelines for troubleshooting DNS-related activation issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
- [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
- [Azure IP address 168.63.129.16 overview](/azure/virtual-network/what-is-ip-address-168-63-129-16)
