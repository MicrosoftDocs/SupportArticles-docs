---
title: Add line item comments to graphical purchase order reports without creating additional white space in Microsoft Dynamics GP
description: Describes how to add line item comments to graphical purchase order reports without creating additional white space in Microsoft Dynamics GP. You must have access to Report Writer, and you may require the system password to complete these steps.
ms.topic: how-to
ms.reviewer: kfrankha
ms.date: 03/13/2024
---
# How to add line item comments to graphical purchase order reports without creating additional white space in Microsoft Dynamics GP

This article describes how to add line item comments to graphical purchase order reports without creating additional white space in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 906709

## Summary

This article describes how to open the reports in Report Writer and how to modify the sections of a report. This article also describes how to create new calculated fields, how to modify existing calculated fields, and how to adjust the report layout.

> [!NOTE]
> These steps will work only if you do not want to include the **Purchasing Manufacturer Numbers** field.

## Back up and open the report

1. If you have modified any reports, back up the Reports.dic file. If you have not modified any reports, go to step 2.

    To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
    2. If you are prompted to enter a system password, type your password.
    3. Click **Microsoft Dynamics GP** or **Great Plains**. The path of the Reports.dic file appears in the **Reports** box.

    > [!NOTE]
    > The Reports.dic file only exists if you previously modified a report.

2. Start Report Writer, and then use the appropriate method:

    - In Microsoft Dynamics GP 10.0 click **Microsoft Dynamics GP**, point to **Tools**, point to **Customize**, and then click **Report Writer**.

    - In Microsoft Dynamics GP 9.0 and earlier versions, point to **Customize** on the **Tools** menu, and then click **Report Writer**.

3. In the **Product** list, click **Microsoft Dynamics GP** or **Great Plains**, and then click **OK**.
4. In Report Writer, click **Reports**.
5. In the **Original Reports** column, select the purchase order report that you want to modify.
6. Click **Insert** to add the report to the **Modified Reports** column.
7. Click **Open**, and then click **Layout**.

## Modify the report sections

1. On the **Tools** menu, click **Section Options**.
2. In the **Additional Footers** section, click **New** to open the **Footer Options** dialog box.
3. In the **Footer Name** box, type *ORD*.
4. In the **Report Table** list, click **Purchase Order Line Rollup Temp**.
5. In the **Field** list, click **Ord**.
6. Click **OK**.
7. In the **Additional Footers** section, click **Comment 1 Footer**, and then click **Remove**.

    If you are prompted to remove the footer, click **Yes**.
8. Repeat step 7 for the following footers in the **Additional Footers** list:

    - **Comment 2 Footer**
    - **Comment 3 Footer**
    - **Comment 4 Footer**

## Modify the calculated fields

1. In the resource list in the Toolbox window, click **Calculated Fields**.
2. Click **sSuppressComment1**, and then click **Open** to open the **Calculated Field Definition** dialog box.
3. In the **Expression Type** section, click **Conditional**.

    If you are prompted to destroy the current expression, click **Continue**.
4. In the **Expression Type** section, click **Calculated**.
5. In the **Result Type** list, click **Integer**.
6. Click **Constants**.
7. In the **Type** list, click **Integer**.
8. In the **Constant** field, type *0*, click **Add**, and then click **OK**.
9. Repeat step 1 through step 8 for the following calculated fields:

    - **sSuppressComment2**
    - **sSuppressComment3**
    - **sSuppressComment4**

## Adjust the report layout

1. In the resource list in the Toolbox window, click **Purchasing Comment**.
2. Drag the **Comment** field to the **F3** section of the **Report Layout** dialog box. The **Report Field Options** dialog box appears. Enter 1 in the **Array Index** field.
3. Repeat step 1 and step 2 so that you add a total of four **Comment** fields.

    When you are prompted for an array index for each field, type 2 for the second field, type 3 for the third field, and then type 4 for the fourth field.

4. In the **F3** section, move the **Comment4** field to the side of the report.

    > [!NOTE]
    > This comment field will not appear in the printed report. However, this comment field must be in the margin so that a calculated field will work.

5. Drag the **Comment Text** field to the **B** section of the **Report Layout** dialog box.

6. Move the following fields outside the margin of the report:

    - **Manufacturer Item Number**  
    - **Manufacturer**  
    - **Item Description**

7. Drag the **B** section to create sufficient space in the body of the report so that the maximum number of comment lines that you might enter will fit.

    For example, if you print 10 lines of comments, the **B** section should be 10 lines long.
8. Resize the **Comment Text** field to occupy the whole **B** section.
9. Delete the following text fields from the **H7** section:

    - **Manufacturer Item Number**  
    - **Manufacturer**  
    - **Description**

## Create the first new calculated field

1. In the resource list in the Toolbox window, click **Calculated Fields**, and then click **New**.
2. In the **Calculated Field Definition** dialog box, specify the following settings:

    - **Name**: Comment
    - **Expression Type**: **Conditional**  
    - **Result Type**: **Integer**
