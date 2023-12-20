---
title: Update add-in error in Sales Copilot for Microsoft Outlook
description: Troubleshoot and resolve error message that repeatedly prompts user to update in Sales Copilot add-in for Outlook.
ms.date: 10/31/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Update add-in error in Sales Copilot for Microsoft Outlook

This article helps you troubleshoot and resolve error message that repeatedly prompts user to update in Sales Copilot add-in for Outlook.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce        |
|**Users**     | All users   |

## Symptom

When you open the Sales Copilot pane in Microsoft Outlook, the **An update to this add-in is available that requires your review and confirmation to install** error is displayed.

When you select **Update**, the behavior depends based on whether you're using the Outlook on the web or desktop app.

:::image type="content" source="media/tsg-add-in-error.png" alt-text="Add-in error":::

If you're using Outlook on the web, a new browser window is launched, and you're navigated to the **Sales Copilot for Microsoft Outlook** screen on the **Add-Ins for Outlook** popup window. The error message is still displayed in the new browser window. However, on the original browser window, you can temporarily use Sales Copilot until the page is refreshed, and you see the original error message.

If you're using the Outlook desktop app, a subsequent error message is displayed indicating that the add-in is currently upgrading. When you close the **Sales Copilot** pane and reopen it, Sales Copilot temporarily works until you close or reopen Outlook, and the error reoccurs.

:::image type="content" source="media/tsg-add-in-warning.png" alt-text="Add-in warning on Outlook desktop app":::

## Cause

Permission changes in the new Sales Copilot add-in for Outlook.

Certain permission changes require explicit administrator consent or reinstallation of the Sales Copilot Outlook add-in. These permission changes are always tied to a recent update to the Sales Copilot Outlook add-in. You can check when the latest update has been applied to the add-in on the corresponding [App Source Details page](https://appsource.microsoft.com/en-US/product/office/WA200003979?tab=DetailsAndSupport). If you see a recent update to the Sales Copilot Outlook add-in, it's likely that the error is tied to corresponding permission changes due to the update.

## Solution

The first step is to identify if the Sales Copilot Outlook add-in is admin-managed or user-managed. You can take the resolution steps accordingly. 

1. Open Outlook (web or desktop).

2. Select **Get Add-Ins** on the **Home** tab in the ribbon.

3. In the **Add-Ins for Outlook** window, check if the **Sales Copilot for Microsoft Outlook add-in** is listed under the **Admin-managed** section.

    :::image type="content" source="media/tsg-add-in-admin-managed.png" alt-text="Admin managed app":::

4. If the add-in is listed under the **Admin-managed** section, ask your tenant administrator to follow these steps:

    5. In the [Microsoft 365 admin center](https://admin.microsoft.com/), select **Settings** > **Integrated apps**.

    6. On the **Integrated apps** page, select the **Sales Copilot** app.

        The **Microsoft Sales Copilot** panel opens. 

    1. If the **Update** button is available, select it, and follow the prompts to update the add-in.

    1. If the **Update** button isn't available, go to the **Configuration** tab, select **Sales Copilot for Microsoft Outlook**, and then select **Remove**. Once done, reinstall the Sales Copilot add-in for Microsoft Outlook. More information: [Install Sales Copilot](/microsoft-sales-copilot/install-viva-sales)

1. If the add-in isn't listed under the **Admin-managed** section, uninstall the add-in from the **My add-ins** section, and reinstall it.

> [!NOTE]
> It can take up to 24 hours for the changes to take effect for the end users when deployed through the admin managed flow.

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.