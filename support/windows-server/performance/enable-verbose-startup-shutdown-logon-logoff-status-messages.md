---
title: Enable verbose startup, shutdown, logon, and logoff status messages in Windows Server 2003
description: Describes how to enable verbose status messages by using Group Policy Object Editor or by editing the Windows registry.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# How to enable verbose startup, shutdown, logon, and logoff status messages in the Windows Server 2003 family

This article describes how to configure Windows so that you receive verbose startup, shutdown, logon, and logoff status messages. Verbose status messages may be helpful when you're troubleshooting slow startup, shutdown, logon, or logoff behavior.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325376

## How to enable verbose startup, shutdown, logon, and logoff status messages

You can enable verbose status messages by using Group Policy Object Editor or by editing the Windows registry.

## Enable verbose status messages by using Group Policy Object Editor

To enable verbose status messages by using Group Policy Object Editor, use the method that is appropriate to your situation:

### In a domain environment

If you're in a domain environment and you want to enable verbose status messages on a group of computers, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. Right-click the container for the domain or the organizational unit to which you want to apply the policy settings, and then click **Properties**.
3. Click the **Group Policy** tab.
4. Click **New**, and then type a descriptive name for the new Group Policy object (GPO).
5. Click the new GPO that you created, and then click **Edit**.
6. Expand **Computer Configuration**, expand **Administrative Templates**, and then click **System**.
7. In the right pane, double-click **Verbose vs normal status messages**.
8. Click **Enabled** > **OK**.
9. Close Group Policy Object Editor, click **OK**, and then quit Active Directory Users and Computers.

> [!NOTE]
> Windows ignores this setting if the **Remove Boot / Shutdown / Logon / Logoff status messages** setting is turned on.

### On a stand-alone computer or a single computer

If you're using a stand-alone computer or if you want to enable verbose status messages on only one computer, follow these steps:

1. Click **Start** > **Run**.
2. In the **Open** box, type *gpedit.msc*, and then click **OK**.
3. Expand **Computer Configuration** > **Administrative Templates**, and then click **System**.
4. In the right pane, double-click **Display highly detailed status messages**.
5. Click **Enabled** > **OK**.
6. Close Group Policy Object Editor, and then click **OK**.

> [!NOTE]
> Windows ignores this setting if the **Remove Boot / Shutdown / Logon / Logoff status messages** setting is turned on.

### Enable verbose status messages by using Registry Editor

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To use enable verbose status messages by editing the registry, follow these steps:

1. Click **Start** > **Run**.
2. In the **Open** box, type *regedit*, and then click **OK**.
3. Locate and then click the following registry key:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
4. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
5. Type *verbosestatus*, and then press ENTER.
6. Double-click the new key that you created, type *1* in the **Value data** box, and then click **OK**.
7. Quit Registry Editor.

> [!NOTE]
> Windows does not display status messages if the following key is present and the value is set to **1**:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DisableStatusMessages`

## More information

If verbose logging isn't enabled, you'll still receive normal status messages such as "Applying your personal settings..." or "Applying computer settings..." when you start up, shut down, log on, or log off from the computer. However, if verbose logging is enabled, you'll receive additional information, such as "RPCSS is starting" or "Waiting for machine group policies to finish....".
