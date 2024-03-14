---
title: Key Segment not found
description: Provides a solution to errors that occur when after installing a recent update or service pack for Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, jolse
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Key Segment not found", "Error Registering table" or "Table open error" messages after a recent update was installed in Microsoft Dynamics GP

This article provides a solution to errors that occur when after installing a recent update or service pack for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2492442

## Symptoms

After installing a recent update or service pack for Microsoft Dynamics GP, you receive this message in any window or running reports in GP:

> Key Segment not Found  
Error registering table GL_Account_MSTR  
Error registering table GL_Account_Master  
Table Open error

## Cause

The step to update the Reports.dic and Forms.dic may have been missed during the update process. The installation instructions on the main service pack page have instructions to update the modified forms and reports dictionaries before installing the patch file at all client workstations. If these dictionaries weren't updated, the error message above will result when using a modified form or report.

For example, below are the steps listed on the main service pack page for Microsoft Dynamics GP 2010, where step 4 may have been missed.

*If you have Microsoft Dynamics GP 2010 already installed, use the steps below:*

1. Download the latest patch release and installation guide below.
2. At the Microsoft SQL Server, double-click the patch file and the install will be silent and only show a progress window.
3. At the Microsoft SQL Server, launch Microsoft Dynamics GP Utilities and update the DYNAMICS database and all company databases.
4. Once the databases are updated at the server, update the modified forms and reports at the Additional Tasks window. Refer to the installation guide for the steps to update.
5. Install the patch file at all client workstations. The patch file can be published using Automatic Client Updates. Once a user signs in, they'll be automatically prompted to install the patch. Refer to Chapter 5 in the SystemAdminGuide.pdf on the Release 2010 DVD under Documentation*.

## Resolution

After the patch or update has been installed and these messages happen, follow these steps:

1. Make a current backup.

2. Go to the Microsoft Dynamics GP code folder. (Default location is `C:\\Program Files\Microsoft Dynamics\GP\DATA`)

3. Right-click on the Dex.ini file and open it with Notepad. Look for the line Synchronize=FALSE and change it to TRUE (case sensitive). If this line doesn't exist, then add this line to the end of the file as shown below. Close the file and save the changes.

    > Synchronize=TRUE

4. Launch Utilities for Microsoft Dynamics GP to start the synchronization process. To do it, follow the appropriate step:

    - In Microsoft Dynamics GP 2010, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 2010**, and then select **GP Utilities**.
    - In Microsoft Dynamics GP 10.0, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 10.0**, and then select **GP Utilities**.
    - In Microsoft Dynamics GP 9.0, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 9.0**, and then select **GP Utilities**.

5. In the Additional Tasks window, synchronize or upgrade forms and reports, depending on the option available.

6. Launch Microsoft Dynamics GP.

7. Exit Microsoft Dynamics GP.

8. Recreate the Reports.dic using the steps in [KB 850465 - How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/850465).

    > [!NOTE]
    > In step 3 of KB 850465, use the instructions after step 3 to import the modified reports back in using the Report Writer method. If that doesn't work, then try the steps listed in step 3 for the Customization Maintenance method.

9. Test again.

10. If there are also modified forms, use [How to re-create the Forms.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/951767) to recreate the Forms.Dic as well.
