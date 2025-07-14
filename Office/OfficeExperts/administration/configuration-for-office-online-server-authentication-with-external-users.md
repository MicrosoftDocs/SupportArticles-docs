---
title: Configuration for Microsoft Offices Online or Office Online Server authentication with external users
description: Describes how to avoid the authentication prompt when you configure Office Online Server to work with external users.
author: helenclu
ms.author: luche
ms.reviewer: jhaak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 06/06/2024
---

# Configuration for Office Online Server authentication with external users

When you configure Microsoft Offices Online or Office Online Server to work with external users, if external users don't want to be prompted for authentication, one major consideration is that the Microsoft Office Online calls need to be passed through the external firewall/reverse proxy.

## Cause

Microsoft Offices Online communicates directly with both the client and the file host, such as SharePoint, Skype for Business and Exchange. The client user doesn't authenticate with Microsoft Offices Online.  Authentication is handled with the file host. Then the file host communicates with the client, and then redirect to Microsoft Offices Online. After that, Microsoft Offices Online communicates with the file host by using OAuth to request the file contents to render within the desired web app.

## Resolution

To avoid an authentication prompt, configure the firewall/reverse proxy to allow Microsoft Offices Online to be accessible anonymously over HTTPS.

This means that your Microsoft Offices Online incoming traffic authentication rules should be configured either as anonymous or pre-authenticated to avoid any authentication challenge.

When using pre-authentication, to prevent a second authentication prompt for SharePoint users, make sure that the session cookie that's issued for SharePoint also applies to your Microsoft Offices Online.  

To verify it, go to your hosting/discovery page through "http(s)://wacexternalurl/hosting/discovery", and you can see the following screenshot:

:::image type="content" source="media/configuration-for-office-online-server-authentication-with-external-users/discovery-page.png" alt-text="Screenshot shows an example of the hosting/discovery page.":::

If an authentication page appears, proceed by browsing your SharePoint site.  Leave the SharePoint page open, then browse the hosting/discovery page again. If you have your session cookie configured correctly, the hosting/discovery should open without an authentication prompt.

If you're still redirected to an authentication page, it's likely means the security token from the authentication provider isn't covering the request to the Office Online Server. As soon as you've configured your security firewall/reverse proxy to allow for pre-auth or anonymous authentication, you should be able to view documents in a web browser.
