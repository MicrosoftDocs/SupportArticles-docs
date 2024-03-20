---
title: You are creating a check with remit-to address PRIMARY error
description: You may receive an error message that happens for certain vendors in the Edit payables checks window in Payables Management. Provides a resolution.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# "You are creating a check with remit-to address PRIMARY" error in Edit Payables Checks window in Payables Management

This article provides a resolution for the error messages that may occur for certain vendors or creditors in the Edit Payables Checks window or the Edit Payables Cheques window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2484711

## Symptoms

You receive one of the following error messages for certain vendors or creditors in the Edit Payables Checks window or the Edit Payables Cheques window in Microsoft Dynamics GP:

> You are creating a check with remit-to address PRIMARY. To create a check for another remit-to address, select Cancel and use the Apply window to select documents for the remit-to address you want before viewing or saving the payment.

> You are creating a cheque with remit-to address PRIMARY. To create a cheque for another remit-to address, select Cancel and use the Apply window to select documents for the remit-to address you want before viewing or saving the payment.

## Cause

This message is alerting you that multiple invoices are included as being applied in a particular check batch that contains multiple remit-to address IDs. The system tells you to which address ID it's going to send the check. This provides you an opportunity to cancel it and use the apply window to select only the documents you want to include in the check going to the specific remit-to address noted in the message.

For example, having the remit-to address of PRIMARY used on one invoice and an applied document with a blank remit-to address, would cause the system to see multiple remit-to address ID's and generate this message.

## Resolution

It's just an informational message. You can continue if all the invoices and applied documents in the check batch can go to the REMIT-TO address referenced in the message.

To see the REMIT-TO address ID's used in this checkrun in the PM Remittance table, execute this script against the company database:

```sql
select distinct (VADCDTRO) from PM20100 where VENDORID = 'XXXX'
```

> [!NOTE]
> Enter the appropriate vendor ID for the *XXXX* placeholder in the script.

To see the REMIT-TO address ID's on all the vendors open invoices in payables for this vendor, execute this script against the company database:

```sql
select distinct (VADCDTRO) from PM20000 where VENDORID = 'XXXX' and CURTRXAM > '0.00000'
```

> [!NOTE]
> Enter the appropriate vendor ID for the *XXXX* placeholder in the script.

## More information

Set the default REMIT-TO address ID on the Vendor Maintenance card so the same address populates the invoice each time. However, you can override it or remove it since it isn't a required field. However, having the same ID default will increase the chances that it will be the same on various documents.
