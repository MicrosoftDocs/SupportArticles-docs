---
title: Description of Intune migration blockers
description: Discusses migration blockers that may be found by the pre-migration checker and the steps to take if your Intune stand-alone environment fails the pre-migration check.
ms.date: 05/11/2020
ms.prod-support-area-path: Migration to the Azure Portal
ms.reviewer: aaronmax, delhan
---
# Intune migration blockers for grouping and targeting

This article discusses migration blockers that are found by the pre-migration checker and provides the steps to take if your Intune stand-alone environment fails the pre-migration check.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4020148

## Summary

This article discusses how to migrate an existing Intune stand-alone environment from Intune grouping and targeting to Azure Active Directory (AD) grouping and targeting. We recommend that you first read [the grouping documentation](/mem/intune/fundamentals/groups-add) that can help you plan the grouping experience.

After you migrate the environment to Azure AD grouping, you will have a new grouping and targeting experience on Azure AD that includes such features as dynamic grouping. However, there are several scenarios that cannot be migrated because they are structured differently in Azure AD or will not work as expected after migration.

In this article, we describe migration blockers that the pre-migration checker may find. If your Intune stand-alone environment fails the pre-migration check, your environment will not migrate. But if you remove all migration blockers before the checker starts to work on your groups, the process may return you to the queue without a delay in migration. There are workarounds for many of these scenarios in which there is no true dynamic grouping in Intune. In most scenarios in which the migration blockers are removed, the Intune stand-alone environment is successfully migrated.

## Office Message Center

