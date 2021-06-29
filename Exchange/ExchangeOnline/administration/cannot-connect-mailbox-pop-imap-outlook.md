---
title: Can't connect to Outlook with POP/IMAP and Modern authentication 
description: Describes why you cannot connect to Outlook by using POP/IMAP and SMTP protocols, and Modern authentication.
author: simonxjx
ms.author: nriera
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 120173
- CSSTroubleshoot
ms.reviewer: agallego
appliesto:
- Exchange Online
search.appverid: 
- MET150
---
# Can't connect to Outlook by using POP/IMAP and Modern authentication

Microsoft recently announced the Exchange Online capability to use OAuth authentication for [POP](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-oauth-support-for-pop-in-exchange-online/ba-p/1406600) and [IMAP and SMTP](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-oauth-2-0-support-for-imap-and-smtp-auth-protocols-in/ba-p/1330432) protocols. Also, tenants are encouraged to disable [Basic authentication](https://techcommunity.microsoft.com/t5/exchange-team-blog/basic-authentication-and-exchange-online-april-2020-update/ba-p/1275508), and move to a [Modern authentication](https://techcommunity.microsoft.com/t5/exchange-team-blog/improving-security-together/ba-p/805892) tenant for modern clients.

If you have disabled Basic authentication, and you are trying to configure an Outlook profile by using POP and SMTP or IMAP and SMTP, you will notice that Outlook neither connects nor authenticates. This is because Outlook supports Modern authentication for only Exchange, Outlook.com, and Gmail at this time.

If you're using POP/IMAP and SMTP for an Exchange Online account in Outlook, you must enable Basic authentication for these protocols. To do this, disable [Azure Active Directory security defaults](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults) if they are enabled.

## Enable Basic authentication for POP and IMAP protocols

If you previously disabled Basic authentication for POP or IMAP by using an Exchange Online authentication policy, you can change the policy to allow these protocols. To re-enable Basic authentication for these protocols, run the following PowerShell command:

```powershell
Set-AuthenticationPolicy -Identity <Policy Name> -AllowBasicAuthPop -AllowBasicAuthImap
```

Then, you can either wait for the token to be refreshed after it expires, or run the following command to force it to refresh immediately:

```powershell
Set-User -Identity <user account> -STSRefreshTokensValidFrom $([System.DateTime]::UtcNow)
```

## Enable Basic authentication for the SMTP protocol

Basic authentication for the SMTP protocol can be enabled and disabled at the tenant level or at the mailbox level.

### Tenant level

To check the current authentication setting at the tenant level, run the following command:

```powershell
Get-TransportConfig | Select SmtpClientAuthenticationDisabled
```

- If the value is "False," Basic authentication for SMTP isn't disabled.
- If the value is "True," Basic authentication for SMTP is disabled, and only SMTP OAuth-capable clients will be able to connect.

To enable Basic authentication, run the following command to revert the value to "False":

```powershell
Set-TransportConfig -SmtpClientAuthenticationDisabled $False
```

For more information about the `Set-TransportConfig` command, see [Set-TransportConfig](/powershell/module/exchange/set-transportconfig).

### Mailbox level

To check the current authentication setting at the mailbox level, run the following command:

```powershell
Get-EXOCasMailbox <mailbox account> -Properties SmtpClientAuthenticationDisabled | Select SmtpClientAuthenticationDisabled
```

- If the value is blank, the tenant level configuration will be honored at the mailbox level. If the tenant level configuration is set to disable Basic authentication, Outlook will not connect. In this case, an exception can be set to allow Basic authentication for the specific mailbox while maintaining the tenant level setting to disable Basic authentication. Or, the tenant level setting can be changed to enable Basic authentication.
- If the value is "False," the tenant level configuration will be overridden by the setting at the mailbox level, and Basic authentication for SMTP won't be disabled for this specific user.
- If the value is "True," Basic authentication for SMTP is disabled, and this user must have an SMTP OAuth-capable client to be able to connect.

To enable Basic authentication, run the following command to revert the value to "False":

```powershell
Set-CasMailbox <mailbox account> -SmtpClientAuthenticationDisabled $False
```

For more information about the `Set-CasMailbox` command, see [Set-CasMailbox](/powershell/module/exchange/set-casmailbox).