---
title: Registry keys that control the File Repair feature
description: Explains how to open an Excel workbook to repair or recover the data.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2007
  - Excel 2003
  - Excel 2002
ms.date: 03/31/2022
---

# Registry keys that control the File Repair feature in Excel

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Description of the Microsoft Windows registry](https://support.microsoft.com/help/256986).

## Summary

Microsoft Excel contains a feature that allows you to recover data from corrupted workbooks. This article describes how to use the registry to override the default behavior when Excel tries to recover data.

## More information

When you open a workbook in Excel, Excel checks for problems in the workbook. If Excel detects a problem in a workbook, the data recovery process begins automatically. 

> [!NOTE]
> You can also manually start the data recovery process. To do this, click **Open** on the **File** menu, click the arrow on the **Open** button, and then click **Open and Repair**. 

All the registry values that affect data recovery are in the following registry subkeys, depending on which version of Excel you are running:

**Microsoft Excel 2002**

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\10.0\Excel\Options**

**Microsoft Office Excel 2003**

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\11.0\Excel\Options**

**Microsoft Office Excel 2007**

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\12.0\Excel\Options**

These subkeys contains three DWORD registry values that you can modify as follows.

> [!NOTE]
> In these subkeys, 2 is always the default value, and 1 is the only other valid value.

### ExtractDataMode

If ExtractDataMode equals 2 (or a value that is not valid), Excel assumes that the structure of the workbook is not corrupted. Therefore, Excel tries to recover the whole workbook, including formulas, formatting, and Microsoft Visual Basic for Applications (VBA) projects. 

If ExtractDataMode equals 1, Excel assumes that the structure of the workbook is corrupted. Therefore, Excel does not try to recover anything other than the data in the workbook. 

To change the value from 2 to 1, follow these steps. 

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Start Registry Editor.
2. Locate the following registry subkey, as appropriate for the version of Excel that you are running: 
    
    **Excel 2002**

    **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\10.0\Excel\Options**
    
    **Excel 2003**

    **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\11.0\Excel\Options**

    **Excel 2007**

    **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\12.0\Excel\Options**
3.  In the list of registry entries, double-click **ExtractDataMode**.
4.  Type 1in the **Value data** field, and then click **OK**.

### ExtractDataFormulas

If ExtractDataFormulas equals 2 (or a value that is not valid), Excel tries to recover formulas and converts a formula to a value if recovery does not succeed. 

If ExtractDataFormulas equals 1, Excel recovers as much of the formula as possible, and substitutes #REF if recovery does not succeed. This value also affects the default option when you are prompted to recover formulas during the Open and Repair process. 

To change the value from 2 to 1, follow these steps: 

1. Start Registry Editor.
1. Locate the following registry subkey, as appropriate for the version of Excel that you are running:

   **Excel 2002**

   **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\10.0\Excel\Options**

   **Excel 2003**

   **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\11.0\Excel\Options**

   **Excel 2007**

   **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\12.0\Excel\Options**
1. In the list of registry entries, double-click **ExtractDataFormulas**.
1. Type 1in the **Value data** field, and then click **OK**.

### ExtractDataDisableUI

If ExtractDataDisableUI equals 2 (or a value that is not valid), Excel prompts you with two messages during the Open and Repair process. The first message prompts you to choose either to repair or to extract data. The second message prompts you to choose either to convert to values or to recover formulas.

If ExtractDataDisableUI equals 1, Excel does not offer you any options during the Open and Repair process. Excel opens the file by using the Safe Load process. Data extraction is still enabled through the object model and through automatic data recovery. 

To change the value from 2 to 1, follow these steps: 

1. Start Registry Editor.
2. Locate the following registry subkey, as appropriate for the version of Excel that you are running: 
    
   **Excel 2002**

   **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\10.0\Excel\Options**

   **Excel 2003**

   **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\11.0\Excel\Options**

   **Excel 2007**

   **HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\12.0\Excel\Options**
3. In the list of registry entries, double-click **ExtractDataDisableUI**.
4. Type 1in the **Value data** field, and then click **OK**.
