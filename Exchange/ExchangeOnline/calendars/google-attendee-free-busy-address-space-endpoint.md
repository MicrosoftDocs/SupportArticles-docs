---
title: Google attendee availability fails when the availability address space is incorrect
description: Check the availability address space and Google endpoint when Exchange Online users can't retrieve Google Workspace availability through Calendar Interop.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel,shanefe
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
  - Outlook for Windows
search.appverid: MET150
ms.date: 11/09/2026
ai-usage: ai-assisted
---
# Google attendee availability fails when the availability address space is incorrect

## Summary

Use this article when Exchange Online initiates a Google Calendar Interop lookup and the Google availability address space is missing or points to an incorrect endpoint. Successful requests in the reverse direction don't validate this configuration.

## Symptoms

You select a Google Workspace mail contact in Outlook Scheduling Assistant, but no availability is returned. The availability address space for the Google domain is absent, its domain doesn't match the configured Google availability domain, or its Autodiscover endpoint differs from the vendor's configuration.

## Cause

Calendar Interop uses an availability address space to direct Exchange-initiated requests to Google. A missing address space or an incorrect domain or endpoint prevents Exchange from following that route.

## Resolution

First confirm that the Google user resolves to the intended Exchange mail contact. Then review the configuration with the Google Workspace administrator.

1. In Exchange Online PowerShell, use [Get-AvailabilityAddressSpace](/powershell/module/exchangepowershell/get-availabilityaddressspace) to inspect existing routes:

   ```powershell
   Get-AvailabilityAddressSpace |
       Format-List ForestName,AccessMethod,TargetAutodiscoverEpr
   ```

1. Compare `ForestName` with the Google availability domain selected during Calendar Interop setup. If you use a user alias domain, compare against that domain rather than assuming that the primary mail domain is the correct route.
1. Compare `TargetAutodiscoverEpr` with the Google endpoint documented for this configuration:

   ```text
   https://calendar.google.com/autodiscover/autodiscover.xml
   ```

1. If the route is missing or incorrect, have the Google administrator generate the Exchange configuration through **Calendar Interop management**, as described in [Set up Calendar availability sharing](https://knowledge.workspace.google.com/admin/sync/allow-exchange-users-to-see-calendar-availability-data). Review the generated configuration before applying it to the correct Exchange organization. Preserve unrelated availability address spaces.
1. Use the existing approved role-account credentials for this deployment. Generating new Google credentials revokes that account's previous credentials, so coordinate any credential replacement across the deployment. Don't include credentials in a support attachment.

This procedure addresses the Exchange-initiated EWS SOAP connection to Google. It doesn't configure Google-to-Exchange authentication or migrate Microsoft 365-to-Microsoft 365 sharing to Graph-based policies.

### Verify the resolution

Review the address space again, and then request the same Google attendee's availability in a new meeting. Use [Google's availability setup verification](https://knowledge.workspace.google.com/admin/sync/verify-the-user-availability-setup) to investigate any remaining connection error. Test the reverse direction separately.

## More information

- [Google Calendar Interop configuration](https://knowledge.workspace.google.com/admin/sync/allow-exchange-users-to-see-calendar-availability-data)
