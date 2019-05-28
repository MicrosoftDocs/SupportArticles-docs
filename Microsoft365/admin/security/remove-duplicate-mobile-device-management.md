---
title: Remove duplicate mobile device management objects in Azure Active Directory
description: Describes how to remove duplicate mobile device management objects in Azure Active Directory (Azure AD).
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office 365
ms.topic: article
ms.author: v-six
---

# How to remove duplicate mobile device management objects in Azure Active Directory

## Introduction 

This article describes how to remove duplicate mobile device management objects in Azure Active Directory (Azure AD). You can use this procedure to remove orphaned device objects in Azure AD that are not automatically removed by the service after 90 days. 

## Procedure 

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.   
2. Click **Admin**, and then click **Azure AD**. 
   > [!NOTE]
   > If you don't already have a Microsoft Azure subscription, each paid Office 365 subscription includes a free subscription to Microsoft Azure. To obtain this subscription, you must first sign up for the Azure Active Directory subscription.
3. Select your directory.
4. Click **Users**, and then select the user account that the device is registered to.
5. Click **Devices**.
6. In the list of devices that are registered to the user, select the device that you want to remove.
7. Delete the orphaned entry.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.