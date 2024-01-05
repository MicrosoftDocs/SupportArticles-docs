---
title: Add-in update error in Copilot for Sales for Outlook
description: Resolves an error message that repeatedly prompts users to update Microsoft Copilot for Sales add-in for Microsoft Outlook.
ms.date: 01/04/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Add-in update error in Copilot for Sales add-in for Microsoft Outlook

This article helps you troubleshoot and resolve an error message that repeatedly prompts users to update the Microsoft Copilot for Sales add-in for Outlook.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce        |
|**Users**     | All users   |

## Symptoms

When you open the Copilot for Sales pane in Microsoft Outlook, the following error message is displayed:

> **Add-in error:** An update to this add-in is available that requires your review and confirmation to install.

When you select **UPDATE**, the behavior depends on whether you're using Outlook on the web or the desktop app.

:::image type="content" source="media/update-add-in-error/add-in-error.png" alt-text="Screenshot that shows the add-in update error and the UPDATE button.":::

- If you're using Outlook on the web, a new browser window is launched, and you're navigated to the **Copilot for Sales for Microsoft Outlook** screen on the **Add-Ins for Outlook** pop-up window. The error message is still displayed in the new browser window. However, on the original browser window, you can temporarily use Copilot for Sales until the page is refreshed, and you see the original error message.

- If you're using the Outlook desktop app, a subsequent error message is displayed indicating that the add-in is currently upgrading. When you close the **Copilot for Sales** pane and reopen it, Copilot for Sales temporarily works until you close or reopen Outlook, and the error reoccurs.

  :::image type="content" source="media/update-add-in-error/add-in-warning.png" alt-text="Screenshot that shows the add-in warning in the Outlook desktop app.":::

## Cause

Permission changes HAVE occurred in the new Copilot for Sales add-in for Outlook.

Certain permission changes require explicit administrator consent or reinstallation of the Copilot for Sales Outlook add-in. These permission changes are always tied to a recent update to the Copilot for Sales Outlook add-in. You can check when the latest update has been applied to the add-in on the corresponding [App Source Details page](https://appsource.microsoft.com/en-US/product/office/WA200003979?tab=DetailsAndSupport). If you see a recent update to the Copilot for Sales Outlook add-in, the error is likely tied to corresponding permission changes due to the update.

## Resolution

The first step is to identify if the Copilot for Sales Outlook add-in is admin-managed or user-managed. You can take the resolution steps accordingly.

1. Open Outlook (web or desktop).

2. Select **Get Add-Ins** on the **Home** tab in the ribbon.

3. In the **Add-Ins for Outlook** window, check if the **Copilot for Sales for Microsoft Outlook add-in** is listed under the **Admin-managed** section.

    :::image type="content" source="media/update-add-in-error/add-in-admin-managed.png" alt-text="Screenshot that shows the Admin-managed section where you can check if the Copilot for Sales for Microsoft Outlook add-in is listed.":::

4. If the add-in is listed under the **Admin-managed** section, ask your tenant administrator to perform these steps:

    1. In the [Microsoft 365 admin center](https://admin.microsoft.com/), select **Settings** > **Integrated apps**.

    1. On the **Integrated apps** page, select the **Copilot for Sales** app.

        The **Microsoft Copilot for Sales** panel opens.

    1. If the **Update** button is available, select it and follow the prompts to update the add-in.

    1. If the **Update** button isn't available, go to the **Configuration** tab, select **Copilot for Sales for Microsoft Outlook**, and then select **Remove**. Once done, reinstall the Copilot for Sales add-in for Microsoft Outlook. For more information, see [Install Copilot for Sales](/microsoft-sales-copilot/install-viva-sales).

5. If the add-in isn't listed under the **Admin-managed** section, uninstall the add-in from the **My add-ins** section, and reinstall it.

> [!NOTE]
> It can take up to 24 hours for the changes to take effect for end users when deployed through the admin-managed flow.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
