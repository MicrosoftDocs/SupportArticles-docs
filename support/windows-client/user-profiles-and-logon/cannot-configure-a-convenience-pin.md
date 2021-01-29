---
title: Cannot configure a convenience PIN
description: Describes an issue that prevents users of Windows 10 Anniversary Update from setting a convenience PIN. This change involves Windows Hello for Business and the increased security that this feature offers. A resolution is provided.
ms.data: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, ntuttle, ardenw
ms.prod-support-area-path: User profiles
ms.technology: windows-client-user-profiles
---
# Cannot configure a PIN when Convenience PIN and Hello for Business policies are enabled

This article provides a resolution to make sure you can configure a PIN when Convenience PIN and Hello for Business policies are enabled in Windows 10.

_Original product version:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3201940

## Symptoms

Users who are running Windows 10 Version 1607 or later version of Windows 10 and who are joined to an Active Directory domain cannot create a convenience PIN. Whereas users who are running Windows 10 Version 1511 or earlier can do so without a problem.

When users navigate to **Settings** > **Accounts** > **Sign-in options**, the option to set a PIN is unavailable (appears dimmed), and therefore it can't be configured.

Additionally, if a user has already configured a convenience PIN in an earlier version of Windows 10 and then upgrades to Windows 10 Version 1607 or later, the PIN works until the user navigates to **Settings** > **Accounts** > **Sign-in options** > **I forgot my PIN**. In this situation, the option to create a PIN is unavailable (appears dimmed). This issue also does not affect Windows 10 Version 1511 and earlier.

## Cause

Windows 10 Version 1607 and later include new functionality that differentiates Windows Hello for Business from a convenience sign-in PIN.

Windows Hello for Business has strong user authentication properties that are frequently and mistakenly assumed to be functioning when the Windows Hello for Business infrastructure is not in place and when a user is using a convenience PIN. This change prevents the creation of a PIN in Windows 10 and later version without Windows Hello for Business.

Additionally, a user cannot create a convenience PIN in Windows 10 Version 1607 and later version when the Use Convenience PIN and Use Windows Hello for Business policies are both enabled unless the device is joined to Azure Active Directory in some way (for example, it is either Azure AD-joined or has the Computer Configuration\Administrative Templates\Windows Components\device registration\Register domain joined computers as devices policy enabled).

To allow convenience PINs to be created on devices that are not joined to Azure AD, make sure that the following conditions are true:

- The Use Windows Hello for Business policy is not enabled.
- The Turn on convenience PIN sign-in policy is enabled.

## Resolution

To use a convenience PIN in Windows 10 Version 1607 or later, the following Group Policy setting must be configured:

- Policy: Turn on convenience PIN sign-in
- Category: Path Computer Configuration\Administrative Templates\System\Logon

> [!NOTE]
>
> - The GPO specifies Windows Server 2012, Windows 8, Windows RT, Windows Server 2012 R2, Windows 8.1, and Windows RT 8.1 only. This is incorrect and will be updated at a later date. This policy does apply to Windows 10 and lets the user set a convenience PIN.
> - Enabling a PIN in this manner does not provide the same level of security as using a PIN with the Windows Hello for Business infrastructure configured.

PIN complexity: Manage PIN complexity in the standard way by using policies that are found in the following location:

Computer Configuration\Administrative Templates\Windows Components\Windows Hello for Business \PIN Complexity

Do not configure settings other than PIN complexity if you want to use a convenience PIN. Having Windows Hello for Business and Turn on convenience PIN sign-in enabled prevents you from setting a PIN.

## More information

When Windows Hello for Business is not in place and a user has a convenience PIN configured, the user is using a password stuffer, which does not have any of the security qualities of Windows Hello for Business. Password stuffers are convenience sign-in PINs and are controlled by the Turn on convenience PIN sign-in Group Policy setting.

Microsoft made this default behavior since Windows 10 Version 1607. The security offered by this default behavior can be decreased at the user's own discretion by enabling a convenience PIN.

For more information, see [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-identity-verification).
