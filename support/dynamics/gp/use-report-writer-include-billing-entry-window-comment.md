---
title: Use Report Writer to include the comment from the Billing Entry window on the RM Detail Historical Aged Trial Balance report in Microsoft Dynamics GP
description: Describes the steps to use Report Writer to include the comment from the Billing Entry window on the RM Detail Historical Aged Trial Balance report in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# How to use "Report Writer" to include the comment from the "Billing Entry" window on the "RM Detail Historical Aged Trial Balance" report in Microsoft Dynamics GP

This article lists the steps to include the comment from the Billing Entry window on the RM Detail Historical Aged Trial Balance report. These steps use Report Writer in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922052

To use Report Writer to include the comment from the Billing Entry window on the RM Detail Historical Aged Trial Balance report, follow these steps:

1. If you have any modified Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains reports, back up the Reports.dic file. To find the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
    2. If you're prompted to enter the system password, type the password.
    3. In the Edit Launch File window, click **Microsoft Dynamics GP** or **Great Plains**. The location of the Reports.dic file is displayed in the **Reports** field.
  
2. Start Report Writer by following these steps:
    1. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
    2. In the **Product** list, click to select **Microsoft Dynamics GP** or **Great Plains**, and then click **OK**.
3. Open the RM Detail Historical Aged Trial Balance report by following these steps:
    1. In the Microsoft Dynamics GP window or the Microsoft Business Solutions - Great Plains window, click **Reports**.
    2. In the **Original Reports** box, click **RM Detail Historical Aged Trial Balance** > **Insert**.
    3. In the **Modified Reports** box, click **RM Detail Historical Aged Trial Balance** > **Open**.
4. Create the table relationship by following these steps:
    1. In the Microsoft Dynamics GP window or the Microsoft Business Solutions - Great Plains window, click **Tables** on the **Tables** menu.
    2. In the Tables window, click **RM_HATB_Document_TEMP** > **Open**.
    3. In the Table Definition window, click **Relationships**.
    4. In the Table Relationship window, click **New**.
    5. In the Table Relationship Definition window, click the Secondary Table lookup button next to the **Secondary Table** field.
    6. In the Relationship Table Lookup window, click to select **RM Open File** in the **Table** list, and then click **OK**.
    7. In the **Secondary Table Key** list, click to select **RM_OPEN_Key1**.
    8. In the **Primary Table** column, click to select **Customer Number** for the **Customer Number** row.
    9. In the **Secondary Table** column, click to select **RM Document Type-All** for the **RM Document Type-All** row.
    10. In the **Secondary Table** column, click to select **Document Number** for the **Document Number** row.
5. Click **OK** three times to return the Report Writer window.
6. Close the Tables window.
7. Modify the report layout by following these steps:
    1. In the Report Definition window, click **Tables**.
    2. Click **RM HATB Document TEMP** > **New**.
    3. In the Related Tables window, double-click **RM Open File** in the **Tables** box.
    4. Click **Close** to close the Report Table Relationships window.
    5. In the Report Definition window, click **Layout**.
    6. In the resource list in the Toolbox window, click **RM Open File**.
    7. Drag the **Transaction Description** field to the H2 area in the Report Layout window.
    8. Close the Report Layout window.
    9. Click **Save** when you're prompted to save the changes.
8. In the Report Definition window, click **OK**.
9. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions-Great Plains** to exit Report Writer.
10. Use one of the following methods to grant the user access the report:
  
    Method 1: Use the standard Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains security
  
    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**.
    2. If you're prompted to enter the system password, type the password.
    3. In the **User ID** list, click to select the identifier of the user to whom you want to give access to the report.
    4. In the **Type** list, click to select **Modified Reports**.
    5. In the **Series** list, click to select **Sales**.
    6. In the **Access List** box, double-click **RM Detail Historical Aged Trial Balance**, and then click **OK**.
        > [!NOTE]
        > An asterisk appears next to the report name.
  
    Method 2: Use Advanced Level Security in Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains
  
    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
    2. If you're prompted to enter the system password, type the password.
    3. Click **View** > **by Alternate, Modified and Custom**.
    4. Expand **Microsoft Dynamics GP** or **Great Plains**, expand **Reports** > **Sales** > **RM Detail Historical Aged Trial Balance**.
    5. Click **Microsoft Dynamics GP (Modified)** or **Great Plains (Modified)**.
    6. Click **Apply** > **OK**.
  
        > [!NOTE]
        > By default, the current user and company are selected when you start Advanced Level Security. Any changes that you make apply to the current user and company. However, you can select additional users and companies in the Company area and in the User area of the Advanced Level Security window.
