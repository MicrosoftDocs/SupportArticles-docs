---
title: iOS or iPadOS device stuck on Intune enrollment screen
description: Resolves an issue where iOS/iPadOS devices are stuck on an enrollment screen during Microsoft Intune enrollment.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
ms.custom: sap:Enroll Devices - iOS\Advisory
---

# iOS or iPadOS device is stuck on an enrollment screen

This article fixes an issue where iOS/iPadOS devices are stuck on a Microsoft Intune enrollment screen for more than 10 minutes. An enrolling device may get stuck in either of two screens:

- Awaiting final configuration from "Microsoft"
- Guided Access app unavailable. Please contact your administrator.

## Cause

There are two potential causes for this issue:

- There's a temporary outage with Apple services.
- iOS/iPadOS enrollment is set to use VPP tokens (as shown in the table below) but there's something wrong with the VPP token.

| Enrollment settings | Value |
| ---- | ---- |
| Platform | iOS/iPadOS |
| User Affinity | Enroll with User Affinity |
|Authenticate with Company Portal instead of Apple Setup Assistant | Yes |
| Install Company Portal with VPP | Use token: token address |
| Run Company Portal in Single App Mode until authentication | Yes |

## Solution

To fix the problem, complete the procedures in this section:

1. Determine if there's something wrong with the VPP token and fix it.
2. Identify which devices are blocked.
3. Wipe the affected devices.
4. Tell the user to restart the enrollment process.

### Determine if there's something wrong with the VPP token

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **iOS/iPadOS** > **iOS enrollment** > **Enrollment program tokens** > token name > **Profiles** > profile name > **Manage** > **Properties**.
2. Review the properties to see if any errors similar to the following appear:
    - This token has expired.
    - This token is out of Company Portal licenses.
    - This token is being used by another service.
    - This token is being used by another tenant.
    - This token was deleted.
3. Fix the issues for the token.

### Identify which devices are blocked by the VPP token

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **iOS/iPadOS**k > **iOS enrollment** > **Enrollment program tokens** > token name > **Devices**.
2. Filter the **Profile status** column by **Blocked**.
3. Make a note of the serial numbers for all the devices that are **Blocked**.

### Remotely wipe the blocked devices

After you've fixed the issues with the VPP token, you must wipe the devices that are blocked.

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **All devices** > **Columns** > **Serial number** > **Apply**.
2. For each blocked device, choose it in the **All devices** list and then choose **Wipe** > **Yes**.

### Tell the users to restart the enrollment process

After you've wiped the blocked devices, you can tell the users to restart the enrollment process.
