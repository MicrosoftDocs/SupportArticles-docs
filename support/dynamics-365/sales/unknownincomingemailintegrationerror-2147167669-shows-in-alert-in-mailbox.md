---
title: UnknownIncomingEmailIntegrationError -2147167669 appears in alert in mailbox
description: UnknownIncomingEmailIntegrationError -2147167669 appears in alert in Microsoft Dynamics 365 mailbox.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# UnknownIncomingEmailIntegrationError -2147167669 appears in alert in Microsoft Dynamics 365 mailbox

This article provides a resolution for the issue that you may receive the **UnknownIncomingEmailIntegrationError -2147167669** warning when you can't receive emails in a Microsoft Dynamics 365 mailbox.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4551335

## Symptoms

Emails are not received in a Microsoft Dynamics 365 mailbox and you see a warning alert like the following in a user's mailbox record:

> An unknown error occurred while receiving email through the mailbox [Mailbox Name]. The owner of the associated email server profile [Profile Name] has been notified. The system will try to receive email again later.
>
> **Email Server Error Code:**  Exchange server returned UnknownIncomingEmailIntegrationError -2147167669 exception.

## Cause

This warning is logged if the owner of the mailbox record does not have a Microsoft Dynamics 365 license assigned.

## Resolution

Verify the owner of the mailbox has a Microsoft Dynamics 365 license assigned.

> [!NOTE]
> If you verify the user does have a license, verify there are not any other Microsoft Dynamics 365 mailbox records with the same email address. If there is another mailbox with the same email address and the owner of that mailbox does not have a license, change the email address value in the other mailbox record.
