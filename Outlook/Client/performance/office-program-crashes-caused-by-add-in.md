---
title: Office program crashes due to the SendToBluetooth add-in
description: Fixes an issue in which Office programs crashes if you have the SendToBluetooth add-in installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: nathanad
appliesto: 
  - Outlook 2013
  - Word 2013
  - PowerPoint 2013
  - Excel 2013
  - Microsoft Outlook 2010
  - Microsoft Word 2010
  - PowerPoint 2010
  - Excel 2010
  - Excel 2016
  - Outlook 2016
  - PowerPoint 2016
  - Word 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# Office program crashes caused by Btmofficea.dll or Btmoffice.dll

_Original KB number:_ &nbsp; 2849035

If you have the `SendToBluetooth` add-in installed, your Office programs might be crashing due to an incompatibility issue between the add-in and other Microsoft Office programs.  

## Use the Event Viewer to check to see if the add-in is the cause of your Office programs crashing  

1. Open the Event Viewer.

    - **For Windows 8**

        1. From the Start screen, type **View event logs** in the search box, and tap or click **Settings**.
        1. Tap or click **View event logs**.

    - **For Windows 7 and Windows Vista**

        1. Click **Start**.
        2. In the **Search** box, type **Event Viewer**, and then, in the list of results, double-click **Event Viewer**.

    - **For Windows XP**

        1. Click **Start** > **Control Panel** > **Performance and Maintenance**, and then click **Administrative Tools**, and then double-click **Computer Management**.
        2. In the console tree, expand **Event Viewer**.

2. Now, check for the following events:

    - Event ID: 1000

        > Application Name: Winword.exe  
        > Application Version: 15.0.4481.1508  
        > Module Name: Btmofficea.dll  
        > Module Version: 2.2.0.204  
        > Offset: 0000000000009e9a

    - Event ID: 1000

        > Application Name: Excel.exe  
        > Application Version: 14.0.6117.5003  
        > Module Name: Btmoffice.dll  
        > Module Version: 3.0.2.298  
        > Offset: 0000913e

## Manually disable the `SendToBluetooth` add-in

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

> [!IMPORTANT]
> Before you start the steps below, make sure you close all of your Office programs.

1. Open the Registry Editor, here's how:

    - For Windows 8  

        Go to your Desktop, press the Windows key + X and click **Run**. Type `regedit` in the Open box, and then press Enter.

    - For Windows 7 and Windows Vista

        1. Click **Start** and type `regedit` in the Start Search box, and then press Enter.
        2. If you are prompted for an administrator password or for confirmation, type the password, or click **Allow**.

    - For Windows XP

        Click **Start**, click **Run**, type `regedit`, and then click **OK**.

2. Locate and select the following registry key, based on the 'bitness' of your Office and Windows installations:

    - 32-bit Office plus 32-bit Windows:

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\<Office program name>\Addins\ btmoffice.Connect`

    - 64-bit Office plus 64-bit Windows:

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\<Office program name>\Addins\ btmoffice.Connect`

    - 32-bit Office plus 64-bit Windows:  

        `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\<Office program name>\Addins\ btmoffice.Connect`

3. Right-click the `LoadBehavior` value and then click **Modify**.
4. Change the **Value Data** to **0**, and then click **OK**.
5. Close Registry Editor.
6. Start your Office program that was crashing to determine if the registry change has improved the stability of the program.

## More information

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Below is some additional information related to the `SendToBluetooth` add-in.

|Information|Details|
|---|---|
| Company Name|Intel Corporation|
| File Description|Office Bluetooth integration|
| File Name|C:\Program Files (x86)\Intel\Bluetooth\btmofficea.dll|
| Friendly Name|Send to Bluetooth|
| InprocServer32|C:\Program Files (x86)\Intel\Bluetooth\btmofficea.dll|
| Internal Name|btmoffice.dll|
| Legal Copyright|Copyright 2011 Motorola Solutions, Inc.|
| Original Filename|btmoffice.dll|
