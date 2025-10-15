---
title: Fix mailbox errors in Dynamics 365
description: Resolves an error that might occur when you try to save an email or a meeting to Dynamics 365 using the Sales app in Outlook.
ms.date: 03/26/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# "Fix mailbox errors in Dynamics 365" error occurs when saving an email or a meeting

This article helps you troubleshoot and resolve the "Fix mailbox errors in Dynamics 365" error when you use Sales app in Outlook.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales app in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | All users   |

## Symptoms

When you open Sales app in Outlook and try to save an email or a meeting to Microsoft Dynamics 365, you see the following error message:

> Fix mailbox errors in Dynamics 365

:::image type="content" source="media/fix-mailbox-errors-in-dynamics-365/fixed-mailbox-errors.png" alt-text="Screenshot that shows the Fix mailbox errors in Dynamics 365 error that occurs during server-side synchronization.":::

## Cause

This issue occurs because one or more sync errors occur in server-side synchronization.

Sales app requires server-side synchronization to synchronize emails and meetings to Dynamics 365. When server-side synchronization encounters an error while attempting the synchronization, Sales app detects and displays this error message for you to take action and resolve the error.

## Resolution

To resolve the error, you must locate the specific error as part of the mailbox alert wall, read the description, and take action. You can also delete the error to suppress it.

1. Open the CRM instance you connected to Sales app.

    > [!NOTE]
    > - To get the CRM instance URL, go to the [Home tab](/microsoft-sales-copilot/personal-app#home-tab) in the Sales personal app in [Outlook](/microsoft-sales-copilot/personal-app#open-the-personal-app-in-outlook) or [Teams](/microsoft-sales-copilot/personal-app#open-the-personal-app-in-teams), and select the environment name in the upper-right corner.
    > - Ensure that you're connected to the correct production environment.

2. Select **Settings** > **Personalization Settings**.

    :::image type="content" source="media/fix-mailbox-errors-in-dynamics-365/personalization-settings.png" alt-text="Screenshot that shows the Personalization Settings option.":::

3. Select the **Email** tab, and then select **View your Mailbox**.

    :::image type ="content" source="media/fix-mailbox-errors-in-dynamics-365/view-your-mailbox-under-email.png" alt-text="Screenshot that shows the View your Mailbox option under the Email tab." lightbox="media/fix-mailbox-errors-in-dynamics-365/view-your-mailbox-under-email.png":::

4. Select **Alerts** in the left pane, and then select **Errors** to see errors related to the mailbox.

    :::image type="content" source="media/fix-mailbox-errors-in-dynamics-365/errors-in-alerts.png" alt-text="Screenshot that shows the errors related to the mailbox."  lightbox="media/fix-mailbox-errors-in-dynamics-365/errors-in-alerts.png":::

    Each error has a description and a link to an article that helps you resolve the error. You can also delete the error to suppress it.

    :::image type="content" source="media/fix-mailbox-errors-in-dynamics-365/error-details-delete.png" alt-text="Screenshot that shows the details of an error and how to delete an error from the Alerts tab.":::

    > [!NOTE]
    > Deleting an error resets the mailbox state. The error might reappear during the next synchronization if the underlying issue isn't resolved.

5. Resolve and clear errors to restore the save to CRM functionality in Sales app.

## More information

If your issue is still unresolved, go to the [Sales solution in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
