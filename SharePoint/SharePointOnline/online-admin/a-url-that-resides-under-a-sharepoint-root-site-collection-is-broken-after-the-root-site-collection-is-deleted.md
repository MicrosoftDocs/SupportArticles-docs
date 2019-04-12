---
title: A URL that resides under a SharePoint root site collection is broken after the root site collection is deleted
description: Describes an issue in which a URL that resides under a SharePoint root site collection is broken after the root site collection is deleted.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
---

# A URL that resides under a SharePoint root site collection is broken after the root site collection is deleted

## Problem

Consider the following scenarios in Office 365:

- A SharePoint Online Administrator deletes the root site collection by using the Manage Site Collections page in the SharePoint admin center. For example, the SharePoint Online Administrator deletes the https://<*domainname*>.sharepoint.com site where <*domainname*> is the name of your domain, such as https://contoso.sharepoint.com.

- All the content sites that have URLs that reside under the root site collection (<*domainname*>.sharepoint.com/sites or <*domainname*>.sharepoint.com/teams) are timing out or you're repeatedly returned to the Office 365 sign-in page.

## Solution

To resolve these issues, restore the root level site collection from the Recycle Bin. For more info about how to restore a deleted site collection from the Recycle Bin, go to [Restore a deleted site collection](https://docs.microsoft.com/sharepoint/restore-deleted-site-collection?redirectSourcePath=%252fen-us%252farticle%252frestore-a-deleted-site-collection-91c18651-c017-47d1-9c27-3a22f325d6f1).

If the site collection is no longer present in the Recycle Bin, or if you prefer to create a new Site collection at the root site location, follow these steps:

> [!NOTE]
> The following steps must be performed by a SharePoint Online Global administrator.

1. Browse to the SharePoint admin center, for example https://<*domainname*>-admin.sharepoint.com, where <*domainname*> is the name of your domain, such as *https://contoso-admin.sharepoint.com*.

2. Verify that the root site collection (https://<*domainname*>.sharepoint.com) doesn't appear in the list of site collections.

3. On the ribbon, click **New**, and then click **Private Site Collection**.

4. Complete the **new site collection form**. You must specify a Title, a value for Template Selection, an Administrator, a Storage Quota, and a Server Resource Quota. You can use the following default values or specify your own:

   - Template Selection: Use the team site template, which is the default, or specify another template if you prefer.

     > [!NOTE]
     > Be aware that this template can't be changed without deleting the site collection. And, be aware that the Publishing Portal template isn't supported at this location.

   - Administrator: Use the alias of the user whom you want to be the administrator for the site collection. This value can be changed later.

   - Storage quota: 100 MB. This value can be changed later.

   - Resource quota: 0. This value can be changed later.

5. Click **OK**.

   > [!NOTE]
   > If the site that was located at the root site location still exists in the Recycle Bin, you must check the box Permanently delete the site collection from the recycle bin and continue, and then click OK.

6. Wait for the site collection to be created. Be aware that this may take several minutes.

7. After the root site collection is created and provisioned, verify access to the site by going to https://<*domainname*>.sharepoint.com.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
