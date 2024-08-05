---
title: Installed programs are incorrectly displayed
description: Provides a solution to an issue where the Add/Remove Programs tool in Control Panel displays installed programs incorrectly.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Application Technologies and Compatibility\MSI and MSIX, csstroubleshoot
---
# Add/Remove Programs tool displays installed programs incorrectly

This article provides a solution to an issue where the **Add/Remove Programs** tool in Control Panel displays installed programs incorrectly.

_Applies to:_ &nbsp; Windows XP  
_Original KB number:_ &nbsp; 266668

## Symptoms

When you install and uninstall programs, the Add/Remove Programs tool in Control Panel may display the installed programs incorrectly. The **Currently installed programs** box may contain only a single text string, or may display a large blank space before the program entries. Other display problems may include that there are no listed programs. Additionally, one of the following error messages may appear:

Message 1  
> An unexpected error occurred. Class not registered  
res://appwiz.cpl/listbox.htc  
Line: 225

Message 2
> Object doesn't support this property or method res://appwiz.cpl/default.hta  
Line: 75

## Cause

This problem may occur if the uninstaller for a program incorrectly removes registry entries that are used by Windows and the Add/Remove Programs tool.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).  

To resolve this problem, follow these steps:

1. Click **Start**, click **Run**, and then type *CMD*.
2. At the prompt, type `REGSVR32 APPWIZ.CPL`.
3. If this fails, look for the registry entries that are listed below. To resolve this issue, check the registry for the following keys and values. Re-create any missing keys or values. These keys use the system drive letter. You may have to adjust these entries to match the configuration of your computer.

    - [HKEY_CLASSES_ROOT\CLSID\{00000535-0000-0010-8000-00AA006D2EA4}]
    "ADODB.Recordset"
    - [HKEY_CLASSES_ROOT\CLSID\{00000535-0000-0010-8000-00AA006D2EA4}\InprocServer32]
    "C:\Program Files\Common Files\System\ado\msado15.dll"
    - [HKEY_CLASSES_ROOT\CLSID\{00000535-0000-0010-8000-00AA006D2EA4}\InprocServer32]
    "ThreadingModel"="Apartment"
    - [HKEY_CLASSES_ROOT\CLSID\{00000535-0000-0010-8000-00AA006D2EA4}\ProgID] "ADODB.Recordset.2.5"
    - [HKEY_CLASSES_ROOT\CLSID\{00000535-0000-0010-8000-00AA006D2EA4}\VersionIndependentProgID]
    "ADODB.Recordset"
    - HKEY_CLASSES_ROOT\CLSID\{2048EEE6-7FA2-11D0-9E6A-00A0C9138C29 }
    "Microsoft OLE DB Row Position Library"
    - HKEY_CLASSES_ROOT\CLSID\{2048EEE6-7FA2-11D0-9E6A-00A0C9138C29}\InprocServer32
    "C:\Program Files\Common Files\System\Ole DB\oledb32.dll" "ThreadingModel"="Both"
    - HKEY_CLASSES_ROOT\CLSID\{2048EEE6-7FA2-11D0-9E6A-00A0C9138C29}\ProgID
    "RowPosition.RowPosition.1"
    - HKEY_CLASSES_ROOT\CLSID\{2048EEE6-7FA2-11D0-9E6A-00A0C9138C29}\VersionIndependentProgID
    "RowPosition.RowPosition"
    - [HKEY_CLASSES_ROOT\CLSID\{352EC2B7-8B9A-11D1-B8AE-006008059382}\InProcServer32]
    %SystemRoot%\System32\appwiz.cpl

4. Follow the steps in one of the following procedures, as it applies to your computer, and then test to determine if this issue is resolved. If the issue is resolved, skip the remaining steps. If the issue is not resolved, go to step 5.
   - To resolve this issue with Internet Explorer 6.0 installed, repair Internet Explorer 6.0:

        1. Click **Start**, and then click **Run**.
        2. Paste the following command in the **Open** box, and then click **OK**:

            ```console
            rundll32 setupwbv.dll, IE6Maintenance C:\Program Files\Internet Explorer\Setup\SETUP.EXE /g C:\WINDOWS\IE Uninstall Log.Txt
            ```

            Because this command is case-sensitive, Microsoft recommends that you copy the command from this article, and then paste the command in the Open box.

   - To resolve this issue with Internet Explorer 5.0 or 5.5 installed, repair Internet Explorer 5.0 or 5.5:

        1. Click **Start**, and then click **Run**.
        2. Paste the following command in the **Open** box, and then click **OK**:

           ```console
           rundll32 setupwbv.dll, IE5Maintenance C:\Program Files\Internet Explorer\Setup\SETUP.EXE /g C:\WINDOWS\IE Uninstall Log.Txt
           ```

           Because this command is case-sensitive, Microsoft recommends that you copy the command from this article, and then paste the command in the Open box.
5. Perform an in-place upgrade:

    > [!NOTE]
    > Before you perform an in-place upgrade, make sure that you back up your data. For more information about the risks of performing an in-place upgrade, see the More Information section.

    1. Run Winnt32.exe from the \I386 directory.
    2. When the Setup screen appears, proceed the upgrading.
    3. Allow installation to complete.

If the Add/Remove Programs tool still does not function properly, shows no content, or if you want to try to fix this issue without upgrading to later versions of Internet Explorer, check the following registry keys to make sure that they contain entries:

- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall`
- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\App Management\ARPCache`

> [!NOTE]
> If the previous registry keys are blank, the Add/Remove Programs tool may also be blank.

Use the command-line REGSVR32 [path\filename] to register each of the following files:

