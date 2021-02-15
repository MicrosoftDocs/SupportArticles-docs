---
title: HTTP Error 500.0 error
description: This article provides resolutions for the HTTP 500.0 error that occurs when you visit a Web site that is hosted on IIS.
ms.date: 12/29/2020
ms.prod-support-area-path: WWW Administration and Management
ms.reviewer: nitgupta
---
# HTTP Error 500.0 - Internal Server Error error when you open an IIS Webpage

This article helps you resolve the HTTP 500.0 error that occurs when you visit a Web site that is hosted on IIS.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 942031

## Summary

This article describes HResult codes when you encounter 500.0 error on an Internet Information Services (IIS) Web application. This article is intended for Web site administrators. These errors have many causes and can affect many different system configurations. The procedures that are described in this article must be performed by a member of the administrator group on the server.

End users that experience these errors should notify the Web site administrator of the problem.

## More information

HTTP Error 500 message indicates that a problem has occurred on the Web server that hosts the Web site at the time the error is returned.

If the error code you see is in the following table, check out the causes and try the solutions.

|HResult code|Error message|Cause|Resolution|
|---|---|---|---|
|0x80070032|Server Error in Application "*application name*"<br/><br/>HTTP Error 500.0 - Internal Server Error<br/><br/>HRESULT: 0x80070032<br/><br/>Description of HRESULT ISAPI filter "\<drive> :\\\<Path of file>\ISAPI_FLT.dll" tried to register for SF_NOTIFY_READ_RAW_DATA notification.<br/>|This problem occurs because IIS 7.0 does not support the Internet Server API (ISAPI) filter that registers for the SF_NOTIFY_READ_RAW_DATA notification.|Do not use the ISAPI filter that registers for the SF_NOTIFY_READ_RAW_DATA notification in IIS|
|0x80070035|Server Error in Application "*application name*"<br/><br/>HTTP Error 500.0 - Internal Server Error<br/><br/>HRESULT: 0x80070035<br/><br/>Description of HRESULT The page cannot be displayed because an internal server error has occurred.<br/>|This problem occurs because the server that is running IIS 7.0 cannot access the configured root directory of the requested location.|Make sure that the server that is running IIS 7.0 can access the configured root directory of the requested location.|
|0x8007000d|Server Error in Application "*application name*"<br/><br/>HTTP Error 500.0 - Internal Server Error<br/><br/>HRESULT: 0x8007000d<br/><br/>Description of HRESULT Handler "ASPClassic" has a bad module "IsapiModule" in its module list.<br/>|This problem occurs because the ISAPIModule module is missing from the modules list for the Web site. The ISAPIModule module is in the following location: `drive:\Windows\System32\inetsrv\isapi.dll`<br/>|Add the ISAPIModule module to the modules list for the Web site. To do this, follow these steps:<br/>1. Click **Start**, click **Run**, type inetmgr.exe, and then click **OK**.<br/>2. In IIS Manager, expand ****server name****, expand **Web sites**, and then click the Web site that you want to modify.<br/>3. In Features view, double-click **Module**.<br/>4. In the Actions pane, click **Add Native Module**.<br/>5. In the **Add Native Module** dialog box, click to select the **IsapiModule** check box, and then click **OK**.|
|0x800700c1|Server Error in Application "*application name*"<br/><br/>HTTP Error 500.0 - Internal Server Error<br/><br/>HRESULT: 0x800700c1<br/><br/>Description of HRESULT The page cannot be displayed because an internal server error has occurred.<br/>|This problem occurs because a script mapping is not valid.|Make sure that the script-mapping points to the ISAPI .dll file that can process the request. To do this, follow these steps:<br/>1. Click **Start**, click **Run**, type inetmgr.exe, and then click **OK**.<br/>2. In IIS Manager, expand ****server name****, expand **Web sites**, and then click the Web site that you want to modify.<br/>3. In Features view, double-click **Handler Mappings**.<br/>4. Make sure that the script-mapping points to the correct ISAPI .dll file.<br/>For example, .asp files should map to the %windir%\system32\inetsrv\asp.dll file.|
|0x80070005|Server Error in Application "*application name*"<br/><br/>HTTP Error 500.0 - Internal Server Error<br/><br/>HRESULT: 0x80070005<br/><br/>Description of HRESULT LoadLibraryEx on ISAPI filter "*path_of_isapi*" failed.<br/>|This problem occurs because an ISAPI filter that is not valid is loaded at the global level or at the Web site level.|Remove the ISAPI filter that is not valid. To do this, follow these steps:<br/>1. Click **Start**, click **Run**, type inetmgr.exe, and then click **OK**.<br/>2. In IIS Manager, expand ***server name***, expand **Web sites**, and then click the Web site that you want to modify.<br/>3. In Features view, double-click **ISAPI Filters**.<br/>4. Right-click the ISAPI filter that you want to remove, and then click **Remove**.|
|0x8007007f|Server Error in Application "*application name*"<br/><br/>HTTP Error 500.0 - Internal Server Error<br/><br/>HRESULT: 0x8007007f<br/><br/>Description of HRESULT Calling GetProcAddress on ISAPI filter "*path_of_isapi*" failed.<br/>|This problem occurs because an ISAPI filter that is not valid is loaded at the global level or at the Web site level.|Remove the ISAPI filter that is not valid. To do this, follow these steps:<br/>1. Click **Start**, click **Run**, type inetmgr.exe, and then click **OK**.<br/>2. In IIS Manager, expand ***server name***, expand **Web sites**, and then click the Web site that you want to modify.<br/>3. In Features view, double-click **ISAPI Filters**.<br/>4. Right-click the ISAPI filter that you want to remove, and then click **Remove**.|
|0x8007007f|Server Error in Application "*application name*"<br/><br/>HTTP Error 500.0 - Internal Server Error<br/><br/>HRESULT: 0x8007007f<br/><br/>Description of HRESULT There is a problem with the resource you are looking for, so it cannot be displayed.<br/>|This problem occurs because the handler mapping for the requested resource points to a .dll file that cannot process the request.|Edit the handler mapping for the requested resource to point to the .dll file that can process the request. To do this, follow these steps:<br/>1. Click **Start**, click **Run**, type inetmgr.exe, and then click **OK**.<br/>2. In IIS Manager, expand ****server name****, expand **Web sites**, and then click the Web site that you want to modify.<br/>3. In Features view, double-click **Handler Mappings**.<br/>4. Right-click the script mapping that you want to edit, and then click **Edit**.<br/>5. In the **Edit Script Map** dialog box, type the appropriate executable file in the **Executable** box, and then click **OK**. For example, .asp files should map to the %windir%\system32\inetsrv\asp.dll file.|
|||||

For any exception thrown from the web application code, check Application event log or your own Application log,  for Exception Type, Exception Message, and Exception Call Stack. If further debugging is needed, use DebugDiag latest version to capture [first chance exception dumps](https://techcommunity.microsoft.com/t5/iis-support-blog/using-debugdiag-to-capture-memory-dumps-on-first-chance/ba-p/377131).  
