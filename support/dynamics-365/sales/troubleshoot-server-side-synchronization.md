---
title: Troubleshoot Server-Side Synchronization
description: Describes how to troubleshooting Server-Side Synchronization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Troubleshooting Server-Side Synchronization

This article describes how to troubleshooting Server-Side Synchronization.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345669

## Configuration and general troubleshooting

1. Open the mailbox record and select the **Alerts** section.  

2. Look for any errors and review the message that is displayed.  

    > [!NOTE]
    > If no errors appear, navigate to **Settings**, **Email Configuration**, and then **Email Configuration Settings**. In the **Configure alerts** section, verify the **Error** option is selected. If this was not already selected, enable this option and select **OK**. Then select the **Test & Enable Mailbox** button again and check for any errors. When performing the Test & Enable action, also make sure to select the checkbox that appears in the dialog.

3. Select the **Learn more** link if it appears. If there's an article designed to help with that specific error, this link will direct you to it.

## Sending Email

- [Why does the email message I sent have a "Pending Send" status?](/power-platform/admin/why-email-message-sent-have-pending-send-status)

    > [!NOTE]
    > If you're using Exchange Online and are attempting to send a large number of emails, you may be hitting [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits). Gmail also has [sending limits](https://support.google.com/a/answer/166852).

- ["You cannot send email as the selected user" error occurs when attempting to send email as another user](https://support.microsoft.com/help/3184980)

## Receiving Email

- [Use Email message filtering and correlation to specify which emails are tracked](/power-platform/admin/email-message-filtering-correlation)

## Synchronizing appointments, contacts, and tasks

- [An appointment is cancelled or deleted unexpectedly when using Server-Side Synchronization](https://support.microsoft.com/help/4345686)
- [A scheduling conflict was found when saving appointment [appointment subject] from Exchange to Microsoft Dynamics 365 because [user] is unavailable at this time](https://support.microsoft.com/help/4340070)
