---
title: Add buckets to the Payables Management 
description: This article describes how to add buckets to the Payables Management Aged Trial Balance report for the detail print option in Report Writer in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Add buckets to the Payables Management Aged Trial Balance report for the detail print option in Report Writer in Microsoft Dynamics GP

This article describes how to add buckets to the Payables Management Aged Trial Balance report for the detail print option in Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 948599

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

## Introduction

This article contains steps to add more aging buckets to the Payables Management Aged Trial Balance report for the detail print option in Report Writer in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0. The default Aged Trial Balance report prints four aging buckets.

## Step 1: Back up the Reports.dic file, and then start Report Writer

1. If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

   1. Use the appropriate step:

      - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.

      - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then click **Edit Launch File**.

   1. If you are prompted, type the system password.

   1. Use the appropriate step:

      - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.
      - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.

   1. Note the path that appears in the **Reports** box.

   1. To close the Edit Launch File window, click **OK**.

2. Use the appropriate step:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.

3. Use the appropriate step:

    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.

    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.

## Step 2: Open the report

1. Click **Reports**.

2. In the **Modified Reports** pane, verify that the PM Aged TB - Detail report is listed.

3. If the PM Aged TB - Detail report is not listed, click **PM Aged TB - Detail** in the **Original Reports** pane, and then click **Insert**.

4. In the **Modified Reports** pane, click **PM Aged TB - Detail** in the **Modified Reports** pane, and then click **Open**.

5. In the Report Definition window, click **Layout**.

## Step 3: Create calculated fields

1. In the **Toolbox** list, click **Calculated Fields**, and then click **New**.

2. In the **Name** field, type *LEGEND26*.

3. Click **String** in the **Result Type** area, and then click **Calculated** in the **Expression Type** area.

4. Click **Fields**.
5. Click **RW Legends** in the **Resources** list, click **Legend** in the **Field** list, and then click **Add**.

6. When you are prompted for any array, type *26*, and then click **OK**.

7. Click **OK**.

8. In the **Toolbox** list, click **Calculated Fields**, and then click **New**.

9. In the **Name** field, type *LEGEND27*.

10. Click **String** in the **Result Type** area, and then click **Calculated** in the **Expression Type** area.

11. Click **Fields**.

12. Click **RW Legends** in the **Resources** list, click **Legend** in the **Field** list, and then click **Add**.

13. When you are prompted for any array, type *27*, and then click **OK**.
14. Click **OK**.
15. In the **Toolbox** list, click **Calculated Fields**, and then click **New**.

16. In the **Name** field, type *LEGEND28*.

17. Click **String** in the **Result Type** area, and then click **Calculated** in the **Expression Type** area.

18. Click **Fields**.

19. Click **RW Legends** in the **Resources** list, click **Legend** in the **Field** list, and then click **Add**.

20. When you are prompted for any array, type *28*, and then click **OK**.  

21. Click **OK**.

## Step 4: Add calculated fields to the report

1. In the Toolbox window, drag the **LEGEND26** field the **H1** section of the Report Layout. Position the LEGEND26 field to the right side of the LEGEND25 field.

2. Drag the **Current TRX5** field to the **H2** section of the Report Layout. Position the Current TRX5 field to the right side of the Period4 - Vouch field.

3. In the Report Layout, double-click **Current TRX5**, click **Invisible** in the **Visibility** field, and then click **OK**.

4. In the Toolbox window, drag the **Period5-Voucher** field to the **H2** section of the Report Layout. Position the Period5-Voucher field over Current TRX5 field.
5. In the Report Layout, double-click **Period5 - Vouch**, click **Hide When Empty** in the **Visibility** field, and then click **OK**.

6. In the Toolbox window, drag the **Period5 - Pay** field to the **B** section of the Report Layout. Position the Period5 - Pay field over the Period5 - Pay field.

7. In the Report Layout, double-click **Period5-Pay**, click **Hide When Empty** in the **Visibility** field, and then click **OK**.

8. In the Toolbox window, drag the **Current TRX5** field to the **F1** section of the Report Layout. Position the Current TRX5 field to the right side of the CurrentTRX4 field.

9. In the Report Layout, double-click **Current TRX5**, click **Sum** in the **Display Type** box, and then click **OK**.

10. In the Toolbox window, drag the **LEGEND26** field to the **RF** section of the Report Layout. Position the LEGEND26 field to the right side of the LEGEND25 field.

11. In the Report Layout, double-click **LEGEND26**, click **Data** in the **Display Type** field, and then click **OK**.

12. In the Toolbox window, drag the **Current TRX5** field to the **RF** section of the Report Layout. Position the Current TRX5 field to the right side of the Current TRX4 field.

13. In the Report Layout, double-click **Current TRX5**, click **Sum** in the **Display Type** field, and then click **OK**.

    > [!NOTE]
    > Repeat these steps to add fields for bucket 6 and bucket 7.

## Step 5: Save the changes to the report, and then exit Report Writer

1. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

2. Click **Save** when you are prompted to save the changes to the report layout.

3. Click **Save** when you are prompted to save the changes to the modified report.

## Step 6: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: By using security in Microsoft Dynamics GP 10.0

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.

2. In the **ID** box, type the user ID that will print this modified report.

3. In the **Product** list, click **Microsoft Dynamics GP**.

4. In the **Type** list, click **Reports**.

5. Expand the **Purchasing** folder.

6. Expand the folder for the report you modified.

7. Click to select **Microsoft Dynamics GP (Modified)**.

8. Click **Save**.

9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.

10. In the **User** list, click a user ID.

11. In the **Company** list, click a company.

12. In the **Alternate/Modified Forms and Reports ID** list, click the ID from step 2.

### Method 2: by using the Advanced Security tool in a version earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.

2. If you are prompted, type the system password in the Please Enter Password box, and then click **OK**.

3. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.

4. Use one of the following steps, depending on which version is installed:

    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.

    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.

5. Expand **Reports**, expand **Purchasing**, and then expand the report that you modified.

6. Use one of the following steps, depending on which version is installed:

   - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.

   - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.

7. Click **Apply**, and then click **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

### Method 3: By using the Standard Security tool in a version prior to Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted, type the system password in the Please Enter Password box, and then click **OK**.

3. In the **User ID** list, click the ID of the user who you want to have access to the modified report.

4. In the **Type** list, click **Modified Reports**.

5. In the **Series** list, click **Purchasing**.

6. In the **Access List** box, double-click the report you modified, and then click **OK**.

    > [!NOTE]
    > An asterisk (*) appears next to the report name.

## References

- [How to add buckets to the Payables Management "Aged Trial Balance" report for the summary print option in Report Writer in Microsoft Dynamics GP](https://support.microsoft.com/help/948664)

- [How to add a new bucket to the "Aged Trial Balance-Detail with Options" report in Payables Management in Microsoft Dynamics GP](https://support.microsoft.com/help/864847)

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
