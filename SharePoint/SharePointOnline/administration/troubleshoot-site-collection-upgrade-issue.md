---
title: Troubleshoot site collection upgrade issues
description: This article describes how to troubleshoot site collection upgrade issues.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Troubleshoot site collection upgrade issues

When you upgrade a site collection to SharePoint Online 2013 mode, errors can occasionally occur. This article helps you understand those errors and address them.

## Check upgrade status and log files

Upgrade status indicators and log files should give you an idea of what went wrong during the upgrade process. We recommend that you carefully review all the errors in the upgrade log files. Warnings might not always indicate an issue, but you should review them, as well, to determine whether any of them are likely to cause even more issues.

1. Review the upgrade status page for your site collection.

   On the **Site Settings**(**Settings** > **Site Settings**) pages for the site collection, in the Site Collection Administration section, click **Site collection upgrade**. On the Site Collection Upgrade page, click **Review Site Collection Upgrade Status**.

1. If pages don't render, check the **Site Settings** page. If the **Site Settings** page works and the upgrade has succeeded, there might be issues with the master page or home page. If the Site Settings page doesn't work, check the site collection upgrade log file for information about the problem.

1. Review the site collection upgrade log files. You can review the site collection upgrade logs by clicking on the link on the upgrade status page for your site collection.

## Common issues

Check to see whether any of the following issues are causing an upgrade error, a warning, or a problem in your site.

**Q: I don't see a UI control on the page that used to be there**

**A:** Reset the page to the default version.

Making changes to the site UI can cause problems in site upgrades. If a page was customized to place a UI control in a non-standard location, you can reset the page to the default version to recover the control.

To reset the page, you can use the **Reset to site definition** link under **Site Actions** on the Site Settings page or use the **Reset to Template** command in SharePoint Designer 2013.

**Q: The view on a large list is not working any longer**

**A:** Create indexed columns, folders, or new views for large lists. You might have to add the indexed column to your existing views.

If a list is large, and users use a view or perform a query that exceeds the limit or throttling threshold, the view, or query will not be permitted. You can create indexed columns with filtered views, organize items into folders, set an item limit on the page for a large view, or use an external list. For more information about large list throttling and how to address issues with large lists, see [Manage lists and libraries with many items](https://support.office.com/article/manage-large-lists-and-libraries-in-sharepoint-b8588dae-9387-48c2-9248-c24122f07c59).

**Q: I see an error about a duplicate content type name**

**A:** Rename content types or fields that conflict with default names.

Occasionally, custom elements (such as a content type) may have a name that conflicts with a name in the new version. In the upgrade log files, you may see an error such as the following:

Failed to activate site collection features on-site Site Url. Exception: A duplicate content type name "name" was found.

This error indicates that a custom content type was added to the specified site in SharePoint Online 2010. During upgrade to SharePoint Online 2013, its name conflicted with the default content type by the same name. Rename the custom content type in the specified site to a different name and run upgrade again.

> [!NOTE]
> Either renaming or removing a content type can cause any customizations dependent on that content type to stop working.

For more information, see [Conflicting content types were found during site collection health check](https://support.office.com/article/b3a1ed52-7a40-41d3-86d0-a9dea7c2e582) and [Create or customize a content type](https://support.office.com/article/27eb6551-9867-4201-a819-620c5658a60f).

**Q: My site looks ugly, doesn't behave as expected, or I see script errors**

**A:** Either edit the page or reset the page to the default version, or remove or replace the custom files.

A problem with custom or inline JavaScript or CSS files can cause these issues.

**Q: Custom content in my site disappeared or doesn't work**

**A:** Change the master page, or change the content so that it doesn't require different Web Part zone layouts.

The master page might have different zone layouts and the content might no longer reference it correctly. As a last resort, you can also reset the page to the default version. However, if you reset the page, you might lose zone-specific content.

**Q: I receive an error that says a control or page cannot render**

**A:** Do one of the following:

If a Web Part was added that is not installed, contact the tenant administrator to have it installed. If is a Web Part that is no longer available or not supported, then use the Web Part maintenance view to remove the Web Part from the page (remove, do not just close the Web Part).

If a page was directly edited, either edit it again to remove the control or Web Part or reset the page to the default version.

A Web Part or other control might have been added to the page that is not installed or is no longer supported. Either a Web Part was added to a zone or the page was directly edited to add a control or Web Part reference directly inline (possibly on a master page).

A SharePoint feature may need to be activated.

For more information, see [Enable or disable site collection features](https://support.office.com/article/a2f2a5c2-093d-4897-8b7f-37f86d83df04) and [Open and use the Web Part Maintenance Page](https://support.office.com/article/eff9ce22-d04a-44dd-ae83-ac29a5e396c2).

**Q: I receive an error that I cannot create a subsite based on a site template because the site template uses the 2010 experience version and my site collection is in the 2013 experience version**

**A:** Recreate the site template in the 2013 experience.

To recreate the site template, create a new subsite based on the 2013 experience, customize it again to match the template that you had, and then save the customized subsite as a template.

For more information, see [Upgrade site templates](https://support.office.com/article/31e8457d-4674-4e14-b778-85461da0a497).

**Q: My theme is not applied to pages in my upgraded site**

**A:** Re-create the theme by using the new theming features in SharePoint 2013.

In SharePoint 2013, the theming engine has been redesigned so that theming is more powerful and more flexible, and so that themes can be more easily upgraded moving forward. However, there is no support for upgrading a THMX file from SharePoint 2010 to SharePoint 2013.

To resolve this, you should first create an evaluation site collection, and then re-create the theme by using the new theming features in SharePoint 2013.

**Q: My custom branding doesn't look right or there are issues in my upgraded site**

**A:** Create an evaluation site collection, and then re-create the master page in the SharePoint 2013 site.

To support the new faster, more fluid UI in SharePoint 2013, changes have been made to the default master pages and CSS files. For this reason, you cannot apply a master page created in SharePoint 2010 to a site in SharePoint 2013. However, when you upgrade your SharePoint 2010 site to SharePoint 2013, the master page is reset to use the default master page in SharePoint 2013. Therefore, after upgrade, your site will not appear with its custom branding.

To resolve this, you should first create an evaluation site collection, and then re-create the master page in the SharePoint 2013 site.

**Q: My upgraded site does not render at all; instead, I see an "unexpected error" with a correlation ID.**

**A:** Your custom branding may use a custom master page that contains a custom content placeholder.

If your custom master page contains a custom content placeholder, and if custom page layouts also contain this custom content placeholder, then an error may prevent the home page of your site from rendering at all after upgrade. Instead, after upgrade, you may see the error message "An unexpected error has occurred."

**Q: When I click the button to create an evaluation site, I get a correlation ID error message.**

**A:** SharePoint appends "–eval" to the end of the evaluation site URL, which may cause the URL to exceed the character limit.

If appending "-eval" causes the URL to exceed the character limit then you'll get the correlation ID error. Lengthy URLs can be caused by deep folder structures and/or folders and files with long names. If you are getting this error, Support can work with you to identify the URLs that exceed the limit and provide the steps to resolve the problem.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
