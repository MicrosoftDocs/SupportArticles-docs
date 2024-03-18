---
title: You don't have permissions to enroll a Windows device in Intune
description: Troubleshoot when you don't have the right privileges to enroll a Windows device in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Enroll Device - Windows\Advisory
ms.reviewer: kaushika
---
# You can't enroll a Windows device in Intune with a non-administrator account

This article helps you fix an issue where you don't have the right privileges to enroll a Windows device in Microsoft Intune if you don't log on to Windows as a local administrator.

## Symptoms

When you try to [enroll your Windows devices in Intune by using the Intune Company Portal](/mem/intune/user-help/windows-enrollment-company-portal), you receive the following error message:

> You don't have the right privileges to perform this operation. Please talk to your admin.

:::image type="content" source="media/no-permission-to-enroll-windows-devices/enrollment-error.png" alt-text="Screenshot of the You don't have the right privileges to perform this operation error.":::

## Cause

This issue occurs if the account that you use to log on to Windows isn't a member of the local Administrators group.

This behavior is expected. Local administrative privileges are required when enrolling an already configured Windows 10 device in Intune.

## Solution

You can use either of the following alternative enrollment methods to enroll your Windows devices in Intune:

- [Enroll Windows devices in Intune by using the Windows Autopilot](/mem/intune/enrollment/enrollment-autopilot)
- [Join a brand-new Windows 10 device](/azure/active-directory/user-help/user-help-join-device-on-network#to-join-a-brand-new-windows-10-device)

These enrollment methods use the local system account. Therefore, you can use them to enroll your devices without having to be a local administrator.
