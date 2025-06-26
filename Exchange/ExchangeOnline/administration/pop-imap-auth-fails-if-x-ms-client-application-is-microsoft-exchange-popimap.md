---
title: POP/IMAP client authenticate fails
description: Describes an issue that blocks authentication for POP and IMAP clients in Exchange Online. Occurs if the value of the X-MS-Client-Application claim type in the AD FS claim rule is set to Microsoft.Exchange.PopImap. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kezuo, v-six
appliesto: 
  - Exchange Online
  - Microsoft 365
search.appverid: MET150
ms.date: 01/24/2024
---
# POP/IMAP client authenticate fails if X-MS-Client-Application in the AD FS claim rule is set to Microsoft.Exchange.PopImap

_Original KB number:_ &nbsp; 3107357

## Symptoms

Consider the following scenario:

- You're using Active Directory Federation Services (AD FS) for POP and IMAP client access authentication.
- You have a claim rule to block access if the value of the X-MS-Client-Application claim type is not Microsoft.Exchange.PopImap.

These settings had previously worked as expected. However, you noticed recently that POP and IMAP clients fail to authenticate even though the correct user name and password is used.

Additionally, if you examine the AD FS access log, you may see entries that resemble the following:

[\<Date>\<Time>] "POST /microsoftonline/ws-username HTTP/1.1" 403 ... "Microsoft.Exchange.Imap"  
[\<Date>\<Time>] "POST /microsoftonline/ws-username HTTP/1.1" 403 ... "Microsoft.Exchange.Pop"

## Cause

A change was made recently in the service to separate POP and IMAP authentication. Instead of Microsoft.Exchange.PopImap, the value that's sent in the X-MS-Client-Application header is Microsoft.Exchange.Imap or Microsoft.Exchange.Pop.

## Resolution

In the existing claim rule, change the value of X-MS-Client-Application from Microsoft.Exchange.PopImap to Microsoft.Exchange.Imap and Microsoft.Exchange.Pop.

## More information

For more information, see the following resources:

- [Limiting access to Microsoft 365 services based on the location of the client](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh526961(v=ws.10))
- [Configuring client access policies](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn592182(v=ws.11))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
