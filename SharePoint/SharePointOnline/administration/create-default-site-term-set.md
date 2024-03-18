---
title: Create a default Site collection Term Set if none is present
description: This article describes how to create a default Site collection Term Set if none is present.
author: helenclu
ms.author: luche
ms.reviewer: cmahoo
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Create a default Site collection Term Set if none is present

This article describes how to create a default Site collection Term Set if none is present.

## Symptom

In a site collection, when you go to **Term Store Management** during a site collection, you don't see a **term set** specific to that respective site collection.

:::image type="content" source="media/create-default-site-term-set/no-local-term-store.png" alt-text="Screenshot shows no local term store available when you go to Term Store Management during a site collection." border="false":::

## Cause

By design, the **local term store** is not available as a default on all sites.

The local term store is only available when publishing is enabled in the site.

## Resolution

Activate the local term store which is missing.

If you need a local term store and don't want to activate the publishing feature, or if the feature isn't available (as it is on modern communication sites), follow these steps:

1. On any site, select the **Gear icon** at the top-right corner of the window, and select **Site contents** from the drop-down menu.

    :::image type="content" source="media/create-default-site-term-set/select-site-contents.png" alt-text="Screenshot shows selecting the Gear icon at the top-right corner of the window and selecting Site contents from the drop-down menu.":::
  
2. Find any list or library, and select the **ellipsis**, then select **Settings**.

   :::image type="content" source="media/create-default-site-term-set/choose-settings.png" alt-text="Screenshot shows finding any list or library, selecting the ellipsis, and then selecting Settings." border="false":::

3. In the List settings, go to the **Columns** section and select **Create column**.

   :::image type="content" source="media/create-default-site-term-set/create-column.png" alt-text="Screenshot of the Columns section in the List setting, selecting Create column." border="false":::

4. Choose a name for the column, such as **LocalMMS** or **NewMMS**.

5. Change the column type from **Single line of text** to **Managed Metadata**.

   :::image type="content" source="media/create-default-site-term-set/change-column-type-managed-metadata.png" alt-text="Screenshot of the Create Column page that changes the column type to Managed Metadata." border="false":::

6. Scroll down to **Term Set Settings** and choose **Customize your term set:**. You can provide description if you would like, but you should see the name of the column you put above there.

   :::image type="content" source="media/create-default-site-term-set/customize-term-set.png" alt-text="Screenshot of Term Set settings, choosing Customize your term set to provide description if you would like." border="false":::

7. Select the **OK** button.

8. Return to the **Taxonomy Term Store** in Site settings, and verify that you can locate the new local term store at the site collection level.

   :::image type="content" source="media/create-default-site-term-set/site-collection-new-local-term-store.png" alt-text="Screenshot of the Taxonomy Term Store in Site settings, with new local term store at the site collection level." border="false":::
