---
title: Fix mailbox errors in Dynamics 365
description: Troubleshoot and resolve  mailbox errors in Dynamics 365.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Fix mailbox errors in Dynamics 365

This article helps you troubleshoot and resolve mailbox errors in Dynamics 365.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | All users   |

## Symptom

When you open Sales Copilot in Outlook, and try to save an email or a meeting to Dynamics 365, you see the following error message: Fix mailbox errors in Dynamics 365:

:::image type="content" source="media/tsg-mailbox-error.png" alt-text="Fix mailbox errors.":::

## Cause

One or more sync errors have occurred with server-side synchronization.

Sales Copilot requires server-side synchronization to synchronize emails and meetings to Dynamics 365. When server-side synchronization encounters an error while attempting the synchronization, Sales Copilot detects and displays this error message for the user to take action and resolve the error.

## Solution

To resolve the error, you must locate the specific error as part of the mailbox alert wall, read the description, and take action. User can also delete the error to suppress it.

1. Open the CRM instance you connected to Sales Copilot.

    > [!NOTE]
    > To get the CRM instance URL, select **Options** (**…**) in the upper-right corner of the Sales Copilot pane. The URL is displayed under **Signed in to Dynamics 365**.

2. Select **Settings** > **Personalization Settings**.

    :::image type="content" source="media/tsg-disabled-mailbox1.png" alt-text="Personalization settings":::

3. Select the **Email** tab, and then select **View your Mailbox**.

    :::image type="content" source="media/tsg-disabled-mailbox2.png" alt-text="Email tab":::

4. Select **Alerts** in the left pane, and then select **Errors** to see errors related to the mailbox.

    :::image type="content" source="media/tsg-mailbox-error1.png" alt-text="See alerts related to the mailbox.":::

    Each error has a description and a link to the article that helps you resolve the error. You can also delete the error to suppress it.

    :::image type="content" source="media/tsg-mailbox-error2.png" alt-text="Delete an error from Alerts tab.":::

    > [!NOTE]
    > Deleting an error resets the mailbox state. The error might reappear during the next synchronization if the underlying issue is not resolved.

5. Resolve and clear errors to restore the save to CRM functionality in Sales Copilot.

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
