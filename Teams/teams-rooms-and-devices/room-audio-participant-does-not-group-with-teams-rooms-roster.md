---
title: Room Audio participant doesn't group with Teams Rooms roster
description: Learn why a laptop participant stays separate from the Teams Rooms participant group when they select Room Audio without a Bluetooth Low Energy proximity association.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/17/2026
---

# Room Audio participant doesn't group with Teams Rooms roster

## Summary

This article explains why a participant who joins a meeting from a laptop and selects **Room Audio** might not appear in the Teams Rooms participant grouping in the meeting roster. It also provides steps to verify Bluetooth Low Energy (BLE) proximity detection and use Proximity Join to create the room association that's required for grouping.

## Symptoms

You see one or more of the following behaviors:

- A user joins a Microsoft Teams meeting from a laptop while they're in a meeting room.
- The user selects **Room Audio** instead of PC audio.
- The user expects to appear under the Teams Rooms device in the meeting roster.
- The user remains listed as a separate participant instead of appearing in the room grouping.
- The Teams Rooms device appears in the room grouping, but the laptop participant doesn't.

## Cause

This behavior occurs when no BLE-based room association exists between the laptop and the Microsoft Teams Rooms device.

Selecting **Room Audio** manually doesn't create the physical room association that's required for roster grouping. To appear in the room grouping, the laptop must detect the room through BLE and join by using Proximity Join.

If Bluetooth is off, or if the client doesn't detect nearby rooms, Proximity Join can't establish the room association.

## Resolution

Use the following steps to verify BLE proximity detection and join the room correctly.

1. On the user's laptop, open Bluetooth settings, and make sure that Bluetooth is turned on.

1. Open Microsoft Teams, join or start the meeting, and check whether **Nearby Rooms** appears.

1. If the room appears through proximity detection, select the prompt to join the meeting and add the room, such as **Join and add this room**.

1. Confirm that the participant now appears within the Teams Rooms participant grouping in the meeting roster.

1. If **Nearby Rooms** doesn't appear, verify that the Microsoft Teams Rooms device is online and that its Bluetooth beacon is available.

1. Test with another user or device in the same room. If another participant joins by using Proximity Join and groups correctly, compare that result with the affected user's join method and Bluetooth state.

1. If Bluetooth is on but Teams still doesn't detect nearby rooms, collect client and room device details, and continue troubleshooting the endpoint and room device Bluetooth configuration.

> [!NOTE]
> Manual room selection with **Room Audio** but without a BLE proximity association doesn't place the participant in the Teams Rooms roster grouping. This behavior is expected.

## More information

- BLE stands for Bluetooth Low Energy.
- Proximity Join uses BLE to detect nearby Microsoft Teams Rooms devices and associate the participant with the room.
- If the user manually searches for and selects a room instead of joining through proximity detection, the participant can remain separate from the room grouping.
- If you need to investigate further, review the Bluetooth state on the user's device, confirm whether **Nearby Rooms** appears in Teams, and verify that the room device is broadcasting its Bluetooth beacon.

No additional information is available.