---
title: Troubleshooting mail enabled public folder synchronization failures when using PowerShell script
description: This article describes two mail enabled public folder synchronization failures. Provides two resolutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CI 116762
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# Troubleshooting mail enabled public folder synchronization failures when using PowerShell script

## Symptoms

When attempting to synchronize mail enabled public folder (MEPF) objects from on-premise to Exchange Online Active Directory using either [Sync-MailPublicFolders.ps1](https://www.microsoft.com/download/details.aspx?id=46381) (Microsoft Exchange Server 2007 and 2010) or [Sync-ModernMailPublicFolders.ps1](https://www.microsoft.com/download/details.aspx?id=54855) (Microsoft Exchange Server 2013, 2016 and 2019), the script fails with one of following errors:

**Error 1:**

`Active Directory operation failed on PU1PR04A03DC006.APCPR04A003.prod.outlook.com. The object 'CN=Marketing,OU=contoso.onmicrosoft.com,OU=Microsoft Exchange Hosted Organizations,DC=APCPR04A003,DC=prod,DC=outlook,DC=com' already exists.`

The error always occurs when the script is performing the **Set** command.

**Error 2:**

`The proxy address "X500:/O=BAT2/OU=EXCHANGE ADMINISTRATIVE GROUP (FYDIBOHF23SPDLT)/CN=RECIPIENTS/CN=E1DBD36E5BEF784A97A5CD66292252D8-00008991FDA8" is already being used by the proxy addresses or LegacyExchangeDN of "HR". Please choose another proxy address.`

## Causes

The first issue occurs because there's an object in Exchange Online with the same name as the MEPF. The conflicting object is reported in the error itself and can be retrieved with the following cmdlet in Exchange Online PowerShell:

```powershell
Get-Recipient '<Distinguished Name reported in the error>'
```

For example:

```powershell
Get-Recipient 'CN=Marketing,contoso.onmicrosoft.com,OU=Microsoft Exchange Hosted Organizations,DC=APCPR04A003,DC=prod,DC=outlook,DC=com'
```

The second issue occurs because the Exchange Online already has an object with the proxy address mentioned in the error.

## Resolution

To fix the first issue, change the name of the MEPF in on-premises using the following cmdlet:

```powershell
Get-MailPublicFolder <MEPF name> | Set-MailPublicFolder -Name <new name for MEPF>
```

For example:

```powershell
Get-MailPublicFolder \Marketing | Set-MailPublicFolder -Name Marketing_PF
```

> [!NOTE]
> Changing the name of MEPF doesn't affect the email address or the actual name of the public folder it's associated with.

To fix the second issue, follow these steps:

1. Find out objects that have same proxy address by using the following cmdlet:

    ```powershell
    Get-Recipient |?{$_.EmailAddresses -like "<address mentioned in the error>"}
    ```

    For example:

    ```powershell
    Get-Recipient |?{$_.EmailAddresses -like "*X500:/O=BAT2/OU=EXCHANGE ADMINISTRATIVE GROUP (FYDIBOHF23SPDXX)/CN=RECIPIENTS/CN=E1DBD36E5BEF784A97A5CD66299952D8-00008991FDA8*"}
    ```

2. If the object returned isn't a MEPF, remove the object if you don't want to keep it.
3. If you only see the MEPF object returned with the same proxy, there are duplicate MEPFs in on-premises. Find the duplicate MEPFs and then remove them. To find the duplicate MEPFs, run the following cmdlet in on-premises:

    ```powershell
    Get-MailPublicFolder | ?{ $_.EmailAddresses -like "<email of problem MEPF>"}
    ```

    For example:

    ```powershell
    Get-MailPublicFolder | ?{ $_.EmailAddresses -like "*hr*"}
    ```

4. If multiple objects are returned, make sure a single object is kept and remove the other objects.
