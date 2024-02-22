---
title: Unable to connect an InfoPath form to SharePoint Online
description: An error occurred while connecting to a Web Service or An error occurred querying a data source when you connect an InfoPath form to a SharePoint Online web service.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Error message when you connect an InfoPath form to a SharePoint Online web service: "An error occurred while connecting to a Web Service"

## Problem

When you try to connect an InfoPath form to SharePoint Online for some web services, you receive one of the following error messages:

- **An error occurred while connecting to a Web Service.**
- **An error occurred querying a data source.**

## More information

This issue occurs because loopback protection is enabled in the SharePoint Online environment. Loopback protection must be disabled for InfoPath forms to be able to connect to some SharePoint Online web services.

For security reasons, loopback protection is always enabled in SharePoint Online. This is a known limitation of InfoPath forms in the Microsoft 365 SharePoint Online environment.

> [!NOTE]
> Some requests are supported and functionality exists to convert these requests to object model calls which does not cause a loopback. The following calls are supported in this scenario:
> - lists.asmx
>   - CheckOutFile
>   - CheckInFile
> - usergroup.asmx
>   - GetUserCollectionFromGroup
>   - GetUserCollectionFromSite
>   - GetGroupCollectionFromWeb
> - UserProfileService.asmx
>   - GetUserProfileByName
>   - GetUserPropertyByAccountName
>   - GetCommonManager
>   - GetUserMemberships
>   - GetCommonMemberships

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
