---
title: Why a PO status changes to Change Order
description: Describes why a purchase order status changes to Change Order and why the value in the Revision field increases in Purchase Order Processing.
ms.reviewer: theley, kfrankha, lmuelle
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# Information about why a purchase order status changes to "Change Order" and why the value in the "Revision" field increases in Purchase Order Processing in Microsoft Dynamics GP

This article describes why a purchase order status changes to **Change Order** and why the value in the **Revision** field increases in Purchase Order Processing in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943964

## Introduction

A purchase order status only changes to **Change Order** when the purchase order has a status of **Released**.

If you delete a line item from a released purchase order, the status doesn't change to **Change Order**. Additionally, the value in the **Revision** field doesn't increase.

Only a purchase order with a status of **Released** tracks revision changes. For example, if you add a new line item to a released purchase order, the purchase order status changes to **Change Order**.

Changes to line items aren't tracked unless you first print the purchase order to change the status back to **Released**.

## More information

The following list indicates the line item fields that cause both the **Revision** number to increase and the status to change to **Change Order**:

- **Site ID**: yes
- **Description**: no
- **Unit of Measure**: yes
- **Quantity Canceled**: yes
- **Quantity Ordered**: yes
- **Unit Cost**: yes
- **Extended Cost**: yes
- **Manufacturer's item number**: yes
- **Required Date**: yes
- **Release by Date**: no
- **Account Number**: no
- **Current Promised Date**: no
- **Promised Ship Date**: no
- **Item Tax Option**: no
- **FOB**: yes
- **Landed Cost ID**: no
- **Tax Schedule ID**: no
- **Shipping Method**: yes
- **Requested By**: no
- **Comment ID**: yes
- **Calculated Tax**: yes
- **Capital Item (for fixed assets)**: no

The following list indicates the header fields and actions that cause both the **Revision** number to increase and the status to change to **Change Order**:

- **Vendor Name**: no
- **Currency ID**: no
- **Buyer ID**: no
- **Type** (for example, from Standard to Drop-Ship): yes
- **Date**: no
- **Allow Sales Documents Commitments**: no
- **Attaching a note to the purchase order**: no
- **Attaching a note to the user**: no
- **Purchase Address ID**: yes
- **Bill-to Address ID**: yes
- **Ship-to Address ID**: yes
- **Shipping Method**: yes
- **Contract Number**: yes
- **Tax Registration No**: no
- **Payment Terms**: yes
- **Confirm With**: no
- **Header Comment ID** (including adding a new comment ID, changing an existing comment ID, or deleting the comment ID): yes
- **Tax Schedule ID**: yes
- **Freight, Miscellaneous, Tax, Trade Discount**: yes
