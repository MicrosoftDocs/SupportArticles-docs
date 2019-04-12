---
title: Call us overprotective message when an external user tries to sync in OneDrive for Business
description: Describes an issue in which you receive "Call us overprotective" message when an external user tries to sync in OneDrive for Business.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
---

# "Call us overprotective" message when an external user tries to sync in OneDrive for Business

## Problem
This article contains information that applies when you use the OneDrive for Business sync client (groove.exe).

**NOTE** To determine which OneDrive sync client you're using, see the article, [Which OneDrive sync client am I using?](https://support.office.com/article/which-version-of-onedrive-am-i-using-19246eae-8a51-490a-8d97-a645c151f2ba?ui=en-US&rs=en-US&ad=US)

When an external user tries to sync a document library by using the OneDrive for Business sync app for a SharePoint Online site collection or sub-site, the user is repeatedly prompted for credentials and receives the following message:

**Call us Overprotective.**

## Solution/Workaround

To work around this issue, enable sharing for the root site collection. To do this, follow these steps:

1. Browse to the **SharePoint admin** center.

2. On the site collections page, select the check box next to the root site collection. For example, select the check box next to **https://contoso.sharepoint.com**.

3. On the ribbon, click **Sharing**.

4. Select **Allow external users who accept sharing invitations and sign in as authenticated users**, and then click **Save**.

**NOTES**

- Be aware that by enabling sharing at the root site collection, users can share resources on the site with external users. For more information about external sharing, go to [External sharing overview](https://docs.microsoft.com/sharepoint/external-sharing-overview).

- Replace the **contoso** placeholder with the domain that you use for your organization.

## More information

This issue occurs because the OneDrive for Business sync app checks sharing properties at the root site collection (https://*contoso*.sharepoint.com). Although the site collection where the external user is trying to sync has sharing enabled, the OneDrive for Business sync app validates that sharing is enabled for the root site collection.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
