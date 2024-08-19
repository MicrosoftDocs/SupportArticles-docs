---
title: Public folder mailbox not found in a multi-geo environment
description: Discusses how to resolve public folder mailbox errors when you try to manage public folder mailboxes in a multi-geo environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
  - CI 166461
ms.reviewer: haembab, batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Public folder mailbox not found in a multi-geo environment

## Symptoms

As a Microsoft Exchange administrator, when you try to retrieve or edit a public folder in an [Exchange multi-geo tenant](/microsoft-365/enterprise/multi-geo-capabilities-in-exchange-online), you receive an error message that resembles:

> The mailbox '`<mailbox GUID>`' is not found in the local forest. Please connect to the right forest by using ConnectionUri as `https://outlook.office365.com/powershell-liveid?email=<mailbox email address>` while running New-PSSession.

When you try to create a public folder, you receive an error message that resembles:

> No public folders exist in this organization. Before you create a public folder, please make sure that you created at least one public folder mailbox. To create a public folder, click 'Add' +. After you create the public folder, you'll need to assign permissions so users can access it and create subfolders.

## Cause

Your admin account mailbox and the mailbox for the public folder that you're trying to work with are in different geo locations. The Exchange admin center (EAC) doesn't support access to public folder mailboxes that are in a different geo location than the one that your admin account mailbox is in. If you're using Exchange Online PowerShell, you might not have connected the PowerShell session to the public folder mailbox.

> [!NOTE]
>
> A geo location might contain several forests. Forests are specific to a geo location. The issue can also occur if the admin mailbox and the public folder mailbox are in the same geo location but in different forests.

## Resolution

To manage a public folder mailbox that exists in a different geo location than the one that your admin account mailbox is in, follow these steps:

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa) to get the primary SMTP address of the public folder mailbox. The connection steps work regardless of whether multifactor authentication (MFA) is enabled:

   1. Load the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) by running the following command in a PowerShell window:

      ```powershell
      Import-Module ExchangeOnlineManagement
      ```

   2. Connect to Exchange Online PowerShell using modern authentication:

      ```powershell
      Connect-ExchangeOnline
      ```

      When you're prompted, enter the password for your admin account. If the account has MFA enabled, you must also enter a security code.

   3. Get the primary SMTP address of the public folder mailbox by using the [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet. If the error message specifies the mailbox GUID, run the following command:

      ```powershell
      Get-Mailbox -PublicFolder '<mailbox GUID>' | fl PrimarySmtpAddress
      ```

      If the error message doesn't specify the mailbox GUID, run the following commands to query the root public folder mailbox:

      ```powershell
      $mailboxGuid = (Get-OrganizationConfig).RootPublicFolderMailbox.HierarchyMailboxGuid.Guid
      Get-Mailbox -PublicFolder $mailboxGuid | fl PrimarySmtpAddress
      ```

2. Open an Exchange Online PowerShell session that connects to the mailbox for the public folder that you're trying to work with:

   1. Connect to Exchange Online PowerShell by using a connection string that specifies the primary SMTP address of the public folder mailbox that you got in step 1:

      ```powershell
      Connect-ExchangeOnline -UserPrincipalName <admin mailbox> -ConnectionUri https://outlook.office365.com/powershell?email=<mailbox smtp address>
      ```

      For example, if the admin account is `admin@contoso.onmicrosoft.com`, and the SMTP address of the public folder mailbox is `PFMBX1_3f15ace7@contoso.onmicrosoft.com`, run the following command:

      ```powershell
      Connect-ExchangeOnline -UserPrincipalName admin@contoso.onmicrosoft.com -ConnectionUri https://outlook.office365.com/powershell?email=PFMBX1_3f15ace7@contoso.onmicrosoft.com
      ```

      When you're prompted, enter the password for your admin account. If the account has MFA enabled, you must also enter a security code.

   2. Retry your command that creates, retrieves, or edits a public folder.

## More information

- To check the geo location and forest of your admin mailbox, run the following command:

  ```powershell
  Get-Mailbox <admin mailbox> | select MailboxLocations
  ```

  In the following example output, `eurprd07` identifies the geo location and forest of the admin mailbox. The geo location is Europe. The forest within that geo location is indicated by `07`.

  > MailboxLocations : {1;1bfe328f-3be7-4262-a19d-9b136f993e88;Primary;eurprd07.prod.outlook.com;40169cc4-ad05-42a4-a9cb-c49427346652}

- To check the geo location and forest of the public folder mailbox, run the following command:

  ```powershell
  Get-Mailbox -PublicFolder '<mailbox GUID>' | select MailboxLocations
  ```

  In the following example output, `namprd07` identifies the geo location and forest. The geo location is North America. The forest within that geo location is indicated by `09`.

  > MailboxLocations : {1;b97dc6ee-4f88-4ff1-ab66-df87fe274b79;Primary;namprd09.prod.outlook.com;1dac0c0d-7de1-476e-a2f5-e080237a3091}

- To check the default geo location of your organization, run the [Get-OrganizationConfig](/powershell/module/exchange/get-organizationconfig) cmdlet as follows:

  ```powershell
  Get-OrganizationConfig | fl DefaultMailboxRegion
  ```

- Your admin account mailbox and the public folder mailbox might be in a different geo location or forest if:

  - Exchange Server Online performed a cross-forest public folder mailbox move for load balancing.

  - An admin in your organization requested [data migration to a local datacenter geo](/microsoft-365/enterprise/moving-data-to-new-datacenter-geos).

  - An admin in your organization performed an [unsupported public folder migration](/microsoft-365/enterprise/multi-geo-capabilities-in-exchange-online#feature-limitations-for-multi-geo-in-exchange-online) to a satellite geo location.
  
- For more information about how to manage Exchange Online mailboxes in a multi-geo environment, see [Connect to a geo location in Exchange Online PowerShell](/microsoft-365/enterprise/administering-exchange-online-multi-geo#connect-to-a-geo-location-in-exchange-online-powershell).
