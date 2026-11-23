---
title: Collect a browser trace for free/busy lookups in Outlook on the web
description: Capture, inspect, and safely share a browser network trace for one Outlook on the web Scheduling Assistant availability lookup.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel, shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
appliesto:
  - Exchange Online
  - Outlook on the web
search.appverid: MET150
ms.date: 11/12/2026
ai-usage: ai-assisted
---

# Collect a browser trace for free/busy lookups in Outlook on the web

## Summary

To diagnose availability issues with any client, you need to capture the HAR trace from the availability lookup in Outlook on the web. The capture in Outlook on the web records the raw error from the server better than any other client. Use Microsoft Edge DevTools to capture the network activity for the availability lookup. Keep the reproduction to one requester and one target so that you can correlate the observed result with the trace.

A trace provides evidence for an investigation but collecting it doesn't repair an availability problem. The procedure described in this article captures an availability lookup in Scheduling Assistant, not during the process of opening a shared calendar.

## Before you begin

Identify the following information:

- The requester who can't see availability.
- The target attendee or room whose availability you're checking.
- The mailbox location and organization for each user.
- The meeting date range that reproduces the issue.
- The observed result or exact error message.

Ask the requester to reproduce the lookup while signed in to their own mailbox. Don't ask them to share their password or authentication tokens.

> [!CAUTION]
> A HAR file can contain identities, calendar information, and authentication data. A sanitized export removes sensitive headers but doesn't remove all sensitive information from request or response bodies. Review the file before sharing it, and don't upload it to public forums or online trace-analysis services.

## Capture one availability lookup

1. In Microsoft Edge, sign in to Outlook on the web as the requester, and open **Calendar**.
1. Press **F12** to open DevTools, and select **Network**. For the available controls, see the [Network tool reference](/microsoft-edge/devtools/network/reference).
1. Confirm that network recording is active, and clear the existing request list immediately before reproducing the lookup.
1. In Outlook on the web, create a new event, open **Scheduling Assistant**, and select the affected date and time range.
1. Add only the target attendee or room. Wait for the availability result or error to appear, and record the reproduction time with its time zone.
1. Stop network recording. Record the observed result without sending the meeting invitation.
1. In DevTools, select **Export HAR (sanitized)**. Save the file locally. For the current export controls, see [Save all network requests to a HAR file](/microsoft-edge/devtools/network/reference#save-all-network-requests-to-a-har-file).

Keep the complete recording for the short reproduction. Filtering the display isn't a way to remove sensitive information from the saved trace.

## Inspect the captured requests

1. In **Network**, select **Import HAR file** to open a saved trace, or continue with the requests already captured. For the import controls, see [Import a HAR file into DevTools](/microsoft-edge/devtools/network/reference#import-a-har-file-into-devtools-for-analysis).
1. Locate requests recorded when you added the target. Use the reproduction time and the request data to correlate the lookup. If you can't confidently identify the request, keep the short recording intact rather than discarding requests.
1. Select the target attendee or room request, and inspect its **Payload** and **Response** tabs. Where present, compare the attendee and time-range data with the lookup you reproduced.
1. Record the returned error text and the HTTP status. An HTTP success status alone doesn't establish that the availability lookup succeeded; also compare the response and the result shown in Scheduling Assistant.
1. Keep the requester, target, time range, reproduction time, and exact error together with the trace so the investigation uses the same lookup.

For these inspection controls, see [View request payload](/microsoft-edge/devtools/network/reference#view-request-payload-query-string-parameters-and-form-data) and [Display a response body](/microsoft-edge/devtools/network/reference#display-a-response-body).

## Share evidence safely

Review the trace for personal information and secrets even if you used the sanitized export. Don't include passwords, authentication tokens, or unrelated calendar content in an accompanying description.

If Microsoft Support requests the trace, transfer it through your [Microsoft Support request](/microsoft-365/admin/get-help-support), together with the reproduction details. Don't post the file or raw request and response data publicly.
