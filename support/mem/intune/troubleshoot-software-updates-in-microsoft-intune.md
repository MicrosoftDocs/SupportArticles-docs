---
title: Windows 7 devices with superseded updates stop reporting to Intune
description: Troubleshooting guidance to help resolve when Windows 7 devices with many superseded updates stop reporting to Microsoft Intune
ms.date: 11/09/2021
ms.reviewer: mghadial
---
# Windows 7 devices with many superseded updates stop reporting to Intune

This article helps resolve when Windows 7 devices that have multiple superseded updates stop reporting to Intune.

## Symptoms

Microsoft Intune clients may experience one or more of the following symptoms:

- Devices suddenly stop reporting to Intune.
- Devices experience high CPU utilization.
- Applications install slowly when installed through Intune.
- The Microsoft Intune Center shows the following error: `An error occurred while updating your computer. Error found: Code 0x800705b4`.
- The Intune Admin Console > Groups > All Devices > status shows: `One or more agents that are installed on this computer have errors. The information for this computer may not be accurate or up-to-date.`

## Cause

This problem can occur if superseded updates (updates are replaced by another update) haven't been declined for an extended period. During certain processes, such as installing an application, Windows checks all superseded updates in sequence so that the updates and their successors are correctly mapped. If the list of superseded updates gets too large, this checking task may cause high CPU utilization because of the processing load and time required. This issue primarily affects Windows 7 devices because of the large number of superseded updates that are available for Windows 7. Newer operating systems may not have as many available superseded updates, and may not be susceptible to this issue.

## Solution

To fix this issue, decline all superseded updates.

1. Sign in to the [Microsoft Endpoint Manager admin console](https://endpoint.microsoft.com/).
2. Select **Software Updates**.
3. Decline all superseded updates that may apply to Windows 7 or to applications, such as Microsoft Office, that were installed on the affected clients.
4. Restart the affected clients.

If you're running Windows 7, be sure the following update is installed: [Windows Update Client for Windows 7: June 2015](https://support.microsoft.com/help/3050265).
