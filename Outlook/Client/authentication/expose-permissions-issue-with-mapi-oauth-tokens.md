---
title: Cannot expose permissions to generate OAuth tokens for Extended MAPI access
description: Microsoft doesn't expose permissions to generate OAuth tokens for Extended MAPI access to mailboxes.
author: cloud-writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Network disconnects, password or credentials prompt
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Microsoft Exchange Server
  - Microsoft Outlook
ms.date: 01/30/2024
---

# Microsoft doesn't expose permissions to generate OAuth tokens for Extended MAPI access to mailboxes

## Symptoms

Extended MAPI solutions that try to connect to mailboxes which require Modern authentication receive repeated password prompts and cannot connect.

Additionally, you can't connect by using OAuth credentials unless an initial connection is established by using the Outlook client.

## Cause

Microsoft doesn't expose a permissions model for generating OAuth tokens for mailbox access by using Extended MAPI. Modern authentication permissions are available only for Exchange Web Services (EWS), Outlook REST, and Microsoft Graph.

Also, Microsoft doesn't support the direct use of Microsoft Outlook credentials by third-party applications.

## Workaround

If your application requires mailbox access by using Extended MAPI, and if Modern authentication is required, you can establish an initial connection by using Outlook, and then use the same Outlook profile to connect to the mailbox by using your custom application. This lets Outlook acquire OAuth tokens that Extended MAPI can then reuse.

## More information

Microsoft also doesn't expose OAuth permissions for connecting to and making requests to Exchange and Outlook endpoints other than EWS. Modern authentication against the Offline Address Book (OAB), Autodiscover, and other Exchange and Outlook endpoints isn't supported in third-party applications.
