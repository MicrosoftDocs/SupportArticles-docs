---
title: Connection issues when MAPI is disabled
description: This article resolves the connection issues between Microsoft Outlook and Exchange Server that occur when Messaging Application Programming Interface (MAPI) is disabled for a user.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: robevans
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
ms.date: 10/30/2023
---
# Connection issues between Outlook and Exchange when MAPI is disabled for a user

_Original KB number:_ &nbsp; 2996728

## Symptoms

Consider the following scenario:

- You try to create a new Outlook profile and you receive the following error message:

    > The action cannot be completed. The connection to Microsoft Exchange is unavailable. Outlook must be online or connected to complete this action.

- You are unable to connect to your Exchange mailbox with an existing Outlook profile and **Disconnected** displays in the Outlook Status Bar:

   :::image type="content" source="./media/connection-issues-mapi-disabled/disconnected-message-outlook-2010.png" alt-text="Screenshot of the Disconnect message in Outlook 2010 Status Bar." border="false":::

   :::image type="content" source="./media/connection-issues-mapi-disabled/disconnected-message-outlook-2013.png" alt-text="Screenshot of the DISCONNECT message in Outlook 2013 Status Bar." border="false":::

- You are unable to open Public Folders or an Online Archive, and you receive the following error message:

    > Cannot expand the folder. Microsoft Exchange is not available. Either there are network problems or the Exchange server is down for maintenance.

## Cause

You don't have MAPI enabled in your protocol settings.

## Resolution

To resolve this issue, run the following from the Windows PowerShell cmdlet from Exchange Management Console:

```powershell
Set-CasMailbox User1@contoso.com -MapiEnabled $True
```

## More information

You can verify MAPI is enabled by checking the protocol settings for the user:

:::image type="content" source="./media/connection-issues-mapi-disabled/verify-mapi-enabled.png" alt-text="Screenshot of the protocol settings for the user, which includes MAPI." border="false":::

For more information about protocol settings and Adsiedit, see [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)).
