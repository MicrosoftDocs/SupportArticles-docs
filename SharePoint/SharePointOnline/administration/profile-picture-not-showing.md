---
title: Profile picture isn't shown in SharePoint Online
description: Your profile picture isn't shown in SharePoint Online.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Profiles and People\Photo Sync
  - CSSTroubleshoot
  - CI 150415
appliesto: 
  - SharePoint Online
ms.date: 07/17/2024
---

# Profile picture isn't shown in SharePoint Online

Your SharePoint Online profile picture isn't displayed on SharePoint sites or in People web parts. To get your profile picture displayed, try the following resolution.

## Run the Picture Sync diagnostic

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with user photos.

Select **Run Tests** to populate the diagnostic in the Microsoft 365 Admin Center.

> [!div class="nextstepaction"]
> [Run Tests: Picture Sync](https://aka.ms/PillarPictureSync)

The diagnostic performs a large range of verifications for users who may not be seeing an updated profile picture.

## References

- [Information about profile picture synchronization in Microsoft 365](https://support.microsoft.com/office/information-about-profile-picture-synchronization-in-microsoft-365-20594d76-d054-4af4-a660-401133e3d48a)

- [Bulk upload user profile pictures](https://github.com/pnp/PnP/tree/master/Samples/Core.ProfilePictureUploader)
    
    **DISCLAIMER**
    Copyright (c) Microsoft Corporation. All rights reserved. This script is made available to you without any express, implied, or statutory warranty, not even the implied warranty of merchantability or fitness for a particular purpose, or the warranty of title or noninfringement. The entire risk of the use or the results from the use of this script remains with you.
