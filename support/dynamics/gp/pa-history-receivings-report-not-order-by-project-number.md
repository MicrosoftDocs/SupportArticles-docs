---
title: PA History Receivings Report doesn't order by project number in Microsoft Dynamics GP
description: The PA History Receivings Report is not sorted by Project Number. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# PA History Receivings Report does not order by project number in Microsoft Dynamics GP

This article provides a solution to an issue where the PA History Receivings Report doesn't order by project number.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2678985

## Symptom

The PA History Receivings Report is not sorting by Project Number in Microsoft Dynamics GP even though you have selected **by Project Number** in the **Sort** list in the **History Report Options** window.

## Cause

This is a documented bug with the software in Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010.

## Resolution

Use Report Writer to manually add a new sort using the PA PO Receipt Line History table and the PA Project Number field. To do this follow these steps:

1. Open the report in Report Writer. To do this, follow these steps:

    1. Click **Tools**, point to **Customize**, and then click **Report Writer**.
    2. In the Product list, click **Project Accounting**.
    3. On the **Toolbar**, click **Reports**.
    4. In the **Original Reports** list, click **PA History Receivings**, and then click **Insert**.
    5. In the **Modified Reports** list, click **PA History Receivings**, and then click **Open**.
    6. In the **Report Definition** window, click **Sort**.

2. In the **Sorting Definition** window, select PA PO Receipt Line History table, select PA Project Number field and click **Insert**. Click **OK**.

3. Click **OK** on **Report Definition** window.

4. Save your changes, and then exit Report Writer. To do this, follow these steps:

    1. Click **File**, and then click **Microsoft Dynamics GP**.
    2. When you are prompted to save the changes to the layout, click **Save**.
    3. When you are prompted to save the changes to the report, click **Save**.

5. Grant security to the report. To do this, follow these steps.

    1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click Alternate/Modified Forms and Reports.
    2. In the **ID** box, type the Alternate/Modified User ID that is associated with the User ID who will print this modified report.
    3. In the Product list, click **Project Accounting**.
    4. In the Type list, click **Reports**.
    5. Click on the plus sign next to the Project folder.
    6. Click on the plus sign next to the **PA History Receivings**.
    7. Click on the radio button next to Project Accounting (Modified).
    8. Click **Save**.

6. To print the PA History Receivings report, you can go to the **History Report Options** window. On the **Reports** menu, point to **Project**, point to **History**, and then click **Receivings**.
