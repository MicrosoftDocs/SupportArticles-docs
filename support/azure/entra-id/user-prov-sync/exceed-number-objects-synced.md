---
title: Error (This company has exceeded the number of objects that can be synchronized) displays in a directory synchronization report
description: Describes how to increase the Active Directory directory service quota for directory synchronization in an Office 365, Azure, or Microsoft Intune environment.
ms.date: 07/06/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: users
---
# An error displays in a directory synchronization report: This company has exceeded the number of objects that can be synchronized

This article describes how to increase the Active Directory directory service quota for directory synchronization in an Office 365, Azure, or Microsoft Intune environment.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 User and Domain Management  
_Original KB number:_ &nbsp; 2812409

## Symptoms

You receive an email message from `MSOnlineServicesTeam@MicrosoftOnline.com` that contains the following error message:

> Error 016: Synchronization has been stopped. This company has exceeded the number of objects that can be synchronized. Contact Microsoft Online Services Support.

> [!NOTE]
> This article can also be used if you just want to request to increase the directory service quota in case you're planning to have more than the allowed number of objects in a Microsoft cloud service such as Office 365, Azure, or Microsoft Intune, and you don't use Active Directory synchronization. The current directory service quota in Microsoft Entra ID is 50,000 objects.

## Cause

This issue occurs because the number of objects that you created in your Microsoft Entra ID exceed your directory service limit. Microsoft Entra ID limits how many objects can be created by each organization. Groups, contacts, and user objects in your Microsoft Entra organization are counted as part of your organization's directory usage.

Your default directory service quota is calculated according to the following guidelines:

- If you don't have any verified domains, the current directory service quota in Microsoft Entra ID is 50,000 objects.

  1. If your organization was created before October 5, 2011, your default directory service quota is 10,000 objects.
  2. If your organization was created after October 5, 2011 and before May 2012, your default directory service quota is 20,000 objects.
  3. If your organization was created after May 2012, your default directory service quota is 50,000 objects.
- If you have at least one verified domain, the default directory service quota in Microsoft Entra ID is 300,000 objects.

## Resolution

When the number of groups, contacts, and user objects in your on-premises Active Directory exceed your directory service quota, you can request an increase to the directory service quota limitation for your company. This increase lets you sync more objects than the current default limit when you use directory synchronization.

To continue to create objects in your organization, you must either add a domain or request an increase to your directory service quota. To do this, use the following methods.

### Method 1

If you don't have a verified domain, you must add a domain to increase your quota limit to 300,000 objects. For more information, see [Add your domain](https://technet.microsoft.com/library/hh969247.aspx).

### Method 2

If you have more than 300,000 objects in your on-premises Active Directory directory service, to increase the number of objects that can be synced beyond 300,000, contact Microsoft Support.

## More information

A directory service quota is implemented by using the cloud service as a method to limit the maximum number of objects that can be created and owned by a single security principal. All objects that are synced by using directory synchronization to a company have the creator/owner value set to the default admins group for that company. For example, the admins group is set as follows: `admins@contoso1.microsoftonline.com`. Therefore, this configuration prevents users from creating an unlimited number of objects by using directory synchronization. If a company has a legitimate need to sync more than the directory service quota limit, submit a service request to technical support.

### Frequently asked questions

**Question 1**: Do objects that were manually added through the cloud service portal or through the cloud service API, such as Exchange Online PowerShell, count against my online company quota?

**Answer 1**: Yes.

**Question 2**: Do deleted objects count against my online company quota?

**Answer 2**: Yes. When a cloud service customer deletes an object from an online company, the deleted object is put into a deleted objects container in the directory service. The object remains in the deleted objects container until the tombstone lifetime expires. The expiration is currently set to 30 days.

For example, consider the following scenario. An online company is evaluating a cloud service by using a nonproduction on-premises Active Directory environment. The cloud service organization was created before October 5, 2011, and the default sync limit is 10,000 objects. The company performs a bulk sync of 8,000 group objects and contact objects by using the Directory Sync tool. Later, the online company decides to do the following:

1. Delete those group objects and contact objects from the company's on-premises nonproduction Active Directory DS environment.
2. Add 8,000 user objects to its on-premises nonproduction Active Directory DS environment.
3. Sync the updates to its online company.

The 8,000 group objects and contact objects are moved to the deleted objects container in the directory service. And these objects continue to consume up to 25 percent of the online company quota until they are permanently removed after the 30-day tombstone period. (This percentage is equal to 2,000 objects, or 8,000 × 25 percent.) Therefore, after syncing the 5,000 new user objects, the online company will consume 10,000 objects of its available Active Directory quota, 2,000 from deleted objects plus 8,000 from new user objects. During the 30-day tombstone period (and this period may coincide with the online company evaluation period), the online company may be unable to add any additional objects by using directory synchronization. This condition occurs because the online company's directory service quota has been reached.

In this scenario, the online company that's performing the evaluation of the cloud service must reduce the number of objects in its nonproduction on-premises Active Directory DS environment to complete the product evaluation. However, if the online company can't reduce the number of objects, the company must request an increase in its directory service quota.

**Question 3:** Does having more than one verified domain mean that I can have a quota that's higher than 300,000 objects?

**Answer 3**: No. You're granted a directory quota of 300,000 objects if you have one or more verified domains. You're not granted a quota of 300,000 objects for _each_ verified domain that you register.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
