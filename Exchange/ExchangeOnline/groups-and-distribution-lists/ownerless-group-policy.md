---
title: Microsoft 365 ownerless group policy
description: This article answers questions that you might have about an ownerless group and its policy.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 164095
  - CSSTroubleshoot
ms.reviewer: batre
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
search.appverid: MET150
ms.date: 7/26/2022
---
# Microsoft 365 ownerless group policy

An ownerless group policy applies to Microsoft 365 groups and teams. Only global administrators can [set or edit the policy](/microsoft-365/admin/create-groups/ownerless-groups-teams). The policy queries active members of an ownerless group about whether they'll accept the group ownership. Notifications are sent weekly starting within 24 hours of the policy creation. This article answers questions that you might have about ownerless groups and this policy.

## Does the ownerless group policy apply to Yammer, SharePoint, Stream, and so on?

For Yammer: If a tenant is in Native mode, Yammer groups are identified as Microsoft 365 groups. In this scenario, the ownerless group policy works as expected.  

For SharePoint, Stream, and other applications: Not all groups can be identified as Microsoft 365 groups. Therefore, the ownerless group policy might not work.

## How are the active members in an ownerless group identified?

The activities in the group are used to identify active members. If there are no activities in the group, random members are chosen.

## Will notifications be limited if a tenant has more than 10,000 ownerless groups?  

In Exchange Online, each mailbox has a limit of 10,000 messages to be sent per day. Since ownerless group notification messages are sent by one sender, the sender will be throttled for a tenant that has a large number of ownerless groups. Therefore, the account that's used to send the notification messages can't send more than 10,000 messages per day.  

## How do I customize an ownership notification?  

The ownership notification text can be customized when you configure the ownerless group policy. However, the customization options, such as setting a language based on a country or providing a customized URL, aren't available.

## What occurs if group members accept or decline the ownership in a notification?

Up to two members can accept the ownership of an ownerless group. No additional members are allowed to accept ownership. If either one or two members accept ownership, other members won't receive further notifications.

If members decline the ownership, they won't receive any further notifications. But other members will still receive the notifications until they finish the week's notification.  

## What occurs if members don't respond to the notifications by the time that the notification period ends?  

Assume that the notification period is four weeks. After four weeks, the notifications are no longer sent. In [Microsoft Purview compliance portal](https://go.microsoft.com/fwlink/p/?linkid=2077149), admins can see which ownerless group is unattended in the [audit log](/microsoft-365/compliance/set-up-basic-audit#step-3-search-the-audit-log) by selecting the **Unattended ownerless group** activity. If an audit log is generated, admins can see an alert in the compliance portal. In this scenario, Microsoft 365 groups don't take any further action. Admins have to take further actions on their own to resolve the ownerless groups, such as contacting group members directly.

:::image type="content" source="media/ownerless-group-policy/activities.png" alt-text="Screenshot of the Activities window in which the Unattended ownerless group option is selected.":::

## What occurs if a member forwards a notification to someone else?

The actionable buttons (**Yes** and **No**) aren't available in the forwarded notification email message. Therefore, the recipients of the forwarded email message can't accept or decline the ownership.

## Is it possible to batch update the list of specific groups if a policy is applied to these groups?

No. Currently, you can add and search only one group at a time.  

## Will a single user receive multiple notifications if the user is active in multiple groups?

Yes. The user will receive notifications for all the ownerless groups of which the user is an active member. There is no limit on the number of notifications that are sent to any user.  

## Is a premium plan required for all scenarios of notifications?

Yes. When you specify who can receive ownership notifications for an ownerless group policy, a premium plan is required to create a security group that's used for allowing or blocking the policy.

:::image type="content" source="media/ownerless-group-policy/premium-plan-required.png" alt-text="Screenshot of a warning that requires you to upgrade to a premium plan when you specify who can receive ownership notifications.":::

## Issue: Actionable buttons (**Yes** and **No**) don't appear in a notification.

This issue occurs if the notification email message is first viewed in Preview mode.

To view the actionable buttons, double-click the email message to open it in Full Screen mode.
