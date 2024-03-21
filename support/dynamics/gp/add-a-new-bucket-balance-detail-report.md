---
title: Add a new bucket to Balance-Detail report
description: Describes how to add a new bucket to the "Aged Trial Balance-Detail with Options" report in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, Lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# How to add a new bucket to the "Aged Trial Balance-Detail with Options" report in Payables Management in Microsoft Dynamics GP

This article describes how to add a new bucket to the "Aged Trial Balance-Detail with Options" report in Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864847

## Introduction

By default, the "Aged Trial Balance-Detail with Options" report is set to print the following four aging buckets:

- Current
- 1-30 days
- 31-60 days
- 61 days and over

If you use more than four aging buckets in the Payables Management Setup window, you may have to use Report Writer to add the other aging buckets to the "Aged Trial Balance-Detail with Options" report.

## More information

To add a new bucket to the "Aged Trial Balance-Detail with Options" report in Payables Management, follow these steps:

1. In Microsoft Dynamics GP, start Report Writer. To do it, use the appropriate method:

    - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, point to **Tools**, point to
    **Customize**, and then select **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, select **Tools**, point to
    **Customize**, and then select **Report Writer**.
2. In the **Product** list, select **Microsoft Dynamics GP** or select **Great Plains**, and then select **OK**.
3. Select **Reports**.
4. To insert the report into the **Modified Reports** pane, select the **PM Aged TB-Options-Detail** report in the **Original Reports** list, and then select **Insert**.
5. In the **Modified Reports** list, select **PM Aged TB-Options-Detail**, and then select **Open**.
6. In the Report Definition window, select **Layout**.
7. Create a new calculated field. To do it, follow these steps:

    1. In the Toolbox window, select **Calculated Fields** in the list on the **Layout** tab, and then select **New**.
    2. In the Calculated Field Definition window, specify the following settings:

        - **Name**: Legend 19
        - **Result Type: String**  
        - **Expression Type: Calculated**  
        - On the **Functions** tab, specify the following settings:

            - Select the **System-Defined** option.
            - **Function: STRIP**  
            - Select **Add**.
        - On the **Fields** tab, specify the following settings:

            - **Resources: RW Legends**  
            - **Fields: Legend**  
            - Select **Add**.
            - In the Microsoft Dynamics GP window, type 19 in the **Enter the array index** field, and then select
            **OK**.
        - To close the Calculated Field Definition window, select **OK**.