To determine whether you have already installed any of the items that are discussed in this article, go to the [Office Message Center](https://portal.office.com/AdminPortal/Home?ref=MessageCenter), log on by using your administrator credentials, and then check your messages.

If your migration will not continue because of any of the scenarios that are discussed in this article, we may have posted a message for you. We will also follow up with you if we cannot migrate your environment, and we will provide additional instructions. Tenants are not scheduled by date. Instead, they are selected by an algorithm that assesses the complexity of the tenant. Less complex tenants are migrated first, and the most complex tenants are migrated toward the end of the schedule. Also, the Office Message Center posts a message when migration of your scale unit or tenant is about to start.

Remember to look for a notice in the Office Message Center before you run the migration. After the migration is completed, you should see a banner in the console. When you click the **Groups** page, that page refers you to the new experience. You will also be able to use the new Intune on Azure administrative experience after the migration.

## Migration blockers

The following situations are considered the most significant migration blockers.

### Policies or applications targeted to ungrouped users or devices

Currently, Intune lets you target policies to non-groups. Non-groups are those devices or users that were not put anywhere specific. Therefore, they are located in the All Users bucket. In Azure AD, you can use [dynamic groups](/azure/active-directory/users-groups-roles/groups-dynamic-membership) to automatically assign devices and users directly to groups. However, targeting must be done at a group level.

To remove this blocker, you must move your ungrouped users and devices to the desired groups. Additionally, you must remove anything that you have targeted to those ungrouped users or devices. This includes policies, applications, and terms of use. After you move a device or user from one group to another, the policy is applied according to the group that you move the device to. You would not want to cause migration blockers to be restored after you have removed them.

### Using exclusion groups

Currently, you can create security groups in [https://portal.office.com](https://portal.office.com) or [https://portal.azure.com](https://portal.azure.com). However, you cannot target any policy or applications to those groups in Intune. Instead, you create Intune groups by including or excluding your security groups from a parent group, and then targeting your policies to the Intune groups. After the migration, you can target your policies directly to the security groups.

If your Intune groups are created by excluding security groups, Intune cannot migrate them yet because there is no equivalent way to exclude groups in Azure AD. For example, you could create an Intune group that is named **All US Users** by excluding the **All EU Users** security group from the **All Users** group. However, that exclusion would delay your migration because the process cannot create a dynamic group that has the same result. Again, when you remove your excluded groups, remember that the excluded group and your policies and anything else that you have targeted to that excluded group must also be removed.

### Using nested (implicit exclusion) groups

Even if you never use the **Exclude** button on your criteria membership, you create a nested group (also known as an implicit exclusion group) if you do the following:

- Create a group that does not use **All Users** as the parent group.
- Start by having an empty group on the criteria membership page.
- Include one or more security groups.

For example, you want a group that is named **US Marketing**. You already have an Intune group that is named **All US Users**, and a security group that is named **Worldwide Marketing**. When you create your **US Marketing** Intune group, you do the following:

- Set the parent group to **All US Users**.
- Start by having an empty group on the criteria membership page.
- Include **Worldwide Marketing**.

Because you use the **All US Users** parent group, you exclude any marketing employees who are not based in the United States.

### Groups that use the `Is Manager` clause

Earlier versions of Intune enabled you to create a target group in which one of the criteria is a manager. This feature is deprecated in the current program version. However, if the clause still exists in your Intune setup, you must remove it. Otherwise, your account will fail the migration pre-check.

### Conflicting application deployment rules

In Intune, you might have targeted an application to all users except a specific group that is a child of the targeted group. Because application policies differ, and the exception group is a child of the user's group, this also prevents deployment from migrating. To fix this situation, create a group, target the policies and applications as you want, and then move the child group to its own group.

### Earlier versions of the Exchange connector for Intune

If you use an earlier version (earlier than December 2016), migration is blocked because the Intune on Azure is a new infrastructure in the back end, and the Exchange connector is updated to connect to the new infrastructure. You can fix this blocking issue by updating to the latest Exchange connector version of Intune. For more information about how to update your Intune Exchange Connector, see the [Intune Exchange connector requirements](/mem/intune/protect/exchange-connector-install#intune-exchange-connector-requirements) section of [Set up the on-premises Intune Exchange connector](/mem/intune/protect/exchange-connector-install).

After you pass the migration pre-check, we will pre-populate your groups in Azure AD, migrate your groups and targeting, and then run a consistency checker to make sure that everything that you had in the old Intune groups moved as expected to the new groups. This includes policies that are targeted to devices, groups, and other entities.

## Frequently asked questions  

### What happens if I do not fix my grouping issues?

Even if you do not fix your grouping, exclusion, and nesting issues, we will continue to try to migrate you. In this situation, we will try to reach you through the Message Center to let you know that you are blocked. Eventually, we will take a snapshot of the current situation, and create static groups in Azure AD that mimic what you had in Intune. We will also notify you through the Message Center that we created static groups instead of dynamic groups during the migration. You can then decide what to do about that situation after the migration.

> [!NOTE]
> Several customers who had nested groups but no other blocking issues were unintentionally migrated together with **snapshot** groups. If you are one of those customers, search for a Message Center post at [https://portal.office.com](https://portal.office.com/) for more information.

### Why should I care whether my group is migrated as a static group?

Dynamic groups in Azure AD make life easier for administrators. When a user or device meets certain criteria, they are automatically added to the dynamic group and automatically receive policies, applications, and terms and conditions that are deployed to that dynamic group.

If you had an Intune group that used to update dynamically but is migrated as a static group, your newly added users and devices will not automatically receive deployments. For example, if you had an Intune group that included everyone on the **Sales** team but excluded user *Joey Maxfield*, the **snapshot** group is migrated as a flat list of users in **Sales**, minus the user *Joey Maxfield*. Therefore, *Joey* will not receive the deployments that he used to receive. If a new user, *Terri Richards*, joins the **Sales** team after the migration, she is not automatically added to the static **Sales** group and does not receive applications, policies, or terms and conditions that are targeted to that group.

## References

- [Office Message Center](https://portal.office.com/AdminPortal/Home?ref=MessageCenter)
- For the Intune grouping documentation, see the following Intune article:

  [Add groups to organize users and devices](/mem/intune/fundamentals/groups-add)

- For more information about how to update your Intune Exchange Connector, see the [Intune Exchange connector requirements](/mem/intune/protect/exchange-connector-install#intune-exchange-connector-requirements) section of the following Intune article:

  [Set up the on-premises Intune Exchange connector](/mem/intune/protect/exchange-connector-install)

- For more information about how to handle conflicting application deployment rules, see the [How conflicts between app intents are resolved](/mem/intune/apps/apps-deploy#how-conflicts-between-app-intents-are-resolved) section of the following Intune article:

  [Assign apps to groups with Microsoft Intune](/mem/intune/apps/apps-deploy)
