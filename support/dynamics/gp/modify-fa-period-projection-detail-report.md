---
title: Modify FA Period Projection-Detail report
description: How to modify the Fixed Assets Period Projection - Detail report to prevent pre-projection amounts from being displayed in Microsoft Dynamics GP.
ms.reviewer: theley, ryanklev, cwaswick, nikkij
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Fixed Assets
---
# How to modify the Fixed Assets Period Projection - Detail report to prevent pre-projection amounts from being displayed in Microsoft Dynamics GP

This article describes how to modify the Fixed Assets Period Projection - Detail report in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0 to prevent pre-projection amounts from being displayed in the report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 915101

## Introduction

In Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, when you run the Fixed Assets Period Projection - Detail report, you enter a date range. You can enter a date range that includes dates after the Depreciated to Date of the asset. If you do it, pre-projection amounts are displayed for the dates that aren't included in the date range. These pre-projection amounts aren't actual depreciation amounts. Instead, these pre-projection amounts are an estimate that is calculated by the project routine.

## More information

To prevent these pre-projection amounts from being displayed on the Fixed Assets Period Projection - Detail report, follow these steps:

1. To open the Fixed Assets Period Projection - Detail report, follow these steps:

    1. On the **Reports** menu, point to **Fixed Assets**, and then select **Projection**.
    1. In the **Projection Reports** dialog box, select **Period Projection - Detail** in the **Reports** list.
    1. Select an option in the Options pane, select **Insert**, and then select **Modify**.
    1. In the Projection Report Options window, select **Destination** to open the Report Destination window, select the **Screen** check box, and then select **OK**.
    1. In the Projection Report Options window, select **Print** to print the report to the screen. On the menu, select **Modify** to open Report Writer.

2. To create the calculated fields, follow these steps:

    **Step 1**: Create Calculated Field 1

    1. In the Toolbox, select **Calculated Fields** in the list of resources, and then select **New**.
    1. In the **Calculated Field Definition** dialog box, type Suppress in the **Name** box.
    1. In the **Result type** list, select **Integer**.
    1. Under **Expression Type**, select **Conditional**.
    1. On the **Fields** tab, select **Calculated Fields** in the **Resources** list.
    1. In the **Field** list, select **Pre-Projection**, and then select **Add**.
    1. Under **Operators**, select **=**.
    1. Select the **Constants** tab, select **String** in the **Type** list, and then select **Add**.
        > [!NOTE]
        > The conditional expression that is created is displayed as follows:  
        >  Pre-Projection = ""
    1. Under **Expressions**, select the **True Case** field to select it.
    1. Select the **Constants** tab, select **Integer** in the **Type** list, type 1 in the **Constant** box, and then select **Add**.
    1. Under **Expressions**, select the **False Case** field.
    1. Select the **Constants** tab, select **Integer** in the **Type** list, type 0 in the **Constant** box, and then select **Add**.
    1. Select **OK** to save the changes.

    **Step 2**: Create Calculated Field 2

    1. In the Toolbox, select **Calculated Fields** in the list of resources, and then select **New**.
    1. Type Suppress 2 for the name.
    1. In the **Result type** list, select **Integer**.
    1. Under **Expression Type**, select **Conditional**.
    1. On the **Fields** tab, select **Report Fields** in the **Resources** list.
    1. In the **Field** list, select **F2_Last Pre-projection**, and then select **Add**.
    1. Under **Operators**, select **=**.
    1. Select the **Constants** tab, select **String** in the **Type** list, type Pre-projection in the **Constant** box, and then select **Add**.
        > [!NOTE]
        > The conditional expression that is created is displayed as follows:  
        > F2_Last Pre-projection = "Pre-projection"
    1. Under **Expressions**, select the **True Case** field.
    1. Select the **Constants** tab, select **Integer** in the **Type** list, type 0 in the **Constant** box, and then select **Add**.
        > [!NOTE]
        > The conditional expression that is created is displayed as follows:  
        > 0
    1. Under **Expressions**, select the **False Case** field.
    1. Select the **Constants** tab, select **Integer** in the **Type** list, type 1 in the **Constant** box, and then select **Add**.
        > [!NOTE]
        > The conditional expression that is created is displayed as follows:
        > 1
    1. Select **OK** to save the changes.

    **Step 3**: Create Calculated Field 3

    1. In the Toolbox, select **Calculated Fields** in the list of resources, and then select **New**.
    1. Type **Total** for the name.
    1. In the **Result type** list, select **Currency**.
    1. Under **Expression Type**, select **Calculated**.
    1. On the **Fields** tab, select **Report Fields** in the **Resources** list.
    1. In the **Field** list, select **F2_SUM YTD Depreciation Amount**, and then select **Add**.
    1. Under **Operators**, select **-**.
    1. In the **Resources** list, select **Report Fields**.
    1. In the **Field** list, select **F2_SUM YTD Depreciation Pre-Projection**, select **Add**, and then select **OK**.

        > [!NOTE]
        > The conditional expression that is created is displayed as follows:  
        > F2_SUM YTD Depreciation Amount - F2_SUM YTD Depreciation Pre-Projection

