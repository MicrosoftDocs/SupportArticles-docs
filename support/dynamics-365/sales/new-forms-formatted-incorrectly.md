---
title: New Forms are formatted incorrectly
description: Provides a solution to an issue where new forms are formatted incorrectly or don't appear when working offline in the Microsoft Dynamics CRM Outlook client.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# New Forms are formatted incorrectly or don't appear when working offline in the Microsoft Dynamics CRM Outlook client after applying the December 2012 Service Update

This article provides a solution to an issue where new forms are formatted incorrectly or don't appear when working offline in the Microsoft Dynamics CRM Outlook client after applying the December 2012 Service Update.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2789573

## Symptoms

After applying the December 2012 Service Update for Microsoft Dynamics CRM Online, users may notice that the new form definitions may experience the following issues when working offline in the Microsoft Dynamics CRM Outlook Client:

1. The new form definitions for Lead, Opportunity, and Case will load in an incorrect format and will be missing the process and tab controls.
2. The new form definitions won't be available to use, and these entities will load with the previous form definition instead.

## Cause

These issues can occur if:

1. The client has installed Update Rollup 12 or later, but is missing the Update Rollup 12 patch for the related MUI packs installed on the system.
2. Update Rollup 12 or later isn't installed on the client or related MUI packs.

## Resolution

To view the new form definitions while working offline, the following conditions must be met:

- The client must have Update Rollup 12 or later installed.
- All MUI packs installed on the client must also have Update Rollup 12 or later installed.

> [!NOTE]
> A base language MUI pack is installed by default upon the initial installation of the Microsoft Dynamics CRM Outlook client. This MUI pack doesn't appear in the Add or Remove programs applet. Users will need to install the Update Rollup 12 patch for the base language MUI pack, as well as any additional MUI packs installed on the system.
