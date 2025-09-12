---
title: Round a calculated field in Report Writer
description: Describes how to create a calculated field to round to the nearest two decimal places or the nearest whole dollar by using Report Writer in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to round a calculated field in Report Writer in Microsoft Dynamics GP

This article describes how to create a calculated field to use a Report Writer function to round to the nearest two decimal places or the nearest whole dollar by using Report Writer in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872275

## Step A: Back up the report, and then open the report

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

    1. Use the appropriate step:

        - In Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File**.

    2. If you're prompted for the password, type the system password.
    3. In the Edit Launch File window, select **Microsoft Dynamics GP**.

        The path of the Reports.dic file appears in the **Reports** box.

2. Use the appropriate step:

   - In Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
   - In Microsoft Dynamics GP 9.0, point to
   **Customize** on the **Tools** menu, and then select
   **Report Writer**.
3. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.

4. In Report Writer, select **Reports**.

5. In the **Original Reports** section, select the report that you want to modify, and then select **Insert**.
6. In the **Modified Reports** list, select the report that you want to modify, and then select **Open**.
7. In the Report Definition window, select **Layout**.

## Step B: Create a calculated field for the rounding process

1. In the Toolbox window, select **Calculated Fields** in the list, and then select **New**.
2. In the Calculated Field Definition window, type **Rounded** in the **Name** field.
3. In the **Result Type** list, select **Currency**.
4. In the **Expression Type** area, select **Calculated**.
5. Select the **Functions** tab, and then select **User Defined**.
6. In the **Core** list, select **System**.
7. In the **Function** list, select **RW_Round**, and then select **Add**. Select the right parenthesis in the expression at the bottom and select **Remove**.
8. Select the **Fields** tab, select the appropriate resource in the **Resources** list, select the field that you want to round in the **Field** list, and then select **Add**. (You may need to save the calculated field and go to the report layout and check where the field you're trying to edit is named and what table it's from.)
9. Select the **Constants** tab, and then select **Integer** in the **Type** list.
10. In the **Constant** box, type **0**, and then select **Add**.

    > [!NOTE]
    > To round to the right of the decimal separator, type 0 in the **Constant** box. To round to the left of the decimal separator, type **1** in the **Constant** box.
11. In the **Constant** box, enter the number of places to the right or to the left of the decimal separator to round to, and then select **Add**.

    > [!NOTE]
    >
    > - Type **2** if you want to use two decimal places. Type **0** if you don't want to use decimal places.
    > - You can also use a field instead of a constant to specify the number of places. For example, you can use the **Function Decimal Places** field.

12. Again in the Constant box, type the number for the rounding mode that you want to use, and then select **Add**. Type 2 if you want to use the default rounding mode. Select the right parenthesis operator to add that to the end of the equation.

    > [!NOTE]
    > The available modes are as follows:
    >
    > - 0: ROUNDMODE_UP: A value is always rounded up.
    > - 1: ROUNDMODE_DOWN: A value is always rounded down or truncated.
    > - 2: ROUNDMODE_HALF_UP : If the last digit that is to be rounded is five, the value is rounded up.
    > - 3: ROUNDMODE_HALF_DOWN: If the last digit that is to be rounded is five, the value is rounded down.
    > - 4: ROUNDMODE_HALF_EVEN: If the last digit that is to be rounded is five and the previous digit is odd, the value is rounded up. Otherwise, the value is rounded down.
    > - 5: ROUNDMODE_CEILING: The value is always rounded toward positive infinity.
    > - 6: ROUNDMODE_FLOOR: The value is always rounded toward negative infinity.

13. On the calculated expression at the bottom, select the **wording** in the left margin to view the expression: It should like look this:

    ```sql
    FUNCTION_SCRIPT(RW_Roundxxxxx022)
    where xxxxx is the field you are rounding from step 8.
    ```

14. Select **OK** to close the window.
15. Drag the newly created calculated field to the location that you want to use in the layout. You can delete the original field and put this calculated field in its place.
    - Double-click the field, select the ellipsis button (...), and then select an appropriate format. (Suggested is DLR11_$S2.) Select **OK**.
    - Select the calculated field in the Layout and in the top menubar select **Tools and Drawing Options**. Select the appropriate Font style and size to match the other fields on the check. (The default is Helvetica (Generic) and font size of 8.)
16. Select **OK** to close the Report Field Options window.

## Step C: Save the report, and then exit Report Writer

1. Close the Report Layout window.
2. Select **Save** when you're prompted to save your changes.
3. In the Report Definition window, select **OK**.
4. On the **File** menu, select **Microsoft Dynamics GP**.

## Step D: Grant access to the report

- Method 1: Use security in Microsoft Dynamics GP 10.0

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then point to **Alternate/Modified Forms and Reports**.
    2. In the **ID** box, type the ID of the user who will print this modified report.
    3. In the **Product** list, select **Microsoft Dynamics GP**.
    4. In the **Type** list, select **Reports**.
    5. Expand the appropriate series.
    6. Expand the report that you modified.
    7. Select **Microsoft Dynamics GP (Modified)**.

        > [!NOTE]
        > A check mark is displayed at the beginning of the report name.

    8. Select **Save**.

- Method 2: Use Advanced Security in Microsoft Dynamics GP 9.0

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
    2. If you're prompted, type the system password.
    3. Select **View**, and then select **by Alternate, Modified and Custom**.
    4. Expand **Microsoft Dynamics GP**, and then expand **Reports**.
    5. Expand the appropriate series.
    6. Expand the report that you modified.
    7. Select **Microsoft Dynamics GP (Modified)**.
    8. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, the current user and company are selected when you start Advanced Security. Any changes that you make are for the current user and company. However, you can select additional users and companies in the **User** field and in the **Company** field in the Advanced Security window.

- Method 3: Use Microsoft Dynamics GP security in Microsoft Dynamics GP 9.0

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you're prompted, type the system password.
    2. In the **User ID** list, select the user ID of the user who will access the report.
    3. In the **Type** list, select **Modified Reports**.
    4. In the **Series** list, select the appropriate series.
    5. In the **Access List** box, double-click the report that you modified, and then select **OK**.

        An asterisk appears next to the report name.

## References

For more information about how to use Report Writer, refer the Report Writer User's Guide in the **Printable Manuals** section of the **Help** menu.

For more information about the Report Writer functions, see the Report Writer Programmer's Interface document in the Software Development Kit (SDK).
