---
title: Unable to access SharePoint Online
description: Troubleshoot SharePoint Online inaccessible issue when you have no appropriate permissions to access the site or file or receive 503 or Server is busy errors.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI113890
  - CSSTroubleshoot
ms.reviewer: salarson, prbalusu
appliesto: 
  - SharePoint Online
search.appverid: MET150
ms.date: 12/17/2023
---

# Unable to access SharePoint Online

There are several reasons why Microsoft SharePoint or Microsoft OneDrive might become inaccessible. You can use the following guide to troubleshoot this issue for users who can't access SharePoint Online.

## Do users have appropriate permissions?  

- Check whether users have the appropriate permissions to access the [site](https://support.office.com/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658) or [file](https://support.office.com/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c
). If they don't have the necessary permissions, grant the permissions to them.
- If the users were granted permissions to the site or file but they still receive an error message such as "Access Denied" or "You need permission to access this site," see [this troubleshooting guide](/sharepoint/troubleshoot/administration/access-denied-sharepoint-error).

## Are users receiving "503" or "Server is busy" or "You are now in line to access this site" error messages?

- If users are receiving **"503"** or **"Server is busy"** error messages, the error might be caused by throttling within the SharePoint service. SharePoint Online uses throttling to maintain optimal performance and reliability of the SharePoint Online service. Throttling limits the number of user actions or concurrent calls (by script or code) to prevent overuse of resources. For more information about throttling, see [Avoid getting throttled or blocked in SharePoint Online](/sharepoint/dev/general-development/how-to-avoid-getting-throttled-or-blocked-in-sharepoint-online).

- In some cases, you may receive a message that states **"You are now in line to access this site"**. This page replaces the 503-Service unavailable error message on SharePoint pages. The waiting room page itself has built-in retry mechanisms that automatically confirm whether the page you're trying to access is available to users. The user doesn't need to refresh the page as the page handles it automatically. **Manually refreshing the page may further delay the page load, as it will proceed to do the verification after each refresh.** This page also serves to acknowledge that an issue has been identified and is being worked on, and that users should wait for the page to load or try again later.

  :::image type="content" source="media/sharepoint-online-inaccessible/waiting-room.png" alt-text="Screenshot of the waiting room page that shows the error message stating you are now in line to access this site.":::

- If the SharePoint or OneDrive site is slow or delayed for multiple users, a temporary service issue may be occurring. In this case, users may experience intermittent delays or navigation errors when they try to access SharePoint sites or OneDrive content. To determine whether your organization is affected, check the [Service Health Dashboard](https://admin.microsoft.com/AdminPortal/Home#/servicehealth).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
