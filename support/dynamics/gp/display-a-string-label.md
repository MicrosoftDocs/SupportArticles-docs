---
title: Display a string label
description: Describes how to display a radio option in a report in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to display a string label instead of an integer representation of a radio group in Microsoft Dynamics GP

This article describes how to display a string label instead of an integer representation of a radio group in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926393

## Introduction

A setting that you configure by using an option isn‘t stored in a table in Microsoft Dynamics GP.

> [!NOTE]
> Options are also known as radio buttons.

The setting is stored as an integer that represents the selected option. This integer is known as a radio group. If you want to display the value of an option, you can use the integer value that is based on the position of the selected option in the tab sequence. The first position has a value of 0, the second position has a value of 1, and so on. If you want to convert a setting that you configure by using an option into a string representation, use the RW_Token user-defined function. However, because the RW_Token function expects an integer that starts with a value of 1, you must create a calculated field that adds a 1 to the integer value. To create this calculated field, follow these steps.

## Step 1: Back up the Reports.dic file

Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To do it, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
2. If you're prompted for the password, type the system password.
3. In the Edit Launch File window, select the product for the report that you want to modify. Note the path that appears in the **Reports** box.
4. Select **OK** to close the Edit Launch File window.

## Step 2: Open Report Writer

1. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
2. Use the appropriate step:
   - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
   - In Microsoft Business Solutions - Great Plains 8.0 and 7.5, select **Great Plains** in the **Product** list, and then select **OK**.

## Step 3: Modify the report

1. Open the report layout of the report that you're modifying.
2. In the Toolbox window, select **Calculated Fields** in the **Resources** list, and then select **New**.
3. Type a name for the calculated field in the **Name** box.
4. In the **Resources** list, select the table for the radio group field that you want to modify. In the **Field** list, select the radio group field that you want to convert, and then select **Add**.
5. Select the plus sign.
6. Select the **Constants** tab, and then select **Integer** in the **Type** list. In the **Constant** field, type **1**, and then select **Add**.
7. Select **OK**.
8. Select **New**, and then type a name for the string field.
9. In the **Result Type** list, select **String**. In the **Expression Type** list, select **Calculated**.
10. Select the **Functions** tab, and then select **User-Defined**.
11. In the **Core** list, select **System**. In the **Function** list, select **RW_Token**, and then select **Add**.
12. Select the **Constants** tab. In the **Type** list, select **String**.
13. In the **Constant** field, enter the list of strings, and then select **Add**. Separate the strings by using a token character.
14. In the **Constant** field, enter the same token character, and then select **Add**.
15. Select the **Fields** tab, and then select the calculated field that you created.
16. Select **Add**.
17. Select **OK**.
18. Drag the new calculated field into the report.

> [!NOTE]
> The following examples are some sample calculated fields:

- FUNCTION_SCRIPT(RW_Token "One|Two|Three|Four|Five|Six" "|" Radio_Group)
- FUNCTION_SCRIPT(RW_Token "Balance Sheet,Profit and Loss" "," Posting_Type)
- FUNCTION_SCRIPT(RW_Token "Debit:Credit" ":" Typical_Balance)

For more information, see the Report Writer Programmer's Interface document in the Software Development Kit (SDK). You can install the SDK from the Tools folder of CD2 of the Microsoft Dynamics GP installation CDs.

## Step 4: Grant security to the modified report

To grant security to the report, use one of the following methods.

### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. If you're prompted for the password, type the system password.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Expand **Microsoft Dynamics GP** or **Microsoft Great Plains**, expand **Reports**, expand the node for the appropriate series, and then expand the node for the report that you modified.
4. Select **Microsoft Dynamics GP (Modified)** or **Microsoft Great Plains (Modified)**, select **Apply**, and then select **OK**.

> [!NOTE]
> By default, the current user and the current company are selected when you start the Advanced Security tool. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

### Method 2: Use Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you're prompted for the password, type the system password.
2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Product** list, select the product for the report that you modified.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select the series for the report that you modified.
6. In the **Access List** box, double-click the report that you modified, and then select **OK**. An asterisk appears next to the report name.
