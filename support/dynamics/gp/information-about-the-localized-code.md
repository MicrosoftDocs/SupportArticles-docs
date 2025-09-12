---
title: Information about the localized code
description: Describes additional code and functionality that is provided when you install the Australian localized version of Microsoft Great Plains. Also provides information about core features of Microsoft Great Plains that can be enabled for use in Australia.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# Information about the localized code for the Australian version of Microsoft Great Plains

This article outlines the localized code that is added to a Microsoft Dynamics GP installation when you install the Australian localized version. This article also indicates what steps must be followed to enable this code.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 910128

When you select Australia as your country/region during the installation of Microsoft Dynamics GP, the following additional code pieces are included together with the standard installation functionality:

- Auerr.cnk file

  The Auerr.cnk file changes the terminology and formats that are in the Dynamics.dic file to meet Australian requirements. The following table contains examples of the terminology differences:

  |Standard Terminology|Australian Localized Terminology|
  |---|---|
  |Customer|Debtor|
  |Vendor|Creditor|
  |ZIP Code|Postcode|
  |Tax Registration Number|Australian Business Number (ABN)|
  |(XXX)XXX-XXXX Ext. XXXX|(XXX)XXXX-XXXX Ext. XXX|

  The code modifications that are created by this chunk file are not required to use Microsoft Great Plains with an Australian company. However, these modifications make it simpler to store telephone numbers and to enter tax information into the correct fields.

- A4.cnk file

  The A4.cnk file changes many of the standard Microsoft Dynamics report layouts in the Dynamics.dic file to fit reports on A4 paper instead of on U.S. Letter paper. The dimensions of US Letter paper are 8.5" x 11" or 216 mm x 279 mm, whereas the dimensions of A4 paper are 8.27" x 11.69" or 210 mm x 297 mm.

  The code modifications that are created by this chunk file are not required to use Microsoft Great Plains with an Australian company. However, if you try to print default graphical reports on A4 paper in Microsoft Dynamics GP without making these modifications, characters may be lost in the right margin of the paper, and additional white space will appear at the bottom of the page.

- BAS_Rpt.cnk file

  The `BAS_Rpt.cnk` file creates the BAS_Rpt.dic file. The BAS_Rpt.dic file adds functionality to the way that you can report data for GST (Goods and Services Tax) that is collected and paid and for PAYG (Pay As You Go Withholding) that is withheld. This functionality formats the data as required by the Australian Taxation Office (ATO). This data can be reported by using the Business Activity Statement (BAS) and the Installment Activity Statement (IAS). These reports can be printed monthly, quarterly, or annually. The new dictionary also provides links to the Electronic Commerce Interface (ECI) software that is provided by the ATO for automated transmittal.

  > [!NOTE]
  > The Microsoft Dynamics GP GST reporting uses accrual basis accounting. Reporting that uses cash basis accounting of these figures is not provided or supported.

  The BAS_Rpt.dic also adds functionality to print PAYG Vendor Summary reports at the end of the financial year to summarize the total PAYG tax that has been withheld from vendors. This information can also be transmitted electronically by using the ECI software.

  The code modifications that are created by this chunk file are not required to use Great Plains with an Australian company. However, these modifications can make tax reporting simpler for an Australian company.

To enable the Australian functionality, you must also set several parameters in the Microsoft Dynamics GP Company Options window. The best way to enable GST and all the associated features is to select the **Enable GST for Australia** check box. When you select this check box, the Australian Taxation Information Setup wizard starts. If you have installed the `BAS_Rpt.cnk` file. You can use this wizard to quickly configure GST settings.

> [!NOTE]
> To open the Company Options window, select **Tools**, point to **Setup**, point to **Company**, and then select **Company**. In the Company Setup window, select **Options**.

When the Australian Taxation Information Setup wizard is completed, the following options are also set in the Company Options window:

- The **Enable Tax Date** check box is selected.
- The **Allow Summary-Level Tax Edits** check box is cleared.
- The **Enable VAT Return** check box is cleared.
- The following features are also enabled after you enable GST:
  - View Inclusive of Tax
  - Recipient Created Tax Invoices
  - BAS Assignments on Tax Details
  - Tax Invoice Required/Received
  
The final step is to enable PAYG functionality. To do this, enter the Creditor ID for the ATO in the **Withholding Creditor ID** field.

> [!NOTE]
> You must also enter the withholding information for each creditor individually in the Vendor Withholding Options window. To do this, follow these steps:
>
> 1. Open the Vendor Withholding Options window. To do this, select **Cards**, point to **Purchasing**, and then select **Creditor**.
> 2. In the **Creditor ID** field, enter the ID of the creditor for whom you want to update the withholding information. Then select **Withholding**.
