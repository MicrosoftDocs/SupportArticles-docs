---
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-virtual-machines
ms.topic: include
ms.date: 06/17/2024
ms.reviewer: jarrettr
---
Fix the corrupted hive by following these steps:

1. Delete the VM.

   > [!IMPORTANT]
   > When you're prompted to confirm the VM deletion, make sure that you clear the **Delete with VM** option that's associated with the OS disk resource type.

1. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [Attach a managed data disk to a Windows VM by using the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
1. Connect to the troubleshooting VM.
1. Select **Start**, and then search for and select **Computer management**. In the console tree of the Computer Management app, select **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
1. On the OS disk that you attached, navigate to the *\\Windows\\System32\\config* folder. Copy all the files to a backup folder in case a rollback is required.
1. Select **Start**, and then search for and select **Registry Editor** (*regedit.exe*).
1. In the Registry Editor app, select the **HKEY_USERS** subtree, select **File** > **Load Hive** on the menu, and then load the *\\Windows\\System32\\config\\SYSTEM* file.
1. If the hive loads without issues, this means that the hive wasn't closed correctly. In this situation, unload the hive to unlock the file and fix the issue.

   > [!NOTE]
   > If you receive the following error message, contact Azure Support:
   >
   > > Cannot load \<drive>:\\Windows\\System32\\config\\SYSTEM: Error while loading hive

1. Detach the repaired OS disk from the troubleshooting VM. Then, create a new VM from the OS disk.
