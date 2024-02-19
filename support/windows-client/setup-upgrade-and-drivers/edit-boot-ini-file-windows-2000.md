---
title: How to edit the Boot.ini file in Windows 2000
description: Describes steps to edit the Boot.ini file in a Windows 2000 environment.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: cbutch, kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# How to edit the Boot.ini file in Windows 2000

This article describes the steps to edit the Boot.ini file in a Windows 2000 environment.

> [!NOTE]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 311578

## Summary

This step-by-step article describes how to edit the Boot.ini file in a Windows 2000 environment. NTLDR displays the bootstrap loader screen, where you can select an operating system to start. This screen is based upon the information in the Boot.ini file. If you don't select an entry before the counter reaches zero, NTLDR loads the operating system that is specified by the default parameter in the Boot.ini file. Windows 2000 Setup places the Boot.ini file in the active partition. NTLDR uses information in the Boot.ini file to display the bootstrap loader screen from which you select the operating system.

You should back up the Boot.ini file before you edit it. The first tasks include modifying your folder options so you can view hidden files, and then backing up the Boot.ini file.

## Modifying Folder Options

1. Right-click Start, and then click Explore.
2. On the Tools menu, click Folder Options, and then click View.
3. In the Advanced Settings area, click to select the **Show hidden files and folders** check box, click to clear the **Hide protected operation system files (Recommended)** check box, click OK, and then click OK.
4. In the left pane, click to select the %systemroot%, right-click Boot.ini in the display pane, and then click Properties.
5. Click to clear the Read-only attribute check box, and then click OK.

## Save a backup copy of Boot.ini

1. Right-click Start, and then click Explore.
2. In the left pane, click the %systemroot% drive, in the right pane, click the Boot.ini file, and then click Copy.
3. Open a temporary folder in the left pane, right-click in the right display pane, and then click Paste to create a copy of the Boot.ini file in that folder.

## Sample Boot.ini file

This is a sample of a default Boot.ini file from a Windows 2000 Server-based computer:

```ini

[boot loader]
timeout=30
default=multi(0)disk(0)rdisk(0)partition(1)\WINNT
[operating systems]
multi(0)disk(0)rdisk(0)partition(1)\WINNT="Windows 2000 Server" /fastdetect

```

This is a sample of the preceding Boot.ini file after the addition of another partition that is running Windows XP Professional.

```ini

[boot loader]
timeout=30
default=multi(0)disk(0)rdisk(0)partition(1)\WINNT
[operating systems]
multi(0)disk(0)rdisk(0)partition(1)\WINNT="Windows 2000 Server" /fastdetect
multi(0)disk(0)rdisk(0)partition(2)\WINNT="Windows XP Professional" /fastdetect

```

## Editing the Boot.ini file

1. Click Start, point to Programs, point to Accessories, and then click Notepad.
2. In Notepad, click Open on the File menu.
3. Click the %systemroot% drive in the Look in box, click the Boot.ini file, and then click Open.

### Removing an operating system from the menu

1. In Notepad, select the line that contains information about the operating system you want to remove, and then press DELETE. Example of the line to select:

    ```ini
    multi(0)disk(1)rdisk(0)partition(2)\Windows="Windows 98" /fastdetect  
    ```

2. On the File menu, click Save.

### Modifying the operating system menu order

1. In Notepad, select the line that needs to be moved, press CTRL+C, press DELETE, click to place the cursor to where the line needs to be placed, and then press CTRL+V.
2. Repeat step 1 as needed for your configuration, and then click Save on the File menu.

### Modifying the default operating system

The default represents the operating system that will be loaded if no selection is made before the time-out occurs.

1. In Notepad, modify the following line to reflect the operating system that is to be the default:

    ```ini
    default=multi(0)disk(0)rdisk(0)partition(1)\WINNT  
    ```

    For example, changing the default from Windows 2000 Server to Microsoft Windows 95
  
    ```ini
    default=multi(0)disk(0)rdisk(0)partition(1)\WINNT  
    ```

    would be modified to:
  
    ```ini
    default=multi(0)disk(0)rdisk(1)partition(2)\Windows  
    ```

2. On the File menu, click Save.

### Modifying the time-out

The time-out represents the number of seconds you are allowed to select an operating system from the menu before the default operating system is loaded.

1. In Notepad, edit the following line to reflect the number of seconds needed.timeout=30

2. On the File menu, click Save.

## Troubleshooting

- If there's a problem with the file that is being edited, copy the original Boot.ini file that was backed up to the %systemroot% folder.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
