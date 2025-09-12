---
title: 400 Bad Request when you access the Options page
description: Resolves a problem that occurs when a user tries to access the Options page under Outlook Web App in Exchange Server 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error when a user accesses the Options page in Exchange Server 2010: 400 Bad Request

_Original KB number:_ &nbsp; 2971274

## Symptoms

When a user logs in to Outlook Web App (OWA) in Microsoft Exchange Server 2010 and then clicks **Options** and then **See all options**, the user may receive an error: 400 Bad Request.

## Cause

The error occurs because the user doesn't have a time zone value specified on the mailbox in Exchange Server 2010. You can verify this value by running the `Get-MailboxRegionalConfiguration -identity <username>` cmdlet.

Legacy configuration may still exist on the OWA virtual directory. In Exchange Server 2007, administrators could change values so that users wouldn't be prompted for language or time zone preferences on their first logon attempt. For example, administrators could set value 1033 for English as follows:

```powershell
Set-OWAVirtualdirectory "owa (Default Web Site)" -DefaultClientLanguage 1033 -LogonAndErrorLanguage 1033
```

When the OWA virtual directory is configured by using a value other than 0 (zero) for `DefaultClientLanguage` and `LogonAndErrorLanguage`, the language attributes on the mailbox aren't updated. Additionally, if the time zone isn't set in the regional configuration for Exchange Server 2010, the user may receive the error that is mentioned in the [Symptoms](#symptoms) section. These values are required for the Exchange Control Panel to work correctly.

Although these cmdlets are still accepted by Exchange Server 2010 virtual directories, the cmdlets are considered legacy settings. So, we recommend that you use the `Set-MailboxRegionalConfiguration` cmdlet in Exchange Server 2010. For example:

```powershell
Set-MailboxRegionalConfiguration -Identity <username> -Language en-us -TimeZone "Eastern Standard Time"
```

## Resolution 1: Set a time zone value for one or more users

- Set a time zone value for the user by using the following command:

    ```powershell
    Set-MailboxRegionalConfiguration -Identity <username> -Language en-us -TimeZone "Eastern Standard Time"
    ```

- Set the time zone for multiple users by using the following command. However, this will change all users to the specific time zone only.

    ```powershell
    get-mailbox | Set-MailboxRegionalConfiguration -Timezone "Eastern Standard Time"
    ```

## Resolution 2: Set the default client language and logon error language to 0

If you have multiple affected users, set the default client language and logon error language to 0 on the virtual directory by using the following command. However, this value is considered a legacy attribute. Although it can be used in Exchange Server 2010, the `Set-MailboxRegionalConfiguration` is preferred:

```powershell
Get-OWAVirtualdirectory "xcsicas1\OWA (Default Web Site)" |Set-OWAVirtualdirectory -DefaultClientLanguage 0 -LogonAndErrorLanguage 0
```

## More information

If you try to verify that users don't have a time zone by running `Mailbox -Resultsize Unlimited | Get-MailboxRegionalConfiguration`, the return on the identity attribute will be a null value. This is a known issue in Exchange Server 2010. So, you should use the resolution 2 only if multiple users are affected.
