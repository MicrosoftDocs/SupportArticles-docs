---
title: How to install and to configure the external connector for a terminal server or remote desktop server
description: Provides a step-by-step description of how to configure the external connector for a Windows Server terminal server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# How to install and configure the external connector for a terminal server or remote desktop server

This article provides a step-by-step description of how to configure the external connector for a Windows Server terminal server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 887432

## Introduction

This article describes how to install and to configure the external connector for a Microsoft Windows Server 2003, Windows Server 2008 terminal server or Windows Server 2008 R2 Remote Desktop Session Host server. A terminal server is a server that has Terminal Server enabled.

## More information

To install and to configure the external connector for a Windows Server 2003 or Windows Server 2008 terminal server, follow these steps:

1. Activate your Windows Server Terminal Server License Server.

    > [!NOTE]
    > Do not install any licenses on the Terminal Server License Server.
2. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **Terminal Services Configuration** to start the Terminal Services Configuration tool.
3. In the left pane under **Terminal Services Configuration**, click **Server Settings**.
4. In the right pane under **Settings**, right-click **Licensing**, and then click **Properties**.
5. In the **Licensing Mode** list, click **Per User**, and then click **OK**.

> [!NOTE]
> If the external connector does not work after you follow these steps, you may have to install per-user licenses on the Terminal Server License Server.

To install and to configure the external connector for a Windows Server 2008 R2 Remote Desktop Services (RDS) server, follow these steps:

1. On the RD Session Host server, open **Remote Desktop Session Host Configuration**. To open **Remote Desktop Session Host Configuration**, click **Start**, point to **Administrative Tools**, point to **Remote Desktop Services**, and then click **Remote Desktop Session Host Configuration**.
2. If the User Account Control dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.
3. In the **Edit settings** section, under **Licensing**, double-click **Remote Desktop licensing mode**.
4. On the **Licensing** tab of the **Properties** dialog box, select **Per User mode**.

    > [!NOTE]
    > If the Remote Desktop licensing mode choices are dimmed and you cannot make a selection, the Set the Remote Desktop licensing mode Group Policy setting has been enabled and has been applied to the RS Session Host server.
5. Next, click on the **Add** button under "Remote Desktop license server" section to point to a RDSLS Server.

    For detailed steps, see [Specify a License Server for an RD Session Host Server to Use](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770585(v=ws.11)).

6. Click **OK** to save your changes to the licensing settings.
