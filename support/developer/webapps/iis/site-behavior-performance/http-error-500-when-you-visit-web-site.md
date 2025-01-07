---
title: HTTP Error 500.0 Internal Server Error
description: This article provides resolutions for the HTTP Error 500.0 error that occurs when you visit a web site that is hosted on IIS.
ms.date: 10/21/2024
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: zixie
---
# HTTP Error 500.0 - Internal Server Error error when you open an IIS webpage

This article helps you resolve the HTTP Error 500.0 error that occurs when you visit a web site that is hosted on Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 942031

## Summary

This article mainly describes HResult codes when you encounter the HTTP Error 500.0 error on an IIS web application. For the 500.0 errors caused by the web application code, refer to the [More information](#more-information) section. 

This article is intended for web site administrators. These errors have many causes and can affect many different system configurations. The procedures that are described in this article must be performed by a member of the administrator group on the server.

End users that experience these errors should notify the web site administrator of the problem.

## HResult code

HTTP Error 500.0 message indicates that a problem occurs on the web server that hosts the web site at the time the error is returned.

See the following details of these errors.

## HResult code 0x80070032

Error message:

> Server Error in Application "\<application name\>"  
HTTP Error 500.0 - Internal Server Error  
HRESULT: 0x80070032  
Description of HRESULT ISAPI filter *:::no-loc text="drive:\\FilePath\\ISAPI_FLT.dll":::* tried to register for `SF_NOTIFY_READ_RAW_DATA` notification.

### Cause

This problem occurs because IIS doesn't support the Internet Server API (ISAPI) filter that registers for the `SF_NOTIFY_READ_RAW_DATA` notification.

### Resolution

Don't use the ISAPI filter that registers for the `SF_NOTIFY_READ_RAW_DATA` notification in IIS.

## HResult code 0x80070035

Error message:

> Server Error in Application "\<applicationName\>"  
HTTP Error 500.0 - Internal Server Error  
HRESULT: 0x80070035  
Description of HRESULT The page cannot be displayed because an internal server error has occurred.

### Cause

This problem occurs because the server that is running IIS can't access the configured root directory of the requested location.

### Resolution

Make sure that the server that is running IIS can access the configured root directory of the requested location.

## HResult code 0x8007000d

Error message:

> Server Error in Application "\<application name\>"  
HTTP Error 500.0 - Internal Server Error  
HRESULT: 0x8007000d  
Description of HRESULT Handler "ASPClassic" has a bad module "IsapiModule" in its module list.

### Cause

This problem occurs because the ISAPIModule module is missing from the modules list for the web site. The ISAPIModule module is in this location:  *:::no-loc text="drive:\\Windows\\System32\\inetsrv\\isapi.dll":::*.

### Resolution

To add the ISAPIModule module to the modules list for the web site, follow these steps:

1. Select **Start** > **Run**, type *inetmgr.exe*, and then select **OK**.
2. In IIS Manager, expand **\<server name>** > **Web sites**, and then select the web site that you want to modify.
3. In **Features** view, double-click **Module**.
4. In the **Actions** pane, select **Add Native Module**.
5. In the **Add Native Module** dialog box, select the **IsapiModule** checkbox, and then select **OK**.

## HResult code 0x800700c1

Error message:

> Server Error in Application "\<application name\>"  
HTTP Error 500.0 - Internal Server Error  
HRESULT: 0x800700c1  
Description of HRESULT The page cannot be displayed because an internal server error has occurred.

### Cause

This problem occurs because a script mapping isn't valid.

### Resolution

To make sure that the script-mapping points to the *ISAPI.dll* file that can process the request, follow these steps:

1. Select **Start** > **Run**, type *inetmgr.exe*, and then select **OK**.
2. In IIS Manager, expand **\<server name>** > **Web sites**, and then select the web site that you want to modify.
3. In **Features** view, double-click **Handler Mappings**.
4. Make sure that the script-mapping points to the correct *ISAPI.dll* file.

   For example, *.asp* files should map to the *:::no-loc text="%windir%\\system32\\inetsrv\\asp.dll":::* file.

## HResult code 0x80070005

Error message:

> Server Error in Application "\<application name\>"  
HTTP Error 500.0 - Internal Server Error  
HRESULT: 0x80070005  
Description of HRESULT LoadLibraryEx on ISAPI filter "path_of_isapi" failed.

### Cause

This problem occurs because an ISAPI filter that isn't valid is loaded at the global level or at the web site level.

### Resolution

To remove the ISAPI filter that isn't valid, follow these steps:

1. Select **Start** > **Run**, type *inetmgr.exe*, and then select **OK**.
2. In IIS Manager, expand **\<server name>** > **Web sites**, and then select the web site that you want to modify.
3. In **Features** view, double-click **ISAPI Filters**.
4. Right-click the ISAPI filter that you want to remove, and then select **Remove**.

## HResult code 0x8007007f

There are two possibilities for HResult 0x8007007f:

### Error message 1

> Server Error in Application "\<application name\>"  
HTTP Error 500.0 - Internal Server Error  
HRESULT: 0x8007007f  
Description of HRESULT Calling GetProcAddress on ISAPI filter "path_of_isapi" failed.

#### Cause

This problem occurs because an ISAPI filter that isn't valid is loaded at the global level or at the web site level.

#### Resolution

To remove the ISAPI filter that isn't valid, follow these steps:

1. Select **Start** > **Run**, type *inetmgr.exe*, and then select **OK**.
1. In IIS Manager, expand **\<server name>** > **Web sites**, and then select the web site that you want to modify.
1. In **Features** view, double-click **ISAPI Filters**.
1. Right-click the ISAPI filter that you want to remove, and then select **Remove**.

### Error message 2

> Server Error in Application "\<application name\>"  
HTTP Error 500.0 - Internal Server Error  
HRESULT: 0x8007007f  
Description of HRESULT There is a problem with the resource you are looking for, so it cannot be displayed.

#### Cause

This problem occurs because the handler mapping for the requested resource points to a *.dll* file that can't process the request.

#### Resolution

To make the handler mapping for the requested resource point to the *.dll* file that can process the request, follow these steps:

1. Select **Start** > **Run**, type *inetmgr.exe*, and then select **OK**.
1. In IIS Manager, expand **\<server name>** > **Web sites**, and then select the web site that you want to modify.
1. In **Features** view, double-click **Handler Mappings**.
1. Right-click the script mapping that you want to edit, and then select **Edit**.
1. In the **Edit Script Map** dialog box, type the appropriate executable file in the **Executable** box, and then select **OK**.  

   For example, *.asp* files should map to the *:::no-loc text="%windir%\\system32\\inetsrv\\asp.dll":::* file.

## More information

If the web application code throws an exception and is caught by the application's runtime (for example, the ASP.NET runtime), you might also see the HTTP Error 500.0 error in the web response. For any exception thrown from the web application code, check the Application event log or your own custom Application log for the Exception Type, Exception Message, and Exception Call Stack. 

If further debugging is needed, use the latest version of DebugDiag to capture [first-chance exception dumps](https://techcommunity.microsoft.com/t5/iis-support-blog/using-debugdiag-to-capture-memory-dumps-on-first-chance/ba-p/377131).  
