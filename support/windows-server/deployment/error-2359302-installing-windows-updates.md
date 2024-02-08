---
title: Error code 2359302 when installing updates in Windows Server 2019
description: Helps resolve an issue in which you receive error code 2359302 when installing updates in Windows Server 2019.
author: Deland-Han
ms.author: delhan
ms.date: 11/23/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, shahke, v-lianna
ms.custom: sap:servicing, csstroubleshoot, ikb2lmc
ms.subservice: deployment
---
# Error code 2359302 when installing updates in Windows Server 2019

This article helps resolve an issue in which you receive error code 2359302 when installing updates in Windows Server 2019.

When you install updates in Windows Server 2019, you receive the 2359302 error in the Windows Setup event log under Event Viewer. For example:

> Windows update could not be installed because of error 2359302 "" (Command line: ""C:\Windows\system32\wusa.exe" "C:\temp\windows10.0-kb5027222-x64 5802ce76528f37a5abbd6bde65549a9bad98acfc.msu" ")

In the system, the updates are displayed as **Install Pending**.

> [!NOTE]
> To obtain the similar output, open a command prompt or Powershell window as an administrator and run `Dism /Online /Get-Packages /Format:table`. 

:::image type="content" source="media/error-2359302-installing-windows-updates/install-pending.png" alt-text="Screenshot showing that the updates are displayed as Install Pending status.":::

In the Component Based Servicing (CBS) registry key, the updates are displayed under the `PendedSessionPackages` registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\PendedSessionPackages`

:::image type="content" source="media/error-2359302-installing-windows-updates/cbs-pendedsessionpackages.png" alt-text="Screenshot showing that the updates are displayed under the PendedSessionPackages registry key.":::

## Uninstall all pending updates and delete the pending transactions

To resolve this issue, follow these steps:

1. Start the system in the Windows Recovery Environment (WinRE) environment by using one of the following media:

	- Windows Server operating system (OS) media
	- [Microsoft Diagnostics and Recovery Toolset (DaRT) 10](/microsoft-desktop-optimization-pack/dart-v10/)
	- Other Windows bootable media

2. Run the [list volume](/windows-server/administration/windows-commands/list-volume) command to list all volumes and find the OS disk. For example, the D volume is the OS disk in the following screenshot:

	:::image type="content" source="media/error-2359302-installing-windows-updates/d-volume-os-disk.png" alt-text="Screenshot showing that the D volume is the OS disk.":::
	
3. Navigate to the transaction folder and show hidden files by running the following commands:

	```console
	cd D:\Windows\System32\Config\TxR\
	attrib -h -r -s
	dir
	```

	:::image type="content" source="media/error-2359302-installing-windows-updates/show-hidden-files.png" alt-text="Screenshot showing the hidden files in the transaction folder.":::
 
4. Back up the transaction files by running the following commands:

	```console
	mkdir backup
	copy *.* backup
	dir backup
	```
	
	:::image type="content" source="media/error-2359302-installing-windows-updates/back-up-transaction-files.png" alt-text="Screenshot showing the output of the transaction files backup command.":::
 
5. Delete the transaction files by running the following commands:

	```
	dir
	del *.blf
	del *.regtrans-ms
	```

6. Navigate to the [WinSxS](/windows-hardware/manufacture/desktop/clean-up-the-winsxs-folder) folder and rename the *pending.xml* file by running the following commands:

	```console
	cd D:\Windows\WinSxS\
	ren pending.xml pending.xml.old
	```

7. In Registry Editor, select the `HKEY_LOCAL_MACHINE` registry key, and then select **File** > **Load Hive**.
8. Navigate to the following folder and select the **COMPONENTS** hive:

	*C:\\Windows\\System32\\config*

9. Delete the `ExecutionState` and `PendingXmlIdentifier` registry values (if they exist) from the following registry key:

	`HKEY_LOCAL_MACHINE\COMPONENTS`

10.	Run the following command to revert pending actions:

	```console
	DISM /image:D :\ /cleanup-image /revertpendingactions
	```

	You'll receive the following message:

	```output
	Reverting pending actions from the image.... The operation completed.
	```

11.	Restart the system, and you'll receive the following message:

	> Reverting pending actions

12. Install the update again by running the following command:

	```console
	DISM /online /Add-package /PackagePath:"C:\temp\Win10.xxx.CAB"
	```
