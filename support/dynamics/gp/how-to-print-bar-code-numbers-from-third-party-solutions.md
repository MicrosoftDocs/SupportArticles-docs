---
title: How to print bar-code numbers from third-party solutions
description: How to print bar-code numbers from third-party solutions in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, 
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to print bar-code numbers from third-party solutions in Microsoft Dynamics GP

This article describes the general guidelines about how to print bar-code number fields in reports in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0. The bar-code numbers are printed from the third-party solutions for bar coding that are listed under the Industry Solutions section of PartnerSource and of CustomerSource.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856450

> [!NOTE]
> You must have administrator user rights or access to Report Writer to follow these steps.

## Prerequisites for printing bar-code numbers

1. You must install a bar-code package that includes fonts on each workstation where you want to print reports. You can buy bar-code fonts, or you can download free bar-code fonts from the Internet.

   > [!NOTE]
   > We do not have a list of compatible bar-code formats. Therefore, you must perform test prints that use the bar-code font to make sure that the font is compatible with your printer.

2. The bar-code number must be recorded somewhere in the Microsoft Dynamics GP system. For example, if you are assigning a bar-code number to each item, you can use the following fields:
    - **Item Number**
    - **Item Description**
    - **Item Short Description**

3. The report must have a table that includes the field that stores the bar-code number.
4. The report must have a graphical format in Report Writer.

5. Most bar-code readers expect a start character and an end character to identify the code field. The common practice is to use an asterisk `*` before and after the field. For example, item A must be entered as `*Item A*` so that the reader can decrypt the field.

## How to configure Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains to print bar-code numbers

### Step 1 - Create a calculated field in Report Writer

You must create a calculated field in Report Writer to accept the bar codes. To do this, follow these steps:

1. Print the report to the screen, and then select **Modify** to open the Report Layout.
2. In the Toolbox, select **Calculated fields**, and then select **New**.
3. In the **New field** dialog box, type or select the following elements in the respective fields:

   - **Name**: Barcode_Field_Name
   - **Result Type**: **String**
   - **Expression Type**: **Calculated**

4. On the **Constants** tab, select the following elements, and then select **Add**:

    - **Type**: **String**
    - **Constant**: *
5. Select the **Cat** button.
6. On the **Functions** tab, select the following elements, and then select **Add**:

   - **Type**: **System-defined**
   - **Function**: **STRIP**

   > [!NOTE]
   > The **STRIP** function removes additional spaces in each field.

7. On the **Fields** tab, select the following elements, and then select **Add**:

    - **Resources**: Table_Name
    - **Field**: Field_Name

    > [!NOTE]
    > Replace the Table_Name place holder with the appropriate table name, and replace the Field_Name place holder with the appropriate field name that contains the bar code.

8. Select the **Cat** button.
9. On the **Constants** tab, select the following elements, and then select **Add**:

    - **Type**: **String**
    - **Constant**: `*`
10. The resulting calculated fields are displayed as follows:

    `"*" # Table_Name . Field_Name # "*"`
11. Select **OK**.
12. In the Toolbox, select **Calculated Fields**.
13. Drag the calculated field that you created to the appropriate area of the Report Layout.
14. On the **File** menu, select **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**. When you are prompted to save changes, select **Save**.

### Step 2 - Grant user rights for the report, and do a test print

#### In Microsoft Dynamics GP 10.0

1. Create the ID to print the modified report. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
    2. If you are prompted, type the system password.
    3. In the **ID** field and in the **Description** field, type the ID and the description that you want to use.
    4. Select the following elements for the respective fields:

        - **Product**: **Microsoft Dynamics GP**
        - **Type**: **Reports**
    5. Expand the appropriate series, expand the appropriate report, and then select **Microsoft Dynamics GP (Modified)**.
    6. Select **Save**.

2. Grant user rights to print the modified report. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then select **User Security**.
    2. Select the user ID and the company database that you want.
    3. In the **Alternate/Modified Forms and Reports ID** field, select the ID that you created in step 1.
    4. Save the changes, and then log off from Microsoft Dynamics GP.
    5. Sign in to Microsoft Dynamics GP, and then print the report.

#### In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

You can use the Advanced Security tool in these versions, as follows:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
2. Type the system password if you are prompted.
3. Select **View**, and then select **by Alternate, Modified and Custom**.
4. Expand the following nodes:

   - **Microsoft Dynamics GP** or **Microsoft Great Plains**
   - **Reports**
5. Expand the appropriate series, and then expand the folder that contains the report that you modified.
6. Select **Microsoft Dynamics GP (Modified)** or **Microsoft Great Plains (Modified)**.
7. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

8. Print the report.

#### In versions earlier than Microsoft Business Solutions - Great Plains 8.0

You can use the Standard Security tool in these versions, as follows:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you are prompted, type the system password.
2. In the **User ID** list, select the ID of the user or users who you want to have access to the modified report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select the appropriate series.
5. In the **Access List** box, double-click the report that you modified, and then select **OK**.
6. Print the report.
