---
title: Users are redirected to Mobile Express
description: This article provides a resolution for the problem that occurs when you attempt to access Microsoft Dynamics CRM Online after the December 2012 Service Update.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Users are redirected to Mobile Express in Internet Explorer 7 after the Microsoft Dynamics CRM Online December 2012 Service Update

This article helps you resolve the problem that occurs when you attempt to access Microsoft Dynamics CRM Online after the December 2012 Service Update.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2784960

## Symptoms

Internet Explorer 7 users are redirected to the Mobile Express website (`https://<org>.crm.dynamics.com/m`) when attempting to access Microsoft Dynamics CRM Online after the December 2012 Service Update.

## Cause

Internet Explorer 7 compatibility was removed in the December 2012 Service Update. As a result, all requests to the Microsoft Dynamics CRM Online website from Internet Explorer 7 clients will be redirected to the Mobile Express website. This is the expected behavior for all unsupported browsers.

## Resolution

Use a compatible browser to access the Microsoft Dynamics CRM website as described in the following KB article:

[Browser compatibility with Microsoft Dynamics CRM 2011](https://support.microsoft.com/help/2784954)
