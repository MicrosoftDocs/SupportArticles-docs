---
title: Error when you install an Office program
description: Describes an error message that you receive when you install an Office program.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: jenl
appliesto: 
  - Office 2010
ms.date: 06/06/2024
---

# "Error 1919. Error configuring ODBC data source" when you run the Setup program for Office

## Symptoms

When you run the Setup program for any of the programs listed in the "Applies to" section, you may receive the following error message:

> Error 1919. Error configuring ODBC data source: MS Access Database. ODBC error 6: Component not found in the registry. Verify that the file MS Access Database exists and that you can access it.

If you select **Ignore**, you may receive the following error message:

> Error 1919. Error configuring ODBC data source: Excel Files. ODBC error 0: Verify that the file Excel Files exists and that you can access it.

You may also receive any one of the following error messages:

- > Error 1919. Error configuring ODBC data source: MS Access Database. ODBC error 0: Verify that the file MS Access Database exists and that you can access it.
- > Error 1919. Error configuring ODBC data source: Visual FoxPro Database. ODBC error 0: Verify that the file Visual FoxPro Database exists and that you can access it.
- > Error 1919. Error configuring ODBC data source: Visual FoxPro Tables. ODBC error 0: Verify that the file Visual FoxPro Tables exists and that you can access it.
- > Error 1919. Error configuring ODBC data source: dBASE Files. ODBC error 6: Verify that the file dBASE Files exists and that you can access it.

## Cause

These problems may occur if the Windows Registry is missing some registry keys.

## Resolution

To resolve this problem, replace the missing registry keys. To do this, use one of the following methods.

### Method 1: Install MDAC 2.8

For more information about MDAC 2.8, including installation and removal instructions, see [Microsoft Data Access Components (MDAC) Installation](/previous-versions/ms810805(v=msdn.10)).

After you have installed MDAC 2.8, you must restart the computer and log on with administrative credentials.

> [!NOTE]
> MDAC 2.8 is also installed when you install Microsoft Windows XP Service Pack 2 (SP2). If the operating system is Windows XP, you may choose to install Windows XP SP2 instead of following the previous steps.

### Method 2: Reset the registry keys by using the Mdac.inf file

Use Mdac.inf to reset the registry keys. This program may prompt you for your Windows CD to obtain new files.

Do one of the following as appropriate for your operating system and if you have the Windows CD.

#### For the retail editions of Microsoft Windows XP and Microsoft Windows Server 2003

1. Click **Start**, click **Run**, type path\inf in the **Open** box, and then click **OK**.

   In this example, path is the path of your Windows folder. For example, type C:\Windows\Inf or C:\Winnt. By default, C:\Windows is the folder where Windows XP is installed, C:\Winnt is the folder where Windows XP is installed if you upgraded Windows 2000 to Windows XP.
2. On the **Tools** menu, click **Folder Options**.
3. On the **View** tab, in the **Advanced Settings** box, click **Show hidden files and folders**, and then click **OK**.
4. Right-click **Mdac.inf**, and then click
**Install**.
5. If you are prompted for your Windows CD, insert the Windows CD in the CD-ROM drive or DVD-ROM drive.
6. Click the **I386** folder on your hard disk (typically, C:\I386), and then click **OK**.

    If the I386 folder is a subfolder of the Windows folder, on some computers, you can't select it. In this case, type the full path in the
**Copy files from** box (for example, type C:\Windows\I386 or C:\Winnt\I386), and then click **OK**.
7. Restart the computer.

#### For original equipment manufacturer (OEM) Editions of Windows XP

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

#### Step 1: Modify the registry keys

1. Locate the **I386** folder on your hard disk, and then make a note of its path.
2. Click **Start**, and then click **Run**.
3. In the **Open** box, type regedit, and then click **OK**.
4. In Registry Editor, locate and then click the following key:

    `HKEY_Local_Machine\Software\Microsoft\Windows\CurrentVersion\Setup`
5. Right-click the **Installation Sources** entry, and then click **Modify**.
6. In the **Value data** box, change the value to the path of the I386 folder on your hard disk, and then click **OK**.
7. Repeat steps 5 and 6 for each of the following entries:
   - SourcePath
   - ServicePackSourcePath
8. Quit Registry Editor.

#### Step 2: Install Mdac.inf

1. Click **Start**, click **Run**, type C:\Winnt\Inf in the **Open** box, and then click **OK**.
2. On the **Tools** menu, click **Folder Options**.
3. On the **View** tab in the **Advanced Settings** box, click **Show hidden files and folders**, and then click **OK**.
4. Right-click **Mdac.inf**, and then click **Install**.
5. If you are prompted for your Windows CD, insert the Windows CD in the CD-ROM drive or DVD-ROM drive.
6. Click the **I386** folder on your hard disk (typically, C:\I386), and then click **OK**.

    > [!NOTE]
    >
    > - If you don't have the CD for your current Windows installation, click **Browse**, and then locate and select the
 **I386** folder.
    > - If the **I386** folder is a subfolder of the **Windows** folder, on some computers, you can't select it. In this case, type the full path in the **Copy files from** box (for example, type C:\Windows\I386 or C:\Winnt\I386), and then click **OK**.

7. Restart your computer.

### Method 3: Import the registry keys from another computer on the network

**Note** When you import the registry keys from another computer, make sure that the source computer and destination computer run the same operating system. For example, if you are using this method on a computer that is running Windows XP, locate a computer that runs Windows XP that you can use to export the registry keys.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

#### Part 1: Export the keys from the registry on the "source" computer

1. On a computer that is not missing the keys (the "source" computer), click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
2. Locate and then click the following registry key:

   `HKEY_CURRENT_USER\Software\ODBC`
3. On the **File** menu, click **Export**.
4. In the **Save in** box, specify a location to temporarily save the registration file (.reg file).

   In the **File name** box, type a file name, and then click **Save**.
5. Locate and then click the following key:

   `HKEY_LOCAL_MACHINE\Software\ODBC`
6. Repeat steps 4 and 5 to export this key.

#### Part 2: Import the keys to the registry of the "destination" computer

1. Copy the exported .reg files from the source computer to a temporary location on the computer that is missing the keys (the "destination" computer).
2. Click **Start**, click **Run**, type `regedit` in the **Open** box, and then click **OK**.
3. On the **Registry** menu, click **Import Registry File**.
4. Locate and then click one of the .reg files that you copied in step 1, and then click **Open**.
5. Repeat steps 4 and 5 for the other .reg file.

## Workaround

You may be able to work around this problem by clicking **Retry** several times when you receive these error messages. However, this work around may not work in the long term.
