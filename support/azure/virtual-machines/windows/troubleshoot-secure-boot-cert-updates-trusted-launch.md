---
title: Troubleshoot Secure Boot certificate updates on Azure Trusted Launch VMs
description: Diagnose and resolve Secure Boot certificate update issues on Azure Trusted Launch and Confidential VMs running Windows, including Event ID 1795 firmware errors.
ms.date: 06/05/2026
author: scotro
ms.author: scotro
ms.service: azure-virtual-machines
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: arrenc
ms.custom:
- sap:virtual machines\vm management - configuration and setup
- pcy:VM Conf and Setup
appliesto:
  - <a href=https://learn.microsoft.com/azure/virtual-machines/trusted-launch target=_blank>Azure Trusted Launch VMs</a>
  - <a href=https://learn.microsoft.com/azure/confidential-computing/confidential-vm-overview target=_blank>Azure Confidential VMs</a>
---

# Troubleshoot Secure Boot certificate updates on Azure Trusted Launch VMs

This article helps you diagnose and resolve issues with Secure Boot certificate updates on Azure Trusted Launch virtual machines (TVM) and Confidential VMs (CVM) running Windows.

## Symptoms

You experience one or more of the following issues on an Azure Gen2 Trusted Launch or Confidential VM:

- **Event ID 1795** in the System event log: "The system firmware returned an error while attempting to update a Secure Boot variable."
- **Event ID 1801** indicating the certificate update is incomplete.
- The `UEFICA2023Status` registry value is not set to **Updated**.
- The `UEFICA2023Error` registry key exists under `HKLM\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing`.

## Cause

Microsoft Secure Boot certificates issued in 2011 begin expiring in June 2026. Azure Trusted Launch and Confidential VMs must update to the 2023 certificates to maintain boot-level security protections. Several factors can prevent these updates from completing:

| Root Cause | Symptom | Details |
|---|---|---|
| **Host firmware not updated** | Event ID 1795 | The Azure host node had not received the firmware update needed to support guest-initiated KEK updates. This affected long-running VMs where UEFI NVRAM writes require host platform coordination. **Resolved:** The host-side fix shipped in the 2605_2 host OS servicing package (rolled out by end of May 2026). |
| **VM created before March 2024** | Certificate update doesn't complete | Long-running VMs created before March 2024 don't have the 2023 certificates pre-provisioned in virtual firmware. These VMs require both certificate updates AND a Boot Manager update. |
| **Scheduled task disabled** | `UEFICA2023Status` stays empty | The `Secure-Boot-Update` scheduled task is disabled, preventing automatic certificate deployment. |
| **Missing servicing stack update** | `Servicing` registry key doesn't exist | The Secure Boot servicing stack update hasn't been installed. The VM needs the March 2026 cumulative update or later. |
| **Hotpatch-only VMs** | Update not applied | VMs using hotpatching need the April 2026 release that includes the fix outside of hotpatching. |

## Determine certificate update status

### Option 1: Run the diagnostic script via Run Command

Use the **Detect-SecureBootCertUpdateStatus_Summary.ps1** RunCommand script to collect a comprehensive status report.

1. In the Azure portal, navigate to your VM.
2. Select **Operations** > **Run command** > **RunPowerShellScript**.
3. Download and paste the script from the [Azure Support Scripts repository](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/SecureBootCertCheck).
4. Select **Run**.

The script checks:
- Secure Boot enabled state
- `AvailableUpdates` bitmask (decoded into human-readable certificate flags)
- `UEFICA2023Status` and error values
- Event log analysis for all relevant Event IDs (1795–1808)
- Scheduled task state and last run time
- OEM firmware version

### Option 2: Check manually

**Registry check:**

```powershell
# Certificate update status
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing" | Select-Object UEFICA2023Status, UEFICA2023Error, UEFICA2023ErrorEvent

# Available updates bitmask
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot" | Select-Object AvailableUpdates
```

| UEFICA2023Status value | Meaning |
|---|---|
| **Updated** | Certificates successfully applied |
| **InProgress** | Update started but not complete (restart may be needed) |
| **NotStarted** | On post-March 2024 VMs, this is **expected** — firmware already has 2023 certs pre-provisioned, so guest-side cert deployment was never needed. On pre-March 2024 VMs, this means the update hasn't been initiated yet. |
| *Not present* | Servicing key doesn't exist — update hasn't been initiated at all |

**Event log check:**

```powershell
Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='TPM-WMI'; Id=1795,1800,1801,1803,1808} -MaxEvents 10 | Format-Table TimeCreated, Id, Message -Wrap
```

