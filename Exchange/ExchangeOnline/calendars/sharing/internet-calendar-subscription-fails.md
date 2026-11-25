---
title: Internet Calendar subscription fails or the subscribed calendar folder is missing
description: Check a published ICS URL, anonymous reachability, TLS configuration, and the subscription folder when an Internet Calendar can't be added or opened.
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
  - Outlook on the web
ms.date: 11/25/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Internet Calendar subscription fails or the subscribed calendar folder is missing

## Summary

This article explains how to verify the published ICS endpoint and the receiver's subscription when you can't add, open, or synchronize an Internet Calendar.

## Symptoms

You experience one or more of the following symptoms:

- Adding a calendar from a URL fails.
- The URL works only after sign-in or only on the organization's network.
- The subscribed calendar folder is missing.
- A subscription that worked before no longer retrieves events.

## Cause

- If a subscription can't be added or no longer retrieves events, the cause of the issue might be that an internal URL, an authentication requirement, an invalid or outdated endpoint, or an incompatible TLS certificate configuration prevent the retrieval. Internet Calendar subscriptions require a reachable anonymous endpoint. A URL that works in a browser doesn't prove that service-side retrieval succeeds.
- If a subscribed calendar folder is missing, the subscription's destination folder might have been deleted. Even if publishing is enabled on the owner's calendar, it doesn't prove that the receiver has a current subscription.

## Resolution

1. Get the current ICS URL from the publisher. Don't use the HTML URL, which is for browser viewing and isn't the subscription feed. Keep the complete path and query string unchanged.
1. Test the ICS URL without an authenticated session. Confirm that it downloads a calendar file and not a sign-in page or an HTML error page.
1. If access requires an intranet connection or authentication, ask the publisher for an Internet-accessible anonymous endpoint. Internet Calendar subscriptions don't support internal or intranet URLs.
1. Ask the publisher to verify HTTPS availability and certificate validity, trust, and compatibility. Don't bypass certificate validation.
1. If the publisher uses Exchange Online, [check that publishing is enabled](calendar-publish-option-missing.md) and that the supplied URL matches the current calendar.
1. After the publisher corrects an endpoint, certificate, or publishing problem, retry the same ICS subscription. Confirm that the calendar folder appears and retrieves the expected events.
1. If the issue isn't resolved, confirm that the receiver is opening the intended subscription folder. If the folder is missing, add the current ICS subscription again. Don't delete similarly named folders on the assumption that they're stale.
1. Confirm that the replacement subscription folder exists and receives a new, nonsensitive test event after a subscription refresh.

### If the issue persists

If retrieval still fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support) and provide the following information:

- The publisher and the receiver
- The subscription name
- The failure time, including the time zone
- The exact error
- The subscription URL

Provide the subscription URL only in the support request. Don't post it publicly.

If the subscription works but updates are slow, see [Subscribed Internet Calendar updates are delayed or initially incomplete](internet-calendar-updates-delayed.md).
