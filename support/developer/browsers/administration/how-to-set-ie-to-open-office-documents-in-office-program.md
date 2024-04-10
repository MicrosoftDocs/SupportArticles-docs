---
title: How to set IE to open Office documents in Office program
description: Provides a resolution for an issue that occurs when you select an HTML link to a Microsoft Office file and Internet Explorer opens the file in Internet Explorer instead of opening the file in the appropriate Office program.
ms.date: 10/13/2020
ms.reviewer: davidg, JerryHa, ramakoni
---
# How to configure Internet Explorer to open Office documents in the appropriate Office program

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides methods to set Internet Explorer to open Office documents in the appropriate Office program.

_Original product version:_ &nbsp; Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 162059

## Symptoms

When you select an HTML link to a Microsoft Office file (such as a Microsoft Word or Excel document), Internet Explorer may open the file in Internet Explorer, instead of opening the file in the appropriate Office program.

## Cause

This behavior may occur if Internet Explorer is configured to host documents for Office programs that are installed on the computer. By default, Internet Explorer is configured to host documents for Office programs.

## Resolution

To configure Internet Explorer to open Office files in the appropriate Office program instead of in Internet Explorer, use one of the following methods.

> [!NOTE]
> These methods configure Internet Explorer to open Office files in the appropriate Office program for all users.

### Method 1 - Use the Folder Options tool

> [!NOTE]
> If you are running Windows NT 4.0, you may not be able to use the following procedure to configure Internet Explorer to open Office files in the appropriate Office program. If you are running Windows NT 4.0, use method 2.

> [!NOTE]
> If you are running Terminal Server on Windows 2000 or Windows Server 2003, you may not be able to select **Advanced** to open the **Edit File Type** dialog box in step 4 of this procedure. This issue occurs if the NoFileAssociate policy is enabled. Enabling this policy prevents users (including administrators) from changing file type associations for all users.

To configure Internet Explorer to open Office files in the appropriate Office program by using the Folder Options tool:

1. Open **My Computer**.
2. On the **Tools** menu (or the **View** menu), select **Folder Options** (or select **Options**).
3. Select the **File Types** tab.
4. In the **Registered file types** list, select the specific Office document type (for example, Microsoft Excel Worksheet), and then select **Advanced** (or select **Edit**).
5. In the **Edit File Type** dialog box, clear the **Browse in same window** check box (or clear the **Open Web documents in place** check box).
6. Select **OK**.

### Method 2 - Edit the Windows Registry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To configure Internet Explorer to open Office files in the appropriate Office program by editing the Windows registry, set the `BrowserFlags` DWORD value to a correct value for the appropriate document type. To do this, follow these steps:

1. Start Registry Editor (Regedt32.exe).
2. Locate and then select the following registry key:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Classes`

3. Locate the subkey for the specific Office document type. The following table lists the subkeys for several common Office document types.

    ```console
    Document Type Subkey
    ----------------------------------------------------------------------------------------------------------
    Microsoft Office Excel 95 Worksheet Excel.Sheet.5
    Microsoft Office Excel 97-2003 Worksheet Excel.Sheet.8
    Microsoft Office Excel 2007-2010 Worksheet Excel.Sheet.12
    Microsoft Office Excel 2007-2010 Macro-Enabled Worksheet Excel.SheetMacroEnabled.12
    Microsoft Office Excel 2007-2010 Binary Worksheet Excel.SheetBinaryMacroEnabled.12
    Microsoft Office Word 95 Document Word.Document.6
    Microsoft Office Word 97-2003 Document Word.Document.8
    Microsoft Office Word 2007-2010 Document Word.Document.12
    Microsoft Office Word 2007-2010 Macro-Enabled Document Word.DocumentMacroEnabled.12
    Rich Text Format Word.RTF.8
    Microsoft Office PowerPoint 95 Presentation PowerPoint.Show.7
    Microsoft Office PowerPoint 97-2003 Presentation PowerPoint.Show.8
    Microsoft Office PowerPoint 2007-2010 Macro-Enabled Presentation PowerPoint.Show.12
    Microsoft Office PowerPoint 97-2003 Slide Show PowerPoint.Show.8
    Microsoft Office PowerPoint 2007-2010 Slide Show PowerPoint.Show.12
    Microsoft Office PowerPoint 2007-2010 Macro-Enabled Slide Show PowerPoint.ShowMacroEnabled.12
    Microsoft Excel 7.0 worksheet Excel.Sheet.5
    Microsoft Excel 97 worksheetExcel.Sheet.8
    Microsoft Excel 2000 worksheet Excel.Sheet.8
    Microsoft Word 7.0 document Word.Document.6
    Microsoft Word 97 document Word.Document.8
    Microsoft Word 2000 document Word.Document.8
    Microsoft Project 98 project MSProject.Project.8
    Microsoft PowerPoint 2000 document PowerPoint.Show.8
    ```

   To locate the subkey for a document type that is not included in this table, find the subkey for the extension that is associated with the document type. The (default) value for that subkey contains the name of the subkey for that document type. For example, the .xls extension is associated with Excel worksheets. Under the .xls subkey, the (default) value contains the string `Excel.Sheet.5`. Therefore, the subkey for the Microsoft Excel Worksheet document type is the following subkey:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Excel.Sheet.5`

