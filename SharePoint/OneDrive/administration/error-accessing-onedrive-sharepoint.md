---
title: Error when accessing OneDrive or Sharepoint
description: Describes how to resolve an issue when unable to OneDrive or Sharepoint
author: helenclu
ms.author: luche
ms.reviewer: prbalusu
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
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

:::image type="content" source="media/error-accessing-onedrive-sharepoint/site-cannot-reach-error.png" alt-text="Screenshot shows the error that this site can't be reached when you access OneDrive or SharePoint.":::


## Cause

Your subscription to either **OneDrive** or **SharePoint** might have expired.

## Resolution

### Reactivate your subscription

To reactivate your Microsoft 365 subscription, see [Reactive your subscription](/microsoft-365/commerce/subscriptions/reactivate-your-subscription)

### Flush the DNS cache

If your subscription is active and you are still facing the issue, that could be a backlog in the local systems DNS cache which can be removed.

To flush the local systems DNS cache:

1. Select the **Start button**.

2. Type **cmd** and open the **Command Prompt** app.

3. In the **Command Prompt** window, enter the command `ipconfig /flushdns`.

4. Select **Enter** on the keyboard.

Once the DNS has been flushed, try to access **OneDrive** or **SharePoint** again.

If you are still unable to access your service, contact [Microsoft technical support](/microsoft-365/admin/contact-support-for-business-products).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).