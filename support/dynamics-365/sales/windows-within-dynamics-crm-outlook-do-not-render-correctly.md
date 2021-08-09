---
title: Windows within CRM Outlook client do not render properly
description: Microsoft Dynamics CRM windows within the Microsoft Dynamics CRM for Microsoft Office Outlook client don't render completely when the zoom level for the system display is great than 100%. Provides a resolution.
ms.reviewer: jowells
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Windows within the Microsoft Dynamics CRM Outlook client do not render properly

This article provides a resolution for the issue that Microsoft Dynamics CRM windows within the Microsoft Dynamics CRM for Microsoft Office Outlook client don't render completely when the zoom level for the system display is great than 100%.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 2908799

## Symptoms

Microsoft Dynamics CRM windows within the Microsoft Dynamics CRM for Outlook client don't render correctly when the zoom level for the system display is great than 100%.

## Cause

The Microsoft Dynamics CRM windows are a defined sized. When the zoom is increased, the text gets expanded within the window but the window doesn't resize.

## Resolution

To solve this issue, set the Display zoom back to 100% by following these steps:

1. On a client machine with the CRM Outlook client configured, select **Control Panel**.
2. Select **Appearance and Personalization**.
3. Select **Display**.
4. Select **Smaller - 100%**.
5. Select **Apply**.
6. Sign out of the workstation.
7. Sign in back on the workstation.

## More information

The biggest issue this shows up for are Look Up windows. For instance, when a user is creating an email within Outlook with the Microsoft Dynamics CRM for Outlook add-in enabled, they can select **Set Regarding**. After doing that, the lookup window pops up and the Look For drop-down is now missing.
