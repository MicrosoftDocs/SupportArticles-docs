---
title: Outlook asks for password repeatedly when it uses MAPI over HTTP
description: Outlook repeatedly prompts for password when you change the protocol it uses to access Exchange Server from RPC over HTTP to MAPI over HTTP.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: cjiang, todla
appliesto: 
  - Outlook 2010
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook repeatedly prompts for credentials when using MAPI over HTTP to connect to Exchange

_Original KB number:_ &nbsp;4051374

## Symptoms

You change the protocol that your Outlook clients use to access Microsoft Exchange Server from RPC over HTTP to MAPI over HTTP. After the change, Outlook 2016 or Outlook 2010 users are repeatedly prompted for credentials to connect to Exchange Server.

## Cause

This issue occurs because Outlook 2016 or 2010 keeps trying to use the credentials that were cached for the old RPC over HTTP protocol.

## Workaround

To work around this issue, remove the cached credentials from Credential Manager on the users' computers. To do this, follow these steps:

1. In Control Panel, click **User Accounts** > **Credential Manager** > **Windows Credentials**.
2. Remove all credentials that start with *MicrosoftOffice15_Data:SSPI* or *MicrosoftOffice16_Data:SSPI*.
3. Restart Outlook.
4. Enter the user credential in the format of *domain/user*.

## Group policy setting consideration

If you use MAPI over HTTP and the **Authentication with Exchange Server** Group Policy setting for Outlook, you must update the setting to use the **Kerberos/NTLM Password Authentication** that MAPI over HTTP uses as the authentication method.
:::image type="content" source="./media/outlook-prompt-password-when-use-mapi-over-http/authentication-with-exchange-server-window.png" alt-text="Screenshot of Authentication with Exchange Server setting window when you set the authentication setting to Kerberos/NTLM Password Authentication." border="false":::

## References

[Use Group Policy to enforce Office 2010 settings](https://technet.microsoft.com/library/cc179081%28v=office.14%29.aspx)
