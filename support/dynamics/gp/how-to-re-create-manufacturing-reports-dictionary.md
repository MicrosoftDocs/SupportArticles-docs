---
title: How to re-create the manufacturing reports dictionary
description: Discusses how to re-create the manufacturing reports dictionary (ICONRPTS.dic) in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Manufacturing Series
---
# How to re-create the manufacturing reports dictionary in Microsoft Dynamics GP

This article describes how to re-create the manufacturing reports dictionary file (ICONRPTS.dic) in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937819

To re-create the manufacturing reports dictionary file, follow these steps:

1. Export modified forms and reports.

   1. select **Tools**, point to **Customize**, and then select **Customization Maintenance**.
   2. In the **Customization Maintenance** window, select the forms and the reports that you want to export from the current dictionary files.

       > [!NOTE]
       > You can use Shift and Ctrl to select multiple resources. We recommend that you select all the modified reports.

   3. select **Export**.
   4. When you are prompted to select a package file, select the location in which you want to create the package file. Then, select **Save**.

      > [!NOTE]
      >
      > - By default, the package file is created on the desktop. Also by default, the package is named *\<Packagenumber>*.Package. In this name, **number** is an integer that increments by one every time that an export is performed.
      > - A progress bar shows the status of the export. When the export is completed, any errors that are encountered are listed on the screen. Typically, reports in the error list are not exported.

2. Rename the existing ICONRPTS.DIC file. To do this, follow these steps:

   1. Have all users exit out of Microsoft Dynamics GP.
   2. Rename the ICONRPTS.DIC file. The dictionary files may exist on the server or on the client.

        > [!NOTE]
        > You can check the local DYNAMICS.SET file for the correct path for the ICONRPTS.DIC file. By default, the DYNAMICS.SET file and the ICONRPTS.DIC file are in the location: C:\Program Files\Microsoft Dynamics\GP.

   3. Start Microsoft Dynamics GP.

3. Import resources into the new ICONRPTS.DIC file.

   1. select **Tools**, point to **Customize**, and then select **Customization Maintenance**.
   2. In the **Customization Maintenance** window, select **Import**. The Import Package File window opens.
   3. Locate the package file that was created during the previous export process, and then select **Open**.

        > [!NOTE]
        > The Import Package File window lists all resources that exist in the package file.
   4. select **OK** to begin the import.
   5. select **OK** when you are prompted to overwrite the package.

        > [!NOTE]
        > A progress bar shows the status of the import process. Additionally, an error list appears when the import is completed if any errors were encountered. Typically, reports in the error list are imported. However, you may be unable to print the reports.
