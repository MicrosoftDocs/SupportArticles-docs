---
title: Check Number from Payables Management on GL Detail Trial Balance
description: Describes how to add the check number to detailed GL detailed Trial Balance.
ms.reviewer: 
ms.date: 03/13/2024
---
# Check Number from Payables Management on GL Detail Trial Balance

This article introduces how to add the check number to General Ledger Detailed Trial Balance.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850888

You can modify the Trial Balance Detail in Report Writer to pull the check number onto it.

> [!NOTE]
> This will work for checks entered through Manual Payments (**Transactions** > **Purchasing** > **Manual Payments**) and checks entered through Select Checks (**Transactions** > **Purchasing** > **Select Checks**), but will not work for checks that are entered on the fly (**Transactions** > **Purchasing** > **Transaction Entry**).

1. Go to Report Writer (**Tools** > **Customize** > **Report Writer**).
2. Select the Reports button in the toolbar.
3. Find the Trial Balance Detail in the Original Reports section. Highlight it and select the **Insert** button.
4. Then on the Modified Reports side, highlight the same report and choose the **Open** button.
5. In the Report Definition window, choose the **Layout** button.
6. In the **Toolbox**, choose **Year-to-Date Transaction Open** from the drop-down list.
7. In the scrolling window, find Originating Document Number and drag it into the B section on the report.
8. In the report layout, double-click on the field that was just put on the report.
9. In the **Report Field Options** window, be sure the **Display Type** is set to **Visible**.
10. Set the **Field Type** to **Data**.
11. Choose the **OK** button.
12. Choose the **X** from the top-right corner of the **Report Layout** window.
13. Save your changes.
14. Select **OK** in the **Report Definition** window.
15. From the top menu bar, choose **File** > **Great Plains Dynamics**.
16. Give users access to the modified report in the **Security Setup** window (**Setup** > **System** > **Security**) within Dynamics.