3. Click the **Expressions Conditional** field.
4. In the **Field** list, click **F3_LAST Comment[1]**, and then click **Add**.
5. In the **Operators** section, click **<>**.
6. Click the **Constants** tab. In the **Type** list, click **String**, and then click **Add**.
7. In the **Operators** section, click **AND**.
8. On the **Fields** tab in the **Field** list, click **F3_LAST Comment[4]**, and then click **Add**.
9. In the **Operators** section, click **=**.
10. Click the **Constants** tab. In the **Type** list, click **String**, and then click **Add**.
11. Click the **True Case** field.
12. On the **Constants** tab in the **Type** list, click **Integer**. In the **Constant** field, type 1 , and then click **Add**.
13. Click the **False Case** field.
14. On the **Constants** tab in the **Constant** field, type *0*, and then click **Add**.

    The calculated field should resemble the following:

    Expressions Conditional: F3_LAST Comment[1] <>'''' AND F3_LAST Comment[4]=''''  
    TRUE CASE: 1  
    FALSE CASE: 0

15. Click **OK**.

## Create the second new calculated field

1. Click **New**.
2. In the **Calculated Field Definition** dialog box, specify the following settings:

    - **Name**: Comment2
    - **Expression Type**: **Conditional**  
    - **Result Type**: **Integer**

3. Click the **Expressions Conditional** field.
4. In the **Resource** list, click **Purchasing Comment**. In the **Field** list, click **Comment**, and then click **Add**. Type 4 when you are prompted to enter an array index.
5. In the **Operators** section, click **<>**.
6. Click the **Constants** tab. In the **Type** list, click **String**, and then click **Add**.
7. Click the **True Case** field.
8. On the **Constants** tab in the **Type** list, click **Integer**. In the **Constant** field, type 1 , and then click **Add**.
9. Click the **False Case** field.
10. On the **Constants** tab in the **Constant** field, type *0*, and then click **Add**.

    The calculated field should resemble the following:

    Expressions Conditional: POP_Comment.Comment[4] <>''''  
    TRUE CASE: 1  
    FALSE CASE: 0

11. Click **OK**.

## Modify the report section options

1. On the **Tools** menu, click **Section Options**.
2. In the **Additional Footer** section, click **ORD**, and then click **Open**.
3. Click to select the **Suppress When Field Is Empty** check box. In the **Calculated Field** list, click **Comment**.
4. Click **OK**.
5. In the **Body** section in the **Calculated Field** list, click **Comment 2**, and then click **OK**.

## Save your report

1. Close the **Report Layout** dialog box.

    If you are prompted to save the changes, click **Save**.
2. In the **Report Definition** dialog box, click **OK**.
3. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

## Grant access to the report

- Microsoft Business Solutions - Great Plains 8.0 and Microsoft Dynamics GP 9.0

  - Method 1: By using the Advanced Security functionality

    1. Click **Tools**, point to **Setup**, point to **System**, and then click **Advanced Security**. Type the system password if you are prompted.
    2. Click **View**, and then click **by Alternate, Modified and Custom**.
    3. Expand the following nodes:

        - **Great Plains**  
        - **Reports**  
        - **Purchasing**
    4. Expand the purchase order form that you modified.
    5. Click **Great Plains (Modified)**.
    6. Click **Apply**, and then click **OK**.

        > [!NOTE]
        > By default, when you open the **Advanced Security** dialog box, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users and companies in the **Company** area and in the **User** area of the **Advanced Security** dialog box.

  - Method 2: By using standard Microsoft Business Solutions - Great Plains security

    1. Click **Tools**, point to **Setup**, point to **System**, and then click **Security**.

        If you are prompted, type the system password.
    2. In the **User ID** list, click the user ID for the user whom you want to have access to the report.
    3. In the **Type** list, click **Modified Reports**.
    4. In the **Series** list, click **Purchasing**.
    5. In the **Access List** box, double-click the report that you modified, and then click **OK**.

        An asterisk (*) appears next to the report name.

- Microsoft Dynamics GP 10.0

1. Create the ID to print the modified report. To do this, follow these steps:

    1. Click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then click **Alternate/Modified Forms and Reports**.

        If you are prompted for the system password, type the system password.
    2. Type the ID in the **ID** box, and then type the description in the **Description** box.
    3. Click **Microsoft Dynamics GP** in the **Product** field, and then click **Reports** in the **Type** field.
    4. Expand **Series**, and then click **Modified Report**.
    5. Click **Save**.

2. Assign the security to print the modified report. To do this, follow these steps:

    1. Click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then click **User Security**.
    2. Click the user ID and the company database.
    3. Click the menu next to the **Alternate/Modified Forms and Reports ID** field, and then click the ID that you created in step 1b.
    4. Save the changes, and then print the report.
