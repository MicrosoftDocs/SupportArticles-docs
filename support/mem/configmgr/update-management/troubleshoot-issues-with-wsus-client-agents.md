---
title: Troubleshoot issues with Windows Server Update Services (WSUS) client agents
description: Diagnose and resolve issues with the WSUS client agents.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Troubleshoot issues with WSUS client agents

This article helps you diagnose and resolve issues with the Windows Server Update Services (WSUS) client agents.

_Original product version:_ &nbsp; Windows Server Update Services  
_Original KB number:_ &nbsp; 10132

When you experience issues with the WSUS client agents, they can manifest themselves in many ways. Some common problems are listed here:

- It could be an issue with the client settings for Group Policy.
- It could be an issue with BITS.
- It could be an issue with the WSUS agent service.
- It could be related to a network issue that prevents the client from reaching the server.
- It could be an issue with the Automatic Update Agent Store.
- It could be an issue in which clients have duplicate WSUS client IDs caused by disk cloning.

## Verify that the client is configured correctly

When you troubleshoot issues with a WSUS client agent, first make sure the client is properly configured. Make sure the proper Active Directory Group Policy is being received by the client, and the details of the WSUS server are present. You can do so by running the following command:

```console
GPRESULT /V > GPRESULT.TXT
```

Open the text file in Notepad and find the name of your WSUS policy. For example, if your WSUS policy is named **WSUS**, you can find it in the GPRESULT.TXT file within the **Computer Settings** section under the **Applied Group Policy Objects** heading. Below is an example:

```output
Applied Group Policy Objects  
-----------------------------  
Default Domain Policy  
WSUS  
Local Group Policy
```

If the WSUS settings aren't present, possible causes include:

- The system doesn't have the Group Policy from the domain.
- The Group Policy isn't targeted to the client system.

To fix this issue, ensure that the Group Policy is successfully updated on each client, and that the WSUS setting is properly configured.

To update the Group Policy on the client, run `GPUpdate /force` from a Command Prompt.

For more information about configuring Group Policy for WSUS clients, see [Configure Automatic Updates by Using Group Policy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc720539(v=ws.10)).

## Check for issues relating to BITS

Background Intelligent Transfer Service (BITS) is the service used by WSUS to download updates from Microsoft Update to the main WSUS server, and from WSUS servers to their clients. Some download issues may be caused by problems with BITS on the server or client computers. When you troubleshoot download problems, you should ensure that BITS is running properly on all affected computers.

The BITS service must run under the **LocalSystem** account by default. To configure the service to run under the correct account, follow these steps:

1. Open a Command Prompt and run the following command:

    ```console
    sc config bits obj= LocalSystem
    ```

    A space must occur between **obj=** and **LocalSystem**. If successful, you should receive the following output:

    ```output
    [SC] ChangeServiceConfig SUCCESS
    ```

2. Stop and restart BITS.

To view the BITS service status, open a Command Prompt and run the following command:

```console
sc query bits
```

If BITS is running, you should see the following output:

```output
SERVICE_NAME: bits  
TYPE: 20 WIN32_SHARE_PROCESS  
STATE: 4 RUNNING
```

If BITS isn't running, you'll see the following output:

```output
SERVICE_NAME: bits  
TYPE: 20 WIN32_SHARE_PROCESS  
STATE: 1 STOPPED
```

Usually it's possible to resolve BITS issues by stopping the service and restarting it. To stop and restart the BITS service, run the following commands from a Command Prompt:

```console
sc stop bits
sc start bits
```

> [!NOTE]
> You must be logged on as a local administrator to stop and restart BITS.

### BITS fails to start

If the BITS service fails to start, look in the event log for any BITS-related error. You can use the following table to diagnose the cause of these errors.

