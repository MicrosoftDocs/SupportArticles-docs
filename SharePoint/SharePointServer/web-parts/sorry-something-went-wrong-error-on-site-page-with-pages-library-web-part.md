---
title: Sorry, something went wrong error on a Site Page with a Pages library web part added
description: Describes how to resolve a 'Sorry, something went wrong' error on a Site Page with a Pages library web part added.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: Admin
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Designer
  - SharePoint Foundation
  - SharePoint Server
ms.date: 12/17/2023
---

# "Sorry, something went wrong" error on a Site Page with a Pages library web part added

## Symptoms

You see the following error when selecting **Show Related Resources** within the Site Content and Structure page (sitemanager.aspx):

```text
Sorry, something went wrong
An unexpected error has occurred.
```

:::image type="content" source="./media/sorry-something-went-wrong-error-on-site-page-with-pages-library-web-part/error.png" alt-text="Screenshot that shows the error of something went wrong.":::

The SharePoint Universal Logging System ( ULS) reports:

```text
w3wp.exe (0x192C) 0x14AC SharePoint Foundation General 8nca Medium Application error when access /_layouts/15/sitemanager.aspx, Error=Object reference not set to an instance of an object…(truncated)…
```

## Cause

This might happen if a list view web part that is consuming a publishing or pages library has the option "Require Content Approval" checked.

## Resolution

Beginning in October 2018, the Site Content and Structure options were deprecated in SharePoint Online. The UI entry point to SiteManager.aspx was removed from SharePoint Online and direct access is restricted to Site Collection Admins until March 2019.

Because Site Manager has been deprecated, it will no longer receive investment beyond security fixes in SharePoint Online or On Premise.

To resolve this issue:

1. Create a page in the pages library and add the web part there, instead of creating the page in the site pages library.

2. Turn off **Require content approval for submitted items** on the pages library.

## More information

For more information about the deprecation of Site Content and Structure, see the Office support article [Features enabled in a SharePoint Online publishing site](https://support.office.com/article/Features-enabled-in-a-SharePoint-Online-publishing-site-3AB3810C-3C2C-4361-9D0E-0CBE666EA0B0).

The steps to reproduce the error are as follows:

1. Navigate to the **Site Pages Library**.
2. Create a new **Site Page**.
3. Insert the **Pages library web part** on the page.
4. **Save and Check-in** the page.
5. Navigate to **Site Settings** > **Content and structure**, then select **Site Pages** in the left panel.
6. Select the checkbox next to the Site Page created in step 2, then click **Show Related Resources**.

   > [!NOTE]
   > The system will display the related resources for the selected page.

7. Navigate back to the Site Page created in step 2.
8. Place the page in **Edit** mode, then place the **Pages Library web part** in edit mode.
9. Select **OK** in the **web part properties** box without making any changes, then **Save and check-in** the page.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
