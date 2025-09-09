---
title: Application unresponsive due to low system memory
description: This article provides resolution to the problem where you see errors and unstable applications because the system is about to run out of memory.
author: aartig13
ms.author: aartigoyle
ms.topic: troubleshooting
ms.date: 05/10/2022
ms.custom: sap:Integrated Development Environment (IDE)\Other
---

# Visual Studio might become unresponsive if the system runs out of memory

This article helps you mitigate unstable or unresponsive behavior in Visual Studio or other applications if the system is about to run out of memory.

## Cause 1: Some applications consume lots of memory

On your system, some applications might consume a lot of memory and might not be in active use. To check which applications can be causing this issue, follow these steps:

1. Select Ctrl+Shift+Esc keys to open **Task Manager**.
1. Select the **Details** tab.
1. Right-click on a column header, and then select the **Select Columns** item.
1. Select the **Commit size** checkbox in the **Select Columns** window, and then select **OK**.
1. On the **Commit size** column, double-click the column header to sort the commit size by descending order.

    :::image type="content" source="media/visual-studio-unresponsive-resources-consuming-memory/task-manager-details-tab.png" alt-text="Viewing Commit size in the Details tab.":::

### Workaround: Close the memory consuming applications that you aren't using

If you notice a program that consumes a large memory and you aren't actively using it, close that program. When you close such programs, the system and Visual Studio can become more stable.

> [!TIP]
> If you see a program as *vmmem.exe* in the list, which indicates a virtual machine consuming the memory, shut down the virtual machine to make the memory available.
>
> If the programs with the largest commit size are the system programs, closing them might not be safe. The safest approach is to reboot your computer.

## Cause 2: Paging file configuration is not optimal

Paging file is a file on the system disk that acts as an extension of the random-access memory (RAM). When the memory used by the applications exceeds the capacity of RAM, Windows makes space in the RAM by moving the memory contents to the paging file. The default configuration of the paging file is such that Windows can support many programs at the same time.
However, some configurations and circumstances can't allocate sufficient memory to support all the programs that are running on the system.

This problem might result in instability of the programs such as Visual Studio.

### Solution: Configure optimal paging file settings

#### Step 1: Finding the paging file configuration

1. Search for **Advanced System Settings** in Windows search, and select **Open** to open the **System Properties** window.

1. Select **Settings…** in the **Performance** section.

    :::image type="content" source="media/visual-studio-unresponsive-resources-consuming-memory/system-properties-advanced-settings.png" alt-text="Selecting Settings in the Performance group.":::

1. On the **Performance Options** window, select the **Advanced** tab.

1. Select **Change…** in the **Virtual Memory** section.

    :::image type="content" source="media/visual-studio-unresponsive-resources-consuming-memory/system-properties-change-button.png" alt-text="Selecting Change button in the Virtual Memory group.":::

#### Step 2: Setting optimal paging file

- We recommend that you let the system manage the paging file transparently for you. To do this, select the **Automatically manage paging file size for all drives** checkbox, if not checked.

    :::image type="content" source="media/visual-studio-unresponsive-resources-consuming-memory/system-properties-virtual-memory.png" alt-text="Virtual Memory window and settings.":::

- If you have configured the paging file size such that the system manages it and you still see the errors about low memory, check in File Explorer whether the system drive has sufficient disk space. Use the Windows+E keys to open the **File Explorer** window on your computer.

- If you want to customize paging file location, uncheck the **Automatically manage paging file size for all drives** checkbox, and then follow one of these options:

    - We recommend that you let the system manage the paging file size on a disk. To do this, select the **System managed size** option.

    - In some circumstances, you might need to customize the size of the paging file. To learn about one such example, see [Failure to automatically increase the pagefile size](https://devblogs.microsoft.com/cppblog/precompiled-header-pch-issues-and-recommendations/#failure-to-automatically-increase-the-pagefile-size).

        > [!IMPORTANT]
        > Make sure that you set the **Initial size** and **Maximum size** with the cumulative peak commit size of the applications that you typically run on the system.
        >
        > With this setting, the system doesn't automatically update the paging file size. Therefore, if the memory requirements increase either because the running applications consume more memory or due to the start of new applications that consume additional memory, then you should update the **Maximum size** to consider the new requirements.
        >
        > Ensure that the disk has enough space to accommodate the new size.

    - If you have been experiencing system instability due to low system memory, we recommend that you do not select the **No paging file** option.
