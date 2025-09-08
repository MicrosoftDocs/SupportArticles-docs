---
title: Unable to open customizations dictionary error when importing a customized report
description: Describes an error that occurs when you try to import a customized report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Financial - Miscellaneous
---
# "Unable to open customizations dictionary" error when importing a customized report in Microsoft Dynamics GP

This article provides a resolution for the issue that you can't import a customized report due to the "Unable to open customizations dictionary" error in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 869323

## Symptoms

You download a customized report from the Microsoft Dynamics GP Report Library. When you try to import the customized report, you receive the following error message:

> Unable to open customizations dictionary.

In this situation, you're using Microsoft Dynamics GP in a multi-user environment.

## Resolution

To resolve this problem, follow these steps:

1. Confirm that no users are signed in to Microsoft Dynamics GP.
2. Confirm that a Reports.dic file exists. If this is a new installation of Microsoft Dynamics GP, follow these steps to create a Reports.dic file:

   1. On the **Tools** menu, select **Customize**, and then select **Report Writer**.
   2. On the **File** menu, select **Microsoft Dynamics GP**.

       > [!TIP]
       > When you start Report Writer for the first time, a Reports.dic file is created.

3. Try to import the customized report. If you can't import the report, continue with the following steps.

4. Confirm that the Reports.dic file is not read-only. To do this, follow these steps:

   1. In Windows Explorer, locate the Reports.dic file.
   2. Right-click **Reports.dic** and select **Properties**.
   3. On the **General** tab, confirm that the **Read-only** check box is not selected.

5. Determine whether the Reports.dic file is located on the local workstation or is shared on the server in Microsoft Dynamics GP.

    1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Edit Launch File**.
    1. Confirm the path of the Reports.dic file is the same path you found in steps 2 and 3.

6. Start Report Writer.
7. Confirm that you can access the Reports.dic file, and it has no errors.
8. Try to import the customized report from a different workstation. If you can't import the report, continue with the following steps.
9. Recreate the Reports.dic file. To do this, follow these steps:

   1. In Windows Explorer, rename the Reports.dic file.
   2. Create a new Reports.dic file. To do this, follow the procedure in step 2.

      > [!NOTE]
      > If you receive a sharing violation error when you try to rename the Reports.dic file, restart the server or the client computer on which the Reports.dic file is located.

10. Try to import the customized report. If you successfully import the report, import the missing modified reports from the original Reports.dic file.

> [!NOTE]
> If the issue still exists after you apply the above steps, consider the following to solve the issue.
>
> - This error can occur if you import a report for a product you don't have installed on this instance of Microsoft Dynamics GP.
> - This error can also occur if your Forms.dic and Reports.dic files are located on a shared network drive, UNC path, or both. Put the files locally into C drive and try again.
> - Right-click Microsoft Dynamics GP and then select **Run as administrator** to see if this makes a difference with user SA.

## References

- [How to re-create the Reports.dic file in Microsoft Dynamics GP](how-to-re-create-the-reports-dot-dic-file.md)
