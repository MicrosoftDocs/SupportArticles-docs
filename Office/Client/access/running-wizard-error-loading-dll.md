---
title: Error in loading dll when running wizards
description: Fixes an issue in which you receive the error 'Error in loading dll' or 'Object library not registered' when you run wizards in Access.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 106913
  - CSSTroubleshoot
ms.reviewer: denniwil
appliesto: 
  - Access 2010
  - Access 2013
  - Access 2016
  - Access 2019
  - Access for Microsoft 365
search.appverid: MET150
ms.date: 05/26/2025
---
# Microsoft Office Access: 'Error in loading dll'

## Symptoms

When trying to run wizards in Microsoft Office Access, such as the Import Wizards, the Query Wizard, the Report Wizard, and Control Wizards, you receive one of the following errors:

> "Error in loading dll"

> "Object library not registered"

## Cause

One of the following registry keys may not exist.

### ACEDAO.DLL

#### MSI installations

- (64-bit Windows, 32-bit Office):

  **Key**: `HKEY_CLASSES_ROOT\ TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win32`

  **String**: (Default)

  **Value**: C:\Program Files (x86)\Common Files\Microsoft Shared\OFFICE14\ACEDAO.DLL

- (64-bit Windows, 64-bit Office):

  **Key**: `HKEY_CLASSES_ROOT\ TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win64`

  **String**: (Default)

  **Value**: C:\Program Files\Common Files\Microsoft Shared\OFFICE14\ACEDAO.DLL

- (32-bit Windows, 32-bit Office):

  **Key**: `HKEY_CLASSES_ROOT\ TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win32`

  **String**: (Default)

  **Value**: C:\Program Files\Common Files\Microsoft Shared\OFFICE14\ACEDAO.DLL

> [!NOTE]
> OFFICE14 is used in the above registry key path. This should represent the current version of Access installed.
>
> - OFFICE12 - Access 2007
> - OFFICE14 - Access 2010
> - OFFICE15 - Access 2013
> - OFFICE16 - Access 2016

#### Click-to-Run installations

- (64-bit Windows, 32-bit Office):

  **Key**: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\ClickToRun\REGISTRY\MACHINE\SOFTWARE\Classes\TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win32`

  **String**: (Default)

  **Value**: C:\Program Files (x86)\Common Files\Microsoft Shared\OFFICE16\ACEDAO.DLL

- (64-bit Windows, 64-bit Office):

  **Key**: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\ClickToRun\REGISTRY\MACHINE\SOFTWARE\Classes\TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win64`

  **String**: (Default)

  **Value**: C:\Program Files\Common Files\Microsoft Shared\OFFICE16\ACEDAO.DLL

