---
title: How to print Check Date fields in MMDDYYYY in Payables Management reports
description: Introduces how to print the Check Date fields in the Canadian date format of MMDDYYYY in Payables Management reports in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to print the Check Date fields in the Canadian date format of MMDDYYYY in Payables Management reports

This article describes how to print the **Check Date** fields in the Canadian date format of MMDDYYYY in Payables Management reports in Microsoft Dynamics GP. As an illustration, this article will use the PM Check Register report. The steps presented in this article are generic and can be applied to checks as well.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970114

## Step A - Back up the report, and then open the report

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

    1. Follow the appropriate step:

        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File**.

    2. If you are prompted for the password, type the system password.
    3. In the Edit Launch File window, select **Microsoft Dynamics GP**. The path of the Reports.dic file appears in the **Reports** box.

2. Open Report Writer. To do this, follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
    - In Microsoft Dynamics GP 9.0, point to **Customize** on the **Tools** menu, and then select **Report Writer**.

3. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.
4. In Report Writer, select **Reports**.
5. In the **Original Reports** column, select **PM Check Register** report, and then select **Insert**.
6. In the **Modified Reports** list, select the same report, and then select **Open**.
7. In the Report Definition window, select **Layout**.

## Step B - Create the first calculated field that contains the check date

1. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
2. In the Calculated Field Definition window, specify the following settings:
    - **Name**: TEST FORMAT
    - **Result Type**: **String**
    - **Expression Type**: **Calculated**

3. Select the **Functions** tab, and then select **User-Defined**.

4. In the **Core** list, select **System**. Then, in the **Function** list, select **RW_DateToString**.
5. Select **Add**.
6. Select the **Fields** tab. In the **Resource** list, select **Check Register Temp**, and then select **Check Date** in the **Field** list.
7. Select **Add**.
8. Select the **Constants** tab. In the **Type** list, select **String**, and then type MM DD YYYY in the **Constants** field.

   > [!NOTE]
   > There are 3 groups of letters (MM, DD and YYYY) with a space between each group.
9. Select **Add**. The equation of the first calculated field will appear as follows:

   > FUNCTION_SCRIPT(RW_DateToStringPM_Check_Register_TEMP.Check Date"MM DD YYYY")

10. Select **OK**.

## Step C - Create other calculated fields that reference the first calculated field from step B

> [!NOTE]
> These steps describe how to create calculated fields A1 through A8 to format the check date to display as MMDDYYYY.

1. In the Toolbox window, select **Calculated Fields** in the resource list, and then select **New**.
2. In the Calculated Field Definition window, specify the following settings:
    - **Name**: A1
    - **Result Type**: **String**
    - **Expression Type**: **Calculated**

3. Select the **Functions** tab, and then select **System-Defined**. Select **STRIP** in the **Function** list.
4. Select **Add**.
5. Select the **Functions** tab, and then select **User-Defined**. Select **System** in the **Core** list, and then select **RW_Substring** in the **Function** list.
6. Select the **Fields** tab, and then select **Calculated Fields** in the **Resources** list. Select **TEST FORMAT** in the **Field** list, and then select **Add**.
7. Select the **Constants** tab, and then select **Integer** in the **Type** list.
8. Type 1 in the **Constant** field, and then select **Add**.
9. Select **Add** again.
10. Select **OK** to save the calculated field. The equation for A1 will appear as follows:

    > STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 11 ))

11. Repeat step 1 through step 7 to create calculated field A2 through A8. In step 8 and step 9, the integer values will vary. The calculated fields and their equations will appear as follows:

- A2: STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 21 ))
- A3: STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 41 ))
- A4: STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 51 ))
- A5: STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 71 ))
- A6: STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 81 ))
- A7: STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 91 ))
- A8: STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 101 ))

**Additional Notes on the integer value 2, 4, 5, 7, 8, 9 and 10:**

Consider the following scenario: A check exists with the check date 12/10/2009. The TEST FORMAT calculated field that you created will change the date into a string field. Therefore, the date 12/10/2009 is converted to a string field. This allows you to apply the RW_Substring function. The first integer in the RW_Substring function returns the character value that is occupying that space indicated by that integer. The second integer counts how many characters need to be displayed. In this example, the following values are created:

- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 11 )) --> 1
- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 21 )) --> 2
- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 41 )) --> 1
- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 51 )) --> 0
- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 71 )) --> 2
- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 81 )) --> 0
- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 91 )) --> 0
- STRIP(FUNCTION_SCRIPT(RW_SubstringTEST FORMAT 101 )) --> 9

## Step D - Place the calculated fields in the report layout

1. In the Body (B) section of the report, select the **Check Date** field and press the **Delete** key.
2. Expand the Body (B) section of the report to accommodate the calculated fields.
3. Drag the calculated fields A1 through A8 into the Body (B) section of the report. These calculated fields need to be spaced separately (should not be put on top of one another) to format the date as MMDDYYYY.

## Step E - Save the report, and then exit Report Writer

1. Close the report. Select **Save** when you are prompted to save your changes.
2. In the Report Definition window, select **OK**.
3. Select **File**, and then select **Microsoft Dynamics GP**.

## Step F - Grant access to the report

### Method 1 - By using security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Security**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the ID of the user who will print this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand **Sales**.
6. Expand the node for the quote, order, or invoice form that you modified.
7. Select **Microsoft Dynamics GP (Modified).**
   > [!NOTE]
   > A check mark appears at the beginning of the name.
8. Select **Save**.

### Method 2 - By using Advanced Security in Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. If you are prompted, type the system password.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Expand the following nodes:
    - **Microsoft Dynamics GP**
    - **Reports**
    - **Sales**
4. Expand the node for the quote, order, or invoice form that you modified.
5. Select **Microsoft Dynamics GP (Modified)**.
6. Select **Apply**, and then select **OK**.

   > [!NOTE]
   > By default, the current user and company are selected when you start Advanced Security. Any changes that you make are for the current user and company. However, you can select additional users and companies in the **Company** area and in the **User** area of the Advanced Security window.

### Method 3 - By using Microsoft Dynamics GP security in Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you are prompted, type the system password.
2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Purchasing**.
5. In the **Access List** box, double-click the quote, order, or invoice form that you modified, and then select **OK**. An asterisk appears next to the report name.
