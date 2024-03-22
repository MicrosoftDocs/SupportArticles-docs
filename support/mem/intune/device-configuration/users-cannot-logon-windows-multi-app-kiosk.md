---
title: Users can't log on to Windows 10 computers with multi-app kiosk profile assigned
description: Explains why a user can't log on to a Microsoft Entra joined Windows 10 computer if a multi-app kiosk profile is assigned.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\Kiosk
ms.reviewer: kaushika, joelste, intunecic, mobazzar
---
# Users can't log on to Windows if a multi-app kiosk profile is assigned

This article helps you fix an issue in which a user can't log on to a Microsoft Entra joined Windows 10 computer if a multi-app kiosk profile is assigned.

## Symptoms

When a user tries to log on to a Microsoft Entra joined Windows 10 computer that has a multi-app kiosk profile assigned, the attempt fails immediately before the user profile is loaded.

:::image type="content" source="media/users-cannot-logon-windows-multi-app-kiosk/welcome.png" alt-text="Screenshot of the Sign in page." border="false":::

:::image type="content" source="media/users-cannot-logon-windows-multi-app-kiosk/sign-out.png" alt-text="Screenshot of the Sign out page." border="false":::

In this situation, the kiosk profile logon type is **Microsoft Entra user** or **Group**. Additionally, the Windows 10 computer uses a local account, and you notice the following error messages in the Event Viewer logs:

- Microsoft Entra ID - Operational logs (Sample 1 - MFA required via conditional access):
    > Log Name:      Microsoft-Windows-AAD/Operational  
    > Source:        Microsoft-Windows-AAD  
    > Date:          *\<Timestamp>*  
    > Event ID:      1098  
    > Task Category: AadTokenBrokerPlugin Operation  
    > Level:         Error  
    > Keywords:      Error,Error  
    > User:          *\<User SID>*  
    > Computer:      *\<Computer Name>*  
    > Description:  
    > **Error: 0xCAA2000C The request requires user interaction.**  
    > **Code: interaction_required**  
    > Description: AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '00000003-0000-0000-c000-000000000000'.

- Microsoft Entra ID - Operational logs (Sample 2 - Terms of Use (TOU) required via conditional access):
    > Log Name:      Microsoft-Windows-AAD/Operational  
    > Source:        Microsoft-Windows-AAD  
    > Date:          *\<Timestamp>*  
    > Event ID:      1098  
    > Task Category: AadTokenBrokerPlugin Operation  
    > Level:         Error  
    > Keywords:      Error,Error  
    > User:          *\<User SID>*  
    > Computer:      *\<Computer Name>*  
    > Description:  
    > **Error: 0xCAA2000C The request requires user interaction.**  
    > **Code: interaction_required**  
    > Description: AADSTS50158: External security challenge not satisfied. User will be redirected to another page or authentication provider to satisfy additional authentication challenges.

- Assigned Access - Admin logs:
    > Log Name:      Microsoft-Windows-AssignedAccess/Admin  
    > Source:        Microsoft-Windows-AssignedAccess  
    > Date:          *\<Timestamp>*  
    > Event ID:      31000  
    > Task Category: Applying Assigned Access for current user.  
    > Level:         Error  
    > User:          *\<User SID>*  
    > Computer:      *\<Computer Name>*  
    > Description:  
    > Error Unspecified error applying assigned access for current user, signing out...  

## Cause

This behavior is by design.

This issue occurs because the users are targeted by conditional access policies that require user interaction. For example, multi-factor authentication (MFA), or Terms of Use (TOU).

## Solution

To fix this issue, exclude the kiosk users from any conditional access policies that require user interaction, such as MFA or TOU.

If the kiosk user is enabled for MFA, disable it because MFA is currently not supported in multi-app kiosk mode scenarios.