8. Add the fields to the Report Layout window. To do it, follow these steps.

    > [!NOTE]
    > To make room for the additional fields, you may have to delete some fields in the report, or you may have to make some fields smaller.

    1. Add the **Legend 19** field to the H1 section in the Report Layout window. To do it, drag the **Legend 19** field from the calculated field list in the Toolbox window to the H1 section in the Report Layout window. This field should be positioned on the right side of the **Legend 18** field.
    2. Add the **End Amount-Aging Period** field to the H2 section in the Report Layout window. To do it, follow these steps:

        1. In the Toolbox window, select **PM Aged Trial Balance Document Temporary File** in the list on the
        **Layout** tab.
        2. Select the **End Amount-Aging Period** field, and then drag this field to the H2 section in the Report Layout window.
        3. In the Report Layout window, double-click the **End Amount-Aging Period** field.
        4. In the **Array Index** field, set the value to **5**.
        5. In the **Visibility** field, select **Hide When Empty**.
        6. Select the **Format Field** field until **Calculated Fields** appears.
        7. In the box under the **Format Field** field, select **Func/Rept Index**.
        8. Select **OK**.
    3. Add the **Applied Amount - Aging Periods** field to the B section in the Report Layout window. To do it, follow these steps:

        1. In the Toolbox window, select the **PM Aged Trial Balance Apply To TEMP** table in the list on the
        **Layout** tab.
        2. Select the **Applied Amount - Aging Periods** field.
        3. Drag the **Applied Amount - Aging Periods** field to the B section in the Report Layout window.
        4. In the Report Layout window, double-click the **Applied Amount - Aging Periods** field. The Report Field Option window appears.
        5. In Report Field Option window, set the value to **5** in the **Array Index** field.
        6. Select the **Format Field** field until **Calculated Fields** appears.
        7. In the **Visibility** field, select **Hide When Empty**.
        8. In the box under the **Format Field** field, select **Func/Rept Index**.
        9. Select **OK**.

    4. Add the **Vendor Totals5** field to the F1 section in the Report Layout window. To do it, follow these steps:

        1. Drag the **Vendor Totals5** field from the calculated field list in the Toolbox window to the F1 section in the Report Layout window.
        2. In the Report Layout window, double-click the **Vendor Totals5** field. The Report Field Option window appears.
        3. In Report Field Option window, select **Data** in the **Display Type** field.
        4. Select the **Format Field** field until **Calculated Fields** appears.
        5. In the box under the **Format Field** field, select **Func/Rept Index**.
        6. Select **OK**  

    5. Add the **Legend 19** field to the RF section in the Report Layout window. To do it, follow these steps:

        1. Drag the **Legend 19** field from the calculated field list in the Toolbox window to the RF section in the Report Layout window.
        2. Double-click the **Legend 19** field. The Report Field Option window appears.
        3. In Report Field Option window, select **Data** in the **Display Type** field.
        4. Select the **Format Field** field until **Calculated Fields** appears.
        5. In the box under the **Format Field** field, select **Func/Rept Index**.
        6. Select **OK**.
    6. Add the **Grand Totals5** field to the RF section in the Report Layout window. To do it, follow these steps:

        1. Drag the **Grand Totals5** field from the calculated field list in the Toolbox window to the RF section in the Report Layout window.
        2. Double-click the **Grand Totals5** field. The Report Field Option window appears.
        3. In the Report Field Option window, select **Data** in the **Display Type** field.
        4. Select the **Format Field** field until **Calculated Fields** appears.
        5. In the box under the **Format Field** field, select **Func/Rept Index**.
        6. Select **OK**.
9. Close the Report Layout window, select **Save**, and then select **OK** to save the changes.
10. Exit Report Writer. To do it, use the appropriate method:

    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** on the
    **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.
11. Grant access to the "PM Aged TB-Options-Detail" report. To do it, use the appropriate method:

    - In Microsoft Dynamics GP 10.0, follow these steps:

        1. Select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to
        **System**, and then select **Alternate/Modified Forms and Reports**.
        2. In the "Alternate/Modified Forms and Reports" window, specify the following settings:

            - **ID**: Select the appropriate ID.
            - **Product**: **Microsoft Dynamics GP**  
            - **Type: Reports**  
        3. Under **Alternate/Modified Forms and Reports List**, expand **Purchasing**, expand **PM Aged TB-Options-Detail**, and then select **Microsoft Dynamics GP (Modified)**.

    - If you use the standard security tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, follow these steps:

        1. Select **Tools**, point to **Setup**, point to **System**, and then select **Security**.
        2. In the Security Setup window, specify the following settings:

            - **User ID**: Select a user who you want to grant access to the report.
            - **Company**: Select a company that you currently use.
            - **Product: Microsoft Dynamics GP**  
            - **Type: Modified Reports**  
            - **Series: Purchasing**

        3. Select the **PM Aged TB-Options-Detail** report in the **Access List**, double-click the report, and then verify that an asterisk appears next to the "PM Aged TB-Options-Detail" report.

    - If you use the advanced security tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, follow these steps:

        1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

        2. If you're prompted, type the system password in the **Please Enter Password** box, and then select **OK**.

        3. In the Advanced Security window, select **View** under **Status for current user and company selection**, and then select **by Alternate, Modified and Custom**.

        4. Use one of the following steps, depending on which version is installed:
           - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
           - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains.**  
        5. Expand **Reports**, expand **Purchasing**, and then expand the **PM Aged TB-Options-Detail** report that you modified.

        6. Use one of the following steps, depending on which version is installed:

            - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
            - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified).**

        7. Select **Apply**, and then select **OK**.

            > [!NOTE]
            > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.
