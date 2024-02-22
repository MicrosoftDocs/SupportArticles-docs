---
title: Cannot set user culture when CAS proxies to older version
description: When Client Access Server (CAS) proxies to an older server version, you cannot set user culture. Provides methods to solve this issue.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: wduff, charw, v-six
appliesto: 
  - Exchange Server 2010 Service Pack 1
search.appverid: MET150
---
# User Culture cannot be set when Exchange Server 2010 SP1 CAS proxies to an older server version

_Original KB number:_ &nbsp; 2475771

## Symptoms

When you connect to an Exchange Server 2010 Client Access Server (CAS) running Exchange Server 2010 SP1, and you must proxy to an internal Client Access Server running the original Release to Manufacturing (RTM) version of Exchange Server 2010, you receive the following error:

> HTTP 400 - Bad Request will occur in Internet Explorer. IIS logs show:
>
> *DateTime* *IPAddress* POST /owa/ev.owa oeh=1&ns=HttpProxy&ev=LanguagePost&v=14.1.218.13&sessionId=a3789db012cb4d1093cbf206d85c72c6&prfltncy=18 443 contoso\user2 192.168.154.1 Mozilla/4.0+(compatible;+MSIE+6.0;+Windows+NT+5.2;+SV1;+.NET+CLR+1.1.4322) 400 0 0 31

This only occurs for first-time OWA users in the Exchange Server 2010 environment. These users are not prompted to set the User Culture or Time Zone.  

## Status

Microsoft is investigating this issue and will update this article with additional information in the future.

## Resolution - Method 1

1. On an Exchange Server 2010 SP1 computer, launch the Exchange Management Shell with the appropriate Administrative permissions.
2. Type the following cmdlet and press enter:

    ```powershell
    Set-MailboxRegionalConfiguration -Identity <Username> -Language en-us-TimeZone Central Standard Time
    ```

    > [!NOTE]
    > The example cmdlet above specifies the Language as US English, and the Time Zone to US Central Standard Time. Change the language or time zone as needed for your user.

For more information about the cmdlet, see [Set-MailboxRegionalConfiguration](/powershell/module/exchange/set-mailboxregionalconfiguration).

## Resolution - Method 2

Update the target CASs in the organization to use Exchange Server 2010 SP1.

## More information

For more information, see [Understanding Proxying and Redirection](/previous-versions/office/exchange-server-2010/bb310763(v=exchg.141)).