3. Add the following fields to the Report Layout:
    - **Total**  

        To add this field, follow these steps:

        1. In the F2 section of the report, select the **YTD Depreciation Amount** field, and then press the DELETE key.
        1. In the Toolbox, select **Calculated Fields** as a resource.
        1. In the **Fields** list, select **Total**, and then drag the field to the F2 section of the report.
        1. Double-click the **Total** field to open the Report Field Options window, and then select **Data** under **Display Type**.
        1. Select **OK**.

    - **YTD Depreciation Amount**  

        To add this field, follow these steps:

        1. In the Toolbox, select **Projections Report Master** as a resource.
        1. In the **Fields** list, select **YTD Depreciation Amount**, and then drag the field to the F2 section of the report.
        1. Double-click the **YTD Depreciation Amount** field to open the Report Field Options window, and then select **Sum** under **Display Type**.
        1. Under **Visibility**, select **Invisible**.
        1. Select **OK**.

    - **YTD Depreciation Pre-Projection**  

        To add this field, follow these steps:

        1. In the Toolbox, select **Calculated Fields** as a resource.
        1. In the **Fields** list, select **YTD Depreciation Pre-Projection**, and then drag the field to the F2 section of the report.
        1. Double-click the **YTD Depreciation Pre-Projection** field, and then select **Sum** under **Display Type**.
        1. Under **Visibility**, select **Invisible**.
        1. Select **OK**.

    - **Suppress 2**  

        To add this field, follow these steps:

        1. In the Toolbox, select **Calculated Fields** as a resource.
        1. In the **Fields** list, select **Suppress 2**, and then drag the field to the F2 section of the report.
        1. Double-click the **Suppress 2** field, and then select **Last Occurrence** under **Display Type**.
        1. Under **Visibility**, select **Invisible**.
        1. Select **OK**.

4. Select the **YTD Depreciation Pre Projection** fields in the F1 and F2 sections of the report, and then select **Delete** to remove them from these sections.
5. In the F1 and F2 sections of the report, select and then delete the following text:  
    **Pre-Projection Grand Total:**
6. To suppress the Body (B) section of the report, follow these steps:

    1. On the **Tools** menu, select **Section Options**.
    1. In the Report Section Options window, select the **Body** check box.
    1. Select the **Suppress When Field Is Empty** check box, and then select **Suppress** in the **Calculated Field** list.
    1. Select **OK**.

7. To prevent the F2 section from displaying the pre-projection values, follow these steps:

    1. On the **Tools** menu, select **Section Options**.
    1. In the **Additional Footer** section, select **Fiscal Year**, and then select **Open**.
    1. Select the **Suppress When Field Is Empty** check box, and then select **Suppress 2** in the **Calculated Field** list.
    1. Select **OK** two times.
    1. On the **File** menu, select **Microsoft Dynamics GP**.
    1. Select **Save** when you're prompted to save the changes.

8. Grant access to the modified report by using the appropriate method for your version.

    - For Microsoft Dynamics GP 10.0

        1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
        1. In the **ID** box, select the user ID of the user who will print this modified report from the lookup list.
        1. In the **Product** list, select **Fixed Assets**.
        1. In the **Type** list, select **Reports**.
        1. Expand **Financial**.
        1. Expand the modified report for **FA Period Projection - Detail**.
        1. Select **Microsoft Dynamics GP (Modified)**.
        1. Select **Save**.
        1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
        1. In the **User** list, select a user ID.
        1. In the **Company** list, select a company.
        1. In the **Alternate/Modified Forms and Reports ID** field, select the ID that you entered in step b.

    - For Microsoft Dynamics GP 9.0 or for Microsoft Business Solutions - Great Plains 8.0

        **Method 1**: Use the Advanced Security tool

        1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
        1. If you're prompted for a password, type the system password in the **Please Enter Password** box, and then select **OK**.
        1. In the Advanced Security window, select **View**, and then select **By Alternate, Modified and Custom**.
        1. Expand **Fixed Assets**.
        1. Expand **Reports**, expand **Financial**, and then expand **FA Period Projection - Detail**.
        1. Select the **Fixed Assets (Modified)** report.
        1. Select **Apply**, and then select **OK**.

        > [!NOTE]
        > By default, when you use the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security tool. Additionally, you can select additional companies in the **Company Name** area of the Advanced Security tool.

        **Method 2**: Use the Standard Security tool

        1. Select **Tools**, point to **Setup**, point to **System**, and then select **Security**.
        1. If you're prompted for a password, type the system password in the **Please Enter Password** box, and then select **OK**.
        1. In the **User ID** list, select the user ID of the user who you want to have access to the report.
        1. In the **Product** list, select **Fixed Assets**.
        1. In the **Type** list, select **Modified Reports**.
        1. In the **Series** list, select **Financial**.
        1. In the **Access List** list, double-click **FA Period Projection - Detail**.
        1. Select **OK**.
            > [!NOTE]
            > After you select **OK**, an asterisk appears next to the report name to show that access was granted.
