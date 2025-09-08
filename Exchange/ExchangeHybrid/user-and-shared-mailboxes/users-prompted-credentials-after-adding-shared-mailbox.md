---
title: Users prompted for credentials after adding a shared mailbox
description: Describes a scenario in which users are prompted for credentials in Outlook after they add a shared mailbox as a second Exchange email account in their existing Outlook profile.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: ernelso, jmartin, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Users prompted for credentials after adding a shared mailbox as a second Exchange email account in their Outlook profile

_Original KB number:_ &nbsp; 3184064

## Symptoms

Consider the following scenario:

- You have a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Microsoft 365.
- You configured legacy on-premises public folders for a hybrid deployment.
- You create a shared mailbox that's located in Exchange Online.
- You assign Full Access permissions to one or more users.
- Users add the shared mailbox as a second Exchange account in their existing Outlook profile.

In this scenario, users are repeatedly prompted for credentials when they open Outlook.

## Cause

This issue occurs because Outlook tries to connect to the legacy on-premises public folders for the shared mailbox.

## Workaround

To work around the problem, move the shared mailbox to the on-premises environment.

## Resolution

To fix this issue, you can enable access to public folders for users and disable access to public folders for the shared mailbox. To do this, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and follow these steps:

1. Enable access to public folders for users by running the following cmdlet:

   ```powershell
   Set-CASMailbox tony@contoso.com -PublicFolderClientAccess $true
   ```

   > [!NOTE]
   > This example enables access to public folders for the user tony@contoso.com.

1. Disable access to public folders for the shared mailbox by running the following cmdlet:

   ```powershell
   Set-CASMailbox adam@contoso.com -PublicFolderClientAccess $false
   ```

   > [!NOTE]
   > This example disables access to public folders for the shared mailbox adam@contoso.com.

1. Enable access to public folders for the organization by running the following cmdlet:

   ```powershell
   Set-OrganizationConfig -PublicFolderShowClientControl $true
   ```

## More information

An error message that resembles the following is found in the RPC Client Access service log for this connection attempt:

> [LoginPermException] 'User SID: *SID*' can't act as owner of a MailUser
object '/o=ExchangeLabs/ou=Exchange Administrative Group (*Group*)/cn=Recipients/cn=<User_Identity>' with SID *SID* and MasterAccountSid S-1-5-10
 (StoreError=LoginPerm)

For more information, see [Configure legacy on-premises public folders for a hybrid deployment](/exchange/collaboration-exo/public-folders/set-up-legacy-hybrid-public-folders).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
