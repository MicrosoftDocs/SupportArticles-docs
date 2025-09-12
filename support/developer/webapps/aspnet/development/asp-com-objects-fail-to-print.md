---
title: Can't print COM objects called from ASP
description: This article provides a resolution that a COM object sends output to a printer fails when called from Active Server Pages.
ms.date: 02/27/2020
ms.custom: sap:General Development
---
# COM objects fail to print when called from ASP

This article helps you resolve the problem that a COM object sends output to a printer fails when called from Active Server Pages.

_Original product version:_ &nbsp; Active Server Pages  
_Original KB number:_ &nbsp; 184291

## Symptoms

A COM object that sends output to a printer fails when called from Active Server Pages (ASP) but functions correctly when called from an interactive application. This COM object could be either a commercial product such as a Microsoft Office application, or a custom third-party object. A common error message is "ClassName error '800a01e2' Printer error."

## Cause

The standard APIs that most objects use to print depend on registry entries located in HKEY_CURRENT_USER. This registry hive is dynamic. Depending on which user context the process is running under, different information will be loaded into this hive. ASP pages run under IIS, which is running as the SYSTEM account. When you create an instance of a COM object in your ASP code, by default, it will also run as the SYSTEM account. By default, the SYSTEM account does not have any printers set up in the registry.

## Resolution

You can set up printers for the SYSTEM account to resolve this problem. To set up printers for the SYSTEM account, perform the following steps:

> [!WARNING]
> This method requires you to modify the registry using the Registry Editor. Using Registry Editor incorrectly can cause serious, system-wide problems that may require you to reinstall Windows to correct them. Microsoft cannot guarantee that any problems resulting from the use of Registry Editor can be solved. Use this tool at your own risk.

1. Ensure that the user you are currently logged into on the server has the wanted printers installed.
2. Launch the **Registry Editor** (Regedit.exe).
3. Select the following key:

    `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices`

4. From the **Registry** menu, select **Export Registry File**.
5. In the **File Name** text box, type **c:\Devices.reg**.
6. Select the following key:

    `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts`

7. From the **Registry** menu, select **Export Registry File**.
8. In the **File Name** text box, type **c:\PrinterPorts.reg**.
9. Select the following key:

    `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows`

10. From the **Registry** menu, select **Export Registry File**.
11. In the **File Name** text box, type **c:\Windows.reg**.
12. From the **Start** button, select **Run**. Open **Devices.reg** in Notepad by typing Notepad Devices.reg in **Run** dialog box.
13. Replace the text `HKEY_CURRENT_USER` with `HKEY_USERS\.DEFAULT`.
14. Save the file. Then import it into the registry by double-clicking the file in Windows Explorer.
15. Repeat steps 13 through 15 for PrinterPorts.reg and Windows.reg.

> [!NOTE]
> These steps only work for local printers.

To enable IIS to enumerate the network printers by using the SYSTEM account, follow these steps.

> [!NOTE]
> If the process is running under the Network Service account, explicit permissions to the newly created registry are required.

1. Make sure that you're currently logged in to the server as a user who has the wanted network printers installed.
2. Start Registry Editor.
3. Select the following key:
   
   `HKEY_CURRENT_USER\Printers\Connections`

4. On the **Registry** menu, select **Export Registry File**.
5. In the **File Name** box, type **c:\printconns.reg**.
6. To open the **printconns.reg** file in Notepad, select **Start**, select **Run**, type Notepad printconns.reg in the **Open** box, and then select **OK**.
7. Replace the text `HKEY_CURRENT_USER` with the text `HKEY_USERS\.DEFAULT`.
8. Save the file.
9. To import the file into the registry, double-click the file in Windows Explorer.
10. Restart the Print Spooler service.
