---
title: Error This page is not using a valid page layout
description: Viewing a SharePoint .aspx page generates the error This page is not using a valid page layout. Provides a solution for this issue.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Site or Web Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# Trying to view a SharePoint .aspx page generates the error "This page is not using a valid page layout"

## Symptoms

Users attempting to view or render a .aspx format page receive the following error: 

"This page is not using a valid page layout"

## Cause

The .aspx page is using an invalid page layout, or the current layout is corrupt.

## Resolution

There are two potential resolutions for this. 

If the page was working at some point in time, use Version History to revert to the last known working version:

1. Go to Site Actions > View All Site Content.
2. Click Pages.
3. Click the dropdown menu next to the .aspx page in question.
4. Select Version History.
5. Preview older versions to see if the issue was recently introduced. If possible, identify a last-known working version, and suggest the customer restore that version.

Alternatively, we can try to manually try to fix the page layout: 

You may find in Site Content and Structure (/_layouts/sitemanager.aspx) that the Page Layout is listed by path, as opposed to by name. For example, the layout is listed as "/_catalogs/masterpage/WelcomeLinks.aspx" instead of "Welcome page with summary links".

First, we will want to ensure the template is enabled in /_layouts/AreaTemplateSettings.aspx. Typically, Page Layouts is set to "Pages in this site can use any layout".

Then we will want to go to View All Site Content (/_layouts/viewlsts.aspx) -> Pages, click the dropdown on the affected page and select "Edit page properties". From here, select a valid layout. You should now be able to render the page.

In my experience, we sometimes have force the page layout to reset, by changing it to something else, then back to the original layout in both viewlsts.aspx and sitemanager.aspx:

1. Go to /_layouts/viewlsts.aspx > Pages > Edit page properties of the affected page and change the layout to something else.
2. Go to /_layouts/sitemanager.aspx > Pages > Edit page settings of the affected page and change the layout to the same as Step 1.
3. Go back to viewlsts.aspx and change the layout to the original. 
4. Go back to sitemanager.aspx and change the layout back to the original. 
5. Confirm the layout in sitemanager.aspx now displays by Name, not path. 
6. Confirm the page no longer throws errors. 

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
