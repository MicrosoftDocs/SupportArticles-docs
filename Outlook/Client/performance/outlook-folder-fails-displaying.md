---
title: Outlook has insufficient memory to display a folder
description: Fixes an issue in which Outlook folder can't be displayed because of insufficient memory. This issue occurs more frequently if you use add-ins in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Folder views
  - Outlook for Windows
  - CI 112697
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2010
  - Outlook 2013
  - Outlook 2016
  - Outlook 2019
search.appverid: MET150
ms.date: 01/30/2024
---

# "There is not enough free memory to run this program" error in Outlook

## Symptoms

When you click a folder while you're using Microsoft Outlook, you receive one of the following error messages:

### Error message 1

**There is not enough free memory to run this program. Quit one or more programs, and then try again.**

### Error message 2

**Unable to display the folder. There is not enough free memory to run this program. Quit one or more programs, and then try again.**

### Error message 3

**Cannot display the folder. There is not enough free memory to run this program. Quit one or more programs, and then try again.**

You may experience this issue more frequently if you use add-ins in Outlook.

## Cause

This issue occurs because there's insufficient memory to display the folder. This may be caused by any of several different reasons. One of these reasons is that customizations, such as setting a filter, were made to the folder view. Some add-ins in Outlook subscribe to many folders in some or all stores in the profile. Each MAPI subscription uses some shared memory. Therefore, large combinations of items and folders can exhaust the available memory.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around the issue that is described in the "Symptoms" section, increase available memory. To increase the size of the memory heap, follow these steps:

1. Exit Outlook.
2. Select **Start**, select **Run**, type **regedit**, and then select **OK**.
3. Locate and then select the following registry subkey:
   
   **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Messaging Subsystem**

4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Type **SharedMemMaxSize**, and then press Enter.
6. Right-click **SharedMemMaxSize**, and then select **Modify**.
7. In the **Value data** box, type **300000**. Use the default **Base** of **Hexadecimal**.
8. Select **OK**.
9. Locate and then select the following registry subkey:

   **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Messaging Subsystem\Applications\Outlook**

   > [!NOTE]
   > You may have to create the **Applications** and **Outlook** subkeys if they don't exist.
10. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
11. Type **SharedMemMaxSize**, and then press Enter.
12. In the **Value data** box, type **300000**. Use the default **Base** of **Hexadecimal**.
13. Select **OK**.
14. On the **File** menu, select **Exit** to exit Registry Editor.

> [!NOTE]
> If setting the two registry values to **0x300000** doesn't fix the issue, you can increase the size of these values up to **0x800000**.

## More information

If you have a large Outlook data (.pst) file open in Outlook, you can close the .pst file or decrease the number of folders in the .pst file to fix the issue.

If you have many add-ins that are enabled in Outlook, you can disable or uninstall them to determine whether doing this fixes the issue.

For more information, see the following Knowledge Base article:

[269794](https://support.microsoft.com/help/269794/mapi-advise-call-returns-0x8007000e-e-outofmemory
) MAPI Advise() call returns 0x8007000E (E_OUTOFMEMORY)
