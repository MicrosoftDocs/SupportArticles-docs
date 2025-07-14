---
title: Microsoft 365 users aren't signed in to Office through AD accounts
description: Describes an issue that prevents Microsoft 365 users from being automatically signed in to an Office app through their Active Directory account after they sign out of the app. Provides a workaround.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Azure Active Directory
ms.date: 05/29/2025
---

# Microsoft 365 users aren't automatically signed into an Office app through Active Directory accounts after they sign out

## Problem

Microsoft 365 users who are signed in to an Office app through their Active Directory account from a domain-joined computer signs out of the Office app. The next time that the users open the Office app, they aren't automatically signed in. The users have to manually sign in to the Office app.

## Cause

This behavior is expected. When a user logs on to the on-premises environment by using their Active Directory account, the user is signed in to an Office app by using the same credentials. When the user signs out of an Office app, a registry key is set that prevents the user from being signed in automatically the next time that they open the Office app.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

Delete the SignedOutADUser registry key. To do this, follow these steps:

1. Open Registry Editor.
1. Locate, and then click the following registry key:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\Identity**

    > [!NOTE]
    > The <x.0> placeholder represents your version of Office (16.0= Office 2016, 15.0= Office 2013, 14.0 = Office 2010)
1. Right-click the **SignedOutADUser** registry key, and then click **Delete**.
1. When you're prompted to confirm the deletion, click **Yes.**

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread)website.