|Error name|Error code|Description|
|---|---|---|
|ERROR_SERVICE_DOES_NOT_EXIST|0x80070424|See the section on [repairing the BITS configuration](#repair-a-corrupted-bits-configuration) below.|
|ERROR_SERVICE_NOT_IN_EXE|0x8007043B|BITS isn't listed as one of the services in the netsvcs svchost group|
|ERROR_SERVICE_DISABLED|0x80070422|BITS has been disabled. Enable the BITS service.|
|ERROR_SERVICE_DEPENDENCY_DELETED ERROR_SERVICE_DEPENDENCY_FAIL|0x80070433, 0x8007042c|A service appearing in the BITS service dependency list cannot be started. Make sure the dependency list for the BITS service is correct:<br/> **Windows Vista:** RpcSs, EventSystem (also http.sys and LanManWorkstation when peer caching is enabled)<br/> **Windows Server 2003:** Rpcss, EventSystem<br/> **Windows XP:** Rpcss<br/> **Windows 2000:** Rpcss, SENS, Wmi|
|ERROR_PATH_NOT_FOUND| 0x80070003|Pre-Windows Vista: %ALLUSERSPROFILE%\Microsoft\Network doesn't exist|
|ERROR_FILE_NOT_FOUND| 0x80070002|The **Parameters** key is missing. Ensure that the following keys and values exist:<br/>`HKLM\SYSTEM\CurrentControlSet\Services\BITS\Parameters\ServiceDll`= `%SystemRoot%\System32\qmgr.dll`<br/><br/>|
|REGDB_E_CLASSNOTREG, EVENT_E_INTERNALERROR|0x80040154, 0x80040206|BITS for Windows 2000 is dependent on SENS and EventSystem services. If the COM+ catalog is corrupted, BITS may fail with this error code.|
  
### BITS jobs are failing

If the client is properly configured to receive updates, BITS is configured correctly, and BITS appears to start and run properly, you may be experiencing an issue where BITS jobs themselves are failing. To verify it, look in the event log for any BITS-related errors. You can use the following table to diagnose the cause of these errors.

|Error name|Error code|Description|
|---|---|---|
| E_INVALIDARG|0x80070057|An incorrect proxy server name was specified in the user's Internet Explorer proxy settings. This error is also seen when credentials are supplied for authentication schemes that aren't NTLM/Negotiate, but the user name or password is null. Change the user's Internet Explorer proxy settings to be a valid proxy server. Or change the credentials not to be NULL user name/password for schemes other than NTLM/Negotiate. |
| ERROR_WINHTTP_NAME_NOT_RESOLVED| 0x80072ee7|The server/proxy could not be resolved by BITS. Internet Explorer on the same machine in the context of the job owner would see the same problem. Try downloading the same file via the web browser using the context of the job owner.|
| ERROR_HTTP_INVALID_SERVER_RESPONSE| 0x80072f78|It's a transient error and the job will continue downloading.|
| BG_E_INSUFFICIENT_RANGE_SUPPORT| 0x80200013|BITS uses range headers in HTTP requests to request parts of a file. If the server or proxy server doesn't understand range requests and returns the full file instead of the requested range, BITS puts the job into the ERROR state with this error. Capture the network traffic during the error and examine if HTTP GET requests with **Range** header are getting valid responses. Check proxy servers to ensure that they are configured correctly to support Range requests. |
| BG_E_MISSING_FILE_SIZE| 0x80200011|When BITS sends a HEAD request and the server/proxy doesn't return Content-Length header in the response, BITS puts the job in ERROR state with this error. Check the proxy server and WSUS server to ensure that they are configured correctly. Some versions of the Apache 2.0 proxy server are known to exhibit this behavior.|
| BG_E_HTTP_ERROR_403| 0x80190193|When the server returns HTTP 403 response in any of the requests, BITS puts the job in ERROR state with this error code. HTTP 403 corresponds to **Forbidden: Access is denied**. Check access permissions for the account running the job.|
| ERROR_NOT_LOGGED_ON| 0x800704dd|The SENS service isn't receiving user logon notifications. BITS (version 2.0 and later) depends on logon notifications from Service Control Manager, which in turn depends on the SENS service. Ensure that the SENS service is started and running correctly.|
  
### Repair a corrupted BITS configuration

To repair corrupted BITS service configuration, you can enter the BITS service configuration manually.

> [!NOTE]
> This action should only be taken in circumstances where all other troubleshooting attempts have failed. You must be an administrator to modify the BITS configuration.

To repair a corrupted BITS configuration, follow these steps:

1. Open a Command Prompt.
2. Enter the following commands, press ENTER after you type each command:

    ```console
    sc config bits binpath= "%systemroot%\system32\svchost.exe –k netsvcs"
    sc config bits depend= RpcSs/EventSystem
    sc config bits start= delayed-auto
    sc config bits type= interact type=own
    sc config bits error= normal
    sc config bits obj= LocalSystem
    sc privs bits privileges= SeCreateGlobalPrivilege/SeImpersonatePrivilege/SeTcbPrivilege/SeAssignPrimaryTokenPrivilege/SeIncreateQuotaPrivilege
    sc sidtype bits unrestricted
    sc failure bits reset= 86400 actions=restart/60000/restart/120000
    ```

3. Stop and restart BITS.

## Issues with the WSUS agent service

Make sure that the Windows Update service can start successfully.

To view the current status of the Windows Update service, open a Command Prompt and run the following command:

```console
sc query wuauserv
```

If WUAUSERV is running, you should see the following output:

```output
SERVICE_NAME: wuauserv  
TYPE: 20 WIN32_SHARE_PROCESS  
STATE: 4 RUNNING
```

If WUAUSERV isn't running, you see the following output:

```output
SERVICE_NAME: wuauserv  
TYPE: 20 WIN32_SHARE_PROCESS  
STATE: 1 STOPPED
```

Verify that you can start the WUAUSERV service successfully. You must be logged on as a local administrator to stop and restart WUAUSERV.

To start the WUAUSERV service, run the following commands from a Command Prompt:

```console
sc start wuauserv
```

If the client agent fails to start and run properly, check the Windows Update Agent version. If the agent isn't up to date, [update the Windows Update Agent to the latest version](https://support.microsoft.com/help/949104).

You can also [reset Windows Update components](/windows/deployment/update/windows-update-resources#how-do-i-reset-windows-update-components).

After you run the fix or update the agent, run `wuauclt /detectnow`. Check windowsupdate.log to make sure there's no issues.

## Make sure the WSUS server is reachable from the client

Make sure that you can access the URL `http://<WSUSSERVER:port>/iuident.cab` and download the file without errors.

If the WSUS server is unreachable from the client, the most likely causes include:

- There's a name resolution issue on the client.
- There's a network-related issue, such as a proxy configuration issue.

Use standard troubleshooting procedures to verify name resolution is working on the network. If name resolution is working, the next step is to check for proxy issues. Check windowsupdate.log (C:\windows\) to see if there are any proxy related errors. You can run the [`proxycfg`](/previous-versions/windows/desktop/ms761351(v=vs.85)) command to check the WinHTTP proxy settings.

If there are proxy errors, go to Internet Explorer > **Tools** > **Connections** > **LAN Settings**, configure the correct proxy, and then make sure you can access the WSUS URL specified.

Once done, you can copy these user proxy settings to the WinHTTP proxy settings by using the `proxycfg -u` command. After the proxy settings are specified, run `wuauclt /detectnow` from a Command Prompt and check windowsupdate.log for errors.

## Rebuild the Automatic Update Agent Store

When there are issues downloading updates and there are errors relating to the software distribution store, complete the following steps on the client:

- Stop the Automatic Updates service by running `sc stop wuauserv` from a Command Prompt.
- Rename the software distribution folder (for example, C:\Windows\SoftwareDistribution).
- Restart the Automatic Update service by running `sc start wuauserv` from a Command Prompt.
- From a Command Prompt, run `wuauclt /resetauthorization /detectnow`.
- From a Command Prompt, run `wuauclt /reportnow`.

## Check for clients with the same SUSclient ID

You may experience an issue where only one WSUS client appears in the console. Or you may notice that out of a group of clients, only one appears in the console at a time but the exact one that does appear may change over time. This issue can happen when systems are imaged and the clients end up having the same `SUSclientID`.

For those clients that aren't working properly because of the same `SUSclientID`, complete the following steps:

- Stop the Automatic Updates service by running `sc stop wuauserv` from a Command Prompt.
- Delete the `SUSclientID` registry key from the following location:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate`

- Restart the Automatic Update service by running `sc start wuauserv` from a Command Prompt.
- From a Command Prompt, run `wuauclt /resetauthorization /detectnow`.
- From a Command Prompt, run `wuauclt /reportnow`.
