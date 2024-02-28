---
title: Error 80244007 when a Windows Server Update Services (WSUS) client scans for updates
description: Describes an issue in which WSUS clients can't scan for updates.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Error 80244007 when a WSUS client scans for updates

This article helps you fix an issue where you receive the **[80244007] SyncUpdates_WithRecovery failed** error when a WSUS client scans for updates.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 4096317

## Symptom

You use WSUS to deploy software updates to computers in your organization. When a WSUS client computer scans for updates on the WSUS server, you see the following error message in the WindowsUpdate.log file on the client computer:

```output
WS error: <detail><ErrorCode>InvalidParameters</ErrorCode><Message>parameters.InstalledNonLeafUpdateIDs</Message><ID>GUID</ID><Method> http://www.microsoft.com/SoftwareDistribution/Server/ClientWebService/SyncUpdates"</Method></detail>"

*FAILED\* [80244007] SyncUpdates_WithRecovery failed
```

Additionally, the following exception is logged in the SoftwareDistribution.log file on the WSUS server:

```output
ThrowException: actor = http://WSUSServerName:8530/ClientWebService/client.asmxs, ID=GUID, ErrorCode=InvalidParameters, Message=parameters.InstalledNonLeafUpdateIDs, Client=Client_ID
```

## Cause

This issue occurs when the number of updates to be synchronized exceeds the maximum number of installed prerequisites that a WSUS client can pass to `SyncUpdates`.

## Resolution

To fix the issue, follow these steps on the WSUS server:

1. Open an elevated Command Prompt window, and then go to the following location:

   `%programfiles%\Update Services\WebServices\ClientWebService`

2. Type the following commands, and press Enter after each command:

    ```console
    takeown /f web.config
    icacls web.config /grant administrator:(F)
    notepad.exe web.config
    ```

3. Locate the following line in web.config:

   ```xml
   <add key="maxInstalledPrerequisites" value="400"/>
   ```

4. Change the value from **400** to **800**.
5. Save the web.config file.
6. Run `IISReset`.
