---
title: Apply Driver Package task fails with error 80070057
description: The Apply Driver Package task fails with error 80070057 after you upgrade to Configuration Manager current branch version 1706 or a later version.
ms.date: 06/09/2020
ms.prod-support-area-path:
---
# The Apply Driver Package task fails with 80070057 in Configuration Manager

This article fixes an issue in which the **Apply Driver Package** task fails and error 80070057 is logged in SMSTS.log.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4096313

## Symptom

After you upgrade to Configuration Manager current branch version 1706 or a later version, the **Apply Driver Package** task fails, and the following error is logged in SMSTS.log:

> TSManager    Set command line: osddriverclient.exe /install:<Driver_Package_ID> /unsigned:%OSDAllowUnsignedDriver% /recurse:%OSDRecurse%  
> TSManager    Start executing the command line: osddriverclient.exe /install:<Driver_Package_ID> /unsigned:%OSDAllowUnsignedDriver% /recurse:%OSDRecurse%  
> TSManager    !----------------------------------------------------------------!  
> TSManager    Expand a string: WinPE  
> TSManager    Executing command line: osddriverclient.exe /install:<Driver_Package_ID> /unsigned:%OSDAllowUnsignedDriver% /recurse:%OSDRecurse%  
> OSDDriverClient    ==================[ OSDDriverClient.exe ]====================  
> OSDDriverClient    Command line: "osddriverclient.exe" /install:<Driver_Package_ID> /unsigned:true /recurse:%OSDRecurse%  
> OSDDriverClient    FALSE, HRESULT=80070057 (e:\nts_sccm_release\sms\client\osdeployment\osddriverclient\osddriverclient.cpp,197)  
> OSDDriverClient    Argument 3 is invalid.  
> OSDDriverClient    ParseArguments( argc, argv, eDriverOperation, sPackageId, pBootCriticalInfo, bAllowUnsigned, bBestMatch ), HRESULT=80070057 (e:\nts_sccm_release\sms\client\osdeployment\osddriverclient\osddriverclient.cpp,341)  
> OSDDriverClient    Failed to pass arguments. Code 0x80070057  
> OSDDriverClient    Exiting with return code 0x80070057  
> TSManager    Process completed with exit code 2147942487  
> TSManager    !----------------------------------------------------------------!  
> TSManager    Failed to run the action: Apply Driver Package. This is usually caused by a problem with the program. Please check the Microsoft Knowledge Base to determine if this is a known issue or contact Microsoft Support Services for further assistance.  
> The parameter is incorrect. (Error: 80070057; Source: Windows)

## Cause

The new **Install driver package via running DISM with recurse option** feature in the **Apply Driver Package** task is introduced in Configuration Manager current branch version 1706. If the existing boot images aren't updated to the new Configuration Manager binaries, this option isn't recognized. Therefore, error 80070057 is returned.

## Resolution

To fix the issue, follow these steps to update the boot images:

1. In the Configuration Manager console, select **Software Library**.
2. In the Software Library workspace, expand **Operating Systems**, and then select **Boot Images**.
3. Right-click the boot image that you want to update, and then select **Update Distribution Points**.
4. Repeat step 3 for all boot images that were previously distributed.
