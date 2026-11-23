---
title: New Teams Rooms feature not available
description: Troubleshoot a Microsoft Teams Rooms feature that doesn't appear on one or more devices.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/17/2026
---

# New Teams Rooms feature not available

## Summary

This article helps you troubleshoot a new feature that doesn't appear on one or more Microsoft Teams Rooms for Windows devices. In most cases, the device runs an older app version, uses a license that doesn't support the feature, or has the feature disabled in the XML configuration file.

## Symptoms

You notice that a newly released Microsoft Teams Rooms feature isn't available on one device or across multiple devices.

For example, meeting chat might not appear on a Teams Rooms on Windows device even though the feature is documented in the release notes.

## Cause

This issue can occur for one or more of the following reasons:

- The device runs an older version of the Microsoft Teams Rooms app.
- The resource account uses a license that doesn't support the feature.
- The feature is disabled in the XML configuration file.

## Resolution

1. Check the [Microsoft Teams Rooms release notes](/microsoftteams/rooms/rooms-release-note) to confirm which app version introduces the feature you're looking for.

 1. Verify the app version that's installed on the affected device.

   You can verify the version in one of the following ways:

   - In the Teams admin center, go to **Teams devices** > **Teams Rooms on Windows**, select the device, and then review the software health information.
   - On the device, open **Settings** and review the app version information.
   - If you collect device logs, review the app version information in the Teams Rooms log files.

1. If the installed app version is older than the version that introduces the feature, update the Microsoft Teams Rooms app.

   For manual update steps, see: [Update a Teams Rooms device manually](/microsoftteams/rooms/manual-update)

1. Check which Teams Rooms license the device account uses.

   Many new features require a Teams Rooms Pro license. To review licensing requirements, see: [Microsoft Teams Rooms licenses](/microsoftteams/rooms/rooms-licensing)

   You can verify the assigned license in one of the following ways:

   - In the Teams admin center, go to **Teams devices** > **Teams Rooms on Windows**, and then review the device details.
   - On the device, open **Settings** and review the account or license information.
   - If you collect device logs, review the license information that the device reports.

1. If the feature supports XML-based configuration, check whether the feature is disabled in the XML configuration file.

   For XML configuration settings, see: [Manage a Microsoft Teams Rooms console settings remotely with an XML configuration file](/microsoftteams/rooms/xml-config-file)

1. If the feature is disabled in the XML configuration file, update the setting to enable the feature, and then deploy the updated configuration to the device.

## More information

Some features become available only after a specific Microsoft Teams Rooms app release. Always compare the feature's documented release version with the version that's installed on the device before you investigate licensing or configuration.

For example, the meeting chat feature in Gallery, Large gallery, and Together mode is available only in supported app versions and can also be controlled by the XML configuration setting for meeting chat.

> [!NOTE]
> This article covers Microsoft Teams Rooms for Windows. If you manage other Teams Rooms platforms, review the documentation for the specific platform and feature.

> [!NOTE]
> New features, like "Tap to take notes", will not be added as XML settings. We recommend using the individual and bulk settings configuration options within the Teams Rooms Pro Management Portal instead of the XML configuration.
See [Manage a Microsoft Teams Rooms console settings remotely with an XML configuration file](/microsoftteams/rooms/xml-config-file)
