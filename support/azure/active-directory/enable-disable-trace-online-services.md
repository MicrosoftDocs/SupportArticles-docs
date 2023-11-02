---
title: How to enable and disable a trace for the Microsoft Online Services Sign-in Assistant
description: Describes how to enable and disable a trace for the Microsoft Online Services Sign-in Assistant in order to troubleshoot non-browser based sign-in issues.
ms.date: 06/22/2020
ms.reviewer: dahans
ms.service: active-directory
ms.subservice: aad-general
---
# How to enable and disable a trace for the Microsoft Online Services Sign-in Assistant

This article discusses how to enable and disable a trace for the Microsoft Online Services Sign-in Assistant. The log files that are generated can help troubleshoot issues that may occur when you use the Sign-in Assistant in a Microsoft Office 365 environment.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 User and Domain Management  
_Original KB number:_ &nbsp; 2433327

> [!NOTE]
> Use this article only with applications that use the Microsoft Online Services Sign-In Assistant to assist in authentication to Microsoft Entra ID.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

## Enable debug tracing for the Microsoft Online Services Sign-in Assistant

To enable debug tracing for the Microsoft Online Services Sign-in Assistant, follow these steps:

1. Start Notepad, copy and paste the following text to a new file, and then save the file as Enable_SIA_Debug_Tracing.reg:

    ```
    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSOIdentityCRL\Trace]
    "Folder"="C:\\MSOTrace"
    "Flags"=dword:00000001
    "level"=dword:00000099
    "maxsize"=dword:10485760

    [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace]
    "Folder"="C:\\MSOTrace"
    "Flags"=dword:00000001
    "level"=dword:00000099
    "maxsize"=dword:10485760

    [HKEY_CURRENT_USER\Software\Microsoft\MSOIdentityCRL\Trace]
    "Folder"="C:\\MSOTraceLite"
    "Flags"=dword:00000001
    "level"=dword:00000099
    "maxsize"=dword:10485760
    ```

2. Run the Enable_SIA_Debug_Tracing.reg file on the computer that's experiencing the issue to update the registry.
3. Restart the Microsoft Online Services Sign-in Assistant service (if it's installed).

    > [!NOTE]
    > The Microsoft Online Services Sign-in Assistant service is required to be installed only on systems that are running pre-Office 2013 versions of Office or on systems that use PowerShell to connect to Office 365. If the Microsoft Online Services Sign-in Assistant service isn't installed on your system, go to step 4.

    To restart the Microsoft Online Services Sign-in Assistant service, do one of the following:

   - Select **Start**, type services.msc in the search box, and then press Enter. Right-click the **Microsoft Online Services Sign-in Assistant** service, and then select **Restart**.
   - Open an administrative command prompt, and then run the following commands (press Enter after each command):

        ```console
        net stop msoidsvc
        ```

        ```console
        net start msoidsvc
        ```

4. Reproduce the suspected authentication issue on the computer on which tracing is enabled.
5. On drive C, locate the MSOTrace and MSOTraceLite folders. These folders contain the trace files. The names of the trace files are in the following format:

    `msoidsvctrace{GUID}.txt`

    > [!NOTE]
    > When the Microsoft Online Services Sign-in Assistant service is running, you can't rename or delete the debug trace because the file is being used by a process. However, you can create a copy of the debug trace that you can then move to another folder or another computer for review.

6. Examine the debug trace files for any relevant exception messages.

## Disable debug tracing for the Microsoft Online Services Sign-in Assistant

To disable debug tracing for the Microsoft Online Services Sign-in Assistant, follow these steps:

1. Open **Notepad**, copy and paste the following text to a new file, and then save the file as Disable_SIA_Debug_Tracing.reg:

    ```
    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSOIdentityCRL\Trace]
    "Folder"="C:\\MSOTrace"
    "Flags"=dword:00000000
    "level"=dword:00000000

    [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace]
    "Folder"="C:\\MSOTrace"
    "Flags"=dword:00000000
    "level"=dword:00000000

    [HKEY_CURRENT_USER\Software\Microsoft\MSOIdentityCRL\Trace]
    "Folder"="C:\\MSOTraceLite"
    "Flags"=dword:00000000
    "level"=dword:00000000
    ```

2. Run the Disable_SIA_Debug_Tracing.reg file on the computer that's experiencing the issue to update the registry.
3. Restart the Microsoft Online Services Sign-in Assistant service (if it's installed).

    > [!NOTE]
    > The Microsoft Online Services Sign-in Assistant service is required to be installed only on systems that are running pre-Office 2013 versions of Office or on systems that use PowerShell to connect to Office 365. If the Microsoft Online Services Sign-in Assistant service isn't installed on your system, omit this step.

    To restart the Microsoft Online Services Sign-in Assistant service, do one of the following:

    - Select **Start**, type services.msc in the **search** box, and then press Enter. Right-click the **Microsoft Online Services Sign-In Assistant** service, and then select **Restart**.
    - Open an administrative command prompt, and then run the following commands (press Enter after each command):

        ```console
        net stop msoidsvc
        ```

        ```console
        net start msoidsvc
        ```

## Analyze logs

Log file locations depend on the specifics of the Folder registry entry that's listed earlier. In this example, the log is located in the `C:\MSOTrace` or `C:\MSOTraceLite` folder, depending on the application that performs authentication.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
