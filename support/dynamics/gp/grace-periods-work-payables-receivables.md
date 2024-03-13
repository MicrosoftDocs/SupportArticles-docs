---
title: Grace Periods work in Payables/Receivables
description: Describes how Grace Periods work in Payables/Receivables Management in Dynamics GP.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# How Grace Periods work in Payables/Receivables Management in Microsoft Dynamics GP

This article describes how Grace Periods work in Payables/Receivables Management in Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4294026

## Symptom

I set up a grace period on my customer maintenance card, but it didn't seem to work or do anything to the discount due date that was calculated. How do you get grace periods to work?
I'm using a specific DATE for my payment term, and I still get the same discount due date, whether I've a discount grace period of 0 or 5 days on my customer. It doesn't seem to make a difference.

## Information

Here's how the grace periods calculate on customers/vendors:
Grace periods only work with DATE and EOM type payments terms.  Grace periods don't add days to the date. They're only used in the calculation to figure out if the dates should be pushed to the next month or not. And the checkbox to use the customer/vendor grace periods must be marked on the payment term setup.
**Discount Grace Period:**  
Enter a discount grace period. If the document date plus the number of grace period days is the same as or later than the payment terms discount date, the discount date will move to the following month. The due date also will move to the following month.
If you're using Workflow for SharePoint's vendor approval workflow, you must resubmit the vendor record after modifying the discount grace period for an approved vendor or a vendor that doesn't need approval.

**Due Date Grace Period:**  
Enter a due date grace period. If the discount date plus the number of due date grace period days is the same as or later than the payment terms due date, the due date will move to the following month.
If you're using Workflow for SharePoint's vendor approval workflow, you must resubmit the vendor record after modifying the due date grace period for an approved vendor or a vendor that doesn't need approval.
In the Customer Maintenance window, there are the following fields:

## Example

**Example of using Discount Grace Period:**  
Payment term is set up as:

- discount date - set to DATE of fifth
- due date - set to DATE of fifth.
- checkbox marked to 'use customer/vendor grace periods for Date/EOM payment terms'

No discount grace period on customer.
Invoice dated 5/20. Discount date is **6/5**, so due date is pushed to **7/5**. (Both the discount and due date both land on 6/5, so it uses that for the discount date and pushes the due date to the next month of 7/5)

Add discount grace period on customer of five days.
Invoice dated 5/20. Payment terms says disc date is 6/5, and the grace period says date is 5/20 + 5 = 5/25, so that's still less than 6/5, so it uses **6/5** for the Discount date, and pushes the date to **7/5,** so same as before.

Add discount grace period on customer of 20 days.
Invoice dated 5/20. Payment terms says disc date is 6/5 and grace period says date is 5/20 + 20 = 6/9, so the grace period date is after the date the payment term calculated. So it pushes the discount date to the fifth of the next month and uses **7/5**, and that's why has to push the due date to **8/5**. So you can see the discount grace period does calculate a date and use it to figure out which date to push the actual discount date to.

Be sure to set it up in a test company and do some testing with different dates, so you can see for yourself how it works with your scenario.
