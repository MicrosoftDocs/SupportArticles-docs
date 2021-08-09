---
title: Cannot access CRM website after running a repair
description: Describes an issue that causes Microsoft Dynamics CRM to be inaccessible after you run a repair on the Microsoft Dynamics CRM server.
ms.reviewer: henningp, chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Cannot access the Microsoft Dynamics CRM website after running a repair on the Microsoft Dynamics CRM server

This article provides a resolution for the issue that you can't access the Microsoft Dynamics CRM website after you run a repair on the Microsoft Dynamics CRM server.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2498257

## Symptoms

After you run a repair on the Microsoft Dynamics CRM server, you cannot access the Microsoft Dynamics CRM website. Additionally, you receive the following IFD logon prompt when you type your internal URL for accessing CRM:

> HTTP 404 Not Found page.

Additionally, you may receive the following error message in Microsoft Dynamics CRM client for Outlook after you select the organization against which you want to configure:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.

## Cause

When you run a repair on the Microsoft Dynamics CRM server, the internal web address URLs that are stored on the server are changed back to the server name \<port>.

Depending on your environment, web clients may still resolve the changed URL. However, the Microsoft Dynamics CRM client for Outlook is likely to fail during configuration.

## Resolution

To resolve this issue, switch the internal web address URLs back to their original values. (These should be the URLs that you typed when you accessed the CRM website before you ran the repair. These URLs must also match your bindings on the Microsoft Dynamics CRM website.) To do this, follow these steps:

1. On the Microsoft Dynamics CRM server, select **Start**, select **All Programs**, select Microsoft Dynamics CRM 2011, and then select **Deployment Manager**.
2. Right-click Microsoft Dynamics CRM, and then select **Properties**.
3. Under the **Web Address** tab, update the URLs to the match your IIS binding for the Microsoft Dynamics CRM website.
