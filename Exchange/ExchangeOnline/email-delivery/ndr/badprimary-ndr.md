---
title: Remote Server returned 550 5.2.0 RESOLVER.ADR.BadPrimary in Microsoft 365
description: Describes that Exchange Online users receive a Remote Server returned '550 5.2.0 RESOLVER.ADR.BadPrimary' error message when they send mail to a recipient outside of the organization. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
ms.reviewer: pramods, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "550 5.2.0 RESOLVER.ADR.BadPrimary" when an Exchange Online user sends mail to an external contact

_Original KB number:_&nbsp; 3076419

## Problem

When an Exchange Online user tries to send email messages to an external contact, the messages aren't delivered, and the user receives an error message that resembles the following:

> Delivery has failed to these recipients or groups:
>
> \<Recipient email address\>
>
> There's a problem with the recipient's mailbox. Please try resending the message. If the problem continues, please contact your email admin.
>
> Remote Server returned '550 5.2.0 RESOLVER.ADR.BadPrimary; recipient primary SMTP address is missing or invalid'

## Cause

This problem may occur if one of the following conditions is true:

- The primary SMTP address was not added to the external contact's proxy address.
- A legacy proxy address is specified in the external contact's proxy address.

## Solution

To resolve this problem, follow these steps:

1. If the user is using Microsoft Outlook to send mail, clear the external contact's name from the Outlook Auto-Complete list. For more information about how to do this, see [Delete a name from the Auto-Complete list](https://support.office.com/article/2e3d8fb1-eefd-4307-ab73-6f2f23164222).

    If this doesn't resolve the problem, or if the user is using Outlook Web App, go to step 2.
1. Make sure that the proxy address is set correctly in Microsoft 365. To do this, follow these steps:
   1. Sign in to Microsoft 365, and then open the Exchange admin center.
   1. Click Contact, select the external recipient, click Edit (:::image type="icon" source="media/badprimary-ndr/edit.png" border="false":::), and then click **general**.
   1. In the **External email address**  box, make sure that the email address exists, that it's correct, and that it's formatted correctly.

    For example, SMTP:adam@contoso.com is an external email address that's formatted correctly.

1. If you have an Exchange hybrid deployment, make sure that the proxy address of the Active Directory mail contact object is set to the correct email address. If it's not, update the SMTP value, and then run directory synchronization.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
