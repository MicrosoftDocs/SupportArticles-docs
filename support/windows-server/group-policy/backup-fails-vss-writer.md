---
title: Managing Removable Devices Through Group Policy Troubleshooting Guidance
description: Resolves issues in which GPOs and registry settings that control access to removable drives don't work as expected in Windows.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Group Policy\Managing removable devices (USB devices and flash drives) through Group Policy
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Managing removable devices through Group Policy troubleshooting guidance

## Summary

This article provides detailed troubleshooting steps to resolve issues in which Group Policy Objects (GPOs) and registry settings to control access to USB flash drives and other removable storage devices don't work as expected. These issues occur in Windows environments, including Windows 11, 10, and Server editions. Such failures can occur because of product bugs (often after Windows updates), policy misconfiguration, registry and service conflicts, or inherent system limitations. Robust device control is essential for endpoint security, data loss prevention, and regulatory compliance. This article consolidates known failure modes and provides resolutions for IT professionals and administrators.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Verify symptoms**
    - Verify the issue (for example, unauthorized USB access, device allow list failure, legitimate device block, prompt to encrypt drive)
- **Check GPO Application**
    - Run gpresult /h gpresult.html, and use rsop.msc to verify that targeted GPOs are applied.
    - Verify that the GPO is linked to the correct OU and assigned to computer or user as necessary.
- **Review Registry Settings**: Confirm keys in:
    - HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices
    - HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR
    - Check for keys: Deny_Read, Deny_Write, Start
- **Update Windows**
    - Make sure that the latest Windows updates and hotfixes are installed.
    - Cross-reference with known issue rollbacks (KIR) or advisories for your OS build.
- **Audit local versus domain GPO application**
    - Determine where the restriction is being applied (domain, local, cloud-managed, Intune, and so on).
- **Check for Product Bugs and KIRs**
    - Search for current ICMs, KB articles, and KIRs that affect removable storage policies.
- **Inspect policy layering and inheritance**
    - Ensure policy precedence (no conflicting user-level or computer-level settings or inheritance that masks intended policy behavior).
- **Verify device installation policies**
    - For allowlisting: Verify device IDs, instance paths, and setup class GUIDs.
    - Check whether previously installed devices and drivers exist.
- **Examine registry and service conflicts**
    - Review presence and behavior of the HotplugSecureOpen registry key.
    - Check the WPDBusEnum service state.
- **Assess connectivity and aAuthentication**
    - Verify that the device can contact domain controllers (especially when on VPN).
    - Verify that the user or device is in the correct security groups and meets authentication requirements.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### USB or removable storage policies not enforced after update bug

#### Symptoms

- Users can bypass storage policies after certain Windows Updates (for example, 2025.5B, KB5058379, KB5050092, KB5062552).
- GPO appears to be applied (confirmed by gpresult), but access is not blocked.

#### Resolution

1. Apply the Known Issue Rollback (KIR) workaround:
    1. Download and install the affected update’s KIR MSI and policy template.
    1. Apply a registry override. For example:

        ```console
        reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides /v <key> /t REG_DWORD /d 0 /f
        ```
        
    1. In gpedit.msc, set the new policy (KB5050092 or similar) to "Disabled."
    1. Restart the affected computers.

2. Update to the latest Windows build (for example, Windows 11 24H2) when it's available or permitted.

3. Refer to relevant KBs, known bug links, and internal advisories (see "References").

### Registry key (HotplugSecureOpen) regenerates after deletion

#### Symptoms

- The blocking registry key is deleted, but is re-created after a restart.
- Policy enforcement fails until the key is deleted again.

#### Resolution

1. Disable the WPDBusEnum service to prevent key re-creation:

    ```console
    sc config WPDBusEnum start= disabled
    ```

    **Note:** Disabling the service might affect other device functionality.

2. Continue to monitor for permanent fixes (see KIR advisories link in "References").

### Device (allowlisting) fails or blocks all devices

#### Symptoms

- Devices intended to be allowed by device instance ID are blocked if "Deny all removable storage" GPO is also applied.
- Removing the block allows the device, but breaks policy intent.

#### Resolution

1. Move block policy settings from user to computer level GPO.
2. Remove all "Removable Storage Access" user policies.
3. Create a new GPO at computer level:
    - Enable "Apply layered order" for allow/deny device installation.
    - Block installation by setup class for USB drives.
    - Add allowed devices by instance ID or hardware ID.
4. Use gpresult /h report.html and Device Manager to verify enforcement.

### CD, DVD, or other devices blocked unintentionally (global policy overlap)

#### Symptoms

- CD and DVD drives are inaccessible, even if only USB devices should be blocked.
- Scanners and printers that are attached through USB aren't recognized.

#### Resolution

1. Adjust GPO:
    - Make sure that "All Removable Storage Classes: Deny All Access" isn't set if only USB is intended to be blocked.
    - Use more targeted class IDs or exclude CD and DVD-specific blocks.
2. Apply the update (gpupdate /force), restart the device, and retest.
3. For scanners and printers, consult device manager for class GUID, and allow as an exception, if possible.

### GPO isn't applied over VPN, or no domain connectivity

#### Symptoms

- GPO and registry indicate correct configuration, but user experiences unrestricted access when on VPN.
- Logs show "There is no connectivity. Waiting for connectivity again"

#### Resolution

1. Verify that the device can contact all required domain controllers when on VPN.
2. Collect and review GPSVC and network logs.
3. Consult Directory Services team to resolve DC replication or access issues.

### Legacy and unsupported device or system limitation

#### Symptoms

- Can't restrict devices that are connected through RS232, GPIB, or similar interfaces.
- No GPO available in Home editions.

#### Resolution

- Registry-only method for Windows XP and Home editions:

    ```console
    reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v Start /t REG_DWORD /d 4 /f
    ```

- For non-PNP interfaces (RS232/GPIB), third-party tools and DLP solutions are required.

### Deny\_Write or Deny\_Read Settings don't persist or are overwritten

#### Symptoms

- Registry keys that are manually set are reverted after running gpupdate /force.
- Can't unblock devices despite registry editing.

#### Resolution

1. Set required values in the correct policy-managed registry location.
2. Disable the GPO that sets Deny_Write/Deny_Read. Then, run gpupdate /force.
3. Restart the system and verify the behavior.

### BitLocker enforcement, unexpected encryption prompt

#### Symptoms

- Users are prompted to encrypt a USB drive before writing (outside of BitLocker policy intent).

#### Resolution

- Review assigned GPOs and BitLocker removable device policies.
- Adjust as intended. Remove or set BitLocker removable storage policies as necessary.

## Common issues quick reference table

| Symptom | Root cause | Quick fix | Reference |
| --- | --- | --- | --- |
| Policy not enforced after update | Known bug in recent update | Apply KIR or registry override; install fixed OS build | KB5050092, KIR |
| Registry key (HotplugSecureOpen) regenerates | Policy conflict after update | Disable WPDBusEnum service | KIR |
| Device allowlisting ignored | User-level policy overrides | Use computer-level GPO; enable layered order, remove user policies |  |
| CD/DVD, scanner, or printer access blocked | Overbroad access block | Remove "Deny All" policy; use device-specific policies |  |
| GPO not applied (VPN) | DC connectivity issue | Check VPN config, test on LAN, gather GPSVC/network logs |  |
| Manual registry change doesn't persist | GPO overriding | Remove/modify GPO, gpupdate, restart |  |
| BitLocker prompt unexpected | BitLocker GPO enforced | Review GPO, adjust BitLocker removable storage settings |  |
| Device blocking fails on Home edition | No GPO available | Use registry method, accept limitations |  |
| RS232/GPIB not blocked | OS not PNP aware, not removable class | Require third-party or DLP tools |  |
| Allow list not working | Policy layering/order, driver preinstall | Uninstall device, reapply GPO, use setup class GUID and instance ID |  |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- Group Policy Results:
    - gpresult /h gpresult.html
    - Use rsop.msc for GUI view
- Registry Exports:
    - reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices" usbpols.reg
    - reg export "HKLM\SYSTEM\CurrentControlSet\Control\Storage" storage.reg
- Policy Application Logs:
    - Review C:\Windows\INF\setupapi.dev.log
    - C:\Windows\Logs\StorGroupPolicy.log if present
- Service State:
    - sc query WPDBusEnum
- Device Manager:
    - Collect class GUID, device instance path/ID of affected/allowed devices
- Event Viewer:
    - Filter for policy processing and device installation events
- Process Monitor (Procmon):
    - For drive access or permission errors

## References
- [Windows registry key reference](/windows/win32/sysinfo/registry)
