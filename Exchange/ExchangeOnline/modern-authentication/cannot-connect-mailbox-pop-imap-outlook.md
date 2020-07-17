---
title: Can't connect to Exchange Online mailbox using POP/IMAP, SMTP protocols and Modern Authentication in Outlook
description: Describes an issue in which you are not able to connect to Exchange Online mailbox using POP/IMAP, SMTP protocols and Modern Authentication in Outlook.
author: TobyTu
ms.author: Agustin.Gallegos
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: office 365
localization_priority: Normal
ms.custom: 
- CI 120173
- CSSTroubleshoot
ms.reviewer: Agustin.Gallegos
appliesto:
- Exchange Online
search.appverid: 
- MET150
---

# Can't connect to Exchange Online mailbox using POP/IMAP, SMTP protocols and Modern Authentication in Outlook

## Symptoms

Outlook fails to connect or to authenticate if you try to configure an Outlook profile using POP/IMAP and SMTP when Basic authentication is disabled.

## Cause

Outlook only supports Modern authentication for Exchange, Outlook.com and Gmail account. Microsoft announced the Exchange Online capability to use OAuth authentication for [POP](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-oauth-support-for-pop-in-exchange-online/ba-p/1406600), [IMAP and SMTP](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-oauth-2-0-support-for-imap-and-smtp-auth-protocols-in/ba-p/1330432) protocols. Tenants are encouraged to disable [Basic authentication](https://techcommunity.microsoft.com/t5/exchange-team-blog/basic-authentication-and-exchange-online-april-2020-update/ba-p/1275508) and move to a [Modern authentication](https://techcommunity.microsoft.com/t5/exchange-team-blog/improving-security-together/ba-p/805892) tenant with modern clients.

## Resolution

If you're using POP/IMAP and SMTP for an Exchange Online account in Outlook, you must enable Basic authentication for these protocols. To do so, disable [Azure AD Security Defaults](https://docs.microsoft.com/azure/active-directory/fundamentals/concept-fundamentals-security-defaults).

### Enable Basic Authentication for POP and IMAP Protocols

If you disabled Basic authentication for POP or IMAP using an Exchange Online authentication policy, you can modify the policy to allow both protocols. To re-enable Basic authentication for these protocols, run this PowerShell command:

```powershell
Set-AuthenticationPolicy -Identity <Policy Name> -AllowBasicAuthPop -AllowBasicAuthImap
```

Wait for the lifetime of the Token to be refreshed or run this command to make it effective immediately:

```powershell
Set-User -Identity <user account> -STSRefreshTokensValidFrom $([System.DateTime]::UtcNow)
```

### Enable Basic Authentication for the SMTP Protocol

Basic authentication for the SMTP Protocol can be enabled and disabled at the tenant level or at the mailbox level.

#### Tenant level

To check the current authentication setting at the tenant level, run this command:

```powershell
Get-TransportConfig | Select SmtpClientAuthenticationDisabled
```

- If the value is "False", Basic Auth for SMTP isn't disabled.
- If the value is "True", Basic Auth for SMTP is disabled and only SMTP OAuth capable clients will be able to connect.

To enable Basic authentication, run this command:

```powershell
Set-TransportConfig -SmtpClientAuthenticationDisabled $False
```

#### Mailbox level

To check the current authentication setting at the mailbox level, run this command:

```powershell
Get-EXOCasMailbox <mailbox account> -Properties SmtpClientAuthenticationDisabled | Select SmtpClientAuthenticationDisabled
```

- If the value is blank, the tenant level configuration will be honored at the mailbox level. If the tenant level configuration is set to disable Basic authentication, Outlook will fail to connect. In this case, an exception can be set to allow Basic authentication for the specific mailbox while maintaining the tenant level setting to disable Basic authentication. Alternatively, the tenant level setting can be modified to enable Basic authentication.
- If the value is "False", the tenant level configuration will be overridden by the setting at the mailbox level, and Basic authentication for SMTP won't be disabled for this specific user.
- If the value is "True", Basic authentication for SMTP is disabled and this user needs an SMTP OAuth capable client to connect.

To enable Basic authentication, run this command to set the value back to "False":

```powershell
Set-CasMailbox <mailbox account> -SmtpClientAuthenticationDisabled $False
```

## More information

- For more information about the Set-TransportConfig command, see [Set-TransportConfig](https://docs.microsoft.com/powershell/module/exchange/set-transportconfig?view=exchange-ps).

- For more information about the Set-CasMailbox command, see [Set-CasMailbox](https://docs.microsoft.com/powershell/module/exchange/set-casmailbox?view=exchange-ps).
