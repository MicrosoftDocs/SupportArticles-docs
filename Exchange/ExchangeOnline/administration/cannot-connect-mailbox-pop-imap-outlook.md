---
title: Can't connect to Outlook with POP/IMAP and Modern authentication
description: Describes why you cannot connect to Outlook by using POP/IMAP and SMTP protocols, and Modern authentication.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 120173
  - CSSTroubleshoot
ms.reviewer: agallego, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# Can't connect to Outlook by using POP/IMAP and Modern authentication

Microsoft recently announced the Exchange Online capability to use OAuth authentication for [POP](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-oauth-support-for-pop-in-exchange-online/ba-p/1406600) and [IMAP and SMTP](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-oauth-2-0-support-for-imap-and-smtp-auth-protocols-in/ba-p/1330432) protocols. Also, tenants are encouraged to disable [Basic authentication](https://techcommunity.microsoft.com/t5/exchange-team-blog/basic-authentication-and-exchange-online-april-2020-update/ba-p/1275508), and move to a [Modern authentication](https://techcommunity.microsoft.com/t5/exchange-team-blog/improving-security-together/ba-p/805892) tenant for modern clients.

If you've disabled Basic authentication, and you're trying to configure an Outlook profile by using POP and SMTP or IMAP and SMTP, you will notice that Outlook neither connects nor authenticates. This is because Outlook supports Modern authentication only for Exchange profiles (MAPI/HTTP and EWS), Outlook.com, and Gmail at this time. It's also documented in [Deprecation of Basic Authentication in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/deprecation-of-basic-authentication-exchange-online#pop-imap-and-smtp-auth):  

> _There is no plan for Outlook clients to support OAuth for POP and IMAP, but Outlook can connect use MAPI/HTTP (Windows clients) and EWS (Outlook for Mac)._

If you're using POP/IMAP and SMTP for an Exchange Online account in Outlook, you must enable Basic authentication for these protocols (until it's permanently deprecated in October 1st). To do so, disable [Microsoft Entra security defaults](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults) if they are enabled.

## Enable Basic authentication for POP and IMAP protocols

If you previously disabled Basic authentication for POP or IMAP by using an Exchange Online authentication policy, you can change the policy to allow these protocols. To re-enable Basic authentication for these protocols, run the following PowerShell command:

```powershell
Set-AuthenticationPolicy -Identity <Policy Name> -AllowBasicAuthPop -AllowBasicAuthImap -AllowBasicAuthSmtp
```

Then, you can either wait for the token to be refreshed after it expires, or run the following command to force it to refresh immediately:

```powershell
Set-User -Identity <user account> -STSRefreshTokensValidFrom $([System.DateTime]::UtcNow)
```

## Enable the SMTP protocol

The SMTP protocol can be enabled and disabled at the tenant level or the mailbox level. This feature is available to admins to prevent malicious users from submitting messages using this protocol. Some companies may decide to turn off the protocol completely as a security measure, and just enable it for specific mailboxes.

### Tenant level

To check the current setting at the tenant level, run the following command:

```powershell
Get-TransportConfig | Select SmtpClientAuthenticationDisabled
```

- If the value is "False," SMTP isn't disabled.
- If the value is "True," SMTP is disabled for the whole tenant.

To enable the SMTP protocol, run the following command to revert the value to "False":

```powershell
Set-TransportConfig -SmtpClientAuthenticationDisabled $False
```

For more information about the `Set-TransportConfig` command, see [Set-TransportConfig](/powershell/module/exchange/set-transportconfig).

### Mailbox level

To check the current setting at the mailbox level, run the following command:

```powershell
Get-EXOCasMailbox <mailbox account> -Properties SmtpClientAuthenticationDisabled | Select SmtpClientAuthenticationDisabled
```

- If the value is blank, the tenant level configuration will be honored at the mailbox level. If the tenant level configuration is set to disable the SMTP protocol, Outlook will not connect. In this case, an exception can be set to allow it for the specific mailbox while maintaining the tenant level setting to disable the SMTP protocol. Or, the tenant level setting can be changed to enable it completely.
- If the value is "False," the tenant level configuration will be overridden by the setting at the mailbox level, and SMTP won't be disabled for this specific user.
- If the value is "True," SMTP is disabled, and this user will fail to connect using SMTP AUTH.

To enable SMTP for a specific user, run the following command to revert the value to "False":

```powershell
Set-CasMailbox <mailbox account> -SmtpClientAuthenticationDisabled $False
```

For more information about the `Set-CasMailbox` command, see [Set-CasMailbox](/powershell/module/exchange/set-casmailbox).
