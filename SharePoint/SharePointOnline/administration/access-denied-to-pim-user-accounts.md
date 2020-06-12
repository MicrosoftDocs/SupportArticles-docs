---
title: Access denied error for PIM-managed accounts in SharePoint or OneDrive admin center
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 6/10/2020
audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online
ms.custom: 
- CI 119405
- CSSTroubleshoot 
ms.reviewer: prbalusu
description: Describes a resolution to an access denied error received when trying to access PIM-managed accounts in SharePoint or OneDrive admin center.
---

# Error (access denied) for PIM-managed user accounts in SharePoint or OneDrive admin center

## Symptoms

You receive an “Access denied” error message or have an inconsistent experience when you try to access a user account that’s managed by Privileged Identity Management ([PIM](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user?tabs=new)) in a SharePoint Online (SPO) or the OneDrive admin center.

## Cause

Access to a user account is not immediately available in SPO when you request that access by using PIM in Azure Active Directory (AAD). Access should be granted in SPO within a few hours. However, it may take longer.

## Workaround

The potential delay can vary. Therefore, we recommend that you provide account access by setting the PIM access period to 24 hours instead of setting it to a shorter duration.
 
Microsoft is researching this problem and will post more information in this article when the information becomes available.

## More information

### How PIM and SharePoint admin role works

If an administrator enables the SharePoint Administrator role In AAD by using PIM at 7 A.M. for four hours, PIM disables the role assignment at 11 A.M. The user then loses access to the SPO admin center.

After the role is activated in PIM, it must be synchronized with SPO. This synchronization may take some time to finish. This means that the user will not have complete four-hour access. For example, if activation in PIM ends at 7 A.M. and SPO synchronization ends at 9 A.M., the user will have access for two hours only (assuming that the duration is four hours).

Therefore, this problem is expected to occur if you try to access the SPO admin center immediately after you enable the role in PIM. The system requires some time to sync the changes from AAD to SPO. Therefore, we recommend the 24-hour access window.


For more information, see the following Knowledge Base articles:

- [Roles you can't manage in Privileged Identity Management](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-roles)
- [Assign Azure AD roles in Privileged Identity Management](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user?tabs=new)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).