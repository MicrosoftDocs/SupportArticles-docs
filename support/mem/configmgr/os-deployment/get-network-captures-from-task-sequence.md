---
title: Get network captures from a task sequence
description: Describes how to get network captures from a task sequence in Windows PE.
ms.date: 12/05/2023
ms.reviewer: kaushika, luche, bryxiao
---
# How to get network captures from a task sequence in Windows PE

This article provides the steps to get network captures from a task sequence in Windows Preinstallation Environment (Windows PE).

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4034393

## Summary

Microsoft Support sometimes asks customers to capture a network trace when a Configuration Manager task sequence fails and returns a network error. Usually, we request that you capture a network trace by configuring port mirroring on the LAN switch or you capture a network trace on a Virtual Machine (VM) host, if the issue can be reproduced by a VM.

It's difficult to capture a network trace in Windows PE, as the `Netsh` command doesn't support tracing in Windows PE. Additionally, you can't bind to any network adapter if you just copy and then run the Network Monitor command in Windows PE.

## Capture a network trace in Windows PE

1. Extract the Microsoft Network Monitor setup file to a local folder, and then extract the Netmon.msi by using Msiexec.exe.

    :::image type="content" source="media/get-network-captures-from-task-sequence/extract-file.png" alt-text="Screenshot of the output for the extract command." border="false":::

2. In the extracted files, find the Network Monitor driver files Netnm3.inf and Nm3.sys.

    :::image type="content" source="media/get-network-captures-from-task-sequence/find-driver-file.png" alt-text="Screenshot of the extracted files." border="false":::

3. Mount the boot image source file and inject the driver Netnm3.inf into it. Be aware that the image file is the original source image, not the file that has a package ID.

    :::image type="content" source="media/get-network-captures-from-task-sequence/mount-boot-source-file.png" alt-text="Screenshot of the output after mounting the original source image." border="false":::

4. Copy the **Microsoft Network Monitor 3** folder from the extracted Network Monitor files to the \<Image_MountDir> folder. The **Microsoft Network Monitor 3** folder contains all the executables (.exe) that are needed to install and run Network Monitor 3.4.

    :::image type="content" source="media/get-network-captures-from-task-sequence/copy-folder.png" alt-text="Screenshot of the Microsoft Network Monitor 3 folder details." border="false":::

5. Copy Nm3.sys to the following folders. Only the SYSTEM account has write permission. Therefore, you have to use Psexec.exe to start a command prompt with SYSTEM context.

   - \<Image MountDir>\Windows\System32\drivers
   - \<Image MountDir>\Windows\System32\DriverStore\FileRepository\netnm3.inf_amd64_ddce99a12d11c79a

6. Unmount and then commit the Windows PE image. Add the boot image in the Configuration Manager console or update distribution point if you're editing an existing boot image.

    :::image type="content" source="media/get-network-captures-from-task-sequence/unmount-commit-file.png" alt-text="Screenshot of the output after unmounting and committing the Windows PE image." border="false":::

7. Start the computer from PXE or boot media. After the boot image is loaded, press F8 and execute the following commands in the **Microsoft Network Monitor 3** folder. The first command will bind the Network Monitor driver to the network adapter.

    :::image type="content" source="media/get-network-captures-from-task-sequence/nmconfig-netmon.png" alt-text="Screenshot of the nmconfig.exe/install and netmon.exe commands." border="false":::

You can now create a new trace file and start capturing. The parsers aren't available. However, you can save the trace after the issue is reproduced and the trace can be analyzed on another computer.
