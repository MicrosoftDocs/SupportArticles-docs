---
title: How to modify invoice to make numbers converted into words
description: Describes how to modify an invoice in Microsoft Dynamics GP so that numbers are converted into words and then displayed at the bottom of the PA Invoice Format Project Detail Page 1 report.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to modify an invoice to make numbers converted into words and shown at the bottom of "PA Invoice Format Project Detail Page 1"

This article describes how to modify an invoice in Project Accounting in Microsoft Dynamics GP so that numbers are converted to words and then displayed at the bottom of the PA Invoice Format Project Detail Page 1 report in Project Accounting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 920825

## More information

You can use a script that contains the `RW_ConvertToWordsAndNumbers` function to convert the numbers to words and then display the words at the bottom of the report. This function has three parameters:

- *in currency IN_Value*: In this parameter, you set the currency value.
- *in string IN_Currency*  In this parameter, you set the currency ID for the currency. If you use a functional currency, leave this parameter blank.
- *in integer IN_Mode*: In this parameter, any value that is not zero causes the report to use words and numbers instead of only words.

### Step 1 - Back up and then open the report

1. Back up the Parept.dic file if you have existing modified Microsoft Dynamics GP reports for Project Accounting. To find the Parept.dic file, follow these steps:
   1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**. If you are prompted, type the system password.
   2. In the Edit Launch File window, select **Project Accounting**. The location of the Parept.dic file is in the **Reports** field.
2. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
3. In the **Product** list, select **Project Accounting**, and then select **OK**.
4. In Report Writer, select **Reports**.
5. In the **Original Reports** list, select **PA Invoice Format Project Detail Page 1**, and then select **Insert**.
6. In the **Modified Reports** list, select **PA Invoice Format Project Detail Page 1**, and then select **Open**.

### Step 2 - Create a calculated field by using the RW_ConvertToWordsAndNumbers function

1. In the Report Definition window, select **Layout**.
2. In the resource list in the Toolbox window, select **Calculated Fields**, and then select **New**.
3. In the Calculated Field Definition window, specify the following settings:
   - **Name**: Numbers to Words
   - **Result Type**: **String**
   - **Expression Type**: **Calculated**
4. Select the **Functions** tab, and then select **User-Defined**.
5. In the **Core** list, select **System**.
6. In the **Function** list, select **RW_ConvertToWordsAndNumbers**, and then select **Add**.
7. Select the **Fields** tab. In the **Resources** list, select **PA Invoice Format HDR TEMP**.
8. In the **Field** list, select **PA Billing Amount**, and then select **Add**.
9. Select the **Constants** tab. In the **Type** list, select **String**, and then select **Add**.
10. In the **Type** list, select **Integer**. In the **Constant** field, type *0*, and then select **Add**.
11. Select **OK**.

### Step 3 - Add the new calculated field to the report layout

1. In the Toolbox window, drag the **Numbers to Words** calculated field to the RF section of the report.
2. If your report is a graphical report, and you want to use the same font in the **Numbers to Words** calculated field that you use in the other fields in this section, follow these steps:
   1. On the **Tools** menu, select **Drawing Options**.
   2. In the Drawing Options window, select **7** in the **Font** list.

### Step 4 - Save the report and then exit Report Writer

1. Close the Report Layout window.
2. Select **Save** when you receive the following message:

   > Do you want to save the changes to this report layout?
3. In the Report Definition window, select **OK**.
4. On the **File** menu, select **Microsoft Dynamics GP**.

### Step 5 - Grant access to the report

#### Method 1 - By using Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

    > [!NOTE]
    > If you are prompted to type the system password, type the system password.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Expand the following nodes:
   - **Project Accounting**
   - **Reports**
   - **Project**
   - **PA Invoice Format Project Detail Page 1**
4. Select **Project Accounting (Modified)**.
5. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, the current user and the current company are selected when you start Advanced Security. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **Advanced Security** dialog box in the **User** area. You can select additional companies in the **Advanced Security** dialog box in the **Company** area.

#### Method 2 - By using Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

    > [!NOTE]
    > If you are prompted to type the system password, type the system password.
2. In the **User ID** list, select the user ID of the user for whom you want to grant access to the report.
3. In the **Product** list, select **Project Accounting**.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select **Project**.
6. In the **Access List** box, double-click **PA Invoice Format Project Detail Page 1**, and then select **OK**.

    > [!NOTE]
    > An asterisk appears next to the report name.