| Event ID | Meaning | Action |
|---|---|---|
| 1808 | Success — certificates applied | None |
| 1801 | Update initiated, pending restart | Restart the VM |
| 1800 | Restart required to complete | Restart the VM |
| 1803 | Matching KEK not found | Should not occur on standard Azure VMs — contact support |
| 1795 | Firmware error | See [Resolve Event ID 1795](#resolve-event-id-1795) |

## Resolve Event ID 1795

Event ID 1795 on Azure Trusted Launch VMs was caused by unpatched host firmware that didn't support guest-initiated UEFI NVRAM writes for KEK updates.

**Resolution:**

The host-side fix was included in the Azure 2605_2 host OS servicing package, which completed fleet-wide rollout by end of May 2026.

1. **Restart the VM** to allow the VM to land on an updated host node.
2. After restart, wait approximately 48 hours and one or more restarts for the certificate update to complete automatically.
3. Run the diagnostic script or check the registry to verify `UEFICA2023Status = Updated`.

If Event ID 1795 persists after restarting:
1. Redeploy the VM (`az vm redeploy`) to force placement on a different host node.
2. If the issue continues, [create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request) referencing Event ID 1795.

> [!NOTE]
> There is no guest-side workaround for Event ID 1795. The host node must have the firmware update. The guest OS cannot resolve this independently.

## Resolve stalled certificate updates

### Certificate update not initiated

If the `Servicing` registry key doesn't exist:

1. Install the latest Windows cumulative update (March 2026 or later).
2. Restart the VM.
3. Wait for automatic deployment via Windows Update.
4. If automatic deployment doesn't occur, use an IT-initiated method:

```powershell
# Enable IT-initiated deployment via registry
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot" -Name "AvailableUpdates" -PropertyType DWord -Value 0x5944 -Force
```

### Scheduled task disabled

```powershell
# Check task status
Get-ScheduledTask -TaskPath "\Microsoft\Windows\PI\" -TaskName "Secure-Boot-Update" | Select-Object State

# Re-enable if disabled
Enable-ScheduledTask -TaskPath "\Microsoft\Windows\PI\" -TaskName "Secure-Boot-Update"
```

### Update stuck in progress

If `UEFICA2023Status` shows **InProgress** for more than 48 hours:

1. Restart the VM.
2. Check status after 15 minutes.
3. If still in progress, check for `UEFICA2023Error` and review System event logs.

## Pre-March 2024 VMs vs. newer VMs

| VM Creation Date | Firmware Certs | Action Required |
|---|---|---|
| **After March 2024** | 2023 certificates pre-provisioned | Only Windows Boot Manager update needed |
| **Before March 2024** | 2011 certificates only | Both firmware certificate update AND Boot Manager update needed |

> [!IMPORTANT]
> The "before March 2024" distinction refers to VMs that have been **continuously running since before March 2024** — not VMs deployed from older images. Azure injects current firmware certificates at VM creation time regardless of image age. You cannot reproduce the missing-certs scenario by deploying an old Marketplace image today.

For VMs created before March 2024, the certificate updates must be applied from within the guest OS through Windows servicing. Azure cannot push these updates from the hypervisor — the UEFI authenticated variable update protocol requires guest OS initiation.

## Golden image considerations

Azure Compute Gallery and managed images capture OS state (including Boot Manager) but **do not capture Secure Boot firmware variables** (DB, KEK, DBX).

- Apply the Secure Boot 2023 update to the golden image before capturing.
- This advances the Windows Boot Manager in the image but does NOT persist certificates to VMs deployed from the image.
- Newly provisioned VMs (post-March 2024) get 2023 certs automatically in firmware.
- Redeploying onto pre-March 2024 VMs requires applying cert updates in the guest OS first, before advancing the Boot Manager.

Verify before generalizing:

```powershell
Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing" | Select-Object UEFICA2023Status
# Expected: UEFICA2023Status = Updated
```

## Impact of not updating

VMs that don't receive the 2023 certificates will:
- **Continue to boot normally** and receive standard Windows updates.
- **Not receive** new Boot Manager security updates, Secure Boot database/revocation updates, or mitigations for future boot-level vulnerabilities.
- Operate with a **degraded security posture** for the early boot process over time.

> [!IMPORTANT]
> Azure cannot force Secure Boot certificate updates remotely via the hypervisor. The guest OS must initiate the update. Customers with long-running VMs must apply updates from within the guest OS or accept the degraded boot-level security posture after June 2026.

## More information

- [Secure Boot update from 2011 to 2023 certificates: TVM and CVM (KB 5085395)](https://support.microsoft.com/topic/845ec199-03fa-4629-bdc3-822ae0bbe6ca)
- [Known issues and resolutions for Secure Boot certificates updates (KB 5085790)](https://support.microsoft.com/topic/5813673d-2577-4718-ad28-2554a9178e40)
- [Windows Secure Boot certificate expiration and CA updates (KB 5062710)](https://support.microsoft.com/topic/7ff40d33-95dc-4c3c-8725-a9b95457578e)
- [Secure Boot playbook for Windows Server](https://aka.ms/SecureBootForServer)
- [SecureBootCertCheck RunCommand script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/SecureBootCertCheck)
- [Trusted Launch for Azure virtual machines](/azure/virtual-machines/trusted-launch)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
