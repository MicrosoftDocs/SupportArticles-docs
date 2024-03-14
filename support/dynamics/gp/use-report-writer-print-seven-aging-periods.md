---
title: How to use Report Writer to print all seven aging periods on the RM Aged Trial Balance report in Microsoft Dynamics GP 9.0
description: Describes steps to use Report Writer to print all seven aging periods on the RM Aged Trial Balance report in Microsoft Dynamics GP 9.0.
ms.reviewer: theley, lmuelle, kfrankha
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# How to use Report Writer to print all seven aging periods on the RM Aged Trial Balance report in Microsoft Dynamics GP 9.0

This article describes how to use Report Writer to print all seven aging periods on the RM Aged Trial Balance report in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933643

By default, only the first four aging periods appear on the RM Aged Trial Balance report when you print the report. To print all seven periods on the RM Detail Aged Trial Balance report or the RM Quick Detail Aged Trial Balance report, you must modify the report by using Report Writer by following these steps.

## Step 1: Back up and then open the report

Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
1. If you're prompted for the password, type the system password.
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
1. Note the path that appears in the **Reports** box.
1. Click **OK** to close the Edit Launch File window.

## Step 2: Open the report

1. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.
1. Click **Reports**.|
1. In the **Original Reports** area, click **RM Quick Detail Aged Trial Balance** > **Insert**.
    > [!NOTE]
    > This example uses the RM Quick Detail Aged Trial Balance report. Use the appropriate report depending on your scenario.
1. In the **Modified Reports** area, click **RM Quick Detail Aged Trial Balance** > **Open**.

## Step 3: Create a calculated field

1. Click **Layout**.
1. In the Toolbox window, click **Legends** in the resource list, and then click **Legend 5**.
1. Drag **Legend 5** to the **H1** area.
1. In the Toolbox window, click **Calculated Fields** in the resource list, and then click **Bucket 5**.
1. Drag **Bucket 5** to the **H2** area.
1. In the Toolbox window, click **Apply Bucket 5**, and then drag **Apply Bucket 5** to the report body.
1. Double-click each field that you added in the report, click **Hide When Empty** in the **Visibility** list, and then click **OK**.
1. In the Toolbox window, click **Total Bucket Five** in the resource list, and then drag **Total Bucket Five** to the F1 section and the RF section of the report.
1. Double-click **Total Bucket Five** in the **F1** section of the report, click **Sum** in the **Display Type** list, and then click **OK**.
1. Double-click **Total Bucket Five** in the **RF** section of the report, click **Sum** in the **Display Type** list, and then click **OK**.
1. Repeat steps 2-10 to add the following fields:
    - The **Legend 7** field.
    - The **Total Bucket Six** field.
    - The **Total Bucket Seven** field.
1. In the Toolbox window, click **Calculated Fields** in the resource list, and then click **New**.
1. In the **Name** field, type *Legend 5*. In the **Result Type** list, click **String**. In the **Expression Type** area, click **Calculated**.
1. In the **Resources** list, click **RW Legends**. In the **Field** list, click **Legend** > **Add**. When you're prompted, type *5* for the array index, and then click **OK**.
1. Click **OK**, and then drag the **Legend 5** calculated field to the **RF** section and to the **F1** section of the report.
1. In the **RF** section and in the **F1section**, double-click **Legend 5**. In the **Display Type** list, click **Data**.
1. Repeat step 12 through step 16 for the **Legend 6** calculated field and for the **Legend 7** calculated field.
    > [!NOTE]
    > You may have to adjust the formatting in the report. For example, you may have to add dashes to the footers and headers.

## Step 4: Save the modified report

1. Close the report. Click **Save** when you're prompted to save your changes.
1. In the Report Definition window, click **OK**.
1. Use one of the following steps:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 5: Grant access to the modified report

### Method 1: By using Advanced Security

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**. Type the system password if you're prompted.
1. Click **View** > **by Alternate, Modified and Custom**.
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
1. Expand the following nodes:
    - **Reports**
    - **Sales**
    - **RM Quick Detail Aged Trial Balance** or **RM Detail Aged Trial Balance**
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
1. Click **Apply** > **OK**.
    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

### Method 2: By using Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**.
    > [!NOTE]
    > If you're prompted to type the system password, type the system password.
1. In the **User ID** list, click the user ID of the user who will access the report.
1. In the **Type** list, click **Reports**.
1. In the **Series** list, click **Sales**.
1. In the **Access List** box, double-click **RM Quick Detail Aged Trial Balance** or **RM Detail Aged Trial Balance**, and then click **OK**.
    > [!NOTE]
    > After you click **OK**, an asterisk (*) appears next to the report name.

## Step 6: Print the report

Print the report. All seven aging periods should be displayed in the report.

> [!NOTE]
> The legends only print successfully in the report if the report is printed in Microsoft Dynamics GP. The legends don't print successfully in the report if the report is printed in Report Writer.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
