---
title: Can't import drivers into Configuration Manager
description: Fixes an issue that prevents administrators from importing drivers into Configuration Manager. The problem concerns a newer signing method that isn't supported without first installing this hotfix.
ms.date: 12/05/2023
ms.reviewer: kaushika, frankroj
ms.custom: sap:Operating Systems Deployment (OSD)\Driver Management and Installation
---
# Can't import drivers into Configuration Manager

This article fixes an issue in which you can't import drivers into Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3025419

## Symptoms

Consider the following scenario:

- An administrator tries to import drivers into Configuration Manager.
- The site server is running Windows Server 2008 R2.
- The drivers are signed.

In this scenario, you may receive the following error message:

> Error: Some driver(s) cannot be imported successfully. See following details.
>
> Error: Failed to import the following drivers:
>
> &lt;Driver&gt; - The selected driver is not applicable to any supported platforms.

When you view the Configuration Manager logs, you see the following errors:

**DriverCatalog.log**

> \\\\<*UNC_Path_To_Driver*>\\\<*Driver*>.inf is not applicable to any supported platforms.  
> Driver is not applicable to any supported platforms. Code 0x80070661

**SMSAdminUI.log**

> System.Management.ManagementException\r\nGeneric failure \r\n at System.Management.ManagementException.ThrowWithExtendedInfo(ManagementStatus errorCode)  
> at System.Management.ManagementObject.InvokeMethod(String methodName, ManagementBaseObject inParameters, InvokeMethodOptions options)  
> at Microsoft.ConfigurationManagement.ManagementProvider.WqlQueryEngine.WqlConnectionManager.ExecuteMethod(String methodClass, String methodName, Dictionary\`2 methodParameters, Boolean traceParameters)\r\nManagementException details:  
> instance of SMS_ExtendedStatus  
> {  
> Description = "Driver is not applicable to any supported platforms.";  
> ErrorCode = 1633;  
> File = "e:\\\\nts_sccm_release\\\sms\\\siteserver\\\sdk_provider\\\smsprov\\\sspdriverci.cpp";  
> Line = 712;  
> Operation = "ExecMethod";  
> ParameterInfo = "SMS_Driver";  
> ProviderName = "WinMgmt";  
> StatusCode = 2147749889;  
> };  

**SMSProv.log**

> ~\*~\*~e:\nts_sccm_release\sms\siteserver\sdk_provider\smsprov\sspdriverci.cpp(712) : Driver is not applicable to any supported platforms.~\*~\*~  
> ~\*~\*~Driver is not applicable to any supported platforms. ~\*~\*~

When you view the Setupapi.app.log file in the `C:\Windows\inf` directory, you see the following error:

> \>>> [SetupVerifyInfFile - \\\\<*UNC_Path_To_Driver*>\\\<*Driver*>.inf]  
> \>>> Section start \<*Date*> \<*Time*>  
> cmd: C:\Windows\system32\wbem\wmiprvse.exe -Embedding  
> ! sig: Verifying file against specific (valid) catalog failed! (0xe0000244)  
> ! sig: Error 0xe0000244: The software was tested for compliance with Windows Logo requirements on a different version of Windows, and may not be compatible with this version.  
> ! sig: Verifying file against specific (valid) catalog failed! (0xe0000244)  
> ! sig: Error 0xe0000244: The software was tested for compliance with Windows Logo requirements on a different version of Windows, and may not be compatible with this version.  
> \<<< Section end \<*Date*> \<*Time*>  
> \<<< [Exit status: FAILURE(0xe0000244)]

## Cause

Some drivers are signed by a newer signing method that's not recognized or natively supported by Windows Server 2008 R2. Therefore, these drivers cannot be imported into Configuration Manager if the site server is Windows Server 2008 R2.

## Resolution

To resolve the problem, install one or both of the following hotfixes on the site server that's experiencing the problem:

- [2837108](https://support.microsoft.com/help/2837108) You cannot import a Windows 8 signed driver on a Windows Server 2008 R2-based WDS server
- [2921916](https://support.microsoft.com/help/2921916) The "Untrusted publisher" dialog box appears when you install a driver in Windows 7 or Windows Server 2008 R2

> [!NOTE]
>
> - Hotfix 2837108 will resolve the issue even if WDS is not installed on the site server.
> - These hotfixes will add the necessary support to Windows Server 2008 R2 to natively recognize the newer signing methods.

To fully fix the problem, restart the site server after you install hotfix 2837108 or hotfix 2921916. Do this even if the installation process does not prompt you to restart.

After you install hotfix 2837108 or hotfix 2921916 and then restart the server, any affected driver that's already in the Configuration Manager console will have to be removed and then reimported.

## More information

Surface Pro 3 drivers are an example of drivers that exhibit this problem. Because Surface Pro 3 drivers are signed by the newer signing method, they are affected by this issue. You may be able to import them into Configuration Manager when the site server is running Windows Server 2008 R2, but they will be displayed as unsigned until either hotfix 2837108 or hotfix 2921916 is installed on the site server.

If you are able to import the drivers but they are displayed as unsigned, see [Signed drivers are displayed as unsigned in Configuration Manager](signed-drivers-shown-as-unsigned.md).
