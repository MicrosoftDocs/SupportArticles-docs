---
title: Issues occur on computer running the Volume Shadow Copy Service
description: Describes issues in which Event ID 8019, Event ID 20, Event ID 8193, or Event ID 12302 may be logged in the Application log. You may receive an Error 0x8004230F error message or an Error 0x80004002 error message.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# Various issues may occur on a Windows Server 2003-based computer that's running the Volume Shadow Copy Service

This article describes issues in which Event ID 8019, 20, 8193, or 12302 is logged in the Application log. You receive an Error 0x8004230F or 0x80004002 error message.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 940032

## Symptoms

On a Microsoft Windows Server 2003-based computer that is running the Volume Shadow Copy Service (VSS), you experience one of the following symptoms:

- When you perform a backup operation by using the NTBackup tool, the following event is logged in the Application log:
    > Event Type: Error  
    Event Source: NTBackup  
    Event ID: 8019  
    Description: End Operation: Warnings or errors were encountered. Consult the backup report for more details.  

    > [!NOTE]
    > If you view the backup log file, the following information is displayed:
    >
    > Error returned while creating the volume shadow copy:0xffffffff

- If you access the properties of a volume and then click **Shadow Copies**, you receive one of the following error messages:
    > Error 0x8004230F: The shadow copy provider had an unexpected error while trying to process the specified operation.

    > Error 0x80004002: No such interface supported

- One of the following events is logged in the Application log:
    > Event Type: Error  
    Event Source: VSS  
    Event ID: 20  
    Description: Volume Shadow Copy Service error: A critical component required by the Volume Shadow Copy Service is not registered. This might happened if an error occurred during Windows setup or during installation of a Shadow Copy provider. The error returned from CoCreateInstance on class with CLSID {faf53cc4-bd73-4e36-83f1-2b23f46e513e} and Name VSSEvent is [0x80040154].  
    >
    > Event Type: Error  
    Event Source: VSS  
    Event ID: 20  
    Description: Volume Shadow Copy Service error: A critical component required by the Volume Shadow Copy Service is not registered. This might happened if an error occurred during Windows setup or during installation of a Shadow Copy provider. The error returned from CoCreateInstance on class with CLSID {faf53cc4-bd73-4e36-83f1-2b23f46e513e} and Name VSSEvent is [0x80004002].  
    >
    > Event Type: Error  
    Event Source: VSS  
    Event ID: 8193  
    Description: Volume Shadow Copy Service error: Unexpected error calling routine CoCreateInstance. hr = 0x80040154.  
    >
    > Event Type: Error  
    Event Source: VSS  
    Event Category: None  
    Event ID: 8193  
    Description: Volume Shadow Copy Service error: Unexpected error calling routine CoCreateInstance. hr = 0x80004002.  
    >
    > Event Type: Error  
    Event Source: VSS  
    Event ID: 12302  
    Description: Volume Shadow Copy Service error: An internal inconsistency was detected in trying to contact shadow copy service writers. Please check to see that the Event Service and Volume Shadow Copy Service are operating properly.

## Cause

This issue occurs because the VSS system files aren't registered.

## Resolution

> [!NOTE]
> This article isn't for use with Windows Vista, with Windows Server 2008, or with later operating systems. Starting with Windows Vista and with Windows Server 2008, Windows component installation is manifest based. If you try to manually register specific components, such as those that are described in this "Resolution" section, in the operating systems that are mentioned in this note, unexpected results may occur that may require reinstalling Windows to resolve.

To resolve this issue, follow these steps:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.

2. Type the following commands at a command prompt. Press ENTER after you type each command.

    - `cd /d %windir%\system32`
    - `Net stop vss`  
    - `Net stop swprv`  
    - `regsvr32 ole32.dll`
    - `regsvr32 oleaut32.dll`
    - `regsvr32 vss_ps.dll`  
    - `vssvc /register`  
    - `regsvr32 /i swprv.dll`  
    - `regsvr32 /i eventcls.dll`  
    - `regsvr32 es.dll`
    - `regsvr32 stdprov.dll`
    - `regsvr32 vssui.dll`
    - `regsvr32 msxml.dll`
    - `regsvr32 msxml3.dll`
    - `regsvr32 msxml4.dll`
    > [!NOTE]
    > The last command may not run successfully.
3. Perform a backup operation to verify that the issue is resolved.

## More information

### Steps to reproduce this issue

1. Type the following command at a command prompt. Press ENTER after you type the command.

    ```console
    regsvr32 /u swprv.dll
    ```

2. Try to perform a backup operation.
