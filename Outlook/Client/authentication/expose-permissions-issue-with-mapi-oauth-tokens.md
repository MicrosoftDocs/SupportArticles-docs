---
title: Cannot expose permissions to generate OAuth tokens for Extended MAPI access
description: Microsoft doesn't expose permissions to generate OAuth tokens for Extended MAPI access to mailboxes.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Microsoft Exchange Server
  - Microsoft Outlook
ms.date: 3/31/2022
---

# Microsoft doesn't expose permissions to generate OAuth tokens for Extended MAPI access to mailboxes

## Symptoms

Extended MAPI solutions that try to connect to mailboxes that require Modern Authentication receive repeated password prompts and cannot connect. 

Additionally, you can't connect by using OAuth credentials unless an initial connection is established by using the Outlook client.

## Cause

Microsoft does not expose a permissions model for generating OAuth tokens for mailbox access by using Extended MAPI. Modern Authentication permissions are available only for Exchange Web Services (EWS), Outlook REST, and Microsoft Graph.

Furthermore, Microsoft doesn't support the direct use of Outlook credentials by third-party applications. Additionally, there are no plans for exposing OAuth permissions that give applications the privileges that Outlook is granted.  

## Workaround

If your application requires mailbox access by using Extended MAPI, and if Modern Authentication is required, you can establish an initial connection by using Outlook, and then use the same Outlook profile to connect to the mailbox by using your custom application. This lets Outlook acquire OAuth tokens that Extended MAPI can then reuse.

If you cannot use Outlook to acquire an access token and a refresh token, you have to use basic authentication instead. This requires that you disable Modern Authentication on the user account whose mailbox you're accessing.

## More information

Microsoft also doesn't expose OAuth permissions for connecting to and making requests to Exchange and Outlook endpoints other than EWS. Modern Authentication against the Offline Address Book (OAB), Autodiscover, and the other Exchange and Outlook endpoints isn't supported in third-party applications.
