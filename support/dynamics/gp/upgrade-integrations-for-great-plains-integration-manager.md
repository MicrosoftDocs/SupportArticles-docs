---
title: Upgrade integrations for Great Plains Integration Manager
description: Describes how to upgrade integrations for Great Plains Integration Manager.
ms.topic: how-to
ms.date: 03/31/2021
---
# How to upgrade integrations for Great Plains Integration Manager

This article describes how to upgrade integrations that were created on an earlier version of Microsoft Business Solutions - Great Plains Integration Manager to a new version of Integration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859738

> [!IMPORTANT]
> his article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Description of the Microsoft Windows Registry](https://support.microsoft.com/help/256986).

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

To upgrade integrations from an earlier version of Integration Manager to your new version of Integration Manager, follow these steps:

1. Make a backup of your Im.mdb file. By default, this file is located in the C:\\Program Files\\Microsoft Business Solutions\\Integration Manager folder.

2. Using Add or Remove Programs, uninstall the current version of Integration Manager.  

3. On your local workstation, delete the folder where Integration Manager was installed. To find this folder, search for the Im.exe file.

4. Delete the Im.dic file. This file is located in your local installation folder for Great Plains.  

5. On the workstation, click **Start**, click **Run**, type **regedit** in the **Open** box, and then click **OK**.  

6. Locate the following registry subkey:

    `HKey_LocalMachine\Software\Microsoft\Great Plains\Integration Manager`

7. Delete the Integration Manager folder.

8. Locate the following registry subkey:

    `HKey_CurrentUser\Software\Microsoft\Great Plains\Integration Manager`

9. Delete the Integration Manager folder.

    > [!NOTE]
    > If this folder does not exist, the uninstall process may already have removed it.

10. Locate the following registry subkey:

    `HKey_LocalMachine\Software\Great Plains Software`

11. Delete the Integration Manager folder if it exists.

    > [!NOTE]
    > The folder may exist if an earlier version of Integration Manager was installed.

12. Remove the following files from the %system% folder:

    - CBOMLibX.dll
    - CBOM.dll
    - CBOM.tlb
    - TTGComnX.dll
    - TTGScrX.dll
    - TTGVBOleX.dll
    - TTGVBOle.dll

    The quickest way to locate these files is to follow these steps:

    1. Search for CB*.* in the \%system% folder.
    2. Delete all files that are found.
    3. Search for TTG*.dll in the \%system% folder.
    4. Delete all files that are found.  

13. Install the new version of Integration Manager and any service packs that are available.  

14. Replace the new Im.mdb file with the backup of the Im.mdb file that you created in step 1.  

15. Start Integration Manager, click **Tools**, click **Options**, and then specify the path of the new Im.mdb file.

> [!NOTE]
> If you receive an error message that states that the destination does not exist, you may have to add the destination again for certain integrations.
