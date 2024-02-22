---
title: Apply Driver Package task fails with error 80070057
description: The Apply Driver Package task fails with error 80070057 after you upgrade to Configuration Manager current branch version 1706 or a later version.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# The Apply Driver Package task fails with 80070057 in Configuration Manager

This article fixes an issue in which the **Apply Driver Package** task fails and error 80070057 is logged in SMSTS.log.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4096313

## Symptom

After you upgrade to Configuration Manager current branch version 1706 or a later version, the **Apply Driver Package** task fails, and the following error is logged in SMSTS.log:

> TSManager &nbsp; &nbsp;Set command line: osddriverclient.exe /install:<Driver_Package_ID> /unsigned:%OSDAllowUnsignedDriver% /recurse:%OSDRecurse%  
> TSManager &nbsp; &nbsp;Start executing the command line: osddriverclient.exe /install:<Driver_Package_ID> /unsigned:%OSDAllowUnsignedDriver% /recurse:%OSDRecurse%  
> TSManager &nbsp; &nbsp;!----------------------------------------------------------------!  
> TSManager &nbsp; &nbsp;Expand a string: WinPE  
> TSManager &nbsp; &nbsp;Executing command line: osddriverclient.exe /install:<Driver_Package_ID> /unsigned:%OSDAllowUnsignedDriver% /recurse:%OSDRecurse%  
> OSDDriverClient &nbsp; &nbsp;==================[ OSDDriverClient.exe ]====================  
> OSDDriverClient &nbsp; &nbsp;Command line: "osddriverclient.exe" /install:<Driver_Package_ID> /unsigned:true /recurse:%OSDRecurse%  
> OSDDriverClient &nbsp; &nbsp;FALSE, HRESULT=80070057 (e:\nts_sccm_release\sms\client\osdeployment\osddriverclient\osddriverclient.cpp,197)  
> OSDDriverClient &nbsp; &nbsp;Argument 3 is invalid.  
> OSDDriverClient &nbsp; &nbsp;ParseArguments( argc, argv, eDriverOperation, sPackageId, pBootCriticalInfo, bAllowUnsigned, bBestMatch ), HRESULT=80070057 (e:\nts_sccm_release\sms\client\osdeployment\osddriverclient\osddriverclient.cpp,341)  
> OSDDriverClient &nbsp; &nbsp;Failed to pass arguments. Code 0x80070057  
> OSDDriverClient &nbsp; &nbsp;Exiting with return code 0x80070057  
> TSManager &nbsp; &nbsp;Process completed with exit code 2147942487  
> TSManager &nbsp; &nbsp;!----------------------------------------------------------------!  
> TSManager &nbsp; &nbsp;Failed to run the action: Apply Driver Package. This is usually caused by a problem with the program. Please check the Microsoft Knowledge Base to determine if this is a known issue or contact Microsoft Support Services for further assistance.  
> The parameter is incorrect. (Error: 80070057; Source: Windows)

## Cause

The new **Install driver package via running DISM with recurse option** feature in the **Apply Driver Package** task is introduced in Configuration Manager current branch version 1706. If the existing boot images aren't updated to the new Configuration Manager binaries, this option isn't recognized. Therefore, error 80070057 is returned.

## Resolution

To fix the issue, follow these steps to update the boot images:

1. In the Configuration Manager console, select **Software Library**.
2. In the Software Library workspace, expand **Operating Systems**, and then select **Boot Images**.
3. Right-click the boot image that you want to update, and then select **Update Distribution Points**.
4. Repeat step 3 for all boot images that were previously distributed.
