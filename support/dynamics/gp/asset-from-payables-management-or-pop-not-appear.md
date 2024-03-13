---
title: An asset from Payables Management or from Purchase Order Processing does not appear in Fixed Asset Management in Microsoft Dynamics GP
description: Describes a problem that occurs if Microsoft Dynamics GP is not set up completely, or if Microsoft Dynamics GP is set up incorrectly. A resolution is provided.
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.reviewer: theley
---
# An asset from Payables Management or from Purchase Order Processing does not appear in Fixed Asset Management in Microsoft Dynamics GP

This article provides a solution to an issue where an asset from Payables Management or from Purchase Order Processing doesn't appear in Fixed Asset Management when you move it to Fixed Asset Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865907

## Symptoms

When you try to move an asset from Payables Management or from Purchase Order Processing to Fixed Asset Management in Microsoft Dynamics GP, the asset does not appear in Fixed Asset Management.

## Cause

This problem occurs if Microsoft Dynamics GP is not set up completely, or if Microsoft Dynamics GP is set up incorrectly.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> After you complete each step, check whether the problem is resolved.

1. In the **Fixed Assets Company Setup** window, make sure that the **Post PM through to FA** check box and the **Post POP though to FA** check box are selected. To do this, follow these steps:

    1. Open the Fixed Assets Company Setup window. To do this, follow the steps for your version of the program:
        - Microsoft Dynamics GP 10.0

            On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Fixed Assets**, and then click **Company**.
        - Microsoft Dynamics GP 9.0 and earlier versions

            On the **Tools** menu, point to **Setup**, point to **Fixed Assets**, and then click **Company**.

    2. Examine the **Post PM through to FA** check box and the **Post POP though to FA** check box. If it is necessary, click to select both check boxes.

2. In the Fixed Assets Purchasing Posting Accounts Setup window, make sure that you have an FA Clearing Account set up. To do this, follow the steps for your version of the program:

   - Microsoft Dynamics GP 10.0

        On the Microsoft Dynamics GP menu, point to Tools, point to **Setup**, point to **Fixed Assets**, and then click **Purchasing Posting Accounts**.
   - Microsoft Dynamics GP 9.0 and earlier versions

        On the **Tools** menu, point to **Setup**, point to **Fixed Assets**, and then click **Purchasing Posting Accounts**.

    An FA Clearing Account is required if the following conditions are true:

    - The **Post PM through to FA** check box or the **Post POP through to FA** check box is selected.
    - In the Fixed Assets Company Setup window, the **by Account** option is selected.

3. In the **Fixed Assets Company Setup** window, make sure that the **Require Account** check box is selected. If the **Require Account** check box is selected, click the **Default Accounts** arrow to open the **Default Accounts** window, and make sure that all eight default accounts are filled in.

4. Use the appropriate step:

   - Payables Management

        In the Payables Transaction Entry Distribution window, make sure that you use a Fixed Assets Purchasing Posting account for the PURCH Type distribution account.

   - Purchase Order Processing

        In the **Receivings Item Detail Entry** window, make sure that you use a Fixed Assets Purchasing Posting account for the Purchases account.

5. If the **Post POP through to FA** check box and the **by Receipt Line** check box are selected in the **Fixed Assets Company Setup** window, make sure that you click to select the **Capital Item** check box in the **Receivings Item Detail Entry** window before you post the receivings transaction. To open the **Receivings Item Detail Entry** window, point to **Purchasing** on the **Transactions** menu, click **Receivings Transaction Entry**, and then click the arrow next to the **Item** field.

6. Make sure that Fixed Asset is installed on all the client computers where the users will be entering the purchasing transactions. Make sure that the Fam.dic file is in the Microsoft Dynamics GP application directory.

The issue that is described in the Symptoms section does not apply to Microsoft Dynamics GP 10.0.
