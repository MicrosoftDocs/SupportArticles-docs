---
title: Troubleshoot UWP Apps Failing to Open Due to Registry Permissions
description: Learn how to fix UWP apps that fail to open or close immediately due to registry permission issues. Follow troubleshooting steps to restore functionality.
ms.date: 05/07/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting-general
ms.custom:
- sap:windows desktop and shell experience\modern, inbox and microsoft store apps
- pcy:WinComm User Experience
ms.reviewer: kaushika
appliesto:
 - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# Troubleshoot UWP apps failing to open due to incorrect registry permissions

Universal Windows Platform (UWP) apps are designed to run on Windows 10 and Windows 11 using a single code base. This article explains how to troubleshoot UWP apps that fail to open or close immediately due to registry permission issues, helping you restore functionality.

## Symptoms of UWP app failures

On Windows 10 or Windows 11 devices, built-in UWP apps may fail to open or close immediately after launch. This issue affects all user accounts on the device.

Affected apps may include:

- Microsoft Store
- Company Portal
- Microsoft Entra (Azure AD) Broker Plugin (Token Broker)
- Microsoft Lock Screen–related components

Additional symptoms may include:

- Repeated crashes of **BackgroundTaskHost.exe**
- Application crash events referencing **twinapi.appcore.dll**
- Exception code **0xC0000409**
- Error signatures including **FAIL_FAST_FATAL_APP_EXIT_8007000e**

## Cause of registry permission issues

This issue occurs when required registry permissions are missing on the following registry key:

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control
```

UWP apps run under the **ALL APPLICATION PACKAGES** security principal (SID: **S-1-15-2-1**) and require **Read** access to this key. If this permission is missing or inheritance is disabled, UWP apps cannot read required system configuration data and may fail to start.

In affected environments:

- The **ALL APPLICATION PACKAGES** entry is missing the required **Read** permission.
- Access control list (ACL) inheritance is blocked on the key.
- The permission may exist under **ControlSet001** but is missing from **CurrentControlSet**, which is the active control set used at runtime.

## Troubleshooting steps for UWP apps

Follow these steps to resolve the issue.

> [!IMPORTANT]
> Incorrect changes to the registry can cause serious system problems. Follow these steps carefully and make sure you have a backup before proceeding.

### Step 1: Open PowerShell as an administrator

1. Select **Start**, and type `PowerShell`.
1. Right-click **Windows PowerShell**, and then select **Run as administrator**.

### Step 2: Set the target registry path

Run the following command in PowerShell to set the target registry path:

```powershell
$path = "HKLM:\SYSTEM\CurrentControlSet\Control"
```

### Step 3: Enable inheritance

Run the following commands to enable inheritance on the registry key:

```powershell
$acl = Get-Acl $path
$acl.SetAccessRuleProtection($false, $true)
Set-Acl -Path $path -AclObject $acl
```

### Step 4: Add "ALL APPLICATION PACKAGES" ReadKey permission

Run the following commands to add the required permission:

```powershell
$acl = Get-Acl $path
$accessRule = New-Object System.Security.AccessControl.RegistryAccessRule(
    "ALL APPLICATION PACKAGES",
    "ReadKey",
    "ContainerInherit,ObjectInherit",
    "None",
    "Allow"
)
$acl.SetAccessRule($accessRule)
Set-Acl -Path $path -AclObject $acl
```

### Step 5: Verify the permissions (optional but recommended)

Run the following command to verify that the **ALL APPLICATION PACKAGES** permission is correctly applied:

```powershell
(Get-Acl $path).Access | Where-Object { $_.IdentityReference -like "*ALL APPLICATION PACKAGES*" }
```

## Resolution

After restoring the required permissions:

- UWP apps should open normally.
- Microsoft Store, Company Portal, and other affected apps should function as expected.
- **BackgroundTaskHost.exe** crash events should no longer occur.

If the issue persists, restart the device and test again.

