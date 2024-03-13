---
title: Void AR type cash receipt in Cashbook Management in Microsoft Dynamics GP
description: Describes how to void an AR type cash receipt in Cashbook Management in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
---
# How to void an AR type cash receipt in Cashbook Management in Microsoft Dynamics GP

This article explains how to void an "AR" type cash receipt in Cashbook Bank Management using Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3058407

## Symptoms

The cash receipt is listed in the *Build Deposits Entry* window in Cashbook Management and there is no way to delete it in this window. If you deposit it in Cashbook Management and then try to delete this deposit in the *Transaction Enquiry/Void* window, you will get the message:

This deposit is an AR transaction and cannot be voided from the Bank Recon.

## Cause

By design. Since it was an "AR" type cash receipt and updated Receivables Management, the system now considers it to have originated from Receivables Management, and there is no functionality to void the cash receipt in Cashbook Management.

## Resolution

When you post a cash receipt in Cashbook Bank Management, it will create a cash receipt batch in Receivables Management. Depending on what you do with that cash receipt batch in Receivables Management, follow the appropriate method below for voiding the cash receipt:

- *The recommended process is to* *post the cash receipt batch in Receivables Management and deposit the cash receipt in Cashbook Management*. *Then void the posted cash receipt in Receivables Management* under *Posted Transactions* (Transactions | Sales | Posted Transactions). The void will flow back to Cashbook Management, and will be listed in the *Transaction Enquiry/Void* window as a negative amount, to serve as an offset to the deposit for the cash receipt in Cashbook Management. Both the negative amount and deposit will be listed in the *Transaction Enquiry/Void* window to offset each other. This is the intended design.

    > [!NOTE]
    > In the Posted Transactions window, be sure to search under Payments. The Number  will be the payment number assigned to it when it posted to Receivables. The Receipt number from Cashbook can be found in the lower left corner under the Check Number field with a slash preceding it. So look for the Check number field, and Original Amount. If you need help to find the Number, you can also drill back on it from the *Receivables Transaction Enquiry* window (Enquiry | Sales |Transaction by Customer), or even look directly in the RM20101 SQL table to find it by querying on the date and amount. With the Payment Number, you should be able to bring it up in the *Posted Transactions* window in Sales to void it.

- Now if you would delete the cash receipt batch in Receivables Management, then you do not have a way to void the cash receipt that is in Cashbook Management. If you deposit it in Cashbook Management and then try to void the deposit, you will get the message indicated above. At this point, the only way to remove the cash receipt from the *Build Deposits* window in Cashbook Management is to remove it from the following SQL tables (which is not a recommended or supported option):

  - CB100000
  - CB100003
  - CB100011
  - CB330222
  - CB990007--this is the table that actually drops it off the Build Deposits window.
  - CB220210
  - CB600066
