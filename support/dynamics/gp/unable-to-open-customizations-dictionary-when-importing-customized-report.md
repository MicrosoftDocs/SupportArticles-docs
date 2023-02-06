---
title: Unable to open customizations dictionary error when importing a customized report
description: Describes an error that occurs when you try to import a customized report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 02/03/2023
---
# "Unable to open customizations dictionary" error when importing a customized report in Microsoft Dynamics GP

This article provides a resolution for the issue that you can't import a customized report due to the **Unable to open customizations dictionary** error in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 869323

## Symptoms

You download a customized report from the Microsoft Dynamics GP Report Library. When you try to import the customized report, you receive the following error message:

> Unable to open customizations dictionary.

In this situation, you are using Microsoft Dynamics GP in a multiuser environment.

To resolve this problem, follow these steps:

1. Confirm that no users are logged on to Microsoft Dynamics GP.
2. Confirm that a Reports.dic file exists. If this is a new installation of Microsoft Dynamics GP, follow these steps to create a Reports.dic file:

   1. On the **Tools** menu, select **Customize**, and then select **Report Writer**.
   2. On the **File** menu, select **Microsoft Dynamics GP**.

       > [!NOTE]
       > When you start Report Writer for the first time, a Reports.dic file is created.

3. Try to import the customized report. If you cannot import the report, continue with the following steps.

4. Confirm that the Reports.dic file is not read-only. To do this, follow these steps:

   1. In Windows Explorer, locate the Reports.dic file.
   2. Right-click **Reports.dic**, and then select **Properties**.
   3. On the **General** tab, confirm that the **Read-only** check box is not selected.

5. Determine whether the Reports.dic file is located on the local workstation or is shared on the server. To do this, follow the appropriate step.

    In Microsoft Dynamics GP

    - On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Edit Launch File**.

    Confirm that the path of the Reports.dic file is the same path that you found in steps 2 and 3.

6. Start Report Writer.
7. Confirm that you can access the Reports.dic file and that it has no errors.
8. Try to import the customized report from a different workstation. If you cannot import the report, continue with the following steps.
9. Re-create the Reports.dic file. To do this, follow these steps:

   1. In Windows Explorer, rename the Reports.dic file.
   2. Create a new Reports.dic file. To do this, follow the procedure in step 2.

      > [!NOTE]
      > If you receive a sharing violation error when you try to rename the Reports.dic file, restart the server or the client computer on which the Reports.dic file is located.

10. Try to import the customized report. If you successfully import the report, import the missing modified reports from the original Reports.dic file.

 > [!NOTE]
       > This error can also happen if you are importing a report for a product you do not have installed on this instance of Dynamics GP.
       > This can also happen if your form.dic and report.dic are located on a shared network drive and/or UNC path.  Put them local to C drive and try again.
       > Launch Dynamics GP by right click and Lauanch as Administrator rights to see if this makes a difference with user SA.

For more information about how to create Reports.dic files, see [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-re-create-the-reports-dic-file-in-microsoft-dynamics-gp-8a85339e-92ed-03ed-5ca8-f538a5c502a7).
