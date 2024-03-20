---
title: Error when you close Revenue Recognition Entry Distribution dialog box
description: Describes a problem that occurs when you close the Distribution dialog box after creating a Revenue Recognition transaction. Provides solutions to this problem.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Error message when you close the "Revenue Recognition Entry Distribution" dialog box in Project Accounting in Microsoft Dynamics GP and in Microsoft Great Plains: Line(s) contain errors

This article provides help to solve an error that occurs when you close the "Revenue Recognition Entry Distribution" dialog box in Project Accounting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 910123

## Symptoms

You receive the following error message when you close the **Revenue Recognition Entry Distribution** dialog box in Project Accounting in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains:

> The following errors were found while validating distributions: Line(s) contain errors.

## Cause

This issue may occur if one of the following conditions is true:

- The posting account that is being used for the distribution account is not valid.
- The **Closed to Billings** check box is selected in any one of the following dialog boxes:
  - **Project Maintenance**  
  - **Contract Maintenance**  
  - **PA Customer Options**
- A cost category that is assigned to the project is marked as "inactive."

To resolve this issue, use one of the following methods as appropriate.

## Resolution 1: Verify that all the posting accounts that are set up for the project are valid

1. On the **Cards** menu, click **Project**, and then click **Project**.
2. Type your project ID in the **Project No.** box, click **File**, and then click **Print**.
3. In the **Project Print Options** box, click **Budget**, and then click **Accounts**.
4. Click **Print** to print the **Project Budget List** report.
5. Review the report. If either "!!!" or "***" appears next to an account, this account is not valid. You will have to correct the account. After you correct the account, enter the revenue recognition transaction again.

## Resolution 2: Clear the Closed to Billings check box

1. On the **Cards** menu, point to **Project**, and then click **Project**.
2. In the **Project No.** box, type your project ID.
3. Click to clear the **Closed to Billings** check box, and then click **Save**.
4. On the **Cards** menu, point to **Project**, and then click **Contract**.
5. In the **Customer ID** box, type your customer ID.
6. In the **Contract ID** box, type your contract ID.
7. Click to clear the **Closed to Billings** check box, and then click **Save**.
8. On the **Cards** menu, point to **Sales**, click **Customer**, and then type your customer ID in the **Customer ID** box.
9. Click **Project**, and then click to clear the **Closed to Billings** check box.
10. Click **OK**, and then click **Save** in the **Customer Maintenance** dialog box.

## Resolution 3: Clear the Inactive check box for the cost category that is assigned to the project

1. On the **Cards** menu, point to **Project**, and then click **Cost Category**.
2. In the **Cost Category ID** box, type the cost category that is assigned to the project.
3. Click to clear the **Inactive** check box, and then click **Save**.

> [!NOTE]
> If multiple cost categories are assigned to the project, follow these steps for all the cost categories.
