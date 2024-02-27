---
title: Could not get delegate information form the server error
description: You receive a Could not get delegate information form the server error when make changes to delegate settings. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook for Mac error Could not get delegate information from the server

_Original KB number:_ &nbsp; 2742644

## Symptoms

In Outlook 2016 for Mac or Outlook for Mac 2011, you open **Tools** > **Accounts** > **Advanced** > **Delegates**, and you see the following error:

> Could not get delegate information form the server. Please try again later.

:::image type="content" source="media/could-not-get-delegate-information-from-the-server-error/error-details.png" alt-text="Screenshot of the Could not get delegate information form the server error." border="false":::

When this error occurs, you cannot make any changes to your delegate settings or view your current delegates.

## Cause

This issue can occur when there is an invalid user who was added as a delegate, such as a user account that was removed from your organization.

## Resolution

Remove this invalid user account from your delegates in Outlook for Windows.

1. Configure your user account in Outlook for Windows, such as Outlook 2010 or 2013.
2. On the **File** tab, select **Account Settings** > **Delegate Access**.
3. Look for a delegate who displays **(Not Found)**.
4. Select this invalid delegate, then select **Remove**.

   :::image type="content" source="media/could-not-get-delegate-information-from-the-server-error/remove-delegate-who-show-not-found.png" alt-text="Screenshot of the Delegate access dialog box." border="false":::
