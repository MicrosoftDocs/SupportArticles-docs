---
title: Windows Installs Updates When Automatic Updates Are Disabled
description: Learn why Windows installs updates even when automatic updates are disabled by Group Policy and how to resolve it.
audience: itpro
manager: dcscontentpm
ms.date: 04/20/2026
ms.reviewer: 5x5dnd, shan
ms.topic: troubleshooting
ms.custom:
- sap:windows servicing,updates and features on demand\windows update configuration,settings and management
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Windows unexpectedly installs updates when automatic updates are disabled by Group Policy

Windows installs updates automatically on Windows Server 2016 and Windows Server 2019 even when the **Configure Automatic Updates** Group Policy is set to one of the following options:

- Option 2 - **Notify before downloading and installing any updates**
- Option 3 - **Download the updates automatically and notify when they are ready to be installed**
- Option 5 - **Allow local administrators to select the configuration mode that Automatic Updates should notify and install updates** (this option isn't available in any Windows 10 versions)
- Option 7 - **Notify for install and notify for restart** (Windows Server only)

## Cause

This problem occurs during a group policy processing event. The event resets all policy settings and reapplies them. During this interval, the automatic update settings revert to defaults, and updates might be installed. This problem occurs only on Windows Server 2016 and Windows Server 2019.

## Resolution

To avoid this problem, restrict group policy processing to only when group policy objects change on Windows Server 2016 and 2019 unless you're prepared for any queued updates to be installed. This problem is rare, but it can occur.

## Workarounds for Windows Server 2016 and Windows Server 2019

For users on Windows Server 2016 and Windows Server 2019, implementing one of the following workarounds can help reduce the frequency of the problem:

### Enable the "Configure registry policy processing" policy

1. Go to **Computer Configuration** > **Administrative Templates** > **System** > **Group Policy** > **Configure registry policy processing** and set it to **Enabled**.
1. Clear **Do not apply during periodic background processing**.
1. Uncheck **Process even if the Group policy objects haven't changed**.

### Enable the "Configure registry policy processing" policy by using the registry

Set the following registry keys:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}`  
`NoBackgroundPolicy`=dword:00000000  
`NoGPOListChanges`=dword:00000001

You can also run the following commands to modify the registry:

```console
reg add "HKEY\_LOCAL\_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}" /v NoBackgroundPolicy /t REG\_DWORD /d 00000000 /f
reg add "HKEY\_LOCAL\_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}" /v NoGPOListChanges /t REG\_DWORD /d 00000001 /f
```

For more information, see [Configure registry policy processing (admx.help)](https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.GroupPolicy::CSE_Registry).

> [!NOTE]
> These workarounds reduce the frequency of the problem but don't always prevent it.

## Reference

For more information, open [Windows security baseline](/azure/governance/policy/samples/guest-configuration-baseline-windows) and see the "Ensure 'Configure registry policy processing: Process even if the Group Policy objects haven't changed' is set to 'Enabled: TRUE'" row.
