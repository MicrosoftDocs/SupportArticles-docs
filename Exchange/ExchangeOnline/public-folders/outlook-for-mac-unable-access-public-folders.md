---
title: Unable to access on-premises public folders from Outlook for Mac
description: Fixes an issue in which Outlook for Mac users receive the "Folders are temporarily unavailable because Outlook if not connected to the network" error when they access Exchange Server 2013 public folders in a hybrid deployment.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 160578
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre
appliesto: 
  - Exchange Online
  - Outlook for Mac for Office 365
  - Outlook for Mac
  - Exchange Server 2013
search.appverid: MET150
---

# Unable to access Exchange on-premises public folders by using Outlook for Mac

## Symptoms

Consider the following scenario:

- You have a hybrid deployment of Microsoft Exchange Online and Microsoft Exchange Server 2013.
- You configured Exchange Online users to access public folders that are hosted at Exchange Server 2013.

In this scenario, when users use Outlook for Mac in Exchange Online to access the on-premises public folders, they get the following error message:

> Folders are temporarily unavailable because Outlook if not connected to the network.

:::image type="content" source="media/outlook-for-mac-unable-access-public-folders/error.png" alt-text="Screenshot of error message that indicates folders are temporarily unavailable because Outlook if not connected to the network.":::

Additionally, if you check the server log in Exchange Server 2013 that hosts the public folder mailbox, you see the following error message in the log:

> \<Date/Time>.965Z,\<MailboxId>,15,0,1497,30,{AC96A663-47F0-4A84-9B8F-5253CD2CAC7D},NTLM,true,User@contoso.com,contoso.com,MacOutlook/16.57.22011101 (Intelx64 Mac OS X 11.6.3 (Build 20G415)), ,Exch1,EXCH5.contoso.com,GetFolder,500,857,,ErrorInternalServerError,User@contoso.com,..,ServiceDiagnostics_ReportException=System.NullReferenceException: Object reference not set to an instance of an object.
at Microsoft.Exchange.Services.Core.Types.MailboxIdServerInfo.TryGetServerDataForMailbox(MailboxId mailboxId  Guid& mdbGuid  Int32& serverVersion  String& serverFQDN  Guid& mailboxGuid  String& cafeFQDN  Boolean& proxyToCafe)

## Cause

In a hybrid deployment, an Exchange Online mailbox is matched with a remote mailbox in Exchange Server on-premises. This issue occurs if the on-premises remote mailbox isn't set to use the Exchange Online mailbox GUID.

## Resolution

To resolve this issue, set the on-premises remote mailbox to use the Exchange Online mailbox GUID by following these steps:

1. Open Exchange Management Shell, and then get the `ExchangeGUID` value of the affected remote mailbox by running the following cmdlet:

    ```powershell
    Get-RemoteMailbox <MailboxName> | fl ExchangeGUID
    ```

    If the value of the `ExchangeGUID` property returns all zeros, it indicates that the on-premises remote mailbox GUID isn't updated.

    Here's an example of the cmdlet:

    :::image type="content" source="media/outlook-for-mac-unable-access-public-folders/get-guid.png" alt-text="Screenshot of the command output in which ExchangeGuid shows all zeros.":::

2. Connect to Exchange Online PowerShell, and then get the `ExchangeGUID` value of the affected Exchange Online mailbox by running the following cmdlet:

    ```powershell
    Get-Mailbox <MailboxName> | Format-List ExchangeGUID
    ```

    Here's an example of the cmdlet:

    :::image type="content" source="media/outlook-for-mac-unable-access-public-folders/get-exo-mailbox-guid.png" alt-text="Screenshot of the command output in which ExchangeGuid of Exchange Online mailbox is highlighted.":::

3. Go back to Exchange Management Shell, and then set the on-premises remote mailbox to use the `ExchangeGUID` value of the Exchange Online mailbox by running the following cmdlet:

    ```powershell
    Set-RemoteMailbox <MailboxName> -ExchangeGUID "<ExchangeGUID>"
    ```

    **Note:** Replace \<ExchangeGUID> with the value that you get from the cmdlet output in step 2.

    Here's an example of the cmdlet:

    :::image type="content" source="media/outlook-for-mac-unable-access-public-folders/set-remote-mailbox.png" alt-text="Screenshot of the command that set the ExchangeGuid of the Exchange Online mailbox to the remote mailbox.":::
