---
title: Management points stop responding to HTTP requests
description: Management points stop responding to HTTP requests and you receive error 500.19.
ms.date: 12/05/2023
ms.custom: sap:Site Server and Roles\Management Point Operations
ms.reviewer: kaushika
---
# Management points stop responding to HTTP requests with error 500.19

This article provides the steps to solve the issue that **HTTP Error 500.19** error occurs when you try to connect to a management point list address by using a web browser.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4468361

## Symptom

Configuration Manager management points stop responding to client requests. When you use a web browser to connect to the management point list address (`http://<ServerName>/sms_mp/.sms_aut?mplist`), you receive this error message:

> HTTP Error 500.19 - Internal Server Error

This error message is also logged in the IIS log on the management point computer during client requests.

## Cause

This issue occurs if the WSUS server role was previously installed on the management point computer. When the WSUS server role was installed, it installed the XPress compression schema module (suscomp.dll) that loaded in every application pool in IIS. If the 32-bit version of suscomp.dll is loaded in an application pool that runs in 64-bit mode, you experience this issue.

## Resolution

To fix this issue, follow these steps:

1. Locate `%windir%\system32\inetsrv\config`.
2. Open the applicationHost.config file in Notepad.
3. Look for an entry like this:

    > \<scheme name="xpress" doStaticCompression="false" doDynamicCompression="true" dll="C:\Windows\system32\inetsrv\suscomp.dll" staticCompressionLevel="10" dynamicCompressionLevel="0" />

4. Remove the XPress compression schema by running the following command from an elevated command prompt:

    ```console
    %windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/httpCompression /-[name='xpress']
    ```

5. Verify that the compression schema is removed from the applicationHost.config file, and then save the file.

6. Run the following command from an elevated command prompt:

    ```console
    iisreset
    ```
