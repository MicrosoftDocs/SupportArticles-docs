---
title: Can't send emails to a mail-enabled public folder
description: Fixes an issue in which you can't send email to a mail-enabled public folder after you complete a public folder migration from Exchange Server on-premises to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CI 157009
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre, meerak
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans 
search.appverid: MET150
ms.date: 01/24/2024
---
# "554 5.4.14 Hop count exceeded - possible mail loop" error when sending email to MEPF

## Symptoms  

After you complete a public folder migration from Microsoft Exchange Server on-premises to Microsoft Exchange Online, you can't send email messages to a mail-enabled public folder (MEPF), and you receive the following error message:

> 554 5.4.14 Hop count exceeded - possible mail loop

## Cause  

This error is caused by one or both of the following conditions:  

- The centralized mail transport is enabled.
- The public folder parameters that are set at the organizational level aren't configured correctly.

## Resolution  

To resolve this issue, check whether centralized mail transport is enabled. To do this, run the following cmdlet:

```powershell
Get-OutboundConnector | ft name,RouteAllMessagesViaOnPremises,RecipientDomains
```

If the parameters show the following values in the output, this indicates that centralized mail transport is enabled.

```output
RecipientDomains              : {*}
RouteAllMessagesViaOnPremises : True
```

Next, disable centralized mail transport by running the Hybrid Configuration wizard.

If the parameters don't show these same values in the output, or if the issue persists, check the configurations in the following sections. The organization level parameters, `PublicFoldersEnabled` and `PublicFolderMailboxesMigrationComplete`, play an important role in determining how email is routed. If the parameters are configured incorrectly, mail looping issues might occur.

### Exchange Online configuration

To check whether Exchange Online has the correct configuration, run the following cmdlet:  

```powershell
Get-OrganizationConfig | fl RemotePublicFolderMailboxes,PublicFoldersEnabled
```

If the configuration is correct, you'll see the following output:

```output
RemotePublicFolderMailboxes : {}   
PublicFoldersEnabled        : Local
```

If you don't see this output, run the following cmdlet to correct the configuration:

```powershell
Set-OrganizationConfig -RemotePublicFolderMailboxes $Null -PublicFoldersEnabled Local   
```

### External email address for MEPFs

To check whether the correct external email address is configured for the on-premises MEPFs, run the following cmdlet:

```powershell
Get-MailPublicFolder <mail enabled public folder name> | fl ExternalEmailAddress,EmailAddresses 
```

For example:

```powershell
Get-MailPublicFolder sales | fl ExternalEmailAddress,EmailAddresses
```

If the external email address is populated correctly, you'll see output that resembles the following output:

```output
ExternalEmailAddress : smtp:Sales@contoso.mail.onmicrosoft.com  
EmailAddresses       : {smtp:Sales@contoso.mail.onmicrosoft.com, SMTP:Sales@contoso.com}  
```

If you don't see this output, download the [SetMailPublicFolderExternalAddress.ps1](https://www.microsoft.com/download/details.aspx?id=54855) script, and run the script on Exchange Server on-premises.  

**Note** The MEPFs that are synchronized from Exchange Server on-premises to Exchange Online have a value for the `ExternalEmailAddress` parameter stamped. This address is used to route email messages from Exchange Online to Exchange Server on-premises when the public folders are active on Exchange Server on-premises. This parameter in Exchange Online doesn't cause mail looping. However, you have to check this parameter because it's required for messages from Exchange Server on-premises to Exchange Online to be delivered as authenticated.  

### Exchange Server on-premises configuration

To check whether Exchange Server on-premises has the correct configuration, run the following cmdlet:

```powershell
Get-OrganizationConfig | fl PublicFolderMailboxesLockedForNewConnections,PublicFolderMailboxesMigrationComplete,PublicFoldersEnabled 
```

If the configuration is correct, you'll see the following output:

```output
PublicFolderMailboxesMigrationComplete       : True
PublicFoldersEnabled                         : Remote
```

If you don't see this output, run the following cmdlet to correct the configuration:

```powershell
Set-OrganizationConfig -PublicFolderMailboxesMigrationComplete:$true -PublicFoldersEnabled Remote
```
