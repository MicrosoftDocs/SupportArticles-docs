---
title: Excel survey does not have full functionality when you click new in a SharePoint Online library
description: Describes an issue in which you Excel survey does not have full functionality when you click new in a SharePoint Online library.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# Excel survey doesn't have full functionality when you click +new in a SharePoint Online library

## Problem

When you click **+new** in a SharePoint Online library, and then you view the list of available options in the **Create a new file** dialog box, the **Excel survey** option doesn't have full functionality.

## Solution

For the Excel survey to have full functionality, you must configure the following settings:

- Correctly configure Sharing for your tenant.

- Correctly configure Sharing for your site collections.

- Disable file check-out for the library.

- Disable mutiple content types.

To correctly configure Sharing for your tenant, follow these steps:

1. Sign in to the SharePoint admin center.

2. On the left side of the page, click **sharing**.

3. Under **Sharing outside your organization**, click the **Allow sharing with all external users, and by using anonymous access links** option, select view and edition the **Files** list, and then click **OK**.

To correctly configure Sharing for your site collections, follow these steps:

1. Sign in to the SharePoint admin center.

2. On the left side of the page, click **site collections**.

3. Select the check box next to the affected site collection.

4. On the ribbon, click the **Sharing** button.

5. Click the **Allow sharing with all external users, and by using anonymous access links** option, and then click **Save**.

  **NOTE** If Sharing is disabled at the tenant and site collection levels, the Excel survey option may still be available when you click **+New** from a library. However, the Excel survey will not have full functionality unless Sharing is configured correctly.

To remove the check-out requirement, follow these steps:

1. Browse to the affected library.

2. On the **LIBRARY** tab of the ribbon, click **Library Settings**.

3. In the **General Settings** section, click **Versioning settings**.

4. Set the **Require Check Out** setting to **No**, and then click **OK**.

  **NOTE** The check-out feature must be disabled because anonymous users can't check out files and complete the survey. If your existing library requires check-out, we recommend that you create a library specifically for Excel survey files.

To disable mutiple content types, follow these steps:

1. Browse to the affected library.

2. On the **LIBRARY** tab of the ribbon, click **Library Settings**.

3. In the **General Settings** section, click **Advanced settings**.

4. Set the **Allow management of Content types** setting to **No**, and then click **OK**.

**NOTE** Performing this will not show non default content types when clicked New

## More information

This behavior occurs by design, when external sharing is not enabled for a site collection.

For more information about how to manage external sharing for your SharePoint online environment, go to [External sharing overview](https://docs.microsoft.com/sharepoint/external-sharing-overview?redirectSourcePath=%252fen-us%252farticle%252fexternal-sharing-overview-c8a462eb-0723-4b0b-8d0a-70feafe4be85).

For more information about document check-out, go to [Set up a library to require check-out of files](https://support.office.com/article/set-up-a-library-to-require-check-out-of-files-0c73792b-f727-4e19-a1f9-3173899e695b).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
