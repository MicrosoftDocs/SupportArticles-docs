---
title: Microsoft 365 ownerless group policy
description: Answers questions that you might have about an ownerless group and its policy.
author: cloud-writer
ms.author: meerak
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
ms.date: 01/24/2024
---
# Microsoft 365 ownerless group policy

Global administrators can [set or edit a policy](/microsoft-365/admin/create-groups/ownerless-groups-teams) for ownerless Microsoft 365 groups and teams. The policy queries active members of an ownerless group about whether they'll accept the group ownership. Notifications are sent weekly starting within 24 hours of the policy creation. This article answers questions that you might have about ownerless groups and this policy.

## Does the policy for ownerless groups apply to Viva Engage, SharePoint, Stream and so on?

For Viva Engage: If a tenant is in Native mode, Viva Engage groups are identified as Microsoft 365 groups. In this scenario, the policy for ownerless groups works as expected.  

For SharePoint, Stream, and other applications: Not all groups can be identified as Microsoft 365 groups. Therefore, the policy for ownerless groups might not work.

## How are the active members in an ownerless group identified?

The activities in the group are used to identify active members. If there are no activities in the group, random members are chosen.

## Will notifications be limited if a tenant has more than 10,000 ownerless groups?  

In Exchange Online, each mailbox has a limit of 10,000 messages to be sent per day. Because ownerless group notification messages are sent by one sender, the sender will be throttled for a tenant that has many ownerless groups. Therefore, the account that's used to send the notification messages can't send more than 10,000 messages per day.  

## How do I customize an ownership notification?  

The ownership notification text can be customized when you configure the policy for an ownerless group. However, the customization options, such as setting a language based on a country/region or providing a customized URL, are not possible.

## What occurs if group members accept or decline the ownership in a notification?

Up to two members can accept the ownership of an ownerless group. No additional members are allowed to accept ownership. If either one or two members accept ownership, other members won't receive further notifications.

If members decline the ownership, they won't receive any further notifications. But other members will still receive the notifications until they finish the week's notification.  

## What occurs if the notification period ends, and members don't respond?  

Assume that the notification period is four weeks. After four weeks, the notifications are no longer sent. In [Microsoft Purview compliance portal](https://go.microsoft.com/fwlink/p/?linkid=2077149), admins can see which ownerless group is unattended in the [audit log](/microsoft-365/compliance/set-up-basic-audit#step-3-search-the-audit-log) by selecting the **Unattended ownerless group** activity. If an audit log is generated, admins can see an alert in the compliance portal. In this scenario, Microsoft 365 groups don't take any further action. Admins have to take further action on their own to resolve the status of ownerless groups, such as contacting group members directly.

:::image type="content" source="media/ownerless-group-policy/activities.png" alt-text="Screenshot of the Activities window in which the Unattended ownerless group option is selected.":::

## What occurs if a member forwards a notification to someone else?

The actionable buttons (**Yes** and **No**) aren't available in the forwarded notification email message. Therefore, the recipients of the forwarded email message can't accept or decline the ownership.

## Is it possible to batch update the list of specific groups if a policy is applied to these groups?

No. Currently, you can add and search only one group at a time.  

## Will a single user receive multiple notifications if the user is active in multiple groups?

Yes. The user will receive notifications for all the ownerless groups of which the user is an active member. There is no limit to the number of notifications that are sent to any user.  

## Is a premium plan required for all scenarios of notifications?

Yes. In the policy for an ownerless group, when you specify who can receive ownership notifications, a premium plan is required to create a security group that's used to allow or block the policy.

## Issue: Actionable buttons (Yes or No) don't appear in a notification

The issue occurs for the following reasons:

- The notification is first viewed in Preview mode.
- The sender's user principal name (UPN) and primary email address don't match.

To view the actionable buttons, use the following options:

- Double-click the email message to open it in Full Screen mode.
- Make sure that the sender's UPN is the same as the primary email address. For more information, see [Change a user name and email address](/microsoft-365/admin/add-users/change-a-user-name-and-email-address).

## Issue: The policy for the ownerless group is configured, but no member receives the notification

Make sure that the sender that's configured in Group Policy is either a user mailbox or a group mailbox. If you configure any sender other than a user mailbox or group mailbox, the notification is not sent.

If you configured the supported sender (as a user mailbox or group mailbox), check the audit log to trace whether group email notifications were sent.
