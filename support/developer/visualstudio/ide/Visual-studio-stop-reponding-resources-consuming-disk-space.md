---
title: Visual Studio may stop responding if resources consume disk space
description: This article helps you resolve the problem when the disk space exhausts in the computer and your application such as Visual Studio stops responding.
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.topic: troubleshooting
ms.date: 05/10/2022
ms.custom: sap:Integrated Development Environment (IDE)
---

# [Troubleshoot] Visual Studio may stop responding if the running resources are consuming disk space

This article helps you resolve the problem when the disk space exhausts in the computer and Visual Studio application stops responding.

## Cause 1: Some applications consume considerable RAM resources

On your system, when you aren't actively using some applications, its resources might be running in background. If these apps use considerable disk space of random-access memory (RAM), you may experience the frequent instability issues in Visual Studio or in the operating system.
To check which applications cause this issue, follow these steps on your computer:

1. Select the **Ctrl**+**Shift**+**Esc** keys to open **Task Manager**.
1. Select the **Details** tab.
1. Right-click on a column header, and then select the **Select Columns** item.
1. Select the **Commit size** checkbox in the **Select Columns** window, and then select **OK**.
1. On the **Commit size** column, double-click the column header to sort the column descending by the commit size.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/Task-manager-details-tab-1.png" alt-text="Commit size column in Details tab of Task Manager":::

### Workaround: Close the RAM consuming applications that you aren't using

If you notice a program that consumes a large disk space and if you aren't using it to keep it running, close the program. When you close such programs and processes, the system and Visual Studio application can become stable.

> [!TIP]
> If you see a *vmmem.exe* program using memory that your virtual machine commits, you would need to shut down the virtual machine to free up its disk space.
>
> If the top processes that commit large disk space are the system programs, ending them may not be safe. The safest way is to reboot your computer when the running system processes are exhausting the RAM usage.

## Cause 2: Page file configuration isn't optimal

A page file is a file on disk that acts as an extension of the physical memory (RAM) on the system. When the memory usage by applications on a system exceeds the capacity of RAM, Windows can allocate space for RAM by moving the used memory contents to the page file.

The default configuration of page file on Windows is such that the system can support several programs at the same time. However, some configurations and circumstances can’t allocate sufficient memory to support all the programs that are running on the system. This problem might result in instability in any of the programs such as Visual Studio.

### Solution: Finding the Page file configuration and setting it optimal

#### Finding the page file configuration

1. Search for **Advanced System Settings** in Windows search, and select **Open** to open the **System Properties** window.

1. Select **Settings…** in the **Performance** section.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/System-Properties-Advanced-Settings-1.png" alt-text="Selecting Settings in the Performance group":::

1. On the **Performance Options** window, select the **Advanced** tab.

1. Select **Change…** in the **Virtual Memory** section.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/System-Properties-Change-button-1.png" alt-text="Selecting Change button in Virtual Memory group":::

#### Setting the page file optimal

- If you want to let the system manage the page file transparently for you, choose the default option by selecting **Automatically manage paging file size for all drives** checkbox.

    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/System-Properties-Virtual-Memory-1.png" alt-text="Virtual Memory window and settings":::

- If you’ve configured page file size such that the system manages it, but the applications aren't stable, check whether the system drive has sufficient disk space by checking in File Explorer. Use **Windows**+**E** keys to open **File Explorer** window on your computer.

- If you want to customize page file size, uncheck **Automatically manage paging file size for all drives**.

- If you want to let the system manage a disk size, select the **System managed size** option.

- In some circumstances, you can customize the size of the page file for a disk. To learn about customizing Page file size, see [Manually managing the Windows page file](https://devblogs.microsoft.com/cppblog/precompiled-header-pch-issues-and-recommendations/#manually-managing-the-windows-pagefile).

    > [!IMPORTANT]
    > Make sure that you set the **Initial size** and **Maximum size** with the current cumulative peak RAM usage of the applications that are running on the system.
    >
    > Because the system doesn’t automatically update page files, try to avoid an increase in memory requirements of applications by updating them when manually configured.
    >
    > Ensure that the disk has enough space to accommodate the new size.

- In case of system instability issues due to disk space exhaustion, we recommend that you don't select **No paging file**.
