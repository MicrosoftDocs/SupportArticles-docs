---
title: Missing filter label text in list components
description: Provides a resolution for an issue where the filter labels in list components might not be visible in Power Pages design studio due to a text color issue.
ms.reviewer: dmartens
author: tapanm-MSFT
ms.author: tapanm
ms.date: 03/06/2024
ms.service: power-pages
---
# Filter label text is missing in list components in Power Pages design studio

This article provides a resolution for an issue where the filter labels in list components might not be visible in Power Pages design studio due to a text color issue.

## Symptoms

If your site was originally created in [Power Apps portals Studio](/power-pages/configure/design-build-overview), the filter labels in List components might not be visible in the new [Power Pages design studio](/power-pages/getting-started/use-design-studio).

## Cause

This problem happens because of a text color issue in the theme CSS file.

## Resolution

To fix the text color issue, perform the following steps:

1. Open the affected site in the [Portal Management](/power-pages/configure/portal-management-app) app.
1. Go to **Content** > **Web Files**.
1. Select the *portalbasictheme.css* file.
1. From **File Content**, select the *portalbasictheme.css* file again and download it.
1. Save the file locally and create a copy (such as *portalbasictheme.original.css*) as a backup in case you need to revert to the default later. Keep the browser open so you can replace the updated file later.
1. Open the downloaded *portalbasictheme.css* file in a text editor such as Notepad.
1. Add the following content to the end of the file.

    ```css
    .entitylist-filter-option-group .h4 {
      color: #000000;
    }
    ```

1. Save and close the file.
1. Go back to the Portal Management app from the open browser, and then select **Delete** > **OK** to delete the file.
1. Select **Choose File**, select your updated file, and then select **Open** > **Save** to save the uploaded file.

## See also

- [Create and manage web files](/power-pages/configure/web-files)
- [Use Portal Management app](/power-pages/configure/portal-management-app)
