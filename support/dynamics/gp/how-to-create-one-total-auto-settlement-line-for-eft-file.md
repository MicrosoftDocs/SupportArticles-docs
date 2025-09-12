---
title: How to create one total auto settlement line for EFT file
description: Explains how to create one total auto-settlement line for the entire EFT file instead of an auto settlement line for each vendor in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# How to create one total auto settlement line for the Electronic Funds Transfer (EFT) file in Microsoft Dynamics GP

This article introduces how to create one total auto-settlement line for EFT for Payables Management or Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2006198

1. In Microsoft Dynamics GP, select **Cards**, point to **Financial** and select **EFT FIle Format**.
2. Select the **EFT Format ID** you want to add the settlement line to.
3. Mark the checkbox for **Generate Auto-Settlement for Each Detail**.

4. Now unmark the checkbox for **Generate Auto-Settlement for Each Detail** and you'll be prompted with the message:

   > Settlement details exist for this format. Do you want to save or delete the details? Click **SAVE**.

   (This saves the field mappings for the settlement line, so you get one settlement line per file, instead of per detail line.) You'll then be prompted Settlement details have been saved. Verify that the fields are mapped for a summary settlement line. Select **OK**.

5. For the **Line Type**, select the drop-down list and select **Settlement**. Review the default field mappings for each line and edit as necessary to match your bank's requirements.

6. Select **Save**.
