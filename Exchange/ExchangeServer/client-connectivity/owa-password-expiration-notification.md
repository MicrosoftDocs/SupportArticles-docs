---
title: Password expiration isn't notified in OWA
description: Describes an issue that unexpectedly triggers a password expiration notification when a user tries to log in to their mailbox. This issue concerns the fine-grained password policy. A workaround is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: paololin, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
---
# OWA password expiration notification when you use fine-grained password policy

_Original KB number:_ &nbsp; 3141296

## Symptoms

In Outlook on the web or Outlook Web App (OWA), the password expiration notification window is displayed when a user tries to log on to their mailbox. However, the fine-grained password policy shows that the user's password is not expired.

## Cause

This issue occurs because the user is assigned a fine-grained password policy where the maximum password age is longer than the maximum password age in the default domain policy.

## Workaround

To work around this issue, use one of the following methods:

- Disable the fine-grained password policy for all users.
- Disable the OWA password change feature from Exchange Server.
- Change the **Maximum Password Age** value for the Default Domain Policy setting so that it's larger than the value in the fine-grained password policy.

## References

- [AD DS fine-grained password and account lockout policy step-by-step guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770842(v=ws.10))

- [Updating the Default Domain Policy GPO and the Default Domain Controllers Policy GPO](/previous-versions/windows/it-pro/windows-server-2003/dd378987(v=ws.10))
