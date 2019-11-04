---
title: Office 365 users aren't signed in to Office through AD accounts
description: Describes an issue that prevents Office 365 users from being automatically signed in to an Office app through their Active Directory account after they sign out of the app. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Azure Active Directory
---

# Office 365 users aren't automatically signed in to an Office app through Active Directory accounts after they sign out

## Problem 

An Office 365 who is signed in to an Office app through their Active Directory account from a domain-joined computer signs out of the Office app. The next time that the user opens the Office app, they aren't automatically signed in. The user has to manually sign in to the Office app. 

## Cause

This is the expected behavior. When a user logs on to the on-premises environment by using their Active Directory account, the user is signed in to an Office app by using the same credentials. When the user signs out of an Office app, a registry key is set that prevents the user from being signed in automatically the next time that they open the Office app. 

## Workaround

Important Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

Delete the SignedOutADUser registry key. To do this, follow these steps:

1. Open Registry Editor.   
2. Locate, and then click the following registry key:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\Identity** 
    
    **Note** The <x.0> placeholder represents your version of Office (16.0= Office 2016, 15.0= Office 2013, 14.0 = Office 2010)
1. Right-click the **SignedOutADUser** registry key, and then click **Delete**.    
1. When you're prompted to confirm the deletion, click **Yes.**   

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread)website.
