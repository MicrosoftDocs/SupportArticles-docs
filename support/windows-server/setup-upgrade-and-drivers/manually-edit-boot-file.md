---
title: Manually edit Boot.ini file
description: Describes how to manually edit the Boot.ini file in a Windows Server 2003 environment.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, JAMIRC
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Manually edit the Boot.ini file in a Windows Server 2003 environment

This article describes how to manually edit the Boot.ini file in a Microsoft Windows Server 2003 environment.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323427

## Summary

The Ntldr file uses information in the Boot.ini file to display the bootstrap loader screen from which you select the operating system. This screen is based on the information in the Boot.ini file. If you do not select an entry before the counter reaches 0 (zero), Ntldr loads the operating system that is specified by the default parameter in the Boot.ini file.

Windows Server 2003 Setup places the Boot.ini file in the root of the system partition.

Before you edit the Boot.ini file, modify your folder options so you can view hidden files, and then back up the Boot.ini file.

> [!NOTE]
> You can also edit the Boot.ini file by using the System Configuration Utility (Msconfig.exe). To start the System Configuration Utility, click **Start**, click **Run**, type *msconfig* in the **Open** box, and then click **OK**.

## Modify Folder Options

1. Right-click **Start**, and then click **Explore**.
2. On the **Tools** menu, click **Folder Options**, and then click **View**.
3. Under **Advanced Settings**, click **Show hidden files and folders**, click to clear the **Hide protected operating system files (Recommended)** check box, click **Yes**, and then click **OK**.
4. Locate the system partition, locate and right-click the Boot.ini file, and then click **Properties**.
5. Click to clear the **Read-only** check box, and then click **OK**.

## Save a backup copy of the Boot.ini file

1. Right-click **Start**, and then click **Explore**.
2. Locate the system partition, locate and right-click the Boot.ini file, and then click **Copy**.
3. Locate and click the folder where you want to copy the Boot.ini file, and then click **Paste** on the **Edit** menu.

## Sample Boot.ini file

The following is a sample of a default Boot.ini file from a Windows Server 2003-based computer:

```ini
[boot loader]  
timeout=30  
default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS  
[operating systems]  
multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows .NET Standard Server" /fastdetect  
```

The following is a sample of the same Boot.ini file after the addition of another partition that runs Microsoft Windows XP Professional.

```ini
[boot loader]  
timeout=30  
default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS  
[operating systems]  
multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows .NET Standard Server" /fastdetect  
multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Microsoft Windows XP Professional"
```

## Edit the Boot.ini file

1. Click **Start**, point to **Programs**, point to **Accessories**, and then click **Notepad**.
2. On the **File** menu, click **Open**.
3. In the **Look in** box, click the system partition, in the **Files of type** box, click **All Files**, locate and click the Boot.ini file, and then click **Open**.
4. Make the changes that you want to the Boot.ini file, and then click **Save** on the **File** menu.

Examples of changes that you can make are described in the following sections of this article.

## Remove an Operating System from the menu

To remove an operating system from the menu, follow these steps:

1. In Notepad, select the line that contains information about the operating system that you want to remove, and then click **Delete** on the **Edit** menu. For example, select the following line:

    `multi(0)disk(1)rdisk(0)partition(2)\WINDOWS="Microsoft Windows XP Professional" /fastdetect`

2. On the **File** menu, click **Save**.

## Modify the Operating System menu order

To modify the operating system menu order, follow these steps:

1. In Notepad, select the line that you want to move, click **Copy** on the **Edit** menu, and then press **DELETE**.
2. Click where you want to insert the line, and then click **Paste** on the **Edit** menu.
3. Repeat step 1 and step 2 for each line that you want to move, and then click **Save** on the **File** menu.

## Modify the default Operating System

The default operating system is the operating system that is started if no selection is made before the time-out occurs. (The time-out is the number of seconds in which you can select an operating system from the menu before the default operating system is loaded.) To modify the default operating system, follow these steps:

1. In Notepad, modify the following line to change the default operating system:

    `default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS`

    For example, to change the default operating system from Windows Server 2003 to Windows XP Professional, modify the following 

    `linedefault=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS`

    to the following:

    `default=multi(0)disk(0)rdisk(1)partition(2)\WINDOWS`

2. On the **File** menu, click **Save**.

## Modify the time-out

To modify the time-out value, follow these steps:

1. In Notepad, edit the following line to change the time-out (where the value is 30 seconds):

    `timeout=30`

2. On the **File** menu, click **Save**.

## Troubleshooting

If there is a problem with the Boot.ini file that you modified, copy the original Boot.ini file (the one that you backed up earlier) to the system partition.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
