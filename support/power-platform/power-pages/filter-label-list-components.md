---
title: Missing filter label text in list components
description: Filter labels in list components may not be visible in Power Pages design studio due to a text color issue.
ms.reviewer: 
ms.date: 03/05/2024
ms.service: power-pages
---

# Missing filter label text in list components

## Symptoms

If your site was originally created in Power Apps portals Studio, the filter labels in List components may not be visible in the new Power Pages design studio.

## Cause

This problem happens because of the color issue in the theme CSS file.

## Resolution

To fix this text color issue, perform the following steps:

1. Open the affected site in the [Portal Management](/power-pages/configure/portal-management-app) app.
1. Go to **Content** > **Web Files**.
1. Select file **portalbasictheme.css**.
1. Select the **Notes** tab.
1. Select the attachment link to download the file.
1. Make a copy of the file **portalbasictheme.original.css** as a backup if you need to revert to the default later.
1. Open the **portalbasictheme.css** file in a text editor such as notepad, and keep the browser open to replace the updated file later.
1. Add the following to the end of the file:

    `
    .entitylist-filter-option-group .h4 {
      color: #000000;
    }
    `

1. Save and close the file.
1. Back in Portal Management app from the open browser, select the **Edit this note** pencil icon from the right-side of the screen.
1. Select the attachment icon at the bottom-most left > select your updated file > Select **Save** button.

### See also

- [Create and manage web files](/power-pages/configure/web-files)
- [Portal Management app overview](/power-pages/configure/portal-management-app)
