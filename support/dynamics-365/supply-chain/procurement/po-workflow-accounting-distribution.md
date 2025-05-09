---
title: Purchase Order workflow error
description: Workflow Approval Fails Due to Unvalidated Accounting Distributions After Purchase Order Change Request.
ms.reviewer: shubhamshr
ms.date: 05/09/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---
#  Workflow Approval Fails Due to Unvalidated Accounting Distributions After Purchase Order

## Symptoms

When submitting a purchase order for approval after setting it back to Draft and modifying the line item (e.g., changing the Unit price or Confirmed receipt date), the workflow approval process fails with the following error:

"Stopped (error): Accounting distribution validation failed. Please recall purchase order workflow and rectify accounting distributions. This action can only be completed after the line number 1 is fully distributed."

## Steps to reproduce

Create and approve a purchase order for vendor with change management enabled.

Confirm the purchase order.

Request a change to revert the PO to Draft.

Update the line item (e.g., change the unit price or receipt date), and resubmit without saving the line beforehand.

Observe that the workflow approval fails with the above error.

## Workaround

Disable the Parameter Auto Calculate Totals and Accounting Distribution from Accounts Payable Parameters -> General -> Purchase Order Workflow
