---
title: Resolve pairing issues between Teams Rooms on Android console and front-of-room device
description: Troubleshoot pairing issues between a Teams Rooms on Android touch console and its paired front-of-room device or meeting bar.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/25/2026
---

# Resolve pairing issues between Teams Rooms on Android console and front-of-room device

## Summary

This article helps you troubleshoot pairing issues between a Microsoft Teams Rooms on Android touch console and its front-of-room device or meeting bar.

## Symptoms

You experience one or more of the following symptoms on a Microsoft Teams Rooms on Android system:

- The touch console appears unpaired or disconnected from the front-of-room device or meeting bar.
- The console shows a disconnected pairing state.
- The console shows one of the following messages:

  > "Couldn't find the device."
   
  > "Multiple devices found."
   
  > "Pairing could not be completed with the device."
   
- In the Microsoft Teams admin center, the front-of-room device and touch console don't show a healthy paired state.

## Cause

Pairing can fail for multiple reasons. Common causes include the following scenarios:

- The console and front-of-room device are from different manufacturers.
- The devices are signed in with different resource accounts.
- The devices run different Teams app versions.
- One or both devices have a sign-in issue or partial sign-in state.
- A network issue interrupts discovery, keepalive traffic, or recovery.
- Firmware-level pairing doesn't complete or doesn't recover automatically.
- Endpoint information changes and the paired device doesn't receive the update.

## Resolution

Use the following steps to identify and fix the pairing issue.

### Step 1: Validate prerequisites

1. Confirm that the touch console and front-of-room device are from the same manufacturer.
1. Confirm that both devices are signed in with the same account.
1. Confirm that both devices run the same Teams app version.
1. Confirm that both devices are powered on, connected to the network, and responsive.

### Step 2: Check device status

1. Open the Microsoft Teams admin center and review the front-of-room device status under the Teams Rooms on Android device list.
1. Verify that the touch console state is present and that the overall health status is healthy.
1. Review the touch console entry under the touch console device list.
1. Verify the device pairing state and overall health status.

### Step 3: Check for sign-in issues

1. Confirm that neither device shows a sign-in issue or partial sign-in state.
1. If you find a sign-in issue, resolve that issue before you continue troubleshooting the pairing issue.

### Step 4: Collect diagnostic information

1. Record the date and time when you noticed the issue.
1. Record the make and model of both devices.
1. Record the firmware version and Teams app version on both devices.
1. Capture the current state of the console and front-of-room device so you can confirm where the issue appears.
1. Download the device logs from both the touch console and the front-of-room device as close as possible to the time the issue occurs.
1. On the touch console, open **Device Settings** > **Teams Admin Settings** > **Devices** > **Console pairing**, and capture the pairing status page.

### Step 5: Interpret common pairing errors

If the console pairing page shows one of the following errors, use the suggested action:

| Error code | What it means | Message shown | Suggested action |
|---|---|---|---|
| AutoPairRequestFailed | Automatic re-pairing fails when rediscovery is disabled. | Couldn't find the device | Make sure the device is turned on and connected to the network, and then try again. |
| DiscoveryFailed | Rediscovery fails or doesn't return a device. | Couldn't find the device | Make sure the device is turned on and connected to the network, and then try again. |
| MultipleEndpointsDiscovered | The console detects multiple front-of-room devices during rediscovery. | Multiple devices found | Reset device pairing, or try again. |
| InvalidEndpointMetadata | The front-of-room device returns invalid metadata. | Couldn't pair with the device. Endpoint details were invalid | Restart the device, and then try again. |
| CompletePairingFailed | Pairing can't complete after rediscovery. | Pairing could not be completed with the device | Make sure the device is turned on and connected to the network, and then try again. |
| AutoPairRequestTimeout | Automatic pairing or rediscovery times out. | Couldn't find the device | Make sure the device is turned on and connected to the network, and then try again. |

### Use recovery actions

1. Restart the affected devices if the Teams app is unresponsive or if you suspect a temporary firmware pairing issue.
1. Reset pairing if the current pairing is broken and rediscovery doesn't pair the console with the front-of-room device.
1. Unpair the devices if you need to remove the current pairing and ensure that the console signs out.
1. Reset the device to the factory setting only if the app updates or firmware updates don't complete and other recovery steps don't resolve the issue.

> [!NOTE]
> A reset pairing action returns both devices to an unpaired state. An unpair action also removes the pairing, but the console signs out as well.

## More information

- Pairing requires both devices to use the same manufacturer, the same signed-in account, and the same Teams app version.
- If multiple front-of-room devices are signed in with the same account, the console can discover more than one device. This scenario can trigger a "Multiple devices found" message. To reduce pairing issues, use the account on only one front-of-room device.
- Teams client pairing and firmware-level pairing are separate processes. Teams pairing can succeed even if firmware pairing doesn't complete immediately.
- If a network interruption causes keepalive failures, the console can enter a disconnected state and try to recover automatically. After network connectivity is restored, the devices can pair again if sign-in is healthy.
- If the console discovers only one eligible front-of-room device, it can complete the pairing automatically. If the console discovers multiple eligible devices, you might need to complete pairing manually by using the code shown on the front-of-room device.
