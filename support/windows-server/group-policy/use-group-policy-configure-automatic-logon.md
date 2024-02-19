---
title: How to use Group Policy to configure automatic logon
description: Describes the steps to use Group Policy to configure automatic logon in Microsoft Windows Server 2003 Terminal Services.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: cwest, jamirc, kaushika
ms.custom: sap:deploying-software-through-group-policy, csstroubleshoot
---
# How to use Group Policy to configure automatic logon in Windows Server 2003 Terminal Services

This step-by-step article describes how to use Group Policy to configure automatic logon in Microsoft Windows Server 2003 Terminal Services.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324807

## Summary

When you use Remote Desktop Connection to connect to a Windows Server 2003-based computer running Terminal Services, you can provide your logon information before you make the connection. In this way, you automatically pass these credentials to the server.

You specify your user name, password, and logon domain on the General tab in the Remote Desktop Connection dialog box (in the Remote Desktop Connection client window, click Options, and then click the General tab). When you click Connect, the logon information that you typed becomes the default setting for all Remote Desktop connections and is saved in the Default.rdp file.

## Steps to use Group Policy to configure automatic logon in Windows Server 2003 Terminal Services

To fully implement an automatic logon in which the user isn't prompted to supply a password upon connection, the **Always prompt client for password upon connection** policy setting must be turned off on the server. By doing so, users can automatically log on to Terminal Services by supplying their passwords in the Remote Desktop Connection client.

1. Click Start, click Run, type mmc in the Open box, and then click OK.
2. On the File menu, click **Add/Remove Snap-in**.
3. Click Add.
4. Click **Group Policy Object Editor**, and then click Add.
5. Click the target Group Policy object (GPO). The default GPO is Local Computer. Click Browse to select the GPO that you want, and then click Finish.
6. Click Close, and then click OK.
7. Expand the Group Policy object, expand Computer Configuration, expand Administrative Templates, expand Windows Components, expand Terminal Services, and then click **Encryption and Security**.
8. In the right pane, double-click **Always prompt client for password upon connection**.
9. Click Disabled.
10. Click OK, and then quit the Group Policy Object Editor snap-in.
