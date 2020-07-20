---
title: How to remove duplicate mobile device management objects in Azure Active Directory
description: Describes how to remove duplicate mobile device management objects in Azure Active Directory (Azure AD).
ms.date: 05/22/2020
ms.prod-support-area-path: 
ms.reviewer: anthonge, willfid
---
# How to remove duplicate mobile device management objects in Azure Active Directory

This article describes how to remove duplicate mobile device management objects in Azure Active Directory (Azure AD). You can use this procedure to remove orphaned device objects in Azure AD that are not automatically removed by the service after 90 days.

_Original product version:_ &nbsp; Azure Active Directory, Microsoft Intune  
_Original KB number:_ &nbsp; 3060809

## Procedure

1. Sign in to the [Office 365 portal](https://portal.office.com) as an administrator.
2. Select **Admin**, and then select **Azure AD**.

    > [!NOTE]
    >  If you don't already have a Microsoft Azure subscription, each paid Office 365 subscription includes a free subscription to Microsoft Azure. To obtain this subscription, you must first sign up for the Azure Active Directory subscription.

3. Select your directory.
4. Select **Users**, and then select the user account that the device is registered to.
5. Select **Devices**.
6. In the list of devices that are registered to the user, select the device that you want to remove.
7. Delete the orphaned entry.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the
[Azure Active Directory Forums](https://social.msdn.microsoft.com) website.
