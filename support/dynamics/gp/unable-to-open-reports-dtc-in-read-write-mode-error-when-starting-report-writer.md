---
title: Unable to open REPORTS.DIC in read/write mode error when starting Report Writer
description: When you start Report Writer in Microsoft Dynamics GP, you receive the error message - Unable to open REPORTS.DIC in read/write mode.
ms.reviewer: theley, lmuelle 
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Unable to open REPORTS.DIC in read/write mode" error when you start Report Writer in Microsoft Dynamics GP

This article provides resolutions for the error **Unable to open REPORTS.DIC in read/write mode** that may occur when you start Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 844869

## Symptoms

When you start Report Writer in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> Unable to open REPORTS.DIC in read/write mode

## Cause

This message occurs when the path of the reports dictionary is incorrect in the Dynamics.set file.

## Resolution

Any one of the following resolutions may work for you. The resolutions have been listed in the order of the time that they require. The resolution that requires the least time is listed first.

If the first resolution does not work for you, trying additional resolutions until you find a resolution that does work for you.

### Resolution 1 - Change the properties of the Reports.dic file

To change the properties of the Reports.dic file, follow these steps:

1. Right-click **Start**, and then select **Explore**.

2. Locate the folder where Microsoft Dynamics GP is installed, and then select the folder icon to open the folder.
3. Right-click the Reports.dic file, and then select **Properties**.
4. In the **Attributes** area, make sure that the **Read-only** check box is not selected.
5. Select **OK**.
6. Start Microsoft Dynamics GP.
7. Start Report Writer.

### Resolution 2 - Change the location of the reports dictionary by using the Edit Launch File program

To change the location of the reports dictionary by using the Edit Launch File program, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Start Microsoft Dynamics GP.

2. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu. Point to **Setup**, point to **System**, and then select **Edit Launch File** to open the Edit Launch File window.
    - In Microsoft Dynamics GP 9.0 or in previous versions, point to **Setup** on the **Tools** menu, point to **System**, and then select **Edit Launch File** to open the Edit Launch File window.

3. In the **Product Name** column, select **Microsoft Dynamics GP** or **Great Plains**.
4. In the **Reports** box in the **Dictionary Locations** area, type the full path of the Reports.dic file.
5. Select **OK**.
6. Start Report Writer.

### Resolution 3 - Change the location of the reports dictionary in the Dynamics.set file

To change the location of the reports dictionary in the Dynamics.set file, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Right-click **Start**, and then select **Explore**.

2. Locate the folder where Microsoft Dynamics GP is installed, and then select the folder icon to open the folder.
3. Right-click the Dynamics.set file, and then select **Edit**. The file opens in Notepad.
4. Type the full path of the Reports.dic file.

   > [!NOTE]
   > Make sure that you are using a generic format to specify the location. Generic formats are described in the System Administrator's Guide manual.

5. Close the Dynamics.set file, and then select **Save** when you are prompted to save the file.
6. Start Microsoft Dynamics GP.
7. Start Report Writer.

### Resolution 4 - Re-create the Dynamics.set file

To re-create the Dynamics.set file, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Right-click **Start**, and then select **Explore**.

2. Locate the folder where Microsoft Dynamics GP is installed, and then select the folder icon to open the folder.
3. Rename the Dynamics.set file.
4. Double-click the Dynamics.exe file.
5. In the Dexterity Runtime window, select **File**, and then select **Create Launch File**. The Create Launch File window opens.
6. In the **Save In** box, locate the folder where Microsoft Dynamics GP is installed, and then select this folder.
7. Select **Save**.
8. If you are prompted to save one or more of the following files, select **Cancel**:

    - Genddf.set
    - Dynutils.set
    - Tutorial.set
9. Close the Dexterity Runtime window.
10. Start Microsoft Dynamics GP.
11. Start Report Writer.
