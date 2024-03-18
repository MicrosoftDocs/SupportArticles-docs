---
title: Dynamics.set unable to open file
description: Provides a solution to an error that occurs when you try to update modified forms and modified reports in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Dynamics.set: unable to open file" Error message when you try to update modified forms and modified reports in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to update modified forms and modified reports in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872680

## Symptoms

When you try to update modified forms and modified reports in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:
> Dynamics.set: unable to open file.

## Resolution

To resolve this problem, follow these steps:

1. Make sure that the Dynamics.000 file is in the Microsoft Dynamics GP application directory. This file is the backup of the Dynamics.dic file for the version that you're updating from. Make sure that the file isn't read-only.
2. After you verify that the Dynamics.000 file is in the Microsoft Dynamics GP application directory, check the Dynamics.set file to make sure that it contains the correct path for the Reports dictionary that has to be updated. If you still receive the error message, the Dynamics.set file may be damaged. Restore the file from the backup. Or, create a new file.
3. Start Microsoft Dynamics GP Utilities. In the Additional Tasks window, select **Update modified forms and reports**, and then select **Process**.
4. Add the sample company data, and then select **Next**.
5. In the "Update Modified Forms and Reports" window, make sure that you select **Microsoft Dynamics GP** as the product, and then select the **Details** button. Select the location of the original Dynamics.dic file that is version 4.0. This file is the file that was renamed to Dynamics.000. Make sure that the path of the Dynamics.000 file is correct because this file is the file that is used to convert the Reports.dic file from one version of Microsoft Dynamics GP to another version.
6. If the previous steps fail, the Reports.dic file that you're trying to update may be damaged. Restore the Reports.dic file from an earlier version, and then try the update again.
7. Verify that the reports were imported successfully. To do it, print the reports in Microsoft Dynamics GP. You may have received a message that states that no invalid references were found. If you receive this message, you have to print the reports. If the reports don't print correctly, the reports must be re-created.
