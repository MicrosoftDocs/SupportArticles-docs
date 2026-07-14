---
title: Troubleshoot hotpatch failures on Azure VMs
description: Learn how to diagnose and resolve hotpatch deployment failures, unexpected reboots, and Azure Update Manager hotpatching issues on Azure Edition VMs.
author: scotro
ms.author: scotro
ms.reviewer: jarrettr, macla, glimoli, azurevmcptcic
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.date: 07/13/2026
ms.custom:
- sap:Windows Update and OS Upgrades
- pcy:WinComm Devices Deploy
---

# Troubleshoot hotpatch failures on Azure VMs

**Applies to:** :heavy_check_mark: Windows VMs running Azure Edition (Windows Server 2022 Datacenter: Azure Edition and later)

## Summary

This article helps you diagnose and resolve failures with [hotpatching](/windows-server/get-started/hotpatch) on Azure virtual machines (VMs). Hotpatching allows you to install security updates on Azure Edition VMs without requiring a reboot in most cases. When hotpatching fails, the VM might fall back to a standard (cold-patch) update that requires a reboot, or the update might fail entirely.

[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

## Symptoms

Hotpatch failures typically present in one of the following ways:

- **Azure Update Manager shows a hotpatch failure**: The update assessment or deployment in Azure Update Manager reports that a hotpatch couldn't be applied.
- **Unexpected VM reboot after update**: The VM reboots after a patch cycle even though hotpatching was configured.
- **Update history shows "Failed" for hotpatch updates**: The Windows Update history on the VM shows that a hotpatch (KB article) failed to install.
- **Hotpatch assessment shows "Not Ready"**: Azure Update Manager reports that the VM isn't hotpatch-eligible or that the baseline isn't current.

Common error messages:

| Symptom | Typical cause |
|---|---|
| "Hotpatch not supported on this VM" | VM isn't running Azure Edition or the orchestration mode isn't set. |
| "Baseline required before hotpatch" | The VM skipped its last cumulative (baseline) update. |
| Hotpatch installs but VM reboots | The update included changes that can't be applied as a hotpatch and required a cold patch. |
| Extension error: `Microsoft.CPlat.Core.WindowsHotpatch` | The hotpatch extension failed to deploy or run. |

## Cause

Hotpatch failures on Azure VMs have several possible causes:

- **VM doesn't meet hotpatch requirements**: Hotpatching is only supported on specific Azure Edition SKUs. The VM must run Windows Server 2022 Datacenter: Azure Edition or later, use a supported image from Azure Marketplace, and have the `AutomaticByPlatform` patch orchestration mode enabled.
- **Stale baseline**: Hotpatches are delta patches applied on top of the latest cumulative baseline update. If the VM missed its baseline (cumulative) update, subsequent hotpatches can't be applied until a new baseline is installed (which requires a reboot).
- **Extension health issues**: The `Microsoft.CPlat.Core.WindowsHotpatch` extension on the VM must be healthy and running the latest version.
- **Conflicting Group Policy settings**: Windows Update policies (for example, WSUS configuration or deferred updates) can interfere with Azure Update Manager's ability to deploy hotpatches.
- **Windows Update component corruption**: Underlying Windows Update component issues can prevent any update, including hotpatches, from installing. See [Troubleshoot CBS and component store corruption on Azure VMs](troubleshoot-cbs-component-store-corruption-azure-vm.md).

## Resolution

### Step 1: Verify VM eligibility for hotpatching

Verify that the VM meets all hotpatch prerequisites:

```powershell
# Check OS edition
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName

# Check if the image is Azure Edition
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion
```

To check the patch orchestration mode, use the Azure portal or Azure CLI (the Azure Instance Metadata Service doesn't expose patch settings):

- **Azure portal**: Go to **Virtual machines** > your VM > **Updates** > **Update settings** and verify the patch orchestration setting.
- **Azure CLI** (from a machine with CLI access):

  ```azurecli
  az vm show --resource-group <resource-group> --name <vm-name> --query "osProfile.windowsConfiguration.patchSettings"
  ```

The following conditions must be true:

- **OS**: Windows Server 2022 Datacenter: Azure Edition or later.
- **Orchestration mode**: `AutomaticByPlatform`.
- **Image source**: A supported Azure Marketplace image (custom images require extra configuration).

If the orchestration mode is wrong, update it in the Azure portal:

1. Go to **Virtual machines** > your VM > **Updates** > **Update settings**.
1. Set **Patch orchestration** to **Azure-orchestrated**.

### Step 2: Check hotpatch extension health

The hotpatch extension must be healthy:

```powershell
# Check extension status
Get-ChildItem "C:\Packages\Plugins\Microsoft.CPlat.Core.WindowsHotpatch" -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1 |
    ForEach-Object {
        Get-Content (Join-Path $_.FullName "Status\*.status") -ErrorAction SilentlyContinue |
            ConvertFrom-Json |
            Select-Object -ExpandProperty status
    }
```

You can also check the extension status in the Azure portal:

1. Go to **Virtual machines** > your VM > **Extensions + applications**.
1. Find `Microsoft.CPlat.Core.WindowsHotpatch` and check its status.

If the extension is in a failed state, try reinstalling it:

1. Go to **Virtual machines** > your VM > **Extensions + applications**.
1. Select the hotpatch extension > **Uninstall**.
1. Wait for the uninstall to finish.
1. Trigger a new update assessment from **Updates** to reinstall the extension automatically.

### Step 3: Check and install the baseline update

Hotpatches require a current baseline (cumulative) update. If the baseline is stale, you must install the latest cumulative update first, which requires a reboot.

```powershell
# Check the last installed cumulative update
$session = New-Object -ComObject Microsoft.Update.Session
$searcher = $session.CreateUpdateSearcher()
$history = $searcher.QueryHistory(0, 20)
$history | Where-Object { $_.Title -match "Cumulative" } |
    Select-Object Date, Title, ResultCode -First 5
```

If the last cumulative update is more than 3 months old, install the latest cumulative update:

1. In Azure Update Manager, go to your VM > **Updates** > **One-time update**.
1. Select **Include all update classifications** to include cumulative updates.
1. Deploy the update and allow the VM to reboot.

After the baseline is current, subsequent hotpatches should install without a reboot.

### Step 4: Check for conflicting Group Policy settings

Group Policy settings for Windows Update can conflict with Azure Update Manager's hotpatch delivery:

```cmd
gpresult /h C:\Temp\gpresult.html
```

Open the report and look for policies under:

- **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Update**
- Specifically: `Configure Automatic Updates`, `Specify intranet Microsoft update service location` (WSUS), `Do not connect to any Windows Update Internet locations`

If WSUS policies are configured, they can redirect the VM away from Azure Update Manager. For Azure Edition VMs using hotpatching, the recommended configuration is [Azure Update Manager](/azure/update-manager/overview) without WSUS. See [Configure Windows Update settings for Azure Update Manager](/azure/update-manager/configure-wu-agent).

### Step 5: Review update logs

If the issue persists, collect logs for further investigation:

```powershell
# Generate WindowsUpdate.log
Get-WindowsUpdateLog

# Check hotpatch extension logs
$extPath = Get-ChildItem "C:\Packages\Plugins\Microsoft.CPlat.Core.WindowsHotpatch" -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($extPath) {
    Get-ChildItem (Join-Path $extPath.FullName "*.log") -Recurse
}

# Check Component-Based Servicing (CBS) log for errors
Get-Content "C:\Windows\Logs\CBS\CBS.log" -Tail 100 | Select-String "Error|FAIL"
```

If a hotpatch installs successfully after these steps and no unexpected reboot occurs, the issue is resolved.

If the issue persists, collect the following log files before you contact Azure support:

| Log | Location |
|---|---|
| WindowsUpdate.log | Desktop (generated by `Get-WindowsUpdateLog`) |
| CBS.log | `C:\Windows\Logs\CBS\CBS.log` |
| Hotpatch extension logs | `C:\Packages\Plugins\Microsoft.CPlat.Core.WindowsHotpatch\<version>\` |
| DISM log | `C:\Windows\Logs\DISM\dism.log` |

## Hotpatch lifecycle overview

Understanding the hotpatch lifecycle helps explain why some updates require reboots even when hotpatching is configured:

1. **Baseline month** (quarterly): Microsoft releases a full cumulative update that requires a reboot. This becomes the new baseline for subsequent hotpatches.
1. **Hotpatch months** (the two months between baselines): Microsoft releases hotpatch updates that apply security fixes in-memory without rebooting.
1. **Fallback to cold patch**: Some updates include changes that can't be applied as a hotpatch (for example, .NET Framework updates or updates to boot-critical components). These fall back to a standard cumulative update that requires a reboot.

If the VM consistently falls back to cold-patch updates, check whether the VM is current on its baseline. An outdated baseline forces all subsequent updates to be cold patches.

## References

- [Troubleshoot Windows Update failures on Azure VMs](troubleshoot-windows-update-azure-vm.md)
- [Hotpatch for Windows Server](/windows-server/get-started/hotpatch)
- [Automatic VM guest patching for Azure VMs](/azure/virtual-machines/automatic-vm-guest-patching)
- [Troubleshoot known issues with Azure Update Manager](/azure/update-manager/troubleshoot)
- [Configure Windows Update settings for Azure Update Manager](/azure/update-manager/configure-wu-agent)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
