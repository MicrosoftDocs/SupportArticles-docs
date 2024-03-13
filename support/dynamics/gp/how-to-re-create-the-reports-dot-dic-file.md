---
title: Re-create the Reports.dic file
description: Describes how to re-create the Reports.dic file in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to re-create the Reports.dic file in Microsoft Dynamics GP

This article describes how to re-create the Reports.dic file in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850465

## Introduction

This article describes how to do when you use these programs on a computer that is running Microsoft SQL Server.

## Resolution

To recreate the Reports.dic, use these steps below:

### Step 1: Export Modified Reports from the current Reports.dic file

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP**, point to **Tools**, point to **Customize**, and then select **Customization Maintenance**.
2. Select the forms or the reports that you want to export from the current dictionary files. Use the **SHIFT** key or the **CTRL** key to select more than one resource.
3. Select **Export**.
4. In the **Please select a package file** dialog box, select the location where you want to save the file, name the package file, and then select **Save**.

    > [!NOTE]
    > By default, the package file name is Package **Number**.Package. The **Number** placeholder is a placeholder for the number that is incremented every time that an export is performed.

A progress bar shows the status of the export. If an error occurs during the export, the error is listed on the screen. Generally, reports that appear in the error list aren't exported.

### Step 2: Rename the existing Reports.dic file

1. Make sure that all users exit Microsoft Dynamics GP.
2. Using Windows Explorer, navigate to the GP code folder. Right-click on the **Reports.dic** file and rename it to **Reports.bac**. (The file or files may exist on the server or on the workstation. Review the local Dynamics.set file for the correct path.)
3. Start Microsoft Dynamics GP and select **Tools** under Microsoft Dynamics GP, point to **Customize**, and select **Report Writer**. A new Reports.dic file will be automatically created.

### Step 3: Import Modified Reports back into the new Reports.dic file

1. In Microsoft Dynamics GP, select Microsoft Dynamics GP, point to **Tools**, point to **Customize**, and then select **Customization Maintenance**.
2. Select **Import**.
3. In the **Import Package File** dialog box, locate the package file that you created during the export process, and then select **Open**.

4. In the **Import Package File** dialog box, select **OK** to start the import.

    > [!NOTE]
    >
    > - The **Import Package File** dialog box lists all the resources that exist in the package file.
    > - A progress bar shows the status of the import. If an error occurs during the import, the error is listed on the screen. Generally, reports that appear in the error list are imported. However, users may be unable to print the reports.

### (ALTERNATE STEP 3) Import the reports from within Report Writer

1. Make sure that all users exit Microsoft Dynamics GP.
2. Rename the Reports.dic file to **Reports.bac**. The Reports.dic file may be located on the server or on the workstation.
3. Start Microsoft Dynamics GP.
4. On the **Tools** menu, select **Customize**, and then select **Report Writer**. When Report Writer starts, a new Reports.dic file is created.
5. Select **Reports**. The **Modified Reports** list is empty. If the **Modified Reports** list isn't empty, you renamed the wrong Reports.dic file in the [Step 2: Rename the existing Reports.dic file](#step-2-rename-the-existing-reportsdic-file) section. Find the appropriate Reports.dic file, and then start over in that section.
6. In Report Writer, select **Import**.

7. Select the ellipsis button (**...**) next to the **Source Dictionary** box. Locate the Reports.bac dictionary file that you named in step 2, and then select **Open**.
8. In the **Source Dictionary Reports** list, select the modified reports that you want to import, and then select **Insert**. The reports are listed in the **Reports to Import** list.

9. Select **Import**. When the **Reports to Import** list is empty, the modified reports have been imported into the new Reports.dic file.

> [!NOTE]
> If you created your own table relationships, the table relationships will be removed when you rename the Reports.dic file. After you import the reports, the table relationships that you created will be restored. If you created the relationship but didn't link the relationship to a report, you must create the relationship again.

## More information

To synchronize the forms and reports dictionaries to the GL account framework, refer to the steps in [Error message when you try to log on to Microsoft Dynamics GP after you copy the reports.dic file to a shared location: "Reports Dictionary Must be Upgraded"](https://support.microsoft.com/help/857506).

To recreate the forms.dic, refer to the steps in [How to re-create the Forms.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/951767).
