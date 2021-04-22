---
title: Users can't log on to Windows 10 computers with multi-app kiosk profile assigned
description: Fixes an issue in which a user cannot log on to an Azure AD joined Windows 10 computer if a multi-app kiosk profile is assigned.
ms.date: 09/11/2020
ms.prod-support-area-path: Configure device restrictions
ms.reviewer: joelste, intunecic, mobazzar
---
# Users can't log on to Windows if a multi-app kiosk profile is assigned

This article helps you fix an issue in which a user can't log on to an Azure AD joined Windows 10 computer if a multi-app kiosk profile is assigned.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4493932

## Symptoms

When a user tries to log on to an Azure AD joined Windows 10 computer that has a multi-app kiosk profile assigned, the attempt fails immediately before the user profile is loaded.

In this situation, the kiosk profile logon type is **AAD User** or **Group**. Additionally, the Windows 10 computer uses a local account, and you notice the following error messages in the Event Viewer logs:

- AAD - Operational logs (Sample 1 - MFA required):
    > Log Name:      Microsoft-Windows-AAD/Operational  
    > Source:        Microsoft-Windows-AAD  
    > Date:          *[Timestamp]*    
    > Event ID:      1098   
    > Task Category: AadTokenBrokerPlugin Operation 
    > Level:         Error  
    > Keywords:      Error,Error    
    > User:          *[User SID]*          
	> Computer:      *[Computer Name]*       
    > Description:                       
    > **Error: 0xCAA2000C The request requires user interaction.**	    
    > **Code: interaction_required**	    
    > Description: AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '00000003-0000-0000-c000-000000000000'.	    

- AAD - Operational logs (Sample 2 - ToU required):
    > Log Name:      Microsoft-Windows-AAD/Operational    
    > Source:        Microsoft-Windows-AAD    
    > Date:          *[Timestamp]*      
    > Event ID:      1098   
	> Task Category: AadTokenBrokerPlugin Operation     
	> Level:         Error      
	> Keywords:      Error,Error        
    > User:          *[User SID]*          
	> Computer:      *[Computer Name]*      
	> Description:      
    > **Error: 0xCAA2000C The request requires user interaction.**      
    > **Code: interaction_required**        
	> Description: AADSTS50158: External security challenge not satisfied. User will be redirected to another page or authentication provider to satisfy additional authentication challenges.      

- Assigned Access - Admin logs:
	> Log Name:      Microsoft-Windows-AssignedAccess/Admin     
	> Source:        Microsoft-Windows-AssignedAccess       
    > Date:          *[Timestamp]*            
    > Event ID:      31000      
	> Task Category: Applying Assigned Access for current user.     
	> Level:         Error      
    > User:          *[User SID]*          
	> Computer:      *[Computer Name]*     
	> Description:      
	> Error Unspecified error applying assigned access for current user, signing out...     


## Cause

This behavior is by design.

This issue occurs because the users are targeted by conditional access policies that require user interaction, such as multi-factor authentication (MFA) or Terms of Use (ToU).

## Resolution

To fix this issue, exclude kiosk users from any conditional access policies that require user interaction, such as MFA or ToU.    

If the kiosk user is enabled for MFA, please disable it as MFA is currently not supported in multi-app kiosk mode scenarios.
