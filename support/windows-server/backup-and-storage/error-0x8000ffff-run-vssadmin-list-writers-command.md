---
title: Error 0x8000FFFF when running vssadmin list writers command in Windows Server 2003
description: Resolves a problem that occurs when you use the vssadmin list writers command on a Windows Server 2003-based computer. You may receive an error message or the list may be blank.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# Error 0x8000FFFF when you run the vssadmin list writers command on a Windows Server 2003-based computer

This article resolves a problem that occurs when you use the `vssadmin list writers` command on a Windows Server 2003-based computer. when the issue occurs, you may receive an error message, an event, or the list may be blank.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 940184

## Symptoms  

When you run the `vssadmin list writers` command on a Windows Server 2003-based computer, you may experience any of the following symptoms.

> [!NOTE]
> The `vssadmin list writers` command lists the subscribed volume shadow copy writers.

- You receive the following error message:

    > Error: 0x8000FFFF

- The following event may be logged in the Application log:

    > Event Type: Error  
    Event Source: VSS  
    Event ID: 12302  
    Description: Volume Shadow Copy Service error: An internal inconsistency was detected in trying to contact shadow copy service writers. Please check to see that the Event Service and Volume Shadow Copy Service are operating properly.

- The list is blank.

## Cause

This problem may occur if the following registry key is corrupted:

 `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{26c409cc-ae86-11d1-b616-00805fc79216}\Subscriptions`  

## Resolution

> [!IMPORTANT]
> This article is not for use with Windows Vista, with Windows Server 2008, or with later Windows operating systems. Starting with Windows Vista and with Windows Server 2008, Windows component installation is manifest-based. Trying to manually register specific components, as described in the following steps, can have unexpected results that may require you to reinstall Windows to resolve.

To resolve this problem, follow these steps:

1. Click **Start** > **Run**, type *Regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\{26c409cc-ae86-11d1-b616-00805fc79216}\Subscriptions`  

3. On the **Edit** menu, click **Delete**, and then click **Yes** to confirm that you want to delete the subkey.
4. Exit Registry Editor.
5. Click **Start** > **Run**, type*services.msc*, and then click **OK**.
6. Right-click the following services one at a time. For each service, click **Restart**:
    - COM+ Event System
    - COM+ System Application
    - Microsoft Software Shadow Copy Provider
    - Volume Shadow Copy
7. Click **Start** > **Run**, type *cmd*, and then click **OK**.
8. At the command prompt, type *vssadmin list writers*, and then press Enter.
9. If the VSS writers are now listed, close the Command Prompt window. You don't have to complete the remaining steps.

    If the VSS writers aren't listed, type the following commands at the command prompt. Press Enter after each command.
    - `cd /d %windir%\system32`
    - `net stop vss`
    - `net stop swprv`
    - `regsvr32 ole32.dll`
    - `regsvr32 oleaut32.dll`
    - `regsvr32 /i eventcls.dll`
    - `regsvr32 vss_ps.dll`
    - `vssvc /register`
    - `regsvr32 /i swprv.dll`
    - `regsvr32 es.dll`  
    - `regsvr32 stdprov.dll`
    - `regsvr32 vssui.dll`  
    - `regsvr32 msxml.dll`
    - `regsvr32 msxml3.dll`
    - `regsvr32 msxml4.dll`
    > [!NOTE]
    > The last command may not run successfully.
10. At the command prompt, type *vssadmin list writers*, and then press Enter.
11. Confirm that the VSS writers are now listed.

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus/).