- (32-bit Windows, 32-bit Office):

  **Key**: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\ClickToRun\REGISTRY\MACHINE\SOFTWARE\Classes\TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win32`

  **String**: (Default)

  **Value**: C:\Program Files\Common Files\Microsoft Shared\OFFICE16\ACEDAO.DLL

### DAO360.DLL

- (64-bit Windows, 32-bit Office)

  **Key**: `HKEY_CLASSES_ROOT\TYPELIB\{00025E01-0000-0000-C000-000000000046}\5.0\0\win32`

  **String**: (Default)

  **Value**: %CommonProgramFiles(x86)%\Microsoft Shared\DAO\dao360.dll

- (64-bit Windows, 64-bit Office) or (32-bit Windows, 32-bit Office)

  **Key**: `HKEY_CLASSES_ROOT\TYPELIB\{00025E01-0000-0000-C000-000000000046}\5.0\0\win32`

  **String**: (Default)

  **Value**: %CommonProgramFiles%\Microsoft Shared\DAO\dao360.dll

## Resolution

To resolve the issue for MSI installations by setting the correct values for these dlls in the registry , go to the [Let me fix it myself](#let-me-fix-it-myself) section. To resolve the issue for Click-to-Run installations of Office, perform an online repair to the Office installation. For more information about how to repair, see [Repair an Office application](https://support.office.com/Article/Repair-an-Office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

### Let me fix it myself

The steps below resolve the issue by setting the correct values for these dlls in the registry.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Steps to recreate the keys for MSI Installations:

1. Open Notepad.
2. Copy and paste the following lines of text for your environment, starting with 'Windows Registry Editor Version 5.00', into the Notepad document:

   - (64-bit Windows, 32-bit Office):

        ```console
        Windows Registry Editor Version 5.00
        [HKEY_CLASSES_ROOT\TypeLib\{00025E01-0000-0000-C000-000000000046}\5.0\0\win32]
        @=hex(2):25,00,43,00,6f,00,6d,00,6d,00,6f,00,6e,00,50,00,72,00,6f,00,67,00,72,\
          00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,28,00,78,00,38,00,36,00,29,00,\
          25,00,5c,00,4d,00,69,00,63,00,72,00,6f,00,73,00,6f,00,66,00,74,00,20,00,53,\
          00,68,00,61,00,72,00,65,00,64,00,5c,00,44,00,41,00,4f,00,5c,00,64,00,61,00,\
          6f,00,33,00,36,00,30,00,2e,00,64,00,6c,00,6c,00,00,00
        [HKEY_CLASSES_ROOT\TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win32]
        @="C:\\Program Files (x86)\\Common Files\\Microsoft Shared\\OFFICE14\\ACEDAO.DLL"
        ```

   - (64-bit Windows, 64-bit Office):
   
        ```console
        Windows Registry Editor Version 5.00
        [HKEY_CLASSES_ROOT\TypeLib\{00025E01-0000-0000-C000-000000000046}\5.0\0\win32]
        @=hex(2):25,00,43,00,6f,00,6d,00,6d,00,6f,00,6e,00,50,00,72,00,6f,00,67,00,72,\
        00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,25,00,5c,00,4d,00,69,00,63,00,\
        72,00,6f,00,73,00,6f,00,66,00,74,00,20,00,53,00,68,00,61,00,72,00,65,00,64,\
        00,5c,00,44,00,41,00,4f,00,5c,00,64,00,61,00,6f,00,33,00,36,00,30,00,2e,00,\
        64,00,6c,00,6c,00,00,00
        [HKEY_CLASSES_ROOT\TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win64]
        @="C:\\Program Files\\Common Files\\Microsoft Shared\\OFFICE14\\ACEDAO.DLL"
        ```
   
   - (32-bit Windows, 32-bit Office):

        ```console
        Windows Registry Editor Version 5.00
        [HKEY_CLASSES_ROOT\TypeLib\{00025E01-0000-0000-C000-000000000046}\5.0\0\win32]
        @=hex(2):25,00,43,00,6f,00,6d,00,6d,00,6f,00,6e,00,50,00,72,00,6f,00,67,00,72,\
        00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,25,00,5c,00,4d,00,69,00,63,00,\
        72,00,6f,00,73,00,6f,00,66,00,74,00,20,00,53,00,68,00,61,00,72,00,65,00,64,\
        00,5c,00,44,00,41,00,4f,00,5c,00,64,00,61,00,6f,00,33,00,36,00,30,00,2e,00,\
        64,00,6c,00,6c,00,00,00
        [HKEY_CLASSES_ROOT\TypeLib\{4AC9E1DA-5BAD-4AC7-86E3-24F4CDCECA28}\c.0\0\win32]
        @="C:\\Program Files\\Common Files\\Microsoft Shared\\OFFICE14\\ACEDAO.DLL"
        ```

3. Ensure the office version (OFFICE14) specified in the path matches the appropriate value from the list at the beginning of this article.
4. Save the Notepad file as Win32Keys.reg.
5. Do one of the following:

   - Using Windows Explorer, double-click on the Win32Keys.reg file to run it.
   - In the registry editor, go to **File** > **Import** to browse to where you saved the Win32Keys.reg file, and then click **Open**.

## More Information

Registry cleaners are not known to remove the `HKEY_CLASSES_ROOT\TYPELIB\{00025E01-0000-0000-C000-000000000046}\5.0\0\win32` key on 32-bit versions of Windows. However, if you experience the 'Error loading dll' error, you may have installed a program that misregistered either `dao360.dll` or `msado15.dll`.
