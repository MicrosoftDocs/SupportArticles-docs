---
title: SSO no longer works for sign-in
description: Provides a workaround for sign-in issues when using SSO if ADAL and AD FS are used in Skype for Business 2016.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Skype for Business 2019
  - Skype for Business 2016
  - Skype for Business Online
search.appverid: MET150
ms.date: 03/31/2022
---
# Can't sign in using SSO if ADAL and AD FS used in Skype for Business

_Original KB number:_ &nbsp; 4508931

## Symptoms

New users can't sign in to Microsoft Skype for Business 2016 on-premises using the Single Sign-on (SSO) method when Azure Active Directory Authentication Library (ADAL) and Active Directory Federation Services (AD FS) are used.

Existing profiles aren't affected by this issue. New users or users who deleted their profile while trying to sign in receive this error message:

> An error occurred.

This issue also occurs on newly imaged computers if no user profile was created.

## Cause

This issue occurs because the default authentication method changes to Web Account Manager (WAM) after upgrading to Microsoft Office 2016 version 16.0.7967.0000 or a later version.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems can occur if you modify the registry incorrectly. [Back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

Add one of the following registry keys:

- Add the `EnableWAM` key to this subkey:

    `HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Office\16.0\Lync`

    Name: `EnableWAM`  
    Type: **DWORD (32 Bit)**  
    Value: **0x00000000**  

- Add the `EnableWAM` key to this subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Office\16.0\Lync`

    Name: `EnableWAM`  
    Type: **DWORD (32 Bit)**  
    Value: **0x00000000**  

- Add the `DisableADALatopWAM` key to this subkey:

    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\Identity`

    Name: `DisableADALatopWAM`  
    Type: **DWORD (32 Bit)**  
    Value: **1**  

    > [!NOTE]
    > There's a similar key named `DisableADALatopWAMOverride` in the same location. This key isn't used by Skype for Business. Use `DisableADALatopWAM` if you choose this option.

## More information

To prevent this issue, use Modern Hybrid Authentication. For more information, see [Hybrid modern authentication overview and prerequisites for using it with on-premises Skype for Business and Exchange servers](/microsoft-365/enterprise/hybrid-modern-auth-overview).
