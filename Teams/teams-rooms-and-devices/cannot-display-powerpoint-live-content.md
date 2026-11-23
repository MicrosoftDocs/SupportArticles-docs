---
title: Teams Rooms can't display PowerPoint Live content
description: Describes a Microsoft Teams Rooms issue in which PowerPoint Live shows a content display error and provides a fix.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
ms.date: 10/28/2026
---

# Teams Rooms can't display PowerPoint Live content

## Summary

This article describes an issue in which Microsoft Teams Rooms for Windows can't display PowerPoint Live content that is shared from Microsoft Teams or by using the **Present in Teams** option in Microsoft PowerPoint. The article also provides steps to resolve the issue.

## Symptoms

When a meeting attendee shares a PowerPoint presentation by using PowerPoint Live in a meeting, the meeting continues normally, but the room display shows an error message instead of the presentation.

You see an error message similar to the following on the Teams Rooms device:

> Can't display content. There was a problem displaying the content.

This behavior can occur when a meeting attendee:

- shares a recent PowerPoint presentation from the **Share** menu in Teams.
- uses the **Present in Teams** option from PowerPoint.

## Cause

This issue occurs because the network that the Teams Rooms device is using doesn't allow access to required Microsoft 365 content delivery endpoints, including `*.cdn.office.net`. PowerPoint Live in Teams Rooms depends on access to Microsoft 365 web endpoints in addition to the core Teams endpoints. If those additional endpoints aren't reachable, the room display might fail to load shared PowerPoint content even though other meeting features continue to work.

## Resolution

Make sure that the network used by the Microsoft Teams Rooms for Windows device allows the required Microsoft 365 endpoints for Teams and Office content.

1. Review the Microsoft 365 URLs and IP address ranges for Teams:
   [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges)
1. Review the additional Microsoft 365 common and Office Online endpoints that are required for PowerPoint Live and related content experiences:
   [Microsoft 365 common and Office Online endpoints](/microsoft-365/enterprise/microsoft-365-u-s-government-gcc-high-endpoints#microsoft-365-common-and-office-online)
1. Allow the required endpoints on your network, including `*.cdn.office.net`.
1. Restart the Teams Rooms device, and then test PowerPoint Live again in a meeting.

> [!NOTE]
> If the required network endpoints are blocked, then updating device firmware, updating the Teams Rooms app, resetting the device, and verifying a 1080p display resolution with 100% scaling won't resolve this issue.
