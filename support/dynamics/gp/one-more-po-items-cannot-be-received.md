---
title: One or more PO items cannot be received
description: Provides a solution to an error that occurs when you try to receive a purchase order in Microsoft Dynamics GP.
ms.reviewer: theley, Beckyber
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# "One or more purchase order items can't be received as they have an encumbrance status of pre-encumbered or invalid" Error message when you try to receive a purchase order in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to receive a purchase order in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2709819

## Symptoms

When you try to receive a shipment or a shipment/invoice document against a purchase order in the Receivings Transaction Entry window, you receive the following error message:

> One or more purchase order items can't be received as they have an encumbrance status of pre-encumbered or invalid.

> [!NOTE]
> Encumbrance Management is enabled and all Purchase Order Documents that receive this error come from Business Portal Requisition Management.

## Cause

No integration has ever existed between Business Portal Requisition Management and Encumbrance Management and new columns were added to the POP10100 table that now render previous steps to get by the issue obsolete.

In versions before Microsoft Dynamics GP 10.0 RTM, users wouldn't receive the error and could get by the missing integration by encumbering the Purchase Order documents that came from Business Portal Requisition Management in either the Mass Encumbrance window or by running Encumbrance Routine Maintenance. Even though they were able to complete the receiving process there were no checks against the budget using these steps. The Mass Encumbrance window and Encumbrance Routine Maintenance would populate the Encumbrance Management tables for the Purchase Order documents so that processing against the purchase order could continue.

In Microsoft Dynamics GP 10.0 RTM and later versions, new columns have been added to the POP10100 table. Because of the addition of these columns, these steps no longer allow users to continue the receiving process. When you use either the Mass Encumbrance window or the Encumbrance Routine Maintenance window to encumber the Purchase Orders, the system will encumber the Purchase Order documents allowing you to move forward with printing. However when you try to enter a shipment receipt the following error message: One or more purchase order items can't be received as they have an encumbrance status of pre-encumbered or invalid

In Microsoft Dynamics GP 10.0 RTM and later versions, new columns exist in the POP10100 table for the extra workflow functionality. Those columns are Workflow_Approval_Status and Workflow_Priority. These columns have a default value of 0 when Purchase Order documents are brought in from Requisition Management. The default values for a purchase order created through the Purchase Order Entry window are 9 and 2 respectively. The Requisition Management default values of 0 aren't valid and it results in Encumbrance Management being unable to handle the transaction correctly.

## Resolution

Don't use Encumbrance Management when creating Purchase Order documents via Business Portal Requisition Management. It isn't supported and tables don't populate correctly, which results in an error when attempting to receive against the Purchase Order documents. Customers that are using BP Requisition Management and Encumbrance Management in Microsoft Dynamics GP 10.0 RTM and later versions will receive the error reported in this article. There's no workaround for this issue, however, you can get past the error referenced in this article by doing one of the following steps:

- Manually update the tables via SQL to show the Workflow_Approval_Status field as a value of 9 and the Workflow_Priority field as a value of 2 in the POP10100.
- If manual updates aren't suitable for your business, you can look at creating a SQL trigger to automatically populate the data for you. If assistance is needed in creating this type of trigger, contact support and we can forward your request to Professional Services for a quote. This type of service is considered consulting and there would be a charge for creating a SQL trigger. If you want to pursue this option, contact Customer Service.

> [!NOTE]
> In cases where you print the Purchase Order document after the document is created via Requisition Management and prior to updating the Workflow_Approval_Status and Workflow_Priority fields, the status of the Purchase Orders are populated with the wrong status of Pre-budget. When you try to receive, you receive the following error message:  
> One or more purchase order items can't be received as they have an encumbrance status of pre-encumbered or invalid

In addition, when you look at the purchase order in the Mass encumbrance window, it displays as Pre-budget. If you meet this situation, in addition to updating the values mentioned above, you'll need to also update the ENCBSTAT field in the ENC10110 table for the purchase order to 2 (pre-encumbrance). Use the Mass Encumbrance window to Encumber and then reprint the Purchase Order.
