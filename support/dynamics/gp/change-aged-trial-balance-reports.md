---
title: Modify the aged trial balance reports in Report Writer so that the printed reports show the number of days outstanding in Payables Management in Microsoft Dynamics GP 9.0 and in Microsoft Great Plains 8.0
description: Describes steps to modify the aged trial balance reports in Report Writer so that the printed reports show the number of days outstanding in Payables Management in Microsoft Dynamics GP 9.0 and in Microsoft Great Plains 8.0.
ms.reviewer: ryanklev
ms.topic: how-to
ms.date: 03/13/2024
---
# How to modify the aged trial balance reports in Report Writer so that the printed reports show the number of days outstanding in Payables Management in Microsoft Dynamics GP 9.0 and in Microsoft Great Plains 8.0

This article contains detailed instructions for printing the number of days outstanding for each invoice on an aged trial balance in Microsoft Business Solutions - Great Plains or in Microsoft Dynamics GP. To do it, you must open an aged trial balance report in Report Writer in Microsoft Business Solutions - Great Plains or in Microsoft Dynamics GP, create a new calculated field, add the new field to the layout, and then grant security to the modified report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 910699

## Introduction

Suppose that you must determine which invoices to pay now. To make a good decision, you want to know the number of days that each invoice has been outstanding. This article contains detailed instructions for modifying the aged trial balance reports in Report Writer so that the printed reports show the number of days outstanding for each invoice. You can follow similar steps to modify other reports in Report Writer.

## Step 1: Back up the report, and then open the report

1. Back up the Reports.dic file if you have existing, modified Microsoft Dynamics GP reports. To find the location of the Reports.dic file, follow these steps:
    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
    1. If you're prompted for the password, type the system password.
    1. In the **Edit Launch File** dialog box, click **Microsoft Dynamics GP**.
1. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
1. In the **Product** list, click **Microsoft Dynamics GP** > **OK**.
1. In Report Writer, click **Reports**.
1. In the **Original Reports** column, click the payables aged trial balance report that you want to modify, and then click **Insert**.
1. In the **Modified Reports** list, click the payables trial balance report that you want to modify, and then click **Open**.
1. In the **Report Definition** dialog box, click **Layout**.

## Step 2: Create a calculated field for the number of days outstanding

1. In the resource list on the toolbox, click **Calculated Fields** > **New**.
1. In the **Calculated Field Definition** dialog box, specify the following settings:
    - **Name**: Number of Days Outstanding
    - **Result Type**: **Integer**
    - **Expression Type**: **Calculated**
1. In the **Resources** list, click **Globals**.
1. In the **Field** list, click **User Date** > **Add**.
1. In the **Operators** area, click **-**.
1. In the **Resources** list, click **PM Transaction OPEN File**.
1. In the **Field** list, click **Document Date** > **Add**.
1. Click **OK**.

## Step 3: Add the new calculated field to the report layout

1. On the toolbox, click **Number of Days Outstanding**, and then drag **Number of Days Outstanding** to the **H2** section of the report.
1. To use the same font in the **Number of Days Outstanding** field as in the other fields in this section, follow these steps:
    1. On the **Tools** menu, click **Drawing Options**.
    1. In the **Drawing Options** dialog box, click **7** in the **Font** list.
1. To create a column label for this field on the report, follow these steps:
    1. On the toolbox, click **A**.
    1. Position your pointer in the **H1** section directly above where you put the **Number of Days Outstanding** field in step 1 in the "Step a: Back up the report, and then open the report " section of this article.
    1. Type *Number of Days Outstanding*.
    1. To use the same font in the **Number of Days Outstanding** field as in the other fields in this section, follow these steps:
        1. On the **Tools** menu, click **Drawing Options**.
        1. In the **Drawing Options** dialog box, click **7** in the **Font** list.

## Step 4: Save your report

1. Close the **Report Layout** dialog box. If you're prompted to save changes, click **Save**.
1. In the **Report Definition** dialog box, click **OK**.
1. On the **File** menu, click **Microsoft Dynamics GP**.

## Step 5: Grant access to the report

Use one of the following methods.

### Method 1: Use the Advanced Security functionality

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
1. If you're prompted for a password, type the system password.
1. Click **View** > **by Alternate, Modified and Custom**.
1. Expand the following nodes:
    - **Microsoft Dynamics GP**
    - **Reports**
    - **Purchasing**
    - The trial balance report that you modified
1. Click the **Microsoft Dynamics GP (Modified)** option.
1. Click **Apply** > **OK**.
    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Therefore, changes that you make apply to the current user and to the current company. However, you can select additional users and companies in the **Company** area and in the **User** area of the **Advanced Security** dialog box.

### Method 2: Use standard Microsoft Dynamics GP security functionality

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**. If you're prompted for a password, type the system password.
1. In the **User ID** list, click the user ID for the user whom you want to have access to the report.
1. In the **Type** list, click **Modified Reports**.
1. In the **Series** list, click **Purchasing**.
1. In the **Access List** box, double-click the trial balance report that you modified, and then click **OK**. An asterisk appears next to the report name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
