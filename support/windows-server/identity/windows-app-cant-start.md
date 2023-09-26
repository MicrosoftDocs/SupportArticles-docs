---
title: Windows App cannot start after ADMT 3.2 security translation runs
description: Provides a solution to an error that occurs when Windows App cannot start after ADMT 3.2 security translation runs.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Windows App cannot start after ADMT 3.2 security translation runs in Windows 8, Windows 8.1 and Windows 10

This article provides a solution to an error that occurs when Windows App cannot start after ADMT 3.2 security translation runs.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3145204

## Symptoms

Consider the following scenario:

- You create a user account in domain A.
- You link a Microsoft Account (MSA) to the user account.
- You log on to a Windows 8-based, Windows 8.1-based, or Windows 10-based computer by using the user account, and then you install a Windows app.
- You use Active Directory Migration Tool (ADMT) 3.2 to migrate the user account from domain A to domain B.
- You run a security translation to update the permissions settings on the client computer by using the users new domain SID.
- You log off and then log back on by using the migrated user account.

In this scenario, the following issues occur:

- Security translation fails and generates error 1314 in the ADMT log on the client on which the security translation agent ran. The log entry resembles the following.

    |Decimal|Hex|Symbolic|Friendly|
    |---|---|---|---|
    |1314|0x522|ERROR_PRIVELEGE_NOT_HELD|A required privilege is not held by the client.|

- Built-in and store applications can't start on Windows 8-based, Windows 8.1-based, or Windows 10-based computers.
- Clicking the **Start** button does not open the **Start** menu on Windows 10-based computers.
- If you switch to Tablet mode and then switch back to the previous mode in Windows 10, the **Start** menu continues to work but other built-in and store applications do not start.

    :::image type="content" source="./media/windows-app-cant-start/built-in-and-store-applications-do-not-start.png" alt-text="The Start menu continues to work but other built-in and store applications do not start.":::

- Search is unresponsive.
- The Settings application does not start on Windows 10-based computers when you click the **Settings** icon directly or use the Windows+I keyboard shortcut. This application works the first time that it is started, and it also works when you use the **Display settings** shortcut menu on the desktop.
- You cannot view .jpg files because the modern application that is assigned in the file associations tool does not start. When this occurs, you receive the following error message:

    > Invalid value for registry

    :::image type="content" source="./media/windows-app-cant-start/invalid-value-registry.png" alt-text="The invalid value for registry error that occurs when you can't view jpg files.":::

- When you click the Store application in the Windows taskbar of a Windows 10-based computer, the command fails, and you receive the following error message:

    > This app can't install.

## Workaround

To work around this issue, follow these steps:

1. Migrate user accounts on a pre-Windows 8 operating system to the destination domain before you upgrade the accounts to Windows 10.
2. For Windows apps that are installed from the Microsoft Store, uninstall and then reinstall the app.
3. Protect application data: Back up and restore data as required to avoid data loss. Data can be copied or restored to a new or different user account that is not yet subject to security translation.

## References

[Active Directory Migration Tool (ADMT) Guide: Migrating and Restructuring Active Directory Domains](https://www.microsoft.com/download/details.aspx?id=19188)
