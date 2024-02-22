---
title: Outlook for Mac users can't access on-premises public folders 
description: Fixes an issue in which Outlook for Mac users receive an error message that indicates Outlook isn't connected to the network when they access Exchange Server 2013 public folders in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 160578
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: batre
appliesto: 
  - Exchange Online
  - Outlook for Mac for Office 365
  - Outlook for Mac
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/24/2024
---

# Outlook for Mac users can't access public folders in Exchange Server 2013

## Symptoms

Consider the following scenario:

- You have a hybrid deployment of Microsoft Exchange Online and Microsoft Exchange Server 2013.
- You configure Exchange Online users to access public folders that are hosted on Exchange Server 2013.

In this scenario, when users use Outlook for Mac in Exchange Online to access the on-premises public folders, they receive the following error message:

> Folders are temporarily unavailable because Outlook is not connected to the network.

Additionally, if you check the server log (*%ExchangeInstallPath%\Logging\Ews*) in Exchange Server 2013 that hosts the public folder mailbox, you see the following error entry:

> \<Date/Time>.965Z,\<MailboxId>,15,0,1497,30,{AC96A663-47F0-4A84-9B8F-5253CD2CAC7D},NTLM,true,User@contoso.com,contoso.com,**MacOutlook/16.57.22011101 (Intelx64 Mac OS X 11.6.3 (Build 20G415))**, ,Exch1,EXCH5.contoso.com,**GetFolder,500**,857,,**ErrorInternalServerError**,User@contoso.com,..,ServiceDiagnostics_ReportException=System.NullReferenceException: **Object reference not set to an instance of an object.**
at Microsoft.Exchange.Services.Core.Types.MailboxIdServerInfo.TryGetServerDataForMailbox(MailboxId mailboxId  Guid& mdbGuid  Int32& serverVersion  String& serverFQDN  Guid& mailboxGuid  String& cafeFQDN  Boolean& proxyToCafe)

## Cause

This issue occurs if the mailbox GUID of the Exchange Online mailbox isn't stamped on the associated on-premises remote mailbox.

## Resolution

To resolve this issue, set the `ExchangeGUID` property on the associated on-premises remote mailbox. To do this, follow these steps:

1. Open [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) on the on-premises server, and then run the following cmdlet to check whether the `ExchangeGUID` property of the on-premises remote mailbox is set:

    ```powershell
    Get-RemoteMailbox <MailboxName> | fl ExchangeGUID
    ```

    If the `ExchangeGUID` property returns all zeros, the value isn't stamped on the on-premises remote mailbox.

2. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and then get the `ExchangeGUID` value of the affected Exchange Online mailbox. To do this, run the following cmdlet:

    ```powershell
    Get-Mailbox <MailboxName> | Format-List ExchangeGUID
    ```

3. Run the following command in Exchange Management Shell to set the value of the `ExchangeGUID` property on the on-premises remote mailbox:

    ```powershell
    Set-RemoteMailbox <MailboxName> -ExchangeGUID "<ExchangeGUID>"
    ```

    **Note:** Replace \<ExchangeGUID> with the value that you get from the cmdlet output in step 2.
