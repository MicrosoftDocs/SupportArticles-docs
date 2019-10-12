---
title: Can't change locale setting for SharePoint Online public website
description: The column "Site Element Id" in the list or library "Site Elements" has been marked for indexing when trying to change the locale for a SharePoint Online public site.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# Error when you change the locale setting for the SharePoint Online public website

## Problem

When you try to change the locale for a Microsoft SharePoint Online public site, you receive the following error message:

```asciidoc
Sorry, something went wrong

The column "Site Element Id" in the list or library "Site Elements" has been marked for indexing. Please turn off all indexed columns before changing the collation of this site. You may re-index those columns after the collation of the site has been changed.
```

## Solution

To work around this issue, remove the index, change the locale, and then re-create the index.

> [!NOTE]
> To make this change, you have to set the **Enforce unique values** option to **No** while you temporarily remove and re-create the index. The steps to do this are included in this workaround.

### Step 1: Remove the index

To remove the index, follow these steps:

1. As an administrator, browse to the public site where the issue exists.
1. Click the gear icon for the **Tools** menu, and then click **Site contents**.
1. On the **Site Contents** screen, click **Site Elements**.
1. In the **Site Elements** list, click the **List** tab on the ribbon, and then click **List Settings**.
1. In the **Columns** section of the Settings page, click **Site Element ID**.
1. Set the **Enforce unique values** option to **No**, and then click **OK**.
1. In the **Columns** section of the **Settings** page, click **Indexed Columns**.
1. On the **Indexed Columns** page, click the link for **Site Element ID**, and then click **Delete** on the next page.

### Step 2: Change the locale

Change the locale setting back to its original configuration. To do this, follow these steps:

1. As an administrator, browse to the public site where the issue exists.
1. Click the gear icon for the **Tools** menu, and then click **Site settings**.
1. In the **Site Administration** section of the **Site Settings** page, click **Regional settings**.
1. For **Locale**, select the desired language, and then click **OK** at the bottom of the page.

### Step 3: Re-create the index

To re-create the index, follow these steps:

1. Click the gear icon for the **Tools** menu, and then click **Site contents**.
1. On the **Site Contents** screen, click **Site Elements**.
1. In the **Site Elements** list, click the List tab on the ribbon, and then click **List Settings**.
1. On the **Settings** page in the **Columns** section, click **Indexed Columns**.
1. On the **Indexed Columns** page, click **Create a new index**.
1. For the **Primary columns for this index** setting in the **Primary Column** section, select **Site Element ID**, and then click **Create** at the bottom of the page.
1. Click **Settings** at the top of the page to browse back to the **Settings** page, and then in the **Columns** list, click **Site Element ID**.
1. Change the **Enforce unique values** setting back to **Yes**, and then click **OK** at the bottom of the page.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).