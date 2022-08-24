---
title: RM Statement templates can't be emailed in Microsoft Dynamics GP 2010
description: There's an RM Statement Template available in Microsoft Dynamics GP 2010, but there are no options to email it to the customer.
ms.reviewer: cwaswick, jakelaux
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# RM Statement templates can't be emailed in Microsoft Dynamics GP 2010

This article describes an issue where you can't email an "RM Statement" Word Template to customers.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2441760

## Symptoms

There's an "RM Statement" Word Template available in Microsoft Dynamics GP 2010, but there are no options to email it to the customer. How do you email it?

## Cause

Emailing the Word RM Statement template isn't functionality that was added to Microsoft Dynamics GP 2010. You can't use the RM Statement Word template until you're on Microsoft Dynamics GP 2013 RTM.

## Resolution

The ability to email RM Customer Statements in Receivables Management in Microsoft Dynamics GP 2010 hasn't changed and still functions the same as it did in prior versions (using the old Report writer way and not word templates). To email RM Statements in Microsoft Dynamics GP 2010 in PDF format, Adobe Writer is required.

## More information

For more information about emailing RM statements, see the following KB articles:

- [How to use email messages to send letters, statements, and invoices to customers in Microsoft Dynamics GP](https://support.microsoft.com/help/903690)

- [How to troubleshoot issues that occur when you send email statements in Microsoft Dynamics GP](https://support.microsoft.com/help/934699)
