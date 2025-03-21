---
title: Notifications for Incoming Messages During Active Sessions
description: Solves an issue where notifications for incoming messages during active sessions not functioning.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/20/2025
ms.custom: sap:Dynamics 365 Contact Center\Voice channel
---
# Notifications for incoming messages during active sessions not functioning

This article provides guidance on resolving issues where notifications for incoming messages during active live chat sessions aren't functioning as expected. Notifications work for new chats but fail to play during ongoing conversations.

## Symptoms

You might not receive notifications for incoming messages during active live chat sessions.

## Cause

This behavior is by design. The notification sound for incoming messages only is played when the conversation tab is hidden. If the tab is visible, the notification doesn't occur.

### Resolution

To solve this issue,

1. Ensure that sound notifications for live chat and incoming messages are enabled in the system settings. Check that sound notifications are configured for open sessions.

1. Ensure your browser's audio isn't muted or restricted. Verify that the correct output device is selected for sound playback.

1. Navigate to the sound record settings in the live chat configuration. Confirm that the sound file is uploaded and properly linked to the sound record.

For detailed instructions, see [Enable sound notifications for conversations in Omnichannel for Customer Service](/dynamics365/customer-service/administer/enable-sound-notifications).