- %systemroot%\System32\Appwiz.cpl
- %systemroot%\System32\Mshtml.dll
- %systemroot%\System32\Jscript.dll
- %systemroot%\System32\Msi.dll
- Program Files\Common Files\System\Ole DB\Oledb32.dll
- Program Files\Common Files\System\Ado\Msado15.dll
- %systemroot%\System32\Msdart32.dll [not registerable]
- %systemroot%\System32\Mshtmled.dll
- %systemroot%\System32\Mswstr10.dll [not registerable]

If the Add/Remove Programs tool displays incomplete information or is blank, verify the file dates. Where possible, register the following files:

- %systemroot%\System32\Gdi32.dll [not registerable]
- %systemroot%\System32\User32.dll [not registerable]
- %systemroot%\System32\Msvcrt.dll [not registerable]
- %systemroot%\System32\Ole32.dll
- %systemroot%\System32\Shlwapi.dll [not registerable]
- %systemroot%\System32\Imm32.dll [not registerable]
- %systemroot%\System32\Indicdll.dll [not registerable]
- %systemroot%\System32\Urlmon.dll
- %systemroot%\System32\Version.dll [not registerable]
- %systemroot%\System32\Lz32.dll [not registerable]
- %systemroot%\System32\Comctl32.dll [not registerable]
- %systemroot%\System32\Clbcatq.dll
- %systemroot%\System32\Oleaut32.dll
- %systemroot%\System32\Mlang.dll
- %systemroot%\System32\Shell32.dll
- %systemroot%\System32\Shdoclc.dll [not registerable]
- %systemroot%\System32\NetapI32.dll [not registerable]
- %systemroot%\System32\Secur32.dll [not registerable]
- %systemroot%\System32\Netrap.dll [not registerable]
- %systemroot%\System32\Samlib.dll [not registerable]
- %systemroot%\System32\Ws2_32.dll [not registerable]
- %systemroot%\System32\Ws2help.dll [not registerable]
- %systemroot%\System32\Wldap32.dll [not registerable]
- %systemroot%\System32\Dnsapi.dll [not registerable]
- %systemroot%\System32\Wsock32.dll [not registerable]
- %systemroot%\System32\Plugin.ocx
- %systemroot%\System32\Wininet.dll [not registerable]
- %systemroot%\System32\Crypt32.dll [not registerable]
- %systemroot%\System32\Msasn1.dll [not registerable]
- %systemroot%\System32\Msls31.dll [not registerable]
- %systemroot%\System32\Imgutil.dll
- %systemroot%\System32\Cscui.dll
- %systemroot%\System32\Cscdll.dll [not registerable]

If the Add/Remove Programs tool can draw the dialog user interface, but does not display any installed program contents, check the registry for the presence of the following key:

`HKEY_CLASSES_ROOT\CLSID\{352EC2B7-8B9A-11D1-B8AE-006008059382}\InProcServer32`

If this registry key is missing, copy the following text to a text file, save the file with a .reg extension, and then double-click the file on the affected computer to return the proper entries.

For Windows Registry Editor Version 5.00:

> [HKEY_CLASSES_ROOT\CLSID\{352EC2B7-8B9A-11D1-B8AE-006008059382}\InProcServer32]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,61,00,70,00,70,00,77,00,69,00,7a,00,2e,00,63,00,70,00,6c,00,00,00  
"ThreadingModel=Apartment"

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the Applies to section.

The following list includes all the registry keys that are used by Add/Remove Programs. These keys must be set by registering Appwiz.cpl, but they are provided here for cross-reference to confirm that the registration completed successfully.

- [HKEY_CLASSES_ROOT\CLSID\{352EC2B7-8B9A-11D1-B8AE-006008059382}]

    @="%DESC_ShellAppMgr%"
- [HKEY_CLASSES_ROOT\CLSID\{352EC2B7-8B9A-11D1-B8AE-006008059382}\InProcServer32]

    @="SystemRoot%\System32\appwiz.cpl" (REG_EXPAND_SZ)"ThreadingModel"="Apartment"
- [HKEY_CLASSES_ROOT\CLSID\{0B124F8C-91F0-11D1-B8B5-006008059382}]

    @="Installed Apps Enumerator"

- [HKEY_CLASSES_ROOT\CLSID\{CFCCC7A0-A282-11D1-9082-006008059382}]

    @="Darwin App Publisher"
- [HKEY_CLASSES_ROOT\CLSID\{CFCCC7A0-A282-11D1-9082-006008059382}\InProcServer32]

    @="SystemRoot%\System32\appwiz.cpl" (REG_EXPAND_SZ)"ThreadingModel"=Apartment"
- [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved]

    "{352EC2B7-8B9A-11D1-B8AE-006008059382}"="Shell Application Manager"

- [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\Publishers\Darwin App Publisher]
@="{CFCCC7A0-A282-11D1-9082-006008059382}"
- [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved]
"{CFCCC7A0-A282-11D1-9082-006008059382}"="Darwin App Publisher"
- [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\InProcCPLs]
"appwiz.cpl"=""

### Registry entries that are used once ARP is running

- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\AppInstallPath`

    Reads INF file. Code reads INF file name. INF section used is AppInstallList
- `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer\Terminal Server\EnableAdminRemote`

    Set to 1 while ARP is running. Tells TS that ARP is running.
Set to 0 when ARP exits.

- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\App Management\Publishers` Enumerates app publishers

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Wx86\cmdline`

    Reads to determine if wx86 is enabled.
- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\NewShortcutHandlers`

    Enumerated to obtain list of new-link handlers. It looks like these handlers may add a link for a given item - for instance, to the Start menu, desktop, or other items.
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Shutdown\ForceReboot`

    Read to determine if a restart is required after running setup.
Presence of value means must-reboot == true.
- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\MS-DOSOptions`
