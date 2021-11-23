---
title: PDF attachment is sent as dat file or missing
description: Describes that a PDF file attachment to e-mail messages that use Dexterity custom code appears as a .dat file or is missing. Provides links to resolve this issue.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# PDF attachment is sent as a .dat file or is missing if using Dexterity custom code to send the e-mail

This article provides a resolution for the issue that the PDF attachment is sent as a .dat file or is missing when you use the custom Dexterity code to send the email message that contains a PDF attachment.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939915

## Symptoms

If you run custom Dexterity code that uses the `MAPI_Send()` function to attach a file in PDF format to an e-mail message, you experience one of the following symptoms:

- The file attachment appears incorrectly as Winmail.dat instead of in the PDF format that you selected.
- The file attachment appears to be missing even though it was attached to the e-mail message.

## Cause

The Microsoft Exchange Server settings may cause the attachment to be sent in RTF format.

Client e-mail systems can receive e-mail messages that have an attachment. However, if the e-mail systems do not support RTF, the attachment cannot be separated correctly from the body of the message.

## Resolution

To resolve this issue, you need to modify the Exchange Server settings.

## Steps to reproduce the issue

1. Create a Dexterity customization by using the MAPI function library as described in the Dexterity Function Library Reference manual. Or, create the customization by using the MAPI dictionary.

    > [!NOTE]
    > The MAPI dictionary is available as a download from Sample Applications for Dexterity on PartnerSource.

2. Send an e-mail message to a user who is outside your global access list.
