---
title: Visual Studio stops responding if resources commit lots of memory
description: This article provides resolution to the problem where you see errors and instable applications because the system is about to run out of memory.
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.topic: troubleshooting
ms.date: 05/10/2022
ms.custom: sap:Integrated Development Environment (IDE)
---

# [Troubleshoot] Visual Studio may become unresponsive if the system runs out of memory

This article helps you resolve the problem where you see errors because the system is about to run out of memory. This issue may cause instability or unresponsiveness in Visual studio or other applications.

## Cause 1: Some applications consume considerable memory

On your system, some applications may consume a lot of memory and may not be in active use. To check which applications might be causing this issue, follow these steps:

1. Select the **Ctrl**+**Shift**+**Esc** keys to open **Task Manager**.
1. Select the **Details** tab.
1. Right-click on a column header, and then select the **Select Columns** item.
1. Select the **Commit size** checkbox in the **Select Columns** window, and then select **OK**.
1. On the **Commit size** column, double-click the column header to sort the commit size by descending order.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/task-manager-details-tab-1.png" alt-text="Commit size column in Details tab of Task Manager.":::

### Workaround: Close the memory consuming applications that you aren't using

If you notice a program that consumes a large commit size and you aren't actively using it, close that program. When you close such programs, the system and Visual Studio may become more stable than before closing them.

> [!TIP]
> If you see a program as *vmmem.exe* in the list, which indicates a virtual machine consuming the memory, shut down the virtual machine to make the memory available.
>
> If programs with the largest commit size are the system programs, closing them may not be safe. The safest approach is to reboot your computer.

## Cause 2: Page file configuration is not optimal

When the memory used by applications exceeds the capacity of random-access memory (RAM), Windows makes space in RAM by moving the used memory contents to the page file. The default configuration of page file is such that Windows can support many programs at the same time.
However, some configurations and circumstances can't allocate sufficient memory to support all the programs that are running on the system.

This problem might result in instability in any of the programs such as Visual Studio.

### Solution: Configure the page file settings to become optimal

#### Step 1: Finding the page file configuration

1. Search for **Advanced System Settings** in Windows search, and select **Open** to open the **System Properties** window.

1. Select **Settings…** in the **Performance** section.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/system-properties-advanced-settings-1.png" alt-text="Selecting Settings in the Performance group.":::

1. On the **Performance Options** window, select the **Advanced** tab.

1. Select **Change…** in the **Virtual Memory** section.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/system-properties-change-button-1.png" alt-text="Selecting Change button in Virtual Memory group.":::

#### Step 2: Setting optimal page file

- We recommend that you let the system manage the page file transparently for you. To do this, select the **Automatically manage paging file size for all drives** checkbox, if not checked.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/system-properties-virtual-memory-1.png" alt-text="Virtual Memory window and settings.":::

- If you’ve configured the page file size such that the system manages it and you still see the errors about low memory, check in File Explorer whether the system drive has sufficient disk space. Use the **Windows**+**E** keys to open the **File Explorer** window on your computer.

- If you want to customize page file location, uncheck the **Automatically manage paging file size for all drives** checkbox, and then follow one of these options:

    - We recommend that you let the system manage the page file size on a disk. To do this, select the **System managed size** option.

    - In some circumstances, you may have to customize the size of the page file. To learn about customizing page file size, see example in [Manually managing the Windows page file](https://devblogs.microsoft.com/cppblog/precompiled-header-pch-issues-and-recommendations/#manually-managing-the-windows-pagefile).

    > [!IMPORTANT]
    > Make sure that you set the **Initial size** and **Maximum size** with the current cumulative peak commit size of the applications that you're running on the system.
    >
    > When you customize the page file size, the system may not update the page file size. Therefore, if the memory requirements increase because of the running applications either consuming large memory or claiming new memory, then update the **Maximum size** to consider the new requirements.
    >
    > Ensure that the disk has enough space to accommodate the new size.

    - If you have been experiencing system instability due to memory exhaustion, we recommend that you do not select the **No paging file** option.
