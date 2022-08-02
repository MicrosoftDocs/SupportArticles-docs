---
title: Can't send emails to a mail-enabled public folder
description: Fixes an issue in which you can't send email messages to a mail-enabled public folder after you complete a public folder migration from Microsoft Exchange Server on-premises to Microsoft Exchange Online.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 157009
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre, meerak
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans 
search.appverid: MET150
ms.date: 8/02/2022
---
# "554 5.4.14 Hop count exceeded - possible mail loop" error when sending emails to MEPF

## Symptoms  

After you complete a public folder migration from Microsoft Exchange Server on-premises to Microsoft Exchange Online, you can't send email messages to a mail-enabled public folder (MEPF) with the following error:

> 554 5.4.14 Hop count exceeded - possible mail loop

## Cause  

This error is caused by one or both of the following conditions:  

- The centralized mail transport is enabled.
- The values of public folder parameters that are set at the organizational level aren't configured correctly.

## Resolution  

To resolve this issue, first check whether centralized mail transport is enabled by running the following cmdlet:

```powershell
Get-OutboundConnector | ft name,RouteAllMessagesViaOnPremises,RecipientDomains
```

If the parameters show the following values in the output, it indicates centralized mail transport is enabled.

```output
RecipientDomains              : {*}
RouteAllMessagesViaOnPremises : True
```

Then, disable centralized mail transport by running the Hybrid Configuration wizard.

If the parameters don't show those values in the output or if the issue persists, you have to check the following configurations. The organization level parameters `PublicFoldersEnabled` and `PublicFolderMailboxesMigrationComplete` play an important role in determining how emails are routed. If they are configured incorrectly, mail looping issues might occur.

### Exchange Online configuration

Run the following cmdlet to check whether Exchange Online has the correct configuration:  

```powershell
Get-OrganizationConfig | fl RemotePublicFolderMailboxes,PublicFoldersEnabled
```

You'll see the following output if the configuration is correct:  

```output
RemotePublicFolderMailboxes : {}   
PublicFoldersEnabled        : Local
```

If not, run the following cmdlet to correct the configuration:

```powershell
Set-OrganizationConfig -RemotePublicFolderMailboxes $Null -PublicFoldersEnabled Local   
```

### External email address for MEPFs

Run the following cmdlet to check whether the correct external email address is configured for the on-premises MEPFs:

```powershell
Get-MailPublicFolder <mail enabled public folder name> | fl ExternalEmailAddress,EmailAddresses 
```

For example:

```powershell
Get-MailPublicFolder sales | fl ExternalEmailAddress,EmailAddresses
```

You'll see an output similar to the following if the external email address is populated correctly:

```output
ExternalEmailAddress : smtp:Sales@contoso.mail.onmicrosoft.com  
EmailAddresses       : {smtp:Sales@contoso.mail.onmicrosoft.com, SMTP:Sales@contoso.com}  
```

If not, download the [SetMailPublicFolderExternalAddress.ps1](https://www.microsoft.com/download/details.aspx?id=54855) script and run the script on Exchange Server on-premises.  

**Note** The MEPFs that are synchronized from Exchange Server on-premises to Exchange Online have a value for the `ExternalEmailAddress` parameter stamped. This address is used to route email messages from Exchange Online to Exchange Server on-premises when the public folders are active on Exchange Server on-premises. This parameter in Exchange Online doesn't cause mail looping. However, you have to check it because it's required for messages from Exchange Server on-premises to Exchange Online to be delivered as authenticated.  

### Exchange Server on-premises configuration

Run the following cmdlet to check whether Exchange Server on-premises has the correct configuration:

```powershell
Get-OrganizationConfig | fl PublicFolderMailboxesLockedForNewConnections,PublicFolderMailboxesMigrationComplete,PublicFoldersEnabled 
```

You'll see the following output if the configuration is correct:

```output
PublicFolderMailboxesMigrationComplete       : True
PublicFoldersEnabled                         : Remote
```

If not, run the following cmdlet to correct the configuration:

```powershell
Set-OrganizationConfig -PublicFolderMailboxesMigrationComplete:$true -PublicFoldersEnabled Remote
```
