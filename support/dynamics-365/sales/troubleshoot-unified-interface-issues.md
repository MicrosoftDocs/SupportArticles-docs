---
title: Troubleshoot issues with Unified Interface 
description: Provides resolutions for the known issues that are related to Unified Interface in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/28/2022
ms.custom: sap:Sales app installation
---

# Troubleshoot issues with Unified Interface

This article helps you troubleshoot and resolve issues related to Unified Interface.

## Issue: Out-of-the-box or custom entities appear as read-only in Unified Interface apps

Some out-of-the-box and custom entities are appearing as read-only in the Sales Hub app (Unified Interface). However, these entities are editable in the legacy web client. Some out-of-the-box buttons are also unavailable on the forms in Unified Interface.

### Cause

This could happen when an entity is set to be read-only in Unified Client.

### Resolution

To resolve this issue, follow these steps:

1. On the navigation bar in your app, select the **Settings** icon and then select **Advanced Settings**.

    :::image type="content" source="media/troubleshoot-unified-interface-issues/advanced-settings-option.png" alt-text="Advanced Settings option on the Settings menu.":::

    The **Business Management** page opens in a new browser tab.

2. On the navigation bar, select **Settings** and then select **Customizations**.

    :::image type="content" source="media/troubleshoot-unified-interface-issues/customization-in-sitemap.png" alt-text="Select Customizations on the Settings page.":::

3. On the **Customization** page, select **Customize the System**.
4. In the solution explorer, under **Components**, expand **Entities** and then select the specific entity that's appearing as read-only.

5. On the **General** tab, under **Outlook & Mobile**, clear the **Read-only in Unified Client** check box.

    :::image type="content" source="media/troubleshoot-unified-interface-issues/read-only-in-unified-client-setting.png" alt-text="Setting to make an entity read-only in the Unified Client." border="false":::

6. Save and publish the customizations.
7. In the Sales Hub app, refresh the window.

All the out-of-the-box actions will be available and entities will be editable.
