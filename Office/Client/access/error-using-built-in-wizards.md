---
title: Access 2010 wizard error after installing Office 2010 SP1
description: Fixes an issue in which you receive an error when using the built-in wizards after installing Microsoft Office 2010 SP1.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: kswallow
appliesto: 
  - Access 2010 64 bit
ms.date: 03/31/2022
---
# Wizard error in Access 2010 after installing Office 2010 SP1

## Symptoms

When you use the built-in wizards in Microsoft Access 2010 (64-bit) with Service Pack 1 (SP1), you receive the following error message:

> The database cannot be opened because the VBA project contained in it cannot be read. The database can be opened only if the VBA project is first deleted. Deleting the VBA project removes all code from modules, forms and reports. You should back up your database before attempting to open the database and delete the VBA project.

After you select **OK** in this message, you may receive any of the following errors messages:

> Cannot update. Database or object is read-only.

> The Visual Basic for Applications project in the database is corrupt.

> Microsoft Access can't find the wizard. This wizard has not been installed, or there is an incorrect setting in the Windows Registry, or this wizard has been disabled.

> [!NOTE]
> This issue is specific to the 64-bit version of Access 2010 (64-bit). It does not occur in the 32-bit version of Access 2010.

## Cause

While you install Access 2010 SP1, the built-in wizard files are not successfully updated.

## Resolution

To resolve this problem, follow these steps:

1. Close all instances of Access 2010.
2. Open File Explorer. To do this, select **Start**, type file, and then select **File Explorer** in the results list.
3. Make sure that file extensions are visible. To do this, select the **View** ribbon, and then select the **File name extensions** check box in the **Show/hide** group.

    :::image type="content" source="media/error-using-built-in-wizards/file-name-extensions.png" alt-text="Screenshot to select the File name extensions check box.":::
4. Rename the following files to (\<*filename*>.old extension).

    |     Original File Name    |     Rename To:      |
    |---------------------------|---------------------|
    |     Acwzmain.accde        |     Acwzmain.old    |
    |     Acwzlib.accde         |     Acwzlib.old     |
    |     Acwztool.accde        |     Acwztool.old    |
    |     Utility.accda         |     Utility.old     |

    > [!NOTE]
    > These files are located at `c:\Program Files\Microsoft Office\Office14\ACCWIZ\`.
5. Start Access.

### Did this fix the problem?

If the problem isn't fixed, [contact support](https://support.microsoft.com/contactus).

## References

- ["The database cannot be opened because the VBA project contained in it cannot be read" when you run a compiled Microsoft Access MDE, ACCDE, or ADE file in Access 2010](error-run-compiled-mde-accde-ade.md)
- [Error (Cannot update. Database or object is read-only) in a query against a linked SharePoint view if there are unlinked lookup fields in Access](error-query-against-linked-sharepoint-view.md)
- [Common file name extensions in Windows](https://support.microsoft.com/help/4479981)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
