---
title: Re-create the Forms.dic file
description: Describes how to re-create the Forms.dic file in Microsoft Dynamics GP.
ms.reviewer: theley, kyouells, dlanglie, grwill
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to re-create the Forms.dic file in Microsoft Dynamics GP

This article describes how to re-create the Forms.dic file in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 951767

## Resolution

Use the steps below to recreate the Forms.dic file:

## Step 1: Export modified windows from the current Forms.dic file

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Customize** and then select **Customization Maintenance**.
2. Select the forms that you want to export from the current dictionary file. Use the SHIFT key or the CTRL key to select more than one resource.
3. Select **Export**.
4. In the **Please select a package file** window, select the location where you want to save the file, name the package file, and then select **Save**.

    > [!NOTE]
    > By default, the package file name is Package **Number**.Package. *Number* is a placeholder for the number that is incremented every time that an export is performed.

## Step 2: Rename the existing Forms.dic file

Rename the existing Forms.dic file to save it as a backup. To do it, follow these steps:

1. Make sure that all users exit Microsoft Dynamics GP.
2. Start Microsoft Dynamics GP.
3. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **System** and then select **Edit Launch File**.
4. If you're prompted, type the system password.
5. In the **Edit Launch File** window, select **Microsoft Dynamics GP**.
6. Record the path that appears in the **Forms** box.
7. To close the **Edit Launch File** window, select **OK**.
8. Locate the Forms.dic file in the path that you noted.
9. Right-click the Forms.dic file, and then select **Copy**.
10. Browse to a location such as the desktop.
11. Right-click the location to which you browsed, and then select **Paste**.
12. In the path from which you copied the Forms.dic from, delete the Forms.dic file so that it can be re-created in the following [Step 3: Import resources into the new Forms.dic file](#step-3-import-modified-windows-into-the-new-formsdic-file) section.

## Step 3: Import modified windows into the new Forms.dic file

1. In Microsoft Dynamics GP, point to **Tools** on the Microsoft Dynamics GP menu, point to **Customize**, and then select **Customization Maintenance**.
2. Select **Import**.
3. In the **Import Package File** window, locate the package file that you created during the export process, and then select **Open**.
4. In the **Import Package File** window, select **OK** to start the import.

    > [!NOTE]
    > The **Import Package File** window lists all the resources that exist in the package file.

## More information  

To recreate the Reports.dic file, see the steps in [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/850465).
