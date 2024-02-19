---
title: No VSS writers are listed when you run the vssadmin list writers command in Windows Server
description: Fixes an issue where no VSS writers are listed when you run the "vssadmin list writers" command and events are logged.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jeffpatt, kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# No VSS writers are listed when you run the vssadmin list writers command in Windows Server

This article helps fix an issue where no VSS writers are listed when you run the `vssadmin list writers` command and events are logged.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009550

## Symptoms

When you run the `vssadmin list writers` command in Windows Server, no VSS writers are listed. Additionally, the following events are logged in the Application log:

> Log Name: Application  
Source: VSS  
Event ID: 22  
Level: Error  
Description:  
Volume Shadow Copy Service error: A critical component required by the Volume Shadow Copy service is not registered. This might happened if an error occurred during Windows setup or during installation of a Shadow Copy provider. The error returned from CoCreateInstance on class with CLSID {faf53cc4-bd73-4e36-83f1-2b23f46e513e} and Name VSSEvent is [0x80040154, Class not registered].  

> Log Name:     Application  
Source:         VSS  
Event ID:       8193  
Level:            Error  
Description:  
Volume Shadow Copy Service error: Unexpected error calling routine CoCreateInstance.  hr = 0x80040154, Class not registered.  

If you open the Windows Server Backup snap-in, you receive the following error message:

> A fatal error occurred during a Windows Server Backup snap-in (Wbadmin.msc) operation.  
Error details:  
Unknown error (0x80042302).  
Close Wbadmin.msc and then restart it  

## Cause

This problem occurs because the registry path of the Eventcls.dll file is incorrect.

## Resolution

To resolve this problem, follow these steps:

1. Click **Start**, type *regedit* in the **Search programs and files** box, and then press ENTER.
2. Locate and then click the following registry key:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EventSystem\\{26c409cc-ae86-11d1-b616-00805fc79216}\EventClasses\\{FAF53CC4-BD73-4E36-83F1-2B23F46E513E}-{00000000-0000-0000-0000-000000000000}-{00000000-0000-0000-0000-000000000000}`  
3. Double-click the **TypeLib** registry value.
4. In the **Value Data** box, type *%systemroot%\\system32\\EVENTCLS.DLL*, and then click **OK**.
5. Exit **Registry Editor**.
6. Click **Start**, type *services.msc* in the **Search programs and files** box, and then press ENTER.
7. Right-click the following services, one at a time. Click **Restart** for each service.
    - **COM+ Event System**
    - **Volume Shadow Copy**  
8. Exit the Services snap-in.
9. Open an elevated command prompt, type *vssadmin list writers*, and then press ENTER.
10. Verify that the VSS writers are now listed.
