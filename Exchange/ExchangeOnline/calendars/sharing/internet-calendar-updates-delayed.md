---
title: Subscribed Internet Calendar updates are delayed or initially incomplete
description: Understand polling and staged synchronization when a subscribed Internet Calendar updates slowly or doesn't initially contain every published event.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid:
  - MET150
appliesto:
  - Exchange Online
ms.date: 11/25/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Subscribed Internet Calendar updates are delayed or initially incomplete

## Summary

This article explains why a subscribed Internet Calendar can update slowly or can be incomplete at first. It describes how to distinguish a one-time import from a live subscription, check the published feed, and assess synchronization progress before contacting Microsoft Support.

## Symptoms

You experience one or more of the following symptoms:

- The published calendar changes before the subscribed calendar does.
- A new subscription contains only some events.
- A calendar imported once from an ICS file doesn't show later changes from the publisher.
- Support diagnostics include the following error message:

  ```text
  Deadline expired before processing folder
  ```

## Cause

- If subscription updates are delayed, the issue might be due to the subscribing service which controls when it polls the published URL. A browser's HTML calendar view is an on-demand snapshot and doesn't determine the subscription polling schedule.
- If the initial synchronization is incomplete, the issue occurs when the service processes a large calendar across multiple sessions.
- If a one-time import doesn't update, the issue might occur because a calendar that is imported once from an ICS file isn't a live subscription and doesn't receive later updates.

## Resolution

1. Confirm whether the affected user subscribed to an ICS URL or imported the file just once. If the user needs ongoing updates, subscribe to the publisher's current ICS feed.
1. Add a nonsensitive test event at the publisher. Confirm that the event appears after the subscriber retrieves the feed, and later changes appear as well. 
1. If the event doesn't appear, check the published feed to confirm that it contains the expected event and date range.
1. Wait for the subscribing service to retrieve updates. If another provider hosts the subscription, ask that provider about its polling behavior. Changing an Exchange calendar permission doesn't change the other provider's refresh interval.
1. For a large calendar, check whether later synchronization sessions continue to add events. Don't repeatedly re-create a subscription that is still making progress. The first session might not populate a large calendar completely.
1. If no further progress occurs, [check endpoint access](internet-calendar-subscription-fails.md) and [check the calendar file size](calendar-import-fails.md). After you correct an endpoint or file-size issue, retry retrieval and confirm that the specific missing event arrives.

### If the issue persists

If the event still doesn't arrive, [contact Microsoft Support](/microsoft-365/admin/get-help-support) and provide the following information:

- The publisher and receiver identities
- A specific missing event
- The subscription name
- The exact error, if available
- The observation times, including the time zone
