---
title: Windows unexpectedly install updates when automatic updates are disabled by Group Policy
description: Discusses a problem that  Windows unexpectedly install updates when automatic updates are disabled by Group Policy.
audience: itpro
manager: dcscontentpm
ms.date: 04/01/2025
ms.reviewer: 5x5dnd, shan
ms.topic: troubleshooting
ms.custom:
- sap:windows servicing,updates and features on demand\windows update configuration,settings and management
- pcy:WinComm Devices Deploy
---
# Windows unexpectedly install updates when automatic updates are disabled by Group Policy

Windows unexpectedly install updates on Windows Server 2016 and Windows Server 2019 automatically even though the Group Policy **Configure Automatic Updates** is set to one of the following options:

- Option 2 - **Notify before downloading and installing any updates**
- Option 3 - **Download the updates automatically and notify when they are ready to be installed**
- Option 5 - **Allow local administrators to select the configuration mode that Automatic Updates should notify and install updates** (This option has not been carried over to any Win 10 Versions)
- Option 7 - **Notify for install and notify for restart** (Windows Server only)

## Cause

This issue occurs when an administrator runs the command `GPUPDATE / FORCE`. This command resets all policy setting and reapplies them. During this time interval, automatic update settings are reverted to defaults and updates might be installed. This issue only occurs on Windows Server 2016 and Windows Server 2019.

## Resolution

To avoid this issue, don't run `GPUPDATE /FORCE` on Windows Server 2016 and 2019 unless you're prepared for any queued updates to be installed. This issue is rare, but it's possible to occur.

## Workarounds for Windows Server 2016 and Windows Server 2019

For users on Windows Server 2016 and Windows Server 2019, implementing one of the following workarounds can help reduce the frequency of the issue:

### Enable the "Configure registry policy processing" policy

1. Navigate to **Computer Configuration** > **Administrative Templates** > **System** > **Group Policy** > **Configure registry policy processing** and set it to **Enabled**.
2. Unselect **Do not apply during periodic background processing**.
3. Select **Process even if the Group policy objects have not changed**.

### Enable the "Configure registry policy processing" policy by using registry

Set the following registry keys:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}`  
"NoBackgroundPolicy"=dword:00000000  
"NoGPOListChanges"=dword:00000001

You can also run the following command to modify the registry:

```console
reg add "HKEY\_LOCAL\_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}" /v NoBackgroundPolicy /t REG\_DWORD /d 00000000 /f
reg add "HKEY\_LOCAL\_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}" /v NoGPOListChanges /t REG\_DWORD /d 00000001 /f
```

For more information, see [Configure registry policy processing (admx.help)](https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.GroupPolicy::CSE_Registry)

> [!NOTE]
> These workarounds reduce the frequency of the problem occurring but don't always prevent the issue.

## Reference

For more information, open [Windows security baseline](/azure/governance/policy/samples/guest-configuration-baseline-windows) and see the "Ensure 'Configure registry policy processing: Process even if the Group Policy objects have not changed' is set to 'Enabled: TRUE'" row.
