---
title: Teams Rooms on Windows sign-in fails with UserInteractionRequired
description: Describes Microsoft Teams Rooms on Windows sign-in failures when the resource account requires interactive authentication and provides resolutions to fix them.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
ms.reviewer: joshj, iztoth, taherr, gurug, miaitelh
author: Cloud-Writer
ms.author: meerak
ms.date: 10/19/2026
---

# Teams Rooms on Windows sign-in fails with UserInteractionRequired

## Summary

This article discusses the sign-in failures that occur with Microsoft Teams Rooms on Windows when a resource account requires an interactive authentication step and provides resolutions to fix them. 

## Symptoms

On a Microsoft Teams Rooms on Windows device, the touch console shows an error that says it can't sign in to Microsoft Teams.

You might also find an entry for `UserInteractionRequired` in the Teams app logs from the device.

Microsoft Teams Rooms on Windows can't show interactive sign-in prompts for the resource account. If Microsoft Entra requires a person to select an option, accept Terms of Use, register security information, or complete another interactive step, then sign-in fails.

## Cause

This issue occurs when the resource account requires an interactive authentication step that Teams Rooms on Windows can't complete.

Examples include these requirements:

- Multifactor authentication (MFA)
- Authentication strength
- Terms of Use
- Self-Service Password Reset (SSPR) registration

### Confirm the issue

1. Collect logs from the affected Teams Rooms on Windows device. If the device can't sign in, use local log collection on the device. For more information, see the Microsoft Teams Rooms documentation about collecting logs.
1. Open the Teams app logs in the device log package.
1. Search the logs for `UserInteractionRequired`.
1. Review the resource account's Microsoft Entra configuration and Conditional Access policies to identify which interactive requirement applies.

## Resolution

Apply the fix that's appropriate for the interactive requirement that affects the resource account. For supported Conditional Access and compliance settings for Teams Rooms, see the Microsoft Teams Rooms documentation for supported Conditional Access and compliance policies.

### Fix MFA or authentication strength requirements

Configure trusted named locations in Conditional Access, and then exclude trusted network locations from each Conditional Access policy that requires MFA or authentication strength.
Alternately, exclude the Teams Rooms resource accounts from each Conditional Access policy that requires MFA or authentication strength.

### Fix Terms of Use requirements

Exclude the Teams Rooms resource accounts from each Conditional Access policy that requires Terms of Use.

### Fix Self-Service Password Reset registration requirements

Exclude the Teams Rooms resource accounts from the Microsoft Entra group that's configured for SSPR.
