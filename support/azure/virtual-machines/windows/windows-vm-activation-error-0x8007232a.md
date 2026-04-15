---
title: Error 0x8007232A DNS server failure when activating Windows
description: Learn how to resolve the 0x8007232A error that occurs when you try to activate an Azure Windows virtual machine (VM).
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0x8007232A "DNS server failure"

**Applies to:** :heavy_check_mark: Windows VMs

This article discusses how to resolve the 0x8007232A error that occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions//ff793433(v=technet.10)) (*slmgr.vbs*) script
- The [PsPing](/sysinternals/downloads/psping) tool

## Symptoms

When you try to activate an Azure Windows VM, you encounter the following error message in Windows Script Host:

> **Error: 0x8007232A** DNS server failure.

## Cause

This error occurs when the VM can't contact a DNS server to resolve the KMS host address. Unlike 0x8007232B (where the DNS name doesn't exist), this error indicates that the DNS query itself failed — the DNS server is unreachable or not responding.

On Azure VMs, this error typically occurs in the following scenarios:

- The VM's DNS configuration points to a custom DNS server that is down or unreachable.
- Network Security Group (NSG) rules are blocking outbound DNS traffic (UDP/TCP port 53).
- The VM is in a virtual network with no DNS resolution path to the KMS host.
- A network virtual appliance (NVA) or firewall is intercepting and dropping DNS traffic.
- The VM's NIC has an incorrect or empty DNS server configuration.

## Solution 1: Reconfigure the VM to use the Azure KMS endpoint directly

Bypass DNS discovery entirely by pointing to the Azure KMS endpoint by name:

1. Open an elevated Command Prompt window on the VM.

2. First, verify DNS resolution is working for basic names:

   ```cmd
   nslookup azkms.core.windows.net
   ```

3. If DNS resolution fails, check the VM's DNS configuration:

   ```cmd
   ipconfig /all
   ```

   Verify the DNS server addresses are correct and reachable.

4. Set the KMS server explicitly (bypasses SRV record lookups):

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

5. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## Solution 2: Fix DNS connectivity

If the VM needs DNS for other purposes (not just activation), troubleshoot the underlying DNS issue:

1. **Check NSG rules**: Ensure outbound traffic on UDP/TCP port 53 is allowed to the DNS server.

2. **Check DNS server health**: If using a custom DNS server, verify it's running and reachable:

   ```cmd
   psping <dns-server-ip>:53
   ```

3. **Reset DNS to Azure default**: If using custom DNS and it's not required, switch back to Azure-provided DNS in the Azure portal:
   - Go to **Virtual network** > **DNS servers** > select **Default (Azure-provided)**.

4. **Flush DNS cache** on the VM:

   ```cmd
   ipconfig /flushdns
   ```

5. Retry activation after DNS connectivity is restored.

## More information

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
- [Name resolution for resources in Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
