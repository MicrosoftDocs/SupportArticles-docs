---
title: How to truncate last two decimal places for payables checks
description: Describes how to truncate the last two decimal places for payables checks in the Check Total field in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# How to truncate the last two decimal places for payables checks in the Check Total field

This article describes how to truncate the last two decimal places for payables checks in the **Check Total** field in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860603

To truncate the last two decimal places for payables checks in the **Check Total** field, follow these steps.

## Step 1 - Back up the report, and then open the report

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

   1. Perform one of the following steps:

      - In Microsoft Dynamics GP 10.0 and higher versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
      - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File**.

   2. If you are prompted for the password, type the system password, and then select **OK**.
   3. In the Edit Launch File window, select **Microsoft Dynamics GP**.

      The path of the Reports.dic file appears in the **Reports** box.

2. Perform one of the following steps:

   - In Microsoft Dynamics GP 10.0 and higher versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
   - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then select **Report Writer**.

3. In Report Writer, select **Reports**.
4. In the **Original Reports** section, select the report that you want to modify, and then select **Insert**.
5. In the **Modified Reports** list, select the payables check that you want to modify, and then select **Open**.

## Step 2 - Change the format type of the Check Total field

1. In the Report Definition window, select **Layout**. This will open the layout of your report.
2. Double-click the **Check Total** field in the footer 1 (**F1**) section of the layout to open the **Report Field Options** window.
3. Select **None** to the right of the **Format Field** section so that nothing is highlighted in the **Format Field** section.
4. Select the **...** button to the right of the **Format** field to open the Format Lookup window.
5. Select **New** to open the Format Definition window.
6. Type a name for the new format.
7. In the **Decimal Digits** field, type *2*, and then select **OK**.

## Step 3 - Save the report, and then exit Report Writer

1. Close the Report Layout window.
2. Select **Save** when you are prompted to save your changes.
3. In the Report Definition window, select **OK**.
4. On the **File** menu, select **Microsoft Dynamics GP**.

## Step 4 - Grant access to the report

### Method 1 - Use security in Microsoft Dynamics GP 10.0 and higher versions

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Security**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the ID of the user who will print this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand the appropriate series.
6. Expand the report that you modified.
7. Select **Microsoft Dynamics GP (Modified)**.

    > [!NOTE]
    > A check mark is displayed at the beginning of the report name.
8. Select **Save**.

### Method 2 - Use Advanced Security in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions-Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
2. If you are prompted for a password, type the system password, and then select **OK**.
3. Select **View**, and then select **By Alternate, Modified and Custom**.
4. Expand **Microsoft Dynamics GP**, and then expand **Reports**.
5. Expand the appropriate series.
6. Expand the report that you modified.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Apply**, and then select **OK**.

> [!NOTE]
> By default, the current user and company are selected when you start Advanced Security. Any changes that you make are for the current user and company. However, you can select additional users and companies in the **User** field and in the **Company** field in the Advanced Security window.

### Method 3 - Use Microsoft Dynamics GP security in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions-Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
2. If you are prompted for a password, type the system password, and then select **OK**.
3. In the **User ID** list, select the user ID of the user who will access the report.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select the appropriate series.
6. In the **Access List** box, double-click the report that you modified, and then select **OK**.

## More information

For more updated information, see [Information about the "Check Amount to Words" tool in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-information-about-the-check-amount-to-words-tool-in-microsoft-dynamics-gp-3ac6efdb-3c50-d3f3-a4f9-fb61678ecc08) for how to change the wording on the check, and how to change the Check Amount field and rounding.
