---
title: Error 0x8007232A - DNS server failure when activating Windows
description: Resolve Error 0x8007232A DNS server failure when you activate an Azure Windows VM. Follow guided steps to restore activation and get your VM licensed.
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0x8007232A - "DNS server failure"

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article explains how to resolve the 0x8007232A error that occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions/ff793433(v=technet.10)) (*slmgr.vbs*) script
- The [PsPing](/sysinternals/downloads/psping) tool

## Symptoms

When you try to activate an Azure Windows VM, you see the following error message in Windows Script Host:

`**Error: 0x8007232A** DNS server failure.`

## Cause

This error occurs if the VM can't contact a DNS server to resolve the Key Management Services (KMS) host address. Unlike error code 0x8007232B that's generated if the DNS name doesn't exist, this error code indicates that the DNS query itself failed because the DNS server is unreachable or not responding.

On Azure VMs, this error typically occurs in the following scenarios:

- The VM's DNS configuration points to a custom DNS server that's down or unreachable.
- Network Security Group (NSG) rules block outbound DNS traffic (User Datagram Protocol (UDP)/Transmission Control Protocol (TCP) port 53).
- The VM is in a virtual network without a DNS resolution path to the KMS host.
- A network virtual appliance (NVA) or firewall intercepts and drops DNS traffic.
- The VM's network adapter has an incorrect or empty DNS server configuration.

## Solution 1: Reconfigure the VM to use the Azure KMS endpoint directly

Bypass DNS discovery entirely by pointing to the Azure KMS endpoint by name.

1. Open an elevated Command Prompt window on the VM.

1. Verify that DNS resolution is working for basic names. Run the following command:

   ```cmd
   nslookup azkms.core.windows.net
   ```

1. If DNS resolution fails, check the VM's DNS configuration:

   ```cmd
   ipconfig /all
   ```

   Verify that the DNS server addresses are correct and reachable.

1. Set the KMS server explicitly (bypasses Service Location (SRV) record lookups):

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## Solution 2: Fix DNS connectivity

If the VM needs DNS for other purposes (not only activation), troubleshoot the underlying DNS issue.

1. **Check NSG rules**: Make sure that outbound traffic on UDP/TCP port 53 is allowed to the DNS server.

1. **Check DNS server health**: If you're using a custom DNS server, verify that it's running and reachable. Run the following command:

   ```cmd
   psping <dns-server-ip>:53
   ```

1. **Reset DNS to Azure default**: If you're using custom DNS, and it's not required, revert to using Azure-provided DNS in the [Azure portal](https://portal.azure.com):

   1. Go to **Virtual network** > **DNS servers**, and then select **Default (Azure-provided)**.

1. **Flush DNS cache** on the VM:

   ```cmd
   ipconfig /flushdns
   ```

1. Retry activation after DNS connectivity is restored.

## References

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
- [Name resolution for resources in Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
