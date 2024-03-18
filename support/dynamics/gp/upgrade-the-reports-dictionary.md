---
title: Upgrade the Reports Dictionary
description: Describes how to upgrade the Reports Dictionary in Microsoft Dynamics GP.
ms.reviewer: theley, kyouells
ms.topic: how-to
ms.date: 03/13/2024
---
# How to upgrade the Reports Dictionary in Microsoft Dynamics GP

This article describes how to upgrade the Reports Dictionary in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 869717

## Introduction

To upgrade the Reports.dic file and the Forms.dic file, follow these steps.

> [!NOTE]
>
> - You must repeat these steps on each workstation that contains a local Reports.dic file or a local Forms.dic file.
> - In scenarios in which a common (shared) Reports.dic or Forms.dic file is used in a multiple-user environment, follow these steps one time.

## More Information

1. Do a new Microsoft Dynamics GP client installation on the workstation.

    > [!NOTE]
    > You can also use the client/server installation that was completed to update the databases on the server.
2. By using Windows Explorer, copy the Reports.dic file and the Forms.dic file from the previous Microsoft Business Solutions - Great Plains installation directory to the new Microsoft Dynamics GP installation directory. To do it, follow these steps:
    1. Right-click **Start**, and then select **Explore**.
    2. Locate the previous Microsoft Business Solutions - Great Plains installation folder.
    3. Right-click the **Reports.dic** file, and then select **Copy**.

        > [!NOTE]
        > By default, the path of the Reports.dic file is as follows:  
        `C:\Program Files\Microsoft Business Solutions\Great Plains`

    4. Locate the new Microsoft Dynamics GP installation folder.

        > [!NOTE]
        > By default, the path is as follows:  
        `C:\Program Files\Microsoft Dynamics\GP`

    5. On the **Edit** menu, select **Paste**.
    6. Repeat steps b through e to copy and paste the Forms.dic file.

        > [!NOTE]
        > If you are updating from Microsoft Business Solutions - Great Plains 8.0 or from Microsoft Dynamics GP 9.0 to Microsoft Dynamics GP 10.0, copy the Reports.dic file and the Forms.dic file to the DATA folder in the Microsoft Dynamics GP 10.0 client installation directory.
3. To copy the Dynamics.dic file, follow these steps:
    1. In Windows Explorer, locate the previous Microsoft Business Solutions - Great Plains installation folder.
    2. Right-click the **Dynamics.dic** file, and then select **Copy**.
    3. Paste the Dynamics.dic file on the desktop or in a temporary folder.
4. Rename the Dynamics.dic file that you copied in step 3 to Dynamics.000 (three zeros after the period).
5. Put the Dynamics.000 file in the new Microsoft Dynamics GP installation folder. To do it, follow these steps:
    1. Right-click the **Dynamics.000** file, and then select **Copy**.
    2. In Windows Explorer, locate the new Microsoft Dynamics GP installation folder.
    3. On the **Edit** menu, select **Paste**.

6. Make sure that the Microsoft Dynamics GP databases are updated before you go to the next step.
7. To upgrade the Reports.dic file or the Forms.dic file, follow these steps:

    1. Select **Start**, select **All Programs**, point to **Microsoft Dynamics** or to **Microsoft Business Solutions**.
    2. Point to **GP** or to **Great plains**, and then select **Great Plains Utilities** or **GP Utilities**.
    3. Sign in to Great Plains Utilities by using the sa user credentials.
    4. In the Additional Tasks wizard, select **Update modified forms and reports** in the list, and then select **Process**.
8. On the **Locate Launch File** page, type the path, or locate the Dynamics.set file of the new Microsoft Dynamics GP installation, and then select **Next**.
9. On the **Update Modified Forms and Reports** page, select **Microsoft Dynamics GP**.
10. In the Product Details: Microsoft Dynamics GP window, select the folder icon to locate the folder where you saved the Dynamics.000 file in step 5, and then select **Dynamics.000**.

    > [!NOTE]
    > If the Product Details: Microsoft Dynamics GP window does not appear, select **Details**.
11. Select **OK** to close the Product Details: Microsoft Dynamics GP window.
12. Make sure that the **Microsoft Dynamics GP** check box is selected.
13. Select **Update** to start the update of the old Reports.dic file and of the old Forms.dic file. An update progress bar displays the progress, and the update process may take some time to be complete.
14. Select **Next**.
15. On the **Additional Tasks** page, select **Launch Microsoft Dynamics GP** to open the Microsoft Dynamics GP sign-in page.

For more information about how to upgrade reports, see the "Reports that won't Update" section of the Upgrade.pdf file. The Upgrade.pdf file is located on Installation CD 1 under **Documentation**.
