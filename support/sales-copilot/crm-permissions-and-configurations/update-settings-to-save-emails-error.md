---
title: Can't save email to CRM due to invalid mailbox settings
description: Resolves an error that occurs in Microsoft Copilot for Sales due to invalid mailbox settings in Microsoft Dynamics 365.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Can't save an email to CRM due to invalid mailbox settings

This article helps you troubleshoot and resolve an error message that occurs in Microsoft Copilot for Sales due to a disabled mailbox in Microsoft Dynamics 365.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

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

When you open Copilot for Sales in Outlook and try to save an email or a meeting to CRM, you see the following error message:

> Update settings to save emails

:::image type="content" source="media/update-settings-to-save-emails-error/change-mailbox-settings-start-saving.png" alt-text="Screenshot that shows the Update settings to save emails error.":::

## Cause

This error occurs when the user's mailbox is disabled or the mailbox is missing a server profile.

## Resolution

1. Open the CRM instance you connected to Copilot for Sales.

    > [!NOTE]
    > To get the CRM instance URL, go to the [Home tab](/microsoft-sales-copilot/personal-app#home-tab) in the Copilot for Sales personal app in [Outlook](/microsoft-sales-copilot/personal-app#open-the-personal-app-in-outlook) or [Teams](/microsoft-sales-copilot/personal-app#open-the-personal-app-in-teams), and select the environment name in the upper-right corner.

2. Select **Settings** > **Personalization Settings**.

    :::image type="content" source="media/update-settings-to-save-emails-error/personalization-settings.png" alt-text="Screenshot that shows the Personalization Settings option.":::

3. Select the **Email** tab, and then select **View your Mailbox**.

    :::image type="content" source="media/update-settings-to-save-emails-error/view-your-mailbox.png" alt-text="Screenshot that shows the View your Mailbox option under the Email tab." lightbox="media/update-settings-to-save-emails-error/view-your-mailbox.png":::

4. Under **Synchronization Method**, ensure a value is selected for **Server Profile**. If not, select **Microsoft Exchange Online**.

    :::image type="content" source="media/update-settings-to-save-emails-error/server-profile-value.png" alt-text="Screenshot that shows the value selected for a server profile.":::

5. In the ribbon, select **Activate** if it's available.

    :::image type="content" source="media/update-settings-to-save-emails-error/activate-mailbox.png" alt-text="Screenshot that shows how to activate a mailbox.":::

    > [!NOTE]
    > To see any errors or warnings related to the server-side synchronization, select **Alerts** in the left pane. Each alert has a link to more information about the issue and how to resolve it.

6. Select **Save & Close**.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
