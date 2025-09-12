---
title: Change the US-NACHA-CCD+ format
description: Describes the method to change the US-NACHA-CCD+ format to include an invoice number in the Addenda record in Electronic Funds Transfer for Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# How to change the US-NACHA-CCD+ format to include an invoice number in the Addenda record in Electronic Funds Transfer for Payables Management in Microsoft Dynamics GP

This article describes how to change the US-NACHA-CCD+ format to include an invoice number in the Addenda record in Electronic Funds Transfer (EFT) for Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968015

## Introduction

To change the US-NACHA-CCD+ format to add an invoice number to the Addenda record, follow these steps:

1. Make a backup of the existing US-NACHA-CCD+ format. To do it, follow these steps:

    1. On the **Cards** menu, point to **Financial**, and then select **EFT File Format**.
    2. In the EFT File Format Maintenance window, enter the EFT format ID that you want change in the **EFT Format ID** field.  
      If you're creating a new EFT format ID, you can skip this section.

    3. Select **Import/Export**.
    4. In the EFT File Format Import/Export window, enter the path to which you want to save the file in the **Export format from current selection to** field.
    5. Select **Export**.

2. Edit the format to add an invoice number in the Addenda record. To do it, follow these steps:

    1. In the EFT File Format Maintenance window, make sure that the US-NACHA-CCD+ format is specified in the **Format Type** field.
    2. In the **Line Type** drop-down list, select **Addenda**.
    3. In the **Length** field, type the appropriate length of the line.
    4. In the **Start-End** field, type the value that you want to use.
    5. In the **Description** field, type a description.
    6. In the **Maps To** drop-down list, select **Data Field**.
    7. Leave the **Pad Char** field blank.
    8. In the **Justify** drop-down list, select **Left** or **Right** based on the bank requirements.
    9. Select the line that you created, and then select **Show Details** to open the data field line for more specifications.
    10. In the **Table Names** drop-down list, select **PM Apply to History File**.
    11. In the **Field Name Lookup** window, select **Apply to Document Number**, and then select **Select**.
    12. Select **Save**.

3. Test the EFT file to verify that the file meets the bank requirements. To do it, follow these steps:

    1. On the **Cards** menu, point to **Financial**, and then select **EFT File Format**.
    2. In the EFT File Format Maintenance window, type a new EFT format ID in the **EFT Format ID** field, and then type a description in the **Description** field.
    3. In the **Format Type** drop-down list, select **US-NACHA-CCD+**.
    4. Select **Save**.
    5. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Routines**, point to **Financial**, and then select **Generate EFT Prenotes**.
    6. In the Generate EFT Prenotes window, enter the EFT checkbook ID that you're using in the **Checkbook ID** field.
    7. In the **Prenotes For** area, select **Vendors Only**.
    8. In the **Prenote Format ID** field, enter the EFT format ID that you created in steps 3a through 3c.
    9. Select **Process**.
    10. Make sure that the created prenote meets the bank requirements.

> [!NOTE]
> To print the invoice number, make sure that you select **Invoice** in the **One Check Per** drop-down list in the Select Payables Checks window. To do it, follow these steps:
>
> 1. On the **Transactions** menu, point to **Purchasing**, and then select **Select Checks**.
> 2. In the **One Check Per** drop-down list, select **Invoice**.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
