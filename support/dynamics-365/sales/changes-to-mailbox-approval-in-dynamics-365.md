---
title: Changes to mailbox approval in Dynamics 365
description: Changes to Mailbox approval in Dynamics 365.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Changes to Mailbox approval in Microsoft Dynamics 365

This article describes the changes to Mailbox approval in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4506139

## Introduction

We are modifying the approval process for new/updated/changed mailboxes. To provide more management flexibility, we are adding the [Exchange administrator](/microsoft-365/admin/add-users/about-admin-roles) as someone who can approve mailboxes. In addition, we're documenting how those authorized to do mailbox approval could change the default settings so user and queue mailboxes would not require approval.

The mailbox approval process is illustrated in the following flow chart.

:::image type="content" source="media/changes-to-mailbox-approval-in-dynamics-365/flow-chart.png" alt-text="Diagram of the Dynamics 365 mailbox approval process.":::

> [!NOTE]
> When the Server-Side Synchronization feature initially released, only the [Global administrator](/microsoft-365/admin/add-users/about-admin-roles) role was able to approve mailboxes.
>
> We are rolling out these changes region-by-region as part of [Service Update 60](https://support.microsoft.com/help/4506766); first for Customer Engagement Online/Exchange Online and then for Customer Engagement Online/Exchange On-premises.

## Permission Model

### Admin mailbox approval

To approve mailboxes in Dynamics 365:

1. You must be a Dynamics 365 System Administrator and either an [Exchange or Office 365 Global administrator](/microsoft-365/admin/add-users/about-admin-roles).
1. You must have the Approve Email Addresses for Users or Queues privilege.

For more information, see [Approve email](/power-platform/admin/connect-exchange-online#approve-email).

## Remove requirement to approve mailboxes

> [!WARNING]
> This option is not recommended as it exposes the possibility of syncing an Exchange mailbox to Dynamics 365 without proper authorization.

To remove the requirement of approving all User or Queue mailboxes, a Dynamics 365 System Administrator (with Exchange administrator or Global administrator rights) must follow these steps:

1. Open the Customer Engagement web application.
2. Navigate to **Settings**, **Administration**, and then click **System Settings**.
3. Uncheck the **Email processing for unapproved user and queues** settings and then click **OK**.

    :::image type="content" source="media/changes-to-mailbox-approval-in-dynamics-365/system-settings.png" alt-text="Screenshot to uncheck the Email processing for unapproved user and queues settings.":::

For more information, see [Remove requirement to Approve](/power-platform/admin/connect-exchange-online#approve-email).

## Questions

If you have questions after reading the provided documentation on this topic, you can contact customer support.
