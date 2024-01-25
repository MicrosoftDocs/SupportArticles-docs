---
title: Alter printers that roam with roaming profiles
description: Describes how to alter a behavior of printers that roams with roaming profiles.
ms.date: 09/10/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, eugenev, austinm
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
ms.subservice: printing
---
# How to Alter Behavior of Printers That Roam with Roaming Profiles

This article describes how to alter a behavior of printers that roams with roaming profiles.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 304767

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## Summary

By design, when a user is using a roaming profile, that user's default printer roams with the user profile. However, in some environments this may not be the desired behavior. This article provides methods you can use to alter this behavior.

## More information

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk. 

> [!IMPORTANT]
> The information in this article is designed for use by corporate administrators. Before you use any of the methods that are described in this article in your environment, you should thoroughly test the method in a test environment.

Printers are designed to roam with a user's roaming profile, and this is why the default printer is stored under the HKEY_CURRENT_USER branch of the registry. To alter this behavior, use either of the following methods.

### Method 1

Export the default printer setting for an already-installed printer, and then merge the setting into the user's profile when the user logs on to the computer:

1. Use Registry Editor (Regedit.exe) to export the following registry key:

    `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows`

2. Modify the registry (.reg) file you made in step 1 with a text editor so that the only registry value name below the key is:  

    "Device"=...

    > [!NOTE]
    > The registry file should contain a blank line at the bottom of the file.
3. Use Registry Editor (Regedit.exe) to add a new ResetPrinter string value under the following registry key:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run`

4. The value of the ResetPrinter value should be something similar to the following value:

    REGEDIT.EXE -S *path*\\*File.reg*  
    where *File.reg* is the name you used to store the default printer.

### Method 2

If computers in a specific area contain similar computer names, you can use a .vbs script file that matches a specific set of characters in the computer name, and installs a corresponding printer. The sample code that is included in this method only requires that you modify the IF lines. For example, the first IF statement in the code translates to "if the computer name contains the text "LAB1-", then set the default printer to "\\\\LAB1\\LaserJet". To complete this method:

1. Copy the following sample VBS code into a. vbs file, for example, Defaultprinter.vbs:

    ```vbs
    Option Explicit
    DIM RegEntry, ComputerName

    RegEntry="HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\ComputerName" ComputerName = ReadRegValue(RegEntry)

    if InStr(1,ucase(ComputerName),"LAB1-",vbTextCompare) > 0 then call SetPrinter("\\LAB1\LaserJet")
    if InStr(1,ucase(ComputerName),"LAB2-",vbTextCompare) > 0 then call SetPrinter("\\LAB2\LaserJet")
    if InStr(1,ucase(ComputerName),"OFFICE-",vbTextCompare) > 0 then call SetPrinter("\\OFFICE\LaserJet")
    'so on and so forth.
    wscript.quit

    '*** This subroutine installs and sets the default printer
    Sub SetPrinter(ByVal PrinterPath)
        DIM WshNetwork
        Set WshNetwork = CreateObject("WScript.Network")
        WshNetwork.AddWindowsPrinterConnection(PrinterPath)
        WshNetwork.SetDefaultPrinter Printerpath
    end sub

    '**** This function returns the data in the registry value
    Function ReadRegValue(ByVal RegValue)
        DIM WSHShell
        Set WSHShell = WScript.CreateObject("WScript.Shell")
        ReadRegValue=""
        On Error Resume Next
        ReadRegValue= WSHShell.RegRead(RegValue)
    End Function
    ```

2. Modify the IF lines as needed. The only portion of the IF lines that need to be modified is between double quotes. You may need to add additional IF lines.
3. Use Registry Editor to create a ResetPrinter string value under the following registry key:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run`

4. The value of ResetPrinter should be something similar to the following value:

    WSCRIPT.EXE *path*\\DefaultPrinter.vbs  
    where *path* is the location where the Defaultprinter.vbs file is stored.

> [!NOTE]
> It is also possible to run the Defaultprinter.vbs file from a login script instead of the run key. Both of the methods that are described in this article reset the default printer that a user's profile is set to print to. Also, if the sample script that is included in this article does not run properly, you may need to upgrade or install the Windows Scripting Host.
>
> Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.
