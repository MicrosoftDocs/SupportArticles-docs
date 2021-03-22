---
title: Windows failed to apply MDM Policy settings
description: You receive an error message when you force a Group Policy update on hybrid Azure AD-joined devices.
ms.date: 05/13/2020
ms.prod-support-area-path: Windows enrollment
---
# Windows failed to apply the MDM Policy settings error when running `gpupdate /force` on hybrid Azure AD-joined devices

This article discusses the **Windows failed to apply the MDM Policy settings** error message that occurs when you run the `gpupdate /force` command on an enrolled Windows device in Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4456826

## Symptoms

When you run the `gpupdate /force` command on a hybrid Azure Active Directory (Azure AD)-joined Windows device that's enrolled in Microsoft Intune, you receive the following warning message:

> Updating policy...
>
> Computer Policy update has completed successfully.
>
> The following warnings were encountered during computer policy processing:
>
> **Windows failed to apply the MDM Policy settings**. MDM Policy settings might have its own log file. Please click on the "More information" link.  
> User Policy update has completed successfully.
>
> For more detailed information, review the event log or run GPRESULT /H GPReport.html from the command line to access information about Group Policy.

## Cause

This issue occurs if the **Auto MDM Enrollment with AAD Token** Group Policy Object (GPO) is applied to the Windows device. In this case, it tries to enroll the device in MDM when you run the `gpupdate /force` command. Because the device was already enrolled, you receive the warning message.

This behavior is expected. You can safely ignore the warning message.

## More information

Below is an example of the `%windir%\debug\usermode\Gpsvc.log` file entry when you enable Group Policy Service debug logging by following the steps in [A Treatise on Group Policy Troubleshooting–now with GPSVC Log Analysis!](/archive/blogs/askds/a-treatise-on-group-policy-troubleshootingnow-with-gpsvc-log-analysis):

> ProcessGPOs(Machine): Processing extension MDM Policy  
> CheckGPOs: No GPO changes but called in force refresh flag or extension MDM Policy needs to run force refresh in foreground processing  
> ProcessGPOList:++ Entering for extension MDM Policy  
> ProcessGPOList: Passing in the force refresh flag to Extension MDM Policy  
> ProcessGPOList: **Extension MDM Policy returned 0x8018000a**.  
> ProcessGPOList: Extension MDM Policy doesn't support rsop logging  
> ProcessGPOs(Machine): **Extension MDM Policy ProcessGroupPolicy failed, status 0x8018000a**.

The [0x8018000a](/windows/win32/mdmreg/mdm-registration-constants) error means that the device is already enrolled.
