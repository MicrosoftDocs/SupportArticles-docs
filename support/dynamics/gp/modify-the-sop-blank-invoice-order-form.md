---
title: Modify the SOP Blank Invoice Form
description: How to modify the SOP Blank Invoice Form to display the total amount of the invoice in words in Microsoft Dynamics GP and in Microsoft Great Plains.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# How to modify the SOP Blank Invoice Form to display the total amount of the invoice in words in Microsoft Dynamics GP and in Microsoft Great Plains

This article describes how to use Report Writer in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains to modify the SOP Blank Invoice Form to display the total amount of the invoice in words.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917473

## Introduction

To modify the SOP Blank Invoice Form to display the total amount of the invoice in words, follow these steps:

## More information

1. Back up and then open the report. To do it, follow these steps:

    1. If you have existing modified Microsoft Dynamics GP or Microsoft Great Plains reports, back up the Reports.dic file. To find the Reports.dic file, follow these steps:

        1.On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**. If you're prompted, type the system password.
        2.In the **Edit Launch File** dialog box, select **Microsoft Dynamics GP** or **Great Plains**. The location of the Reports.dic file is displayed in the **Reports** field.

    1. Select **Tools**, point to **Customize**, and then select **Report Writer**.
    1. In the **Product** list, select **Microsoft Dynamics GP** or **Great Plains**, and then select **OK**.
    1. In Report Writer, select **Reports**.
    1. In the **Original Reports** column, select **SOP Blank Invoice Form**, and then select **Insert**.
    1. In the **Modified Reports** list, select **SOP Blank Invoice Form**, and then select **Open**.

2. Add a report field that you can use to obtain the correct Currency ID value when you print in originating currency. To do it, follow these steps:

    1. In the **Report Definition** dialog box, select **Layout**.
    1. In the **Toolbox** dialog box, select **Sales Transaction Work** in the **Table** list. Then, select **Currency ID**.
    1. Drag the field onto the **RF** section of the report.
    1. Double-click the field.
    1. Select **Invisible** in the **Visibility** list, select **Last Occurrence** in the **Display Type** box, and then select **OK** to close the dialog box.

3. Create a calculated field to obtain the appropriate Currency ID based on the currency view being used. To do it, follow these steps:

    1. In the **Toolbox** dialog box, select **Calculated Fields** in the **Table** list. Then, select **New**.
    1. In the **Name** box, type **CurrencyID**.
    1. In the **Result Type** list, select **String**, and then select the **Conditional** option in the **Expression Type** area.
    1. Select the **Fields** tab, select **Calculated Fields** in the **Resources** list. Then, select **(C) Force Functional** in the **Field** list.
    1. Select **Add**.
    1. Select **Equals (=)** in the **Operators** section.
    1. Select the **Constants** tab.
    1. In the **Type** list, select **Integer**.
    1. In the **Constant value** box, type **1**. Then, select **Add**.
    1. Select the **True Case** field.
    1. Select the **Fields** tab.
    1. In the **Resources** list, select **Globals**. Then, select **Functional Currency** in the **Field** list.
    1. Select **Add**.
    1. Select the **False Case** field.
    1. Select the **Fields** tab.
    1. In the **Resources** list, select **Report Fields**. Then, select **RF_LAST Currency ID** in the **Field** list.
    1. Select **Add**.
    1. Select **OK** to close the **Calculated Field Definition** dialog box.

4. Create a calculated field by using the **RW_ConvertToWordsAndNumbers** function, and then add the field to the report. To do it, follow these steps:

    1. In the **Toolbox** dialog box, select **Calculated Fields** in the **Table** list, and then select **New**.
    1. In the **Name** box, type **AmountinWords**.
    1. In the **Result Type** list, select **String**. Then, select the **Calculated** option in the **Expression Type** area.
    1. Select the **Functions** tab, and then select **User-Defined**.
    1. In the **Core** list, select **System**. Then, select **RW_ConvertToWordsAndNumbers** in the **Function** list.
    1. Select **Add**.
    1. Select the **Fields** tab.
    1. In the **Resources** list, select **Calculated Fields**. Then, select **F/O Document Amount** in the **Field** list.
    1. Select **Add.**
    1. Select the **Fields** tab.
    1. In the **Resources** list, select **Calculated Fields**. Then, select **CurrencyID** in the **Field** list.
    1. Select **Add**.
    1. In the **Type** list, select **Integer**, and then select **Add**. The calculated expression should resemble the following expression:  
        `FUNCTION_SCRIPT(RW_ConvertToWordsAndNumbers F/O Document Amount CurrencyID 0 )`

        > [!NOTE]
        > There's a limit of 80 characters for calculated fields that contain strings. So if it takes more than 80 characters to display the amount in words, the amount in words will be truncated to the first 80 characters.
    1. Select **OK** to close the **Calculated Field Definition** dialog box.
    1. In the **Toolbox** dialog box, select **Calculated Fields** in the **Table** list. Then, select **AmountinWords**.
    1. Drag the field onto the **RF** section of the report.
    1. Double-click the field, and then select **Data** in the **Display Type** box.
    1. Select **OK** to close the dialog box.
    1. Close the report layout.
    1. When you're prompted to save your changes, select **Save**.

5. Exit Report Writer. To do it, follow these steps:

    1. In the **Report Definition** dialog box, select **OK**.
    1. On the **File** menu, select **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

6. Grant access to the report. To do it, use one of the following methods.

    **Method 1**

    Use the Advanced Security tool. To do it, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. If you're prompted, type the system password.
    1. Select **View**, and then select **by Alternate, Modified and Custom**.
    1. Expand the following nodes:
        - **Microsoft Dynamics GP** or **Great Plains**
        - **Reports**
        - **Sales**
        - **SOP Blank Invoice Form**
    1. Select **Microsoft Dynamics GP (Modified)** or **Great Plains (Modified)**.
    1. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and company are selected. Any changes that you make are for the current user and company. However, you can select additional users and companies in the **User** and **Company** areas of the **Advanced Security** dialog box.

    **Method 2**  
    Use standard Microsoft Dynamics GP or Microsoft Great Plains security. To do it, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you're prompted, type the system password.
    1. In the **User ID** list, select the user ID of the user to whom you want to give access to the report.
    1. In the **Type** list, select **Modified Reports**.
    1. In the **Series** list, select **Sales**.
    1. In the **Access List** box, double-click **SOP Blank Invoice Form**, and then select **OK**. An asterisk appears next to the report name.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
