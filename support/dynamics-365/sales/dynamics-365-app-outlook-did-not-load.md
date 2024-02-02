---
title: Dynamics 365 App for Outlook didn't load and window.Office not available
description: Provides a solution to an error that occurs when trying to use the Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Dynamics 365 App for Outlook didn't load completely error occurs in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you try to use the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4567653

## Symptoms

When attempting to use the Dynamics 365 App for Outlook, you see the following error:

> "Dynamics 365 App for Outlook didn't load completely. Please ensure you are connected to internet and restart the add-in."

If you select the **Show more** link, the extra details include the following error:

> "Error: window.Office not available"

## Cause

While loading Dynamics 365 App for Outlook, external script *office.js* might fail to load. Because *office.js* is a required dependency, Dynamics 365 App for Outlook can't start and will show an error.

## Resolution

1. Verify your computer has a connection to the Internet.
2. If you're using Outlook desktop app, follow [Switch from working offline to online](https://support.microsoft.com/office/2460e4a8-16c7-47fc-b204-b1549275aac9) to ensure that you're online.
3. Reload Dynamics 365 App for Outlook.
