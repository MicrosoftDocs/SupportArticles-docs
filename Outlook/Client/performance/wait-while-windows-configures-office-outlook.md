---
title: Please wait while Windows configures Microsoft Office 64-bit Components 2013 when starting Outlook 2013
description: Describes an issue that occurs when the Windows Search Service isn't installed on the computer.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Message occurs when you start Outlook 2013: Please wait while Windows configures Microsoft Office 64-bit Components 2013

_Original KB number:_ &nbsp;2643974

## Symptoms

When you start Microsoft Outlook 2013, you receive the following message:

> Please wait while Windows configures Microsoft Office 64-bit Components 2013

:::image type="content" source="./media/wait-while-windows-configures-office-outlook/message-dialog.png" alt-text="Screenshot of the Outlook message dialog box." border="false":::

> [!NOTE]
> The message disappears after a time, and Outlook starts. However, you continue to receive the message whenever you start Outlook.

## Cause

This issue occurs when the following conditions are true:

- The 32-bit version of Office is installed on a 64-bit version of the operating system.
- The Windows Search Service isn't installed.

## Resolution

To resolve this issue, install the Windows Search Service. To do this, following the steps that are appropriate for your version of Windows.

### Windows 7 and Windows 8

1. Close Outlook.
2. Start Control Panel.
3. Click **Programs and Features** > **Turn Windows features on or off**.
4. Enable **Windows Search**, and then click **OK**.
5. Restart the computer if you're prompted to do this.

### Windows Server 2012

1. Start Server Manager.
2. Click **Manage** > **Add Roles and Features**.
3. On the **Before You Begin** page, click **Next**.
4. On the **Installation Type** page, select **Role-based or Feature-based Installation**, and then click **Next**.
5. On the **Server Selection**  page, select the server or virtual hard disk on which you want to install the Windows Search Service.
6. On the **Features** page, select **Windows Search Service**, and then click **Next.**  
7. On the **Confirmation** page, verify that **Windows Search Service** is listed, and then click **Install**.

### Windows Server 2008

1. Start Server Manager.
2. Click **Roles** in the left navigation pane.
3. Click **Add Roles** in the Roles Summary pane.
4. On the **Server Roles** page, select the **File Services** role, and then click **Next**.
5. On the **Role Services** page, select the **Windows Search Service** role service, and then click **Next**.
6. On the **Confirmation** page, verify that **Windows Search Service** is listed, and then click **Install**.

## More information

If you prefer not to use or install the Windows Search Service, you can disable indexing in Outlook. To do this, follow these steps:

1. Exit Outlook.
1. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.
    - **Windows 8**: Press Windows Key + R to open a Run dialog box. Type *regedit.exe* and then press **OK**.
    - **Windows 7**, **Windows Server 2008**, or **Windows Server 2012**: Click Start, type *regedit.exe* in the search box, and then press Enter.
1. In Registry Editor, locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search`
1. Point to **New** on the **Edit**  menu, and then click **DWORD (32-bit) Value**.
1. Type *PreventIndexingOutlook*, and then press Enter.
1. Right-click **PreventIndexingOutlook**, and then click **Modify**.
1. In the **Value data**  box, type *1*, and then click **OK**.
1. On the **File** menu, click **Exit** to exit Registry Editor.
