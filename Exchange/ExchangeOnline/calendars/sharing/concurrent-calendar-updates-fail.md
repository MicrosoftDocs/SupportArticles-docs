---
title: Concurrent shared calendar changes fail with the RemoteUpdateFailedException error
description: Investigate the RemoteUpdateFailedException error when multiple users simultaneously create, update, or cancel events in the same shared calendar.
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
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Concurrent shared calendar changes fail with the RemoteUpdateFailedException error

## Summary

This article describes shared-calendar operations that fail with the `RemoteUpdateFailedException` error when multiple users make changes at the same time. It explains how to check which changes were saved and what evidence to collect before contacting Microsoft Support.

## Symptoms

- Two or more users create, update, or cancel shared-calendar events at the same time.
- Some operations fail with the `RemoteUpdateFailedException` error.
- The owner and editors might initially see different results.

## Cause

The exception identifies a failed remote update but doesn't establish why the operation failed. Microsoft Support must investigate the affected requests to determine the cause.

## Report the issue to Microsoft Support

Collect the following information, and then [contact Microsoft Support](/microsoft-365/admin/get-help-support). These steps don't correct the failed update.

1. Check the affected event in the owner's calendar in Outlook on the web before you repeat an operation. Determine which change, if any, was saved.
1. Record the participating users, affected calendar, exact exception, operation times with time zone, and clients or devices.
1. [Collect calendar diagnostic logs](../cdl/get-calendar-diagnostic-logs.md) for the owner and affected editors by using the same meeting ID.
1. Contact Microsoft Support, and provide the information. Don't reset permissions or recreate the calendar to try to resolve concurrent-write failures.
