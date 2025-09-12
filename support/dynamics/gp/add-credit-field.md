---
title: Add unit account totals to the Trial Balance Detail report in General Ledger in Microsoft Dynamics GP
description: Describes steps to add unit account totals to the Trial Balance Detail report in General Ledger in Microsoft Dynamics GP.
ms.reviewer: theley, kriszree
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# How to add unit account totals to the Trial Balance Detail report in General Ledger in Microsoft Dynamics GP

This article describes how to add unit account totals to the General Ledger Trial Balance Detail report in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. It describes how to add the **Credit** field. The steps can be modified to apply to the following fields:

- **Beginning Balance**  
- **Debit**  
- **Net Total**  
- **Ending Balance**

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 873908

## Step 1: Back up the Reports.dic file, and then start Report Writer

1. If you have any modified reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. Use the appropriate step:
        - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, on the **Tools** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
    1. If you're prompted, type the system password.
    1. In the Edit Launch File window, click **Microsoft Dynamics GP** or **Great Plains**.
    1. Note the path that is displayed in the **Reports** box.
    1. To close the Edit Launch File window, click **OK**.
    1. Locate the Report.dic file in the path that you noted.
    1. Right-click the **Reports.dic** file, and then click **Copy**.
    1. Browse to a location such as the desktop.
    1. Right-click in this location, and then click **Paste**.

1. Use the appropriate step:
    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools** > **Customize**, and then click **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, on the **Tools** menu, point to **Customize**, and then click **Report Writer**.

1. In the **Product** list, click **Microsoft Dynamics GP** or **Great Plains**, and then click **OK**.

## Step 2: Open the report

1. Click **Reports**.
1. In the **Original Reports** list, click **Trial Balance Detail** > **Insert**.
1. In the **Modified Reports** list, click the same report, and then click **Open**.
1. In the Report Definition window, click **Layout**.

## Step 3: Modify the report

1. In the Toolbox window, click **Calculated Fields** in the resource list, and then click **New**.
1. In the **Name** field, type *Unit Account Totals*.
1. In the **Result Type** list, click **Currency**.
1. In the **Expression Type** area, click **Conditional**.
1. In the **Operators** area, click the equal sign (**=**).
1. Click the **Constants** tab, and then click **Integer** in the **Type** list.
1. In the **Constant** field, type *2*, and then click **Add**.
1. Click the **True Case** field, click the **Fields** tab, and then click **Year-To-Date Transaction Open** in the **Resources** list.
1. In the **Field** list, click **Debit Amount** > **Add**.
1. Click the **False Case** field.
1. Click the **Constants** tab, click **Currency** in the **Type** list, click **Add** > **OK**.
1. In the Toolbox window, click **Calculated Fields** in the resource list.
1. Drag **Unit Account Totals** to the **RF** section of the report.
1. Double-click **Unit Account Totals**, and then click **Sum** in the **Display Type** list.

## Step 4: Save the modified report

1. Close the report. Click **Save** when you're prompted to save your changes.
1. In the Report Definition window, click **OK**.
1. Use the appropriate method:
    - In Microsoft Dynamics GP, click **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 5: Assign security permissions to the modified report

### Method 1: Use security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **Alternate/Modified Forms and Reports**.
1. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
1. In the **ID** box, type the Alternate/Modified Forms and Reports ID that is associated with the user ID that will print this modified report.
1. In the **Product** list, click **Microsoft Dynamics GP**.
1. In the **Type** list, click **Reports**.
1. Expand the **Financial** folder.
1. Expand the folder of the report that you modified.
1. Click **Microsoft Dynamics GP (Modified)** > **Save**.
1. |On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **User Security**.
1. In the **User** list, click a user ID.
1. In the **Company** list, click a company.
1. In the **Alternate/Modified Forms and Reports ID** list, click the ID from step 3.

### Method 2: Use the Advanced Security tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**. Type the system password if you're prompted.
1. Click **View**, and then click **by Alternate, Modified and Custom**.
1. Use the appropriate method:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP.**
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
1. Expand the following nodes:
    - **Reports**
    - **Financial**
    - **Trial Balance Detail**
1. Use the appropriate method:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
1. Click **Apply** > **OK**.
    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

### Method 3: Use standard security in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**. Type the system password if you're prompted.
1. In the **User ID** list, click the user ID of the user who will access the report.
1. In the **Type** list, click **Modified Reports**.
1. In the **Series** list, click **Financial**.
1. In the **Access List** box, double-click **Trial Balance Detail**, and then click **OK**.
    > [!NOTE]
    > After you click **OK**, an asterisk appears next to the report name.
