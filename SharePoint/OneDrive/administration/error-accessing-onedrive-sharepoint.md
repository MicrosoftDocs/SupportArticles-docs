---
title: Error 'DNS_PROBE_FINISHED_NXDOMAIN' when accessing OneDrive or Sharepoint
description: Describes how to resolve an issue when unable to OneDrive or Sharepoint
author: v-miegge
ms.author: prbalusu
manager: dcscontentpm
localization_priority: Normal
ms.date: 02/01/2021
ms.audience: Admin
ms.topic: article
ms.service: one-drive
ms.custom: CSSTroubleshoot
search.appverid:
- SPO160
- MET150
ms.assetid: 
appliesto:
- SharePoint Online
- OneDrive for Business
---

# Error 'DNS_PROBE_FINISHED_NXDOMAIN' when accessing OneDrive or Sharepoint

## Symptom

When you try to access **OneDrive** or **SharePoint**, you receive following error:

![This site can't be reached](media/error-accessing-onedrive-sharepoint/this-site-cannot-be-reached.png)

## Cause

Your subscription to either **OneDrive** or **SharePoint** might have expired.

## Resolution

### Reactivate your subscription

To reactivate your Microsoft 365 subscription, see [Reactive your subscription](https://docs.microsoft.com/microsoft-365/commerce/subscriptions/reactivate-your-subscription)

### Flush the DNS cache

If your subscription is active and you are still facing the issue, that could be a backlog in the local systems DNS cache which can be removed.

To flush the local systems DNS cache:

1. Select the **Start button**.

2. Type **cmd** and open the **Command Prompt** app.

3. In the **Command Prompt** window, enter the command `ipconfig /flushdns`.

4. Select **Enter** on the keyboard.

Once the DNS has been flushed, try to access **OneDrive** or **SharePoint** again.

If you are still unable to access your service, contact [Microsoft technical support](https://go.microsoft.com/fwlink/?linkid=869559).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
