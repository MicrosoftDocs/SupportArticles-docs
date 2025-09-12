---
title: Reserved characters cause the VMM console to crash
description: Fixes an issue in which System Center 2012 Virtual Machine Manager console crashes when you add a library that contains reserved characters.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Adding a library that contains reserved characters to SCVMM 2012 causes the console to crash

This article fixes an issue in which System Center 2012 Virtual Machine Manager console crashes when you add a library that contains reserved characters.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2679685

## Symptoms

When adding a library share to System Center 2012 Virtual Machine Manager, the console may crash if the share being used contains certain reserved characters (such as **>** or **?**).

## Cause

Use of these reserved characters is not permitted. See [Naming Files, Paths, and Namespaces](/windows/win32/fileio/naming-a-file?redirectedfrom=MSDN) for more information.

## Resolution

Do not use any folder or share that contains reserved characters.

## More Information

A carmine trace will show an error similar to the following. Note the name of the share in the top line:

> 00000035 4.64445496 [5600] 15E0.1740::07/29-02:36:09.104#14:ImgLibTask.cs(814): Start adding Library Share \\\\\<servername>\\???|TaskID=9C23BAC8-CB92-46A8-BFC4-E16889A25936  
> 00000036 4.70877552 [5600] 15E0.1740::07/29-02:36:09.167#19:Auditor.cs(224): Auditor: Committing audit record changes Count=1.|TaskID=9C23BAC8-CB92-46A8-BFC4-E16889A25936  
> 00000037 4.71668673 [5600] 15E0.1740::07/29-02:36:09.175#20:UserRoleAuthorizationHelper.cs(113): Get: Running GetAssociatedUR SP prc_TR_Task_GetUserRolesForTask, ObjectID: 9c23bac8-cb92-46a8-bfc4-e16889a25936  
> 00000038 4.71875620 [5600] 15E0.1740::07/29-02:36:09.178#20:UserRoleAuthorizationHelper.cs(113): Get: Running GetAssociatedUR SP prc_IL_GetUserRolesForLibraryShareID, ObjectID: ec3cf570-7547-4957-a51d-dae9b142cf7f  
> 00000039 4.72142792 [5600] 15E0.1740::07/29-02:36:09.180#20:UserRoleAuthorizationHelper.cs(113): Get: Running GetAssociatedUR SP prc_IL_GetUserRolesForLibraryShareID, ObjectID: ec3cf570-7547-4957-a51d-dae9b142cf7f  
> 00000040 6.41748762 [5600] 15E0.1740::07/29-02:36:10.867#04:WsmanAPIWrapper.cs(2752): Retrieving underlying WMI error to throw. Got string "<f:WSManFault xmlns:f="http://schemas.microsoft.com/wbem/wsman/1/wsmanfault" Code="2150859010" Machine="servername"><f:Message><f:ProviderFault provider="WMI Provider" path="%systemroot%\system32\WsmWmiPl.dll"><f:WSManFault xmlns:f="http://schemas.microsoft.com/wbem/wsman/1/wsmanfault" Code="2150859010" Machine="DCMRRXP16N24.dcmanager.lab"><f:Message>The WS-Management service cannot process the request. The WMI service reported that the WMI provider could not perform the requested operation. </f:Message></f:WSManFault><f:ExtendedError><p:__ExtendedStatus xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://schemas.microsoft.com/wbem/wsman/1/wmi/root/wmi/__ExtendedStatus" xmlns:cim="http://schemas.dmtf.org/wbem/wscim/1/common" xsi:type="p:__ExtendedStatus_Type"><p:Description>WDM specific return code: 4200  
> 00000041 6.41748762 [5600] </p:Description><p:Operation>ExecQuery</p:Operation><p:ParameterInfo>select * from MSFC_FCAdapterHBAAttributes</p:ParameterInfo><p:ProviderName>WinMgmt</p:ProviderName><p:StatusCode xsi:nil="true"/></p:__ExtendedStatus></f:ExtendedError></f:ProviderFault></f:Message></f:WSManFault>"  
> 00000042 6.41825581 [5600] 15E0.1740::07/29-02:36:10.868#04:WsmanAPIWrapper.cs(2752): System.Runtime.InteropServices.COMException (0x80338102): The WS-Management service cannot process the request. The WMI service reported that the WMI provider could not perform the requested operation.  
> 00000043 6.41825581 [5600]    at WSManAutomation.IWSManSession.Enumerate(Object resourceUri, String filter, String dialect, Int32 flags)  
> 00000044 6.41825581 [5600]    at Microsoft.Carmine.WSManWrappers.MyIWSManSession.Enumerate(Object resourceUri, String filter, String dialect, Int32 flags) in i:\bt\160\private\product\common\wsman\wsmanWrappers\wsmIDispachWrappers.cs:line 648  
> 00000045 6.41825581 [5600]    at Microsoft.Carmine.WSManWrappers.WsmanAPIWrapper.Enumerate(WSManUri url, String filter, String filterDialect, Type type, Boolean forceTypeCast, Boolean requestAssociationInstances) in i:\bt\160\private\product\common\wsman\wsmanWrappers\WsmanAPIWrapper.cs:line 1701  
> 00000046 6.41890478 [5600] 15E0.1740::07/29-02:36:10.869#04:HBAHelper.cs(52): Getting FC HBA failed on server dcmrrxp16n24.dcmanager.lab  
> 00000047 6.42078829 [5600] 15E0.1740::07/29-02:36:10.870#04:HBAHelper.cs(52): Microsoft.Carmine.WSManWrappers.WSManProviderException: A Hardware Management error has occurred trying to contact server servername.  
> 00000048 6.42078829 [5600] Check that WinRM is installed and running on server servername. For more information use the command 'winrm helpmsg hresult'. ---> System.Runtime.InteropServices.COMException (0x80338102): The WS-Management service cannot process the request. The WMI service reported that the WMI provider could not perform the requested operation.  
> 00000049 6.42078829 [5600]    at WSManAutomation.IWSManSession.Enumerate(Object resourceUri, String filter, String dialect, Int32 flags)  
> 00000050 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.MyIWSManSession.Enumerate(Object resourceUri, String filter, String dialect, Int32 flags) in i:\bt\160\private\product\common\wsman\wsmanWrappers\wsmIDispachWrappers.cs:line 648  
> 00000051 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.WsmanAPIWrapper.Enumerate(WSManUri url, String filter, String filterDialect, Type type, Boolean forceTypeCast, Boolean requestAssociationInstances) in i:\bt\160\private\product\common\wsman\wsmanWrappers\WsmanAPIWrapper.cs:line 1701  
> 00000052 6.42078829 [5600]    --- End of inner exception stack trace ---  
> 00000053 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.ErrorContextParameterHelper.ThrowTranslatedCarmineException(WsmanSoapFault fault, COMException ce) in i:\bt\160\private\product\common\wsman\wsmanWrappers\ErrorContextParameterHelper.cs:line 716  
> 00000054 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.ErrorContextParameterHelper.ThrowTranslatedCarmineException(COMException ce) in i:\bt\160\private\product\common\wsman\wsmanWrappers\ErrorContextParameterHelper.cs:line 664  
> 00000055 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.WsmanAPIWrapper.RetrieveUnderlyingWMIErrorAndThrow(SessionCacheElement sessionElement, COMException ce) in i:\bt\160\private\product\common\wsman\wsmanWrappers\WsmanAPIWrapper.cs:line 2841  
> 00000056 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.WsmanAPIWrapper.Enumerate(WSManUri url, String filter, String filterDialect, Type type, Boolean forceTypeCast, Boolean requestAssociationInstances) in i:\bt\160\private\product\common\wsman\wsmanWrappers\WsmanAPIWrapper.cs:line 1701  
> 00000057 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.WsmanAPIWrapper.Enumerate(WSManUri url, String filter, Type type) in i:\bt\160\private\product\common\wsman\wsmanWrappers\WsmanAPIWrapper.cs:line 1534  
> 00000058 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.WSManRequest\`1.Enumerate(String url, String wqlQuery) in i:\bt\160\private\product\common\wsman\wsmanWrappers\WsmanAPIWrapper.cs:line 3234  
> 00000059 6.42078829 [5600]    at Microsoft.Carmine.WSManWrappers.WSManRequest\`1.Enumerate(String url) in i:\bt\160\private\product\common\wsman\wsmanWrappers\WsmanAPIWrapper.cs:line 3220  
> 00000060 6.42078829 [5600]    at Microsoft.VirtualManager.Engine.Deployment.FCHBAHelper.GetFCHBAAdapters(WsmanAPIWrapper wrapper) in i:\bt\160\private\product\engine\Deployment\HBAHelper.cs:line 64  
> 00000061 6.42078829 [5600]    at Microsoft.VirtualManager.Engine.Deployment.FCHBAHelper.TryGetFCHBAAdpaters(WsmanAPIWrapper wrapper, MSFC_FCAdapterHBAAttributes[]& adapters, ErrorInfo& error) in i:\bt\160\private\product\engine\Deployment\HBAHelper.cs:line 52  
> 00000062 6.42078829 [5600] *** Carmine error was: HostAgentWSManError (2927); HR: 0x80338102  
> 00000063 6.42078829 [5600] *** \\\\\<servername>\\??? ** dcmrrxp16n24.dcmanager.lab **  **  **
