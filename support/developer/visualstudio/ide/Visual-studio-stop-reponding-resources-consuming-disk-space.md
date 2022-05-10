---
title: Visual Studio may stop responding if the running resources are consuming disk space
description: This article helps you resolve the problem when the disk space exhausts in the computer and your application such as Visual Studio stops responding.
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.topic: troubleshooting
ms.date: 05/10/2022
ms.custom: sap:Integrated Development Environment (IDE)
---

# [Troubleshoot] Visual Studio may stop responding if the running resources are consuming disk space

This article helps you resolve the problem when the disk space exhausts in the computer and your application such as Visual Studio stops responding.

## Troubleshoot checklist

To check if the frequent instability issue with Visual Studio or the system is due to some apps aren’t active but are using considerable disk space, follow these steps:

1. Select the **Ctrl**+**Shift**+**Esc** keys to open **Task Manager**.
1. Select the **Details** tab.
1. Right-click on a column header, and then select the **Select Columns** item.
1. Select the **Commit size** checkbox in the **Select Columns** window, and then select **OK**.
1. On the **Commit size** column, double-click the column header to sort the column descending by the commit size.
    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/Task-manager-details-tab.png" alt-text="Commit size colum in Details tab of Task Manager":::

### Workaround: Close the RAM consuming application that you are't using

If you notice a program that is committing a large size on the disk space, and you might not want to keep it running, you can exit the program. By ending such programs and processes, Visual Studio and the operating system can be stable.

> [!TIP]
> If you see a “vmmem.exe” program using memory that a virtual machine commits, you would need to shut down the virtual machine to free up its disk space.
>
> If the top processes are the system programs that commit large disk space, ending them may not be safe. The safest resource is to reboot your computer if the system processes are running and exhausting memory usage.

## Cause: Page file configuration isn't optimal

A page file is a file on disk that acts as an extension of the physical memory (RAM) on the system. When the memory usage by applications on a system exceeds the capacity of RAM, Windows can make space for the RAM by moving the used memory contents to the page file.

The default configuration of page file on Windows is such that the system can support several programs at the same time. However, some configurations and circumstances can’t make enough memory available to support all the programs running on the system. This problem might result in instability to any of the programs such as Visual Studio running at that time.

### Solution: Finding the Page file configuration and setting it optimal

#### Finding the page file configuration

1. Search for **Advanced System Settings** in Windows search, and select **Open** to open **System Properties** window.

1. Select **Settings…** in the **Performance group** to see **Performance Options** window.
    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/System-Properties-Performance-Options.png" alt-text="Performance Options window":::

1. Select the **Advanced** tab.
    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/System-Properties-Advanced-Settings.png" alt-text="Advanced tab in Performnce Options window":::

1. Select **Change…** in the **Virtual Memory** group.
    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/System-Properties-Change-button.png" alt-text="Change button in Virtual Memory group":::

#### Setting the page file optimally

- If you want to let the system manage the page file transparently for you, choose the default option by selecting **Automatically manage paging file size for all drives** checkbox.
    :::image type="content" source="media/Visual-studio-stop-reponding-resources-consuming-disk-space/System-Properties-Virtual-Memory.png" alt-text="Virtual Memory window and settings":::
- If you’ve configured page file size such that the system manages it, but the applications are running into stability issues, check whether the system drive has sufficient disk space by checking in File Explorer. You can use Windows + E keys to open File Explorer on your computer.

- If you want to customize page file size, uncheck **Automatically manage paging file size for all drives** and then see the following:

- If you want let the system manage a disk size, select the **System managed size** option.

- In some circumstances, you need to customize the size of the page file for a disk. To learn about customize Page file size, see Manually managing the Windows page file.
    > [!IMPORTANT]
    > Make sure that you set the **Initial size** and “*Maximum size** with the current cumulative peak RAM usage of applications running on the system.
    >
    > Because the system doesn’t automatically update page files, try to avoid an increase in memory requirements of applications by updating them when manually configured.
    >
    > Ensure that the disk has enough space to accommodate the new size

- In case of system instability issues due to disk space exhaustion, we recommend that you do not select **No paging file**.
