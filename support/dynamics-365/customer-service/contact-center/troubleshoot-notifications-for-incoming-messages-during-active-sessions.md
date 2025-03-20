---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot notifications for incoming messages during active sessions
description: Troubleshoot notifications for incoming messages during active sessions
---
# Troubleshoot notifications for incoming messages during active sessions

This article provides guidance on resolving issues where users do not receive notifications for incoming messages during active live chat sessions.

## Prerequisites

Ensure the following settings and configurations are applied before proceeding:  

1. Sound notifications are enabled for live chat sessions.
2. Browser audio settings are correctly configured to play sound notifications.
3. The sound file is linked to the sound record and uploaded successfully.

## Potential quick workarounds

### Verify notification settings

1. Confirm sound notifications are enabled for live chat in your configuration settings.
2. Double-check that incoming message notifications are active for ongoing chat sessions.

### Check browser audio settings

1. Ensure your browser's audio is not muted or restricted.
2. Verify that the correct output device is selected for sound playback.

## Troubleshooting checklist

### Check sound file linkage

1. Navigate to the sound record settings in the live chat configuration.
2. Confirm that the sound file is uploaded and properly linked to the sound record.

### Test notifications

1. Open a new chat session and verify if sound notifications are functioning.
2. Hide the conversation tab during an ongoing session to test if notifications are triggered.

## Cause: Notifications for active sessions are by design

The notification sound for incoming messages will only be played when the conversation tab is hidden. If the tab is visible, the notification will not occur.

### Solution: Adjust user workflow

1. Minimize or hide the conversation tab to enable sound notifications during ongoing sessions.
2. Refer to [Enable sound notifications for conversations in Omnichannel for Customer Service | Microsoft Learn](/dynamics365/customer-service/administer/enable-sound-notifications) for detailed configuration instructions.

## Advanced troubleshooting and data collection

If issues persist after applying the steps above:  

1. Collect browser logs and audio settings details.
2. Document the steps taken to configure notifications.
3. Submit a support ticket to Microsoft Customer Service for further assistance.