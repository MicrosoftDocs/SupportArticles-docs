---
title: Azure Active Directory (Azure AD) Connect excludes a user's primary group from its group membership
description: Describes an issue that causes Azure AD Connect to exclude a user's primary group from its group membership.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: enterprise-users
---
# Azure AD Connect excludes a user's primary group from its group membership

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 4014115

## Summary

Microsoft Azure Active Directory (Azure AD) Connect doesn't support primary group functionality. Therefore, it does not query the **PrimaryGroupID** attribute to build the group membership of a user. This may cause problems for users who are still using the primary group feature.

:::image type="content" source="media/aad-connect-exclude-user-primary-group/primary-group.png" alt-text="Screenshot shows that Azure A D Connect doesn't support the primary group functionality." border="false":::

When you set the primary group for a user, that user is excluded from the corresponding group membership in Active Directory. Instead, the **PrimaryGroupID** attribute is set with that group.

For example:

1. User1 belongs to Group1, which means that Group1 has User1 as a member.
2. The primary group is changed on User1 from Domain Users to Group1:
    1. User1 is excluded from Group1 Members.
    2. User1 is added as a member of Domain Admins (because it's no longer the primary group).
    3. The User1 **PrimaryGroupID** attribute is set with the Group1 reference.

Programs that need to query groups to give users access that is based on group membership should also query for the **PrimaryGroupID** attribute. However, Azure AD Connect does not support **PrimaryGroupID** because of the complexity of group membership synchronization.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
