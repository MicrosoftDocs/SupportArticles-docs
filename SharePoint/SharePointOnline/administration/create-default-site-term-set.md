---
title: Create a default Site collection Term Set if none is present
description: This article describes how to create a default Site collection Term Set if none is present.
author: v-miegge
ms.author: cmahoo
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.custom: CSSTroubleshoot
ms.topic: article
appliesto:
- SharePoint Online
---

# Create a default Site collection Term Set if none is present

This article describes how to create a default Site collection Term Set if none is present.

## Symptom

In a site collection, when you go to **Term Store Management** during a site collection, you don't see a **term set** specific to that respective site collection.

![No local term store available](./media/create-default-site-term-set/no-local-term-store.png)

## Cause

By design, the **local term store** is not available as a default on all sites.

The local term store is only available when publishing is enabled in the site.

## Resolution

Activate the local term store in site which is missing.

If you need a local term store and don't want to activate the publishing feature, or if the feature isn't available (as it is on modern communication sites), follow these steps:

1. On any site, select the **Gear icon** at the top-right corner of the window, and select **Site contents** from the drop-down menu.

   ![Select Site contents](./media/create-default-site-term-set/select-site-contents.png)
  
2. Find any list or library, and select the **ellipsis**, then select **Settings**.

   ![Choose Settings](./media/create-default-site-term-set/choose-settings.png)

3. In the List settings, go to the **Columns** section and select **Create column**.

   ![Add a Managed Metadata column](./media/create-default-site-term-set/create-column.png)

4. Choose a name for the column, such as **LocalMMS** or **NewMMS**.

5. Change the column type from **Single line of text** to **Managed Metadata**.

   ![Add a Managed Metadata column](./media/create-default-site-term-set/change-column-type-to-managed-metadata.png)

6. Scroll down to **Term Set Settings** and choose **Customize your term set:**. You can provide description if you would like, but you should see the name of the column you put above there.

   ![Select the option to customize your term set](./media/create-default-site-term-set/customize-your-term-set.png)

7. Select the **OK** button.

   ![Select the OK button](./media/create-default-site-term-set/select-okay.png)

8. Return to the **Taxonomy Term Store** in Site settings, and verify that you can locate the new local term store at the site collection level.

   ![The site collection now appears in the term store](./media/create-default-site-term-set/site-collection-appears-in-term-store.png)
