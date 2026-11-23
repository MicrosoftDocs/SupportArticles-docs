---
title: Sign-in delays on Teams Android devices when you use Entra ID dynamic device groups
description: Describes why Teams Android devices can require multiple sign-in attempts when Intune compliance policies target Entra ID dynamic device groups, and how to fix the issue.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams
ms.reviewer: joshj, iztoth, taherr, gurug, miaitelh
ms.date: 10/19/2026
---

# Sign-in delays on Teams Android devices when you use Entra ID dynamic device groups

## Summary

This article describes how to resolve sign-in delays on Teams Android devices when Intune compliance policies target Microsoft Entra ID dynamic device groups.

## Symptoms

On Teams Android devices, sign-in doesn't complete on the first attempt. Instead, you might see one or more sign-in failures before the device signs in successfully.

Typically, the devices are able to sign-in successfully only after the third or fourth attempt.

## Cause

This issue occurs when you use a Microsoft Entra ID dynamic device group to collect Teams Android device objects, and then use that same group as the assignment group for an Intune compliance policy.

In this configuration, the device object needs time to be created and added to the dynamic device group. During that time, Conditional Access and Intune check whether the device is compliant. If those checks happen before group membership finishes updating, sign-in can fail until the replication completes.

This issue affects only Teams Android devices that use the specific combination of Microsoft Entra ID dynamic device groups, Intune compliance policies, and Conditional Access evaluation during sign-in. For related information, see [Moving Teams Android Devices to AOSP Device Management](https://techcommunity.microsoft.com/blog/microsoftteamssupport/moving-teams-android-devices-to-aosp-device-management/4140893).

## Resolution

To avoid the sign-in delay, don't use a dynamic device group as the assignment target for the Intune compliance policy that applies to these devices. Instead, use a dynamic user group or another group type that contains user accounts for the Intune compliance policy assignment.

1. Open the Microsoft Intune admin center.
1. Go to **Devices** > **Compliance policies**.
1. Find the compliance policy that applies to your Teams Android devices.
1. Review the policy assignments.
1. If the policy is assigned to a Microsoft Entra ID dynamic device group, change the assignment to a dynamic user group or another user-based group.
1. Save the policy changes.
1. Try signing in to the device again.

> [!NOTE]
> After you change the compliance policy assignment, allow time for policy and directory changes to apply across your environment.
