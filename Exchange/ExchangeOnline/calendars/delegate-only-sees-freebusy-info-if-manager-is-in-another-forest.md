---
title: Delegate only sees free/busy if manager in another forest
description: Describes an issue that causes a delegate to only see free/busy information in OWA when the manager is in another forest during coexistence.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, mhaque, v-six
appliesto: 
  - Outlook on the web (OWA)
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Delegate can only see free/busy information in OWA when manager is in another forest during coexistence

_Original KB number:_ &nbsp; 4089865

## Symptoms

Consider the following scenario:

- A delegate creates a calendar item for a manager who is in a different forest.
- The delegate has been granted Reviewer or Editor permissions.

In this scenario, the delegate can only see free/busy information of the calendar in OWA. Also, calendar item details are not displayed, and the delegate cannot create an item on the calendar.

:::image type="content" source="media/delegate-only-sees-freebusy-info-if-manager-is-in-another-forest/calendar.png" alt-text="Screenshot of Calendar image for Delegation Test 1.":::

## Cause

This issue occurs because the delegate and manager may not have been moved to the cloud at the same time. OWA can only display calendar data through the organization relationship or sharing policy. Specific permissions that are granted to a delegate are not honored in OWA.

## Resolution

To resolve this issue, the delegate should use the Outlook for Windows client to view full calendar details.

If the delegate is grantedFull Access permissions to the manager's mailbox, the delegate can sign in to the calendar by using an explicit URL, such as `https://Target_User_OWA_URI/owa/Target_User_SMTP_Address/?path=/calendar`.
