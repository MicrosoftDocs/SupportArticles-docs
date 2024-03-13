---
title: Add tax details to SOP Blank Invoice Form report in Microsoft Great Plains Report Writer
description: Describes how to add tax details to the SOP Blank Invoice Form report in Microsoft Great Plains Report Writer.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add tax details to the SOP Blank Invoice Form report in Microsoft Great Plains Report Writer

This article describes how to add tax details to the SOP Blank Invoice Form report in Microsoft Business Solutions - Great Plains Report Writer.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 898476

## Add tax details to the SOP Blank Invoice Form report

1. Back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. Click **Tools**, point to **Setup**, point to **System**, and then click **Edit Launch File**.
    2. If you are prompted for the system password, type the system password.
    3. Click **Great Plains**. The path of the Reports.dic file appears in the **Reports** box.

2. Open the report in Report Writer. To do this, follow these steps:
    1. Click **Tools**, point to **Customize**, and then click **Report Writer**.
    2. In the **Product** list, click **Great Plains**.
    3. On the toolbar, click **Reports**.
    4. In the **Original Reports** list, click **SOP Blank Invoice Form**, and then click **Insert**.
    5. In the **Modified Reports** list, click **SOP Blank Invoice Form**, and then click **Open**.
    6. In the Report Definition window, click **Layout**.

3. Create a calculated field for each tax detail. To do this, follow these steps:
    1. In the toolbox resource list, click **Calculated Fields**, and then click **New**.
    1. In the **Name** field, type the name of the first tax detail.
    1. In the **Result Type** list, click **Currency**.
    1. In the **Expression Type** section, click **Calculated**.
    1. On the **Functions** tab, click **User-Defined**.
    1. In the **Core** list, click **Inventory**.
    1. In the **Function** list, click **rw_SOP_GetDocTaxRngAmtMC**, and then click **Add**.
        > [!NOTE]
        > The rw_SOP_GetDocTaxRngAmtMC function was designed to return the amount of the tax for the given range of tax details on the given SOP document. The tax detail parameter is treated as if it has a wildcard to indicate a range.
    1. On the **Fields** tab, click **Sales Document Header Temp** in the **Resources** list.
    1. In the **Field** list, click **SOP Number**, and then click **Add**.
    1. In the **Resources** list, click **Sales Document Header Temp**.
    1. In the **Field** list, click **SOP Type**, and then click **Add**.
    1. On the **Constants** tab, click **String** in the **Type** list.
    1. In the **String** field, type the contents of the **Tax Detail ID** field exactly as those contents appear in the Tax Detail Maintenance window, and then click **Add**.
    1. On the **Fields** tab, click **Calculated Fields** in the **Resources** list.
    1. In the **Field** list, click **(C) Force Functional**, and then click **Add**.
    1. Click **OK**.

        > [!NOTE]
        > The calculated field looks similar to the following: FUNCTION_SCRIPT(rw_SOP_GetDocTaxRngAmtMC SOP_Documment_HDR_TEMP.SOP Number SOP_Document_HDR_TEMP.SOP Type "**Tax Detail ID**"(C)Force Functional).

4. Repeat step 3a through step 3p for each tax detail that you want to print on the report.
5. Drag each calculated field that you created into the **RF** section of the report.
6. Format the fields so that they print the correct currency symbol. To do this, follow these steps:
    1. Double-click the calculated field in the **RF** section of the report.
    2. Click the ellipsis button.
    3. In the **Format Field** section, click **Sales Document Header Temp**. Continue to click, eight times, until **Sales Document Header Temp** changes to .
    4. Under **Calculated Fields**, click **@Curr Index**.
7. Repeat step 6a through step 6d for each calculated field that you created.
8. Save your changes, and then exit Report Writer. To do this, follow these steps:
    1. Click **File**, and then click **Microsoft Business Solutions-Great Plains**.
    2. When you are prompted to save the changes to the layout, click **Save**.
    3. When you are prompted to save the changes to the report, click **Save**.
9. Grant security to the report. To do this, follow these steps.

    > [!NOTE]
    > By default, when you open the Advanced Security window, the current user and the current company are selected, and any changes that you make are for the current user and the current company. To select additional users and companies, click in the **Company** and the **User** sections of the Advanced Security window.

    1. Click **Tools**, point to **Setup**, point to **System**, and then click **Advanced Security**.
    2. If you are prompted for the system password, type the system password.
    3. Click **View**, and then click **by Alternate, Modified and Custom**.
    4. Expand the following nodes:
        - **Great Plains**  
        - **Reports**  
        - **Sales**  
        - **SOP Blank Invoice Form**  
    5. Click to select the **Great Plains (Modified)** check box.
    6. Click **Apply**, and then click **OK**.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
