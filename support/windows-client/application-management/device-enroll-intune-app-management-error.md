---
title: Support tip - Devices enrolled in Intune Application Management policy are prompted to enroll into Intune
description: This article describes why using All Apps as part of a Conditional Access (CA) policy may not be the best approach.
ms.date: 09/28/2020
ms.prod-support-area-path: intune
ms.service: microsoft-intune
ms.reviewer: saurkosh
author: v-miegge
editor: v-jesits
ms.author: saurkosh
ms.custom: 
- CI 112573
- CSSTroubleshooting
---

# Support tip - Devices enrolled in Intune Application Management policy are prompted to enroll in Intune

## Situation

Using **All Apps** as part of a Conditional Access (CA) policy may not be the best approach.

### Setup

For example, Contoso requires some users to use managed apps when they access **SharePoint Online** and **Exchange Online** resources, so that users can apply Application Management policy (MAM-WE) to these apps and not enroll their device in Intune. Contoso also has a CA policy that requires enrollment for all apps except SharePoint Online and Exchange Online.  

### Result

When these users try to access one of the managed applications, such as **OneDrive**, they're prompted to enroll the device.

> [!NOTE]
> This example uses **Android**.

When you log in to the Outlook app for Android, you can successfully sign in. Because you have a CA policy that requires an approved app, you're prompted to install the Intune Company portal app. Then, you're asked to register, as shown in the following screenshots.

![The user is prompted to install the app](./media/device-enroll-intune-app-management-error/intune-enroll-user-prompted-to-install-app.png)

![The device must be registered with Azure](./media/device-enroll-intune-app-management-error/intune-enroll-device-registered-with-azure.png)
  
When you switch over to the OneDrive app, you'll see a different behavior.

![Prompted to enroll, not register](./media/device-enroll-intune-app-management-error/intune-enroll-not-register.png)

Checking the sign-in logs, you can see the conditional access policy (enforced).

 ![The sign-in logs page](./media/device-enroll-intune-app-management-error/intune-enroll-sign-in-logs.png)

 ![Conditional Access policy](./media/device-enroll-intune-app-management-error/intune-enroll-conditional-access-policy.png)

Now, when you review the **Block all but EXO and SPO** CA policy, you see the following.

![Cloud apps or actions page - Includes](./media/device-enroll-intune-app-management-error/intune-enroll-block-all-but-exo-spo-include.png)
![Cloud apps or actions page - Excludes](./media/device-enroll-intune-app-management-error/intune-enroll-block-all-but-exo-spo-exclude.png)
![Cloud apps or actions page - Grant access](./media/device-enroll-intune-app-management-error/intune-enroll-block-all-but-exo-spo-grant-access.png)

The term *All cloud apps* applies to [apps that are listed, and services that aren't listed](https://docs.microsoft.com/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps).

For more information about best practices and what you should avoid, see [Best practices for Conditional Access in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/conditional-access/best-practices#what-you-should-avoid-doing).
