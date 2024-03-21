---
title: Remove entries from Remote Desktop Connection Computer
description: Introduces how to remove entries from the Remote Desktop Connection Computer box.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, imranu
ms.custom: sap:Remote Desktop Services and Terminal Services\Web access (includes RemoteApp and desktop connections), csstroubleshoot
---
# How to remove entries from the Remote Desktop Connection Computer box

This article describes how to remove entries from the **Remote Desktop Connection Computer** box.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 312169

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

After you use the Remote Desktop Connection tool to connect to another computer, the name of the computer is added to the **Remote Desktop Connection Computer** box. It's easy for you to quickly select the same computer at a later time. However, the tool doesn't provide a way to clear the list of computers or remove one or more entries from the Computer box.

## Remove entries in the Windows Remote Desktop Connection client

To remove entries from the **Remote Desktop Connection Computer** box in the Windows Remote Desktop Connection client, start Registry Editor, and then select this registry key:

`HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default`

Entries appear as MRU*number*, and are visible in the right pane. To delete an entry, right-click it, and then select **Delete**.

## Remove entries in the Mac Remote Desktop Connection client

To remove entries from the **Remote Desktop Connection Computer** box in the Mac Remote Desktop Connection client, delete the `Users:Username:Library:Preferences:Microsoft:RDC Client:Recent Servers` file.

> [!NOTE]
>
> The list of all destination connections (including previous connections) are stored in an MRU*number* value in the following registry key:
>
> `HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default`
>
> Every new connection is given the value of **MRU0**, and the other values are then sequentially moved down in number. The MRU value can contain a Fully Qualified Domain Name (FQDN) or an IP address of the computer to which you connect. For example:
>
> - MRU0REG_SZ192.168.16.60
> - MRU1REG_SZcomputer.domain.com
