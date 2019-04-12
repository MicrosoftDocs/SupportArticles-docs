---
title: Access Denied for a SharePoint Online user who is synchronized to Office 365
description: Describes an issue in which Access Denied for a SharePoint Online user who is synchronized to Office 365.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
---

# "Access Denied" error for a SharePoint Online user who is synchronized to Office 365

## Problem

Consider the following scenario:

- Your organization uses the Microsoft Office 365 Directory Sync tool to populate user information from an on-premises Active Directory installation.

- A user or group is removed from the on-premises Active Directory location that's configured to synchronize to Office 365.

- Synchronization occurs between the on-premises Active Directory location and the Office 365 directory service.

- The user or group is added back to the on-premises Active Directory location that's configured to synchronize to Office 365.

- A synchronization occurs between the on-premises Active Directory location and the Office 365 directory service.

- The user signs in to SharePoint Online and then tries to access resources that he or she had access to before the changes were made.

In this scenario, one of the following error messages is returned:

- **Sorry, this site hasn't been shared with you.**

- **Access Denied.**

- **Let us know why you need access to this site.**

## Solution/Workaround

To work around this issue, remove the permissions for the affected user, users, group, or groups from all SharePoint Online sites. Then, add the user or group permissions back to the sites.

> [!NOTE]
> These steps must be performed for any affected users who meet the conditions that are described in the "Problem" section.

## More Information

For more information about how to manage SharePoint Online user profiles from the SharePoint admin center and about Office 365 and SharePoint profile synchronization, go to [Manage SharePoint Online user profiles from the SharePoint admin center](https://docs.microsoft.com/sharepoint/manage-user-profiles?redirectSourcePath=%252fen-us%252farticle%252fmanage-user-profiles-in-the-sharepoint-admin-center-494bec9c-6654-41f0-920f-f7f937ea9723).

For more information about how to edit permissions for a list, library, or individual item, go to [Edit permissions for a list, library, or individual item](https://support.office.com/article/edit-and-manage-permissions-for-a-sharepoint-list-or-library-02d770f3-59eb-4910-a608-5f84cc297782?ocmsassetID=HA102833689&CorrelationId=1787d721-a762-487b-9dae-ea6f7d649052&ui=en-US&rs=en-US&ad=US).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
