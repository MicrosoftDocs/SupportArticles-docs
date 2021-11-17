---
title: Steps to modify the Employer Number on the Releve 1 (R1) form for Quebec in 2010 in Canadian Payroll for Microsoft Dynamics GP 9.0
description: This article provides steps to change the Employer Number on the Releve 1 (R1) form for Quebec in 2010 in Canadian Payroll for Microsoft Dynamics GP 9.0.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/31/2021
---
# Steps to modify the Employer Number on the Releve 1 (R1) form for Quebec in 2010 in Canadian Payroll for Microsoft Dynamics GP 9.0

This article provides steps to change the Employer Number on the Releve 1 (R1) form for Quebec in Canadian Payroll for Microsoft Dynamics GP 9.0

> [!NOTE]
> This article only applies to Microsoft Dynamics GP 9.0 for the 2010 year-end closing process.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2498913

## Cause

The Employer Number was not coded on the R1 form for Quebec in Round 2 for Microsoft Dynamics GP 9.0.

This doesn't apply to Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010.

## Resolution

The Employer Number on the R1 form must be modified using Report Writer. To do this, follow these steps:

1. Open Report Writer. To do this, click **Tools**, point to **Customize**, and then click **Report Writer**.  
2. Select the product: **Canadian Payroll**, and then click **OK**.
3. Click **Reports**.
4. In the **Original Reports** list, click to select the appropriate R1 form you are using, and then click **Insert** to move it over to the **Modified Reports** list.
5. Click to select the form in the **Modified Reports** list, click **Open** and then **Layout**.  
6. Hide the calculated field on the report showing the **RLNumber** by following these steps:

    1. In the body, double-click the field **RLNumber** at the top of the form.
    2. The **Report Field** Options window will open. Change the **Visibility** field from **Visible** to **Invisible**.
    3. Click **OK**.

7. Create a new field to hard-code the new Employer Number by following these steps:

    1. In the **Toolbox** window, click the **A** button to type text.
    2. On the body of the report, click anywhere near the old field, and then type *FS-10-01-102* to create a new field.
    3. Click somewhere else, and then click on the new field to select it. It will have a box around it with boxes in the corners.
    4. Click **Tools** in the top menu bar, and then click **Drawing Options**.
    5. Set the size and font to be the same as the original field. On the original R1 form, the Font is Courier (generic) and the Font Size is 12.

        > [!NOTE]
        > You can look at the **Drawing Options** on the calculated field in the same manner if you want to double-check the settings.

    6. Click **OK** to close the **Drawing Options** window.
    7. Drag the sides of the newly created field so it is exactly the same size and shape as the invisible calculated field.
    8. Drag the new field over the top of the invisible field.

8. Be sure to follow steps 6-7 for each place you need to change the RLNumber in the body of the form. For example, if you are using a 2-part form, you will need to change it in two places. If you are using a 3-part form, you will need to change it in three places, etc.

9. When you've completed the edits in the body of the report, exit all the windows, and then click **Save** to save the changes.

10. Click **File**, and then click **Microsoft Dynamics GP**.

11. Grant access to the modified form. To do this, follow these steps:

    1. Click **Tools**, point to **Setup**, point to **System**, and then click **Security**.
    2. Enter the User ID and company.
    3. **Product**: Canadian Payroll
    4. **Type**: Modified Reports  
    5. **Series**: Project  
    6. Double-click the Report name so an asterisk appears next to it, indicating that access has been granted.
    7. Click **OK**.
