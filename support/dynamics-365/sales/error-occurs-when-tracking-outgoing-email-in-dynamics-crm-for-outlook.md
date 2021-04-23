---
title: An error occurred promoting this item to Microsoft CRM error 
description: When you track an outgoing email in the Microsoft Dynamics CRM for Outlook client, you may receive an error that states an error occurred promoting this item to Microsoft CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# An error occurred promoting this item to Microsoft CRM occurs when tracking an outgoing email in Microsoft Dynamics CRM for Outlook

This article provides a resolution for the issue that **An error occurred promoting this item to Microsoft CRM** occurs when tracking an outgoing email in Microsoft Dynamics CRM for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2708761

## Symptoms

When tracking an outgoing email in the Microsoft Dynamics CRM for Outlook client, the following error may occur:

> An error occurred promoting this item to Microsoft CRM. The Microsoft CRM Server could not be contacted or the user has insufficient permissions to perform this action.

A Microsoft Dynamics CRM client side trace will show the following:

> The access credentials that you have specified have insufficient delegate permissions to send the e-mail message. Contact your Microsoft Exchange administrator to grant the required Permissions.

## Cause

This error can be caused by the following:

1. The Outlook contact or suggested contact has missing properties such as the email address or SMTP properties.
2. The **HidecontactfromExchangeaddresslists** functionality in Microsoft Exchange Server is being used for either the Sender or Recipient address in the email. Using this functionality removes all SMTP and email address information from a contact when it's synchronized to Outlook, which is used for the Microsoft Dynamics CRM for Outlook client to promote an email. Instead, it provides an Exchange DN value in the **Display Name** field.

By default, Microsoft Dynamics CRM selects the user that tracks the email to display as the Sender of the email in Microsoft Dynamics CRM if it can't find an SMTP email address for the Sender on the original email in Outlook.

## Resolution

If the MAPI properties are damaged or missing, try forwarding the email to the user that originally received the email. Then, Set Regarding to the correct contact. In addition, these properties may be able to be recreated. Contact Outlook support for additional information on this process.

If the Outlook contact or suggested contact is missing properties, add the missing information such as the email address.

If using the **Hide contact from Exchange address lists** functionality in Microsoft Exchange Server, this type of behavior is by design and expected within Microsoft Dynamics CRM, as this Exchange functionality removes the necessary information needed for Microsoft Dynamics CRM to find the original Sender of the email from Outlook. The emails can be tracked manually by using Set Regarding to track this to the correct contact.
