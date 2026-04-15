---
title: Error 0xC0020017 KMS contact failure (SPP Event 8198) when activating Windows
description: Learn how to resolve the 0xC0020017 error (SPP Event ID 8198) that occurs when you try to activate an Azure Windows virtual machine (VM).
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0xC0020017 / 0x8007139F — KMS contact failure (SPP Event 8198)

**Applies to:** :heavy_check_mark: Windows VMs

This article discusses how to resolve the 0xC0020017 (or 0x8007139F) error that occurs when a Windows virtual machine (VM) in Microsoft Azure can't contact the Key Management Service (KMS) for activation. This error is typically reported in the Application Event Log as **Event ID 8198** from the **Security-SPP** source, rather than via the standard `slmgr.vbs` output.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions//ff793433(v=technet.10)) (*slmgr.vbs*) script
- The [PsPing](/sysinternals/downloads/psping) tool

## Symptoms

The Windows VM fails to activate. The standard `slmgr.vbs /ato` command may produce a generic failure, but the actual error is recorded in the **Application Event Log**:

- **Source:** Security-SPP
- **Event ID:** 8198
- **Error code:** `0xC0020017` or `0x8007139F`
- **Description:** License Activation failed. The Software Protection service reported that the computer could not be activated.

You can view this event by running:

```powershell
Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 5 | Format-List TimeCreated, Message
```

## Cause

Error 0xC0020017 indicates that the Software Protection Platform (SPP) service couldn't contact the KMS server. This is functionally similar to error [0xC004F074](windows-vm-activation-error-0xc004f074.md) but is reported through a different code path (the SPP event pipeline rather than the SLC API).

Common root causes on Azure VMs:

- **Network connectivity**: The VM can't reach the KMS endpoint on port 1688 due to NSG rules, User Defined Routes (UDRs), or firewall policies.
- **Forced tunneling**: All outbound traffic is routed through an on-premises VPN or ExpressRoute gateway, bypassing the Azure KMS endpoint.
- **DNS resolution failure**: The VM can't resolve `azkms.core.windows.net`.
- **Wrong KMS target**: The VM is configured to contact an on-premises KMS server that is unreachable from Azure.

## Solution 1: Verify and fix KMS connectivity

1. Open an elevated Command Prompt window on the VM.

2. Check the current KMS configuration:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /dlv
   ```

3. Clear any stale KMS settings and point to Azure KMS:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ckms
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

4. Test connectivity to the Azure KMS endpoint:

   ```cmd
   psping azkms.core.windows.net:1688
   ```

   If this fails, proceed to troubleshoot the network path (NSG rules, UDRs, firewall).

5. Verify DNS resolution:

   ```cmd
   nslookup azkms.core.windows.net
   ```

6. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## Solution 2: Fix forced tunneling

If your virtual network routes all internet traffic through an on-premises gateway (forced tunneling), KMS traffic must be exempted:

1. Add a User Defined Route (UDR) that sends traffic for the Azure KMS IP addresses directly to the Internet. See [Custom routes to enable KMS activation](custom-routes-enable-kms-activation.md) for the specific IP addresses and route configuration.

2. After applying the UDR, retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## Solution 3: Restart the SPP service

In some cases, the SPP service itself may be in a stuck state:

1. Restart the Software Protection service:

   ```powershell
   Restart-Service sppsvc -Force
   ```

2. Wait 30 seconds, then retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

3. Check Event ID 8198 again to confirm the error is resolved:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Security-SPP'; Id=8198} -MaxEvents 1 | Format-List TimeCreated, Message
   ```

## More information

- [Error 0xC004F074 — No KMS could be contacted](windows-vm-activation-error-0xc004f074.md)
- [Custom routes to enable KMS activation with forced tunneling](custom-routes-enable-kms-activation.md)
- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
