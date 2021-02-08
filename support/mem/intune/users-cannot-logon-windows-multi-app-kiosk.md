---
title: Users can't log on to Windows 10 computers with multi-app kiosk profile assigned
description: Fixes an issue in which a user cannot log on to an Azure AD-joined Windows 10 computer if a multi-app kiosk profile is assigned.
ms.date: 09/11/2020
ms.prod-support-area-path: Configure device restrictions
ms.reviewer: joelste, intunecic, mobazzar
---
# Users can't log on to Windows if a multi-app kiosk profile is assigned

This article helps you fix an issue in which a user can't log on to an Azure Active Directory (Azure AD)-joined Windows 10 computer if a multi-app kiosk profile is assigned.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4493932

## Symptoms

When a user tries to log on to an Azure AD-joined Windows 10 computer that has a multi-app kiosk profile assigned, the attempt fails immediately before the user profile is loaded.

In this situation, the kiosk profile logon type is **AAD User** or **Group**. Additionally, the Windows 10 computer uses a local account, and you notice the following error messages in the Event Viewer logs:

- Assigned Access logs:

    > Log Name: &nbsp;Microsoft-Windows-AssignedAccess/Admin  
    > Source: &nbsp; &nbsp; &nbsp; &nbsp;Microsoft-Windows-AssignedAccess  
    > Date: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*DateTime*  
    > Event ID: &nbsp; &nbsp; &nbsp;31000  
    > Task Category: Applying Assigned Access for current user.  
    > Level: &nbsp; &nbsp; &nbsp; &nbsp; Error  
    > Keywords:  
    > User: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*UserSID*  
    > Computer: &nbsp; &nbsp; *ComputerName*  
    > Description:  
    > Error Unspecified error applying assigned access for current user, signing out...

- AAD logs:

    > Log Name: &nbsp; Microsoft-Windows-AAD/Operational  
    > Source: &nbsp; &nbsp; &nbsp; &nbsp;Microsoft-Windows-AAD  
    > Date: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*DateTime*  
    > Event ID: &nbsp; &nbsp; &nbsp;1098  
    > Task Category: AadTokenBrokerPlugin Operation  
    > Level: &nbsp; &nbsp; &nbsp; &nbsp; Error  
    > Keywords: &nbsp; &nbsp; &nbsp;Error,Error  
    > User: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*UserSID*  
    > Computer: &nbsp; &nbsp; *ComputerName*  
    > Description:  
    > Error: 0xCAA2000C The request requires user interaction.  
    > Code: interaction_required  
    > Description: AADSTS50079: Due to a configuration change made by your administrator, or because you moved to a new location, you must enroll in multi-factor authentication to access '00000003-0000-0000-c000-000000000000'.

## Cause

This behavior is by design.

This issue occurs because the users are targeted by conditional access policies that require multi-factor authentication (MFA). Multi-app kiosk currently doesn't support MFA.

## Resolution

To fix this issue, turn off MFA for the kiosk users.
