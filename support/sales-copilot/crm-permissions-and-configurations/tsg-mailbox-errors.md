---
title: Fix mailbox errors in Dynamics 365
description: Resolves the fix mailbox errors in Dynamics 365 error that might occur when you try to save an email or a meeting to Dynamics 365 using Microsoft Copilot for Sales in Outlook.
ms.date: 12/25/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# "Fix mailbox errors in Dynamics 365" error occurs when saving an email or a meeting

This article helps you troubleshoot and resolve the "Fix mailbox errors in Dynamics 365" error in Microsoft Copilot for Sales in Outlook.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | All users   |

## Symptoms

When you open Copilot for Sales in Outlook, and try to save an email or a meeting to Dynamics 365, you see the following error message:

> Fix mailbox errors in Dynamics 365

:::image type="content" source="media/tsg-mailbox-errors/tsg-mailbox-error.png" alt-text="Fix mailbox errors.":::

## Cause

One or more sync errors have occurred with server-side synchronization.

Copilot for Sales requires server-side synchronization to synchronize emails and meetings to Dynamics 365. When the server-side synchronization encounters an error while attempting the synchronization, Copilot for Sales detects and displays this error message for the user to take action and resolve the error.

## Resolution

To resolve the error, you must locate the specific error as part of the mailbox alert wall, read the description, and take action. User can also delete the error to suppress it.

1. Open the CRM instance you connected to Copilot for Sales.

    > [!NOTE]
    > To get the CRM instance URL, select **Options** (**…**) in the upper-right corner of the Copilot for Sales pane. The URL is displayed under **Signed in to Dynamics 365**.

2. Select **Settings** > **Personalization Settings**.

    :::image type="content" source="media/tsg-mailbox-errors/tsg-disabled-mailbox1.png" alt-text="Personalization settings":::

3. Select the **Email** tab, and then select **View your Mailbox**.

    :::image type="content" source="media/tsg-mailbox-errors/tsg-disabled-mailbox2.png" alt-text="Email tab":::

4. Select **Alerts** in the left pane, and then select **Errors** to see errors related to the mailbox.

    :::image type="content" source="media/tsg-mailbox-errors/tsg-mailbox-error1.png" alt-text="See alerts related to the mailbox.":::

    Each error has a description and a link to the article that helps you resolve the error. You can also delete the error to suppress it.

    :::image type="content" source="media/tsg-mailbox-errors/tsg-mailbox-error2.png" alt-text="Delete an error from Alerts tab.":::

    > [!NOTE]
    > Deleting an error resets the mailbox state. The error might reappear during the next synchronization if the underlying issue isn't resolved.

5. Resolve and clear errors to restore the save to CRM functionality in Copilot for Sales.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