4. After you identify the subkey for the specific Office document type, follow these steps:

   1. If the Office document is a Microsoft Office Excel document, add the following value for all Microsoft Office Excel subkeys except the `Excel.Sheet.5` subkey:

       **Value name**: BrowserFlags  
       **Data type**: REG_DWORD  
       **Value**: 8
  
       For the `Excel.Sheet.5` subkey, add the following value:

       **Value name**: BrowserFlags  
       **Data type**: REG_DWORD  
       **Value**: 9

   2. If the Office document is a Microsoft Office Word document or a Rich Text Format document, add the following value for all Microsoft Office Word subkeys except the `Word.Document.12` subkey, the `Word.DocumentMacroEnabled.12` subkey, and the `Word.RTF.8` subkey.

        **Value name**: BrowserFlags  
        **Data type**: REG_DWORD  
        **Value**: 8

        For the Word.Document.12 subkey, the `Word.DocumentMacroEnabled.12` subkey and the `Word.RTF.8` subkey, add the following value:

        **Value name**: BrowserFlags  
        **Data type**: REG_DWORD  
        **Value**: 44(Decimal)

   3. If the Office document is a Microsoft Office PowerPoint document, add the following value for all subkeys except `PowerPoint.SlideShow.12` and `PowerPoint.SlideShowMacroEnabled.12`.

      **Value name**: BrowserFlags  
      **Data type**: REG_DWORD  
      **Value**: 10(Decimal)

      For `PowerPoint.SlideShow.12` and `PowerPoint.SlideShowMacroEnabled.12`, delete the `BrowerFlags` if it exists.

5. Select **OK**, and then quit Registry Editor.

## Applies to

- Internet Explorer 10
- Internet Explorer 9
- Office Home and Student 2013
- Office Professional Plus 2013
- Office Standard 2013
- Office Home and Business 2013
- Excel 2013
- PowerPoint 2013
- Word 2013
- Office Starter 2010
- Office Professional Plus 2010
- Office Standard 2010
- PowerPoint 2010
- Office Home and Business 2010
- Office Home and Student 2010
- Office Professional 2010
- Microsoft Word 2010
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office PowerPoint 2007
- Microsoft Windows Server 2003 Web Edition
- Microsoft Windows Server 2003 Datacenter Edition (32-bit x86)
- Microsoft Windows Server 2003 Enterprise Edition (32-bit x86)
- Microsoft Windows Server 2003 Standard Edition (32-bit x86)
- Microsoft Office Excel 2003
- Microsoft Office Word 2003
- Microsoft Office PowerPoint 2003
- Microsoft Office Basic Edition 2003
- Microsoft Office Professional Edition 2003
- Microsoft Office Professional Enterprise Edition 2003
- Microsoft Office Standard Edition 2003
- Microsoft Windows XP Home Edition
- Microsoft Windows XP Professional
- Microsoft Windows XP Tablet PC Edition
