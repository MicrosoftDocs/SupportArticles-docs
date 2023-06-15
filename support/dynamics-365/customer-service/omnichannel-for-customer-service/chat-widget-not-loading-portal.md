---
title: Chat widget doesn't load on the portal
description: Provides resolutions for the issue where the chat widget doesn't load on the portal in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: yangao
ms.date: 05/23/2023
---
# Chat widget doesn't load on the portal

This article provides a few resolutions for the issue where the chat widget doesn't load on the portal in Omnichannel for Customer Service.

## Symptoms

The chat widget doesn't load on the portal.

:::image type="content" source="media/chat-widget-not-loading-portal/chat-portal.png" alt-text="Screenshot that shows the chat widget shown on the portal.":::

## Cause

There are multiple reasons why this issue may happen, depending on your configuration. There are five ways to try to resolve the issue.

## Resolution 1: Location option

The **Location** option for the chat widget might be configured incorrectly.

Delete the location in **Widget location**, and then recreate it.

To delete and add **Widget location** for the chat widget, follow these steps:

1. Sign in to the **Omnichannel Administration** app.
2. Go to **Administration** > **Chat**.
3. Select a chat widget from the list.
4. Select the **Location** tab.
5. Select a record in the **Widget Location** section, and then select **Delete**.
6. Select **Save**.
7. Select **Add** in the **Widget Location** section to add a record. The quick create pane of the chat widget location appears.
8. Specify the following details.

   | Field | Value |
   |---------------------------|-----------------------------------------|
   | **Title** | Type the title of record.|
   | **Value** | The website domain where the chat widget must be displayed. The domain format shouldn't include the protocol (`http` or `https`). For example, the website is `https://contoso.microsoftcrmportals.com`. Now, the value is `contoso.microsoftcrmportals.com`.|

9. Select **Save** to save the record.
10. Go to the website and check whether the chat widget loads.

> [!NOTE]
> The chat widget requires session storage and local storage to be functional in your browser. Make sure you have cookies enabled in your browser so these services can work properly.

## Resolution 2: Remove location

Alternatively, try removing the chat widget location.

:::image type="content" source="media/chat-widget-not-loading-portal/chat-portal-location.png" alt-text="Screenshot that shows how to remove the chat widget location.":::

## Resolution 3: Clear portal cache

Clear the portal cache by taking the following steps:

1. Go to your portal and sign in as a portal administrator.

   :::image type="content" source="media/chat-widget-not-loading-portal/chat-portal-sign-in-admin.png" alt-text="Screenshot that shows how to sign in to the portal as an administrator.":::

2. Add the following text to the end of your portal URL:

      /_services/about

    For example:

      `https://contoso.powerappsportals.com/_services/about`

3. Select **Clear cache**.

    :::image type="content" source="media/chat-widget-not-loading-portal/chat-portal-clear-cache.png" alt-text="Screenshot that shows how to clear the cache by selecting Clear cache.":::

4. Reload the portal.

   Also, make sure that your web browser allows third-party cookies.

## Resolution 4: Sync portal configurations

To sync portal configurations, take the following steps:

1. Go to [Power Apps](https://make.powerapps.com).
2. Find and select your portal, and then select **Edit**.

    :::image type="content" source="media/chat-widget-not-loading-portal/chat-portal-edit.png" alt-text="Screenshot that shows how to edit the portal in Power Apps.":::

3. Select **Sync Configuration**.

    :::image type="content" source="media/chat-widget-not-loading-portal/chat-portal-sync-configuration.png" alt-text="Screenshot that shows how to select Sync Configuration to sync portal configurations.":::

## Resolution 5: Restart portal

Restart the portal by taking the following steps:

1. Go to [Power Apps](https://make.powerapps.com).
2. Select your portal, and then under **Advanced options**, select **Settings** > **Administration**.

    :::image type="content" source="media/chat-widget-not-loading-portal/chat-portal-administration.png" alt-text="Screenshot that shows the Advanced options settings in the portal.":::

3. Select **Restart**.

    :::image type="content" source="media/chat-widget-not-loading-portal/chat-portal-restart.png" alt-text="Select Restart to restart the portal.":::
