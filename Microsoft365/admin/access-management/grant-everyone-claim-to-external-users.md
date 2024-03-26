---
title: Grant Everyone claim to external users in Microsoft 365
description: Describes a new Everyone option to govern access of external users in Microsoft 365 and identify resources that are granted permissions to all external users.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Azure Active Directory
  - Microsoft 365
ms.date: 03/31/2022
---

# Grant the Everyone claim to external users in Microsoft 365

## Summary

Starting on March 23, 2018, we're updating the behavior and governance of access by external users in Microsoft 365.

After this change is made, an external user will see only the content that is shared with that user or with groups to which the user belongs. External users will no longer see content that is shared to the **Everyone**, **All Authenticated Users**, or **All Forms Users** groups. By default, content that is granted permissions to these groups will be visible only to your organization's users.

Administrators can change the default behavior to enable external users to see content that is shared to **Everyone**, **All Authenticated Users**, or **All Forms Users**. 

## More Information

### Background

In on-premises Active Directory domains, the **Everyone** special group represents all identities in the Active Directory domain. It includes the domain's guest account, which is disabled by default. By default, the **Everyone** group includes all user accounts that are added by delegated administrators to the domain.
 
Before this change, Microsoft 365 shared the behavior of on-premises Active Directory domains: Every user in a tenant's Microsoft Entra ID was effectively considered a member of the **Everyone** group after you added an **Everyone** claim to the user's security context. This included external users. This claim enables a user to access any content that is shared with the **Everyone** group.
 
Similarly, the **All Authenticated Users** and **All Forms Users** claims were added automatically to each user's security context. This included external users who have accounts in the tenant's Microsoft Entra ID. These claims enable users to access any content that is shared with the **All Authenticated Users** or **All Forms Users** groups.
 
Microsoft 365 enables users to share and collaborate seamlessly with users inside and outside their organizations. When a user in your organization adds an external user to a Microsoft 365 group or shares content with an external user and requires authentication ("sign-in") for access, an account is automatically created in Microsoft Entra ID to represent the external guest user. It isn't necessary for a delegated administrator to create the account for the external user.
 
### Updates to the default access for external users

To better support user-driven sharing, we're updating the behavior and governance of access by external users in Microsoft 365.
 
Starting on March 23, 2018, external users will no longer be granted the **Everyone**, **All Authenticated Users**, or **All Forms Users** claims by default. External users will be granted access only to content that is shared with the group to which the external user belongs, and to content that is shared directly with the external user. External users will not have access to content that is shared with these three special groups.
 
### New option to govern access for external users

Use the following guidelines to grant access to external users for the selected groups. 

| **Group claim**| **Procedure**| **Result**  |
|---|---|---|
|**Everyone**|Configure your tenant to grant the **Everyone** claim to external users by running the **Set-SPOTenant -ShowEveryoneClaim $true** Windows PowerShell cmdlet.|External users who are granted the **Everyone** claim  have access to content that is shared to the **Everyone** group.|
|**All Authenticated Users** and **All Forms Users**|Configure your tenant to grant the **All Authenticated Users** and **All Forms Users** claims to external users by running the **Set-SPOTenant -ShowAllUsersClaim $true** Windows PowerShell cmdlet|External users who are granted the **All Authenticated Users** and **All Forms Users** claims have access to content that is shared to the **All Authenticated Users** and **All Forms Users** groups.|

<a name='use-azure-ad-groups-and-dynamic-membership-instead-of-default-claims'></a>

### Use Microsoft Entra groups and dynamic membership instead of default claims

Although we continue to support sharing with the **Everyone**, **Everyone Except External Users**, **All Authenticated Users**, and **All Forms Users** groups, we encourage you to implement role-based access management by using customer-defined groups in Microsoft Entra ID. This includes Microsoft 365 groups.
 
Microsoft 365 groups define the membership and access to content across Microsoft 365 services and experiences. Many Microsoft 365 services already support Microsoft Entra dynamic groups, and these services are defined as a set of rules that are based on Microsoft Entra properties and business logic.
 
Dynamic groups are the best way to make sure that the appropriate users have access to the correct content. Dynamic groups let you define a group one time by using a definition that is based on rules. By having this ability, you don't have to add or remove members as your organization changes. 

## FAQ

**Q:** **Is it currently possible to opt out your tenant from receiving the change?**

**A:** Currently, there's no official "opt out" process. If you continue to use these groups to share to external users, you can run the following cmdlet in PowerShell before March 23, 2018:

```powershell
Set-SPOTenant -ShowEveryoneClaim $true
```

> [!NOTE]
> By default, the **-ShowEveryoneClaim** property value is set to **True**. However, to make sure that the property value is not **null**, run this command to fully update the setting. If you want to verify that the setting is updated, please contact Microsoft Support. 

## Identifying resources permitted to all external users in the tenancy

### Prerequisites

- Download the [**SharePoint Search Query Tool**](https://github.com/SharePoint/PnP-Tools/tree/master/Solutions/SharePoint.Search.QueryTool).

  > [!NOTE]
  > The queries in the following "Process" section can also be run in web browsers.
- Create a consumer account at **Outlook.com**. This account is external to your organization. This example assumes that the account is contoso_externaluser@outlook.com.
 
### Assumption

- Your Microsoft 365 organization is Contoso. Your organization uses contoso.sharepoint.com for SharePoint sites and groups, and contoso-my.sharepoint.com for OneDrive storage.
- You're an administrator for the organization. Your identity isadmin@contoso.com.
 
### Process

- Configure your tenant to grant the **Everyone** claim to external users by
[How to determine resources to which all external users have access](https://support.office.com/article/how-to-determine-resources-to-which-all-external-users-have-access-c3c8642b-cfb3-46b7-9f5a-ce27a6cb8ea1).
