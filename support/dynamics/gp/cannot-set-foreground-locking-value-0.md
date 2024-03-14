---
title: Cannot set foreground locking value to 0
description: Provides a solution to an error that occurs when you run an integration in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Could not set foreground locking value to 0" Error message when you run an integration in Integration Manager for Microsoft Dynamics GP

This article provides a solution to an error that occurs when you run an integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939045

## Symptoms

When running an Integration in Integration Manager for Microsoft Dynamics GP, you receive the following error message:
> could not set foreground locking value to 0

## Resolution

To resolve this problem, use the appropriate resolution.

### Resolution 1

To resolve this problem, obtain the latest update for Integration Manager. Follow the instructions that are in the Readme.txt file that is included in the update. 

### Resolution 2  

Add a setting to the appropriate file that ignores foreground locking time-out errors. To do it, use the appropriate method:

**Method 1** If you're using IntegrationManager.exe to run the integration, edit the Edit the Microsoft.Dynamics.GP.IntegrationManager.ini file to include the following settings:

[IMGPPrv]  
ForegroundAlert=False  
IgnoreLockError=True  
HideMsgBox=True

Save the Microsoft.Dynamics.GP.IntegrationManager.ini file and restart Integration Manager.

**Method 2** If you're using the Microsoft.Dynamics.GP.IntegrationManager.IMRun.exe file to run the integration, edit the IntegrationManager.IMRun.ini file.

If the IntegrationManager.IMRun.ini file doesn't exist, make a copy of the Microsoft.Dynamics.GP.IntegrationManager.ini file and rename it to Microsoft.Dynamics.GP.IntegrationManager.IMRun.ini. Save the Microsoft.Dynamics.GP.IntegrationManager.IMRun.ini file to the Integration Manager folder that contains the Microsoft.Dynamics.GP.IntegrationManager.exe file.

Verify the following settings:

[IMGPPrv]  
ForegroundAlert=False  
IgnoreLockError=True  
HideMsgBox=True

Save the Microsoft.Dynamics.GP.IntegrationManager.IMRun.ini file and restart Integration Manager.
