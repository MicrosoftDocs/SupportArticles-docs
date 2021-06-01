---
title: No permissions to enroll a Windows device
description: Describes an issue in which you can't enroll a Windows device in Microsoft Intune if you don't log on to Windows as a local administrator.
ms.date: 07/24/2020
ms.prod-support-area-path: Windows enrollment
---
# You can't enroll a Windows device in Intune with a non-administrator account

This article helps you fix an issue where you don't have the right privileges to enroll a Windows device in Microsoft Intune if you don't log on to Windows as a local administrator.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4463724

## Symptoms

When you try to [enroll your Windows devices in Intune by using the Intune Company Portal](/mem/intune/user-help/windows-enrollment-company-portal), you receive the following error message:

> You don't have the right privileges to perform this operation. Please talk to your admin.

:::image type="content" source="media/no-permission-to-enroll-windows-devices/error.png" alt-text="Windows enrollment error.":::

## Cause

This issue occurs if the account that you use to log on to Windows isn't a member of the local Administrators group.

This behavior is expected. Local administrative privileges are required for already configured Windows 10 device enrollment in Intune.

## Resolution

You can use either of the following alternative enrollment methods to enroll your Windows devices in Intune:

- [Enroll Windows devices in Intune by using the Windows Autopilot](/mem/intune/enrollment/enrollment-autopilot)
- [To join a brand-new Windows 10 device](azure/active-directory/user-help/user-help-join-device-on-network#to-join-a-brand-new-windows-10-device)

These enrollment methods use the local system account. Therefore, you can use them to enroll your devices without having to be a local administrator.
