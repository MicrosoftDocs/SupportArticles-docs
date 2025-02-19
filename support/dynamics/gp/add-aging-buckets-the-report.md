---
title: Add aging buckets to the report
description: Describes how to use Report Writer in Microsoft Dynamics GP to add aging buckets to the RM Summary Historical Aged Trial Balance report.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# How to add aging buckets to the RM Summary Historical Aged Trial Balance report by using Report Writer in Microsoft Dynamics GP

This article describes how to use Report Writer in Microsoft Dynamics GP to add aging buckets to the RM Summary Historical Aged Trial Balance report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857284

## Introduction

Aging bucket 1 through aging bucket 4 are automatically printed in the aging reports in Receivables Management in Microsoft Dynamics GP. To view the amounts in aging bucket 5 through aging bucket 7, you must manually add the aging buckets to the report. To manually add aging buckets to the report, follow these steps:

## Step 1: Back up the report

1. If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. Use the appropriate step:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File**.
    2. If you're prompted, type the system password.
    3. Use the appropriate step:
        - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0 and in earlier versions, select **Great Plains** in the Edit Launch File window.

    4. > [!NOTE]
       > The path that appears in the **Reports** box.
    5. Select **OK** to close the Edit Launch File window.

## Step 2: Open the report

1. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.
   - In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Customize** on the **Tools** menu, and then select **Report Writer**.
2. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
   - In Microsoft Business Solutions - Great Plains 8.0 and in earlier versions, select **Great Plains** in the **Product** list, and then select **OK**.

3. Select **Reports**.
4. In the **Original Reports** area, select **RM Summary Historical Aged Trial Balance**, and then select **Insert**.
5. In the **Modified Reports** area, select **RM Summary Historical Aged Trial Balance**, and then select **Open**.

## Step 3: Add the fields to the report

1. Select **Layout**.
2. In the Toolbox window, select **Calculated Fields** in the **Resources** list, and then select **Current TRX Amount5**.
3. Drag the **Current TRX Amount5** field to the **RF** section of the report. Then, drag the **Current TRX Amount5** field to the **F1** section of the report. This step will print aging bucket 5. You must move other fields, or you must resize other fields. Put this field on the left side of the **Balance** field.
4. Double-click each field, and then select **Sum** in the **Field** list.
5. Select **OK**.
6. In the Toolbox window, select **Legends** in the **Resources** list, and then select **Legend[5]**.
7. Drag the **Legend[5]** field to the **RF** section of the report. Then, drag the **Legend[5]** field to the **F1** section of the report. This step will print the aging period description. For example, the aging period description may be as follows:  
    120 Days and Over
    > [!NOTE]
    > For graphical reports, if you have to change the font in the new fields to match the fields that are already in the report, continue with steps 8 and 9 in this section.
8. Select a field that was originally in the report. Select **Tools**, and then select **Drawing options**.

    > [!NOTE]
    > The font and the size that is used. Select **OK**.

9. Select the new field. Select **Tools**, and then select **Drawing options**. Define the font and the size to match the existing fields. Select **OK**.
10. You must repeat steps 1 through 7 in this section to add aging bucket 6 and aging bucket 7. To define the aging buckets, use the appropriate step:
    - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Sales**, and then select **Receivables**.
    - In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Tools** on the **Setup** menu, point to **Sales**, and then select **Receivables**.

## Step 4: Save the modified report

1. Close the report. Select **Save** when you're prompted to save the changes.
2. In the Report Definition window, select **OK**.
3. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** on the **File** menu.
   - In Microsoft Business Solutions - Great Plains 8.0 and in earlier versions, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 5: Assign security permissions to the modified report

Method 1: By using Microsoft Dynamics GP security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID of the user who will access this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand the **Sales** folder.
6. Expand the **RM Summary Historical Aged Trial Balance** folder.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Save**.

Method 2: By using the Advanced Security tool in Microsoft Dynamics GP 9.0 and in earlier versions

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

    > [!NOTE]
    > If you're prompted, type the system password.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Use the appropriate step:
   - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
   - In Microsoft Business Solutions - Great Plains 8.0 and in earlier versions, expand **Great Plains**.

4. Expand the following nodes:
   - **Reports**  
   - **Sales**  
   - **RM Summary Historical Aged Trial Balance**
5. Use the appropriate step:
   - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
   - In Microsoft Business Solutions - Great Plains 8.0 and in earlier versions, select **Great Plains (Modified)**.

6. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

Method 3: By using Microsoft Dynamics GP security in Microsoft Dynamics GP 9.0 and in earlier versions

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

    > [!NOTE]
    > If you're prompted, type the system password.
2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Sales**.
5. In the **Access List** box, double-click **RM Summary Historical Aged Trial Balance**, and then select **OK**.

    > [!NOTE]
    > After you select **OK**, an asterisk appears next to the report name.
