---
title: Troubleshoot Windows Update Error 0x80244007
description: Learn how to resolve the Windows Update error 0x80244007, which occurs during update scans.
manager: dcscontentpm
audience: itpro
ms.date: 11/7/2025
ms.topic: troubleshooting
ms.reviewer: scotro, mwesley, jarretr, v-ryanberg, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\Windows Update - Install errors starting with 0x8024 (WU E Setup)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80244007

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

The Windows Update error 0x80244007 normally occurs when Windows clients or virtual machines (VMs) attempt to scan and download updates from Windows Server Update Services (WSUS) or Configuration Manager endpoints. This error is commonly linked to Simple Object Access Protocol (SOAP) faults returned by the server during the update process. This indicates issues with communication or configuration between the client and the update service.

:::image type="content" source="./media/troubleshoot-windows-update-error-0x80244007/error0x80244007.png" alt-text="Windows Update error 0x80244007" lightbox="media/troubleshoot-windows-update-error-0x80244007/error0x80244007.png":::

## Prerequisites

For VMs running Windows in Azure, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

### Symptom 1

When a WSUS client computer scans for updates on the WSUS server, you might see the following error message in the `WindowsUpdate.log` file on the client computer:

```output
WS error: <detail><ErrorCode>InvalidParameters</ErrorCode><Message>parameters.InstalledNonLeafUpdateIDs</Message><ID>GUID</ID><Method> http://www.microsoft.com/SoftwareDistribution/Server/ClientWebService/SyncUpdates"</Method></detail>"
*FAILED* [80244007] SyncUpdates_WithRecovery failed
```

This issue occurs when the number of updates to be synchronized exceeds the maximum number of installed prerequisites that a WSUS client can pass to `SyncUpdates`.

### Symptom 2

Updates fail to install, and the scan itself fails due to an issue with `OtherCachedUpdateIDs`. You might see similar log entries in *C:\Windows\Logs\WindowsUpdate.log* as shown in the following example:

```output
2015-10-30 17:12:53:980 880 1160 IdleTmr WU operation (CAgentProtocolTalker::SyncUpdates_WithRecover) started; operation # 584; does use network; is at background priority
2015-10-30 17:12:54:073 880 1160 WS WARNING: Nws Failure: errorCode=0x803d0013
2015-10-30 17:12:54:073 880 1160 WS WARNING: The body of the received message contained a fault.
2015-10-30 17:12:54:073 880 1160 WS WARNING: Soap fault info:
2015-10-30 17:12:54:073 880 1160 WS WARNING: reason: Fault occurred
2015-10-30 17:12:54:073 880 1160 WS WARNING: code: Client
2015-10-30 17:12:54:073 880 1160 WS WARNING: detail: <detail><ErrorCode>InvalidParameters</ErrorCode><Message>parameters.OtherCachedUpdateIDs</Message><ID>8889e6f6-cc94-4b2b-9d0c-9818649a5dfc</ID><Method>"http://www.microsoft.com/SoftwareDistribution/Server/ClientWebService/SyncUpdates"</Method></detail>
2015-10-30 17:12:54:073 880 1160 WS WARNING: Soap fault detail: errorCode='InvalidParameters', message='parameters.OtherCachedUpdateIDs', id='8889e6f6-cc94-4b2b-9d0c-9818649a5dfc', method='"http://www.microsoft.com/SoftwareDistribution/Server/ClientWebService/SyncUpdates"'
2015-10-30 17:12:54:073 880 1160 WS FATAL: OnCallFailure failed with hr=0X80244007
2015-10-30 17:12:54:073 880 1160 PT WARNING: PTError: 0x80244007
2015-10-30 17:12:54:073 880 1160 PT WARNING: SyncUpdates_WithRecovery failed.: 0x80244007
2015-10-30 17:12:54:073 880 1160 IdleTmr WU operation (CAgentProtocolTalker::SyncUpdates_WithRecover, operation # 584) stopped; does use network; is at background priority
```

### Symptom 3

The check for updates fails with the internal server `error code: 0x80244007` along with `error code: 0x803d0013`. These are caused by a missing WSUS client entry used for authentication and authorization of client access. The `Windows Update` log shows:

```output
2017-05-04 18:00:07:807 1676 117c PT +++++++++++ PT : Synchronizing server updates +++++++++++
2017-05-04 18:00:07:807 1676 117c PT + ServiceId = {3DA21691-E39D-4DA6-8A4B-B43877BCB1B7}, Server URL =  https://<wsusserver>/ClientWebService/client.asmx
2017-05-04 18:00:07:807 1676 117c EP Got WSUS SimpleTargeting URL: " https://<wsusserver> "
2017-05-04 18:00:07:807 1676 117c IdleTmr CIdleTimerHelper starting a WU operation (CAuthorizationCookieWrapper::InitializeSimpleTargetingCookie; does require network, is at background priority, will stop idle timer) from unspecified call
2017-05-04 18:00:07:807 1676 117c PT Initializing simple targeting cookie, clientId = , target group = special-01, DNS name = byolaq.bayer.cnb
2017-05-04 18:00:07:807 1676 117c PT Server URL =  https://<wsusserver>/SimpleAuthWebService/SimpleAuth.asmx
2017-05-04 18:00:07:807 1676 117c WS Service URL='https://<wsusserver>/SimpleAuthWebService/SimpleAuth.asmx'.
2017-05-04 18:00:07:807 1676 117c WS Proxy List: '(null)', Bypass List: '(null)'.
2017-05-04 18:00:07:807 1676 117c WS Current service auth scheme='None'.
2017-05-04 18:00:07:807 1676 117c WS No proxy settings for this web service call.
2017-05-04 18:00:07:854 1676 1184 WS The SOAP message content is not xpress encoded.
2017-05-04 18:00:07:854 1676 117c WS WARNING: Nws Failure: errorCode=0x803d0013
2017-05-04 18:00:07:854 1676 117c WS WARNING: The body of the received message contained a fault .
2017-05-04 18:00:07:854 1676 117c WS WARNING: Soap fault info:
2017-05-04 18:00:07:854 1676 117c WS WARNING: reason: Fault occurred
2017-05-04 18:00:07:854 1676 117c WS WARNING: code: Server
2017-05-04 18:00:07:854 1676 117c WS WARNING: detail: <detail><ErrorCode> InternalServerError </ErrorCode><Message></Message><ID>9f8e13ac-3a64-41c6-a40b-cad7913fc1bb</ID><Method>"  http://www.microsoft.com/SoftwareDistribution/Server/SimpleAuthWebService/GetAuthorizationCookie "</Method></detail>
2017-05-04 18:00:07:854 1676 117c WS FATAL: OnCallFailure failed with hr= 0X80244007
2017-05-04 18:00:07:854 1676 117c WS FATAL: NwsCallWithRetries<Functor>( Functor(_clientId, _targetGroupName, _dnsName, &_result)) failed with hr=0x80244007
```

## Root cause 

This error is primarily caused by SOAP faults returned by the server during the update process. This can occur due to:

- Exceeding the maximum number of installed prerequisites that a WSUS client can pass to `SyncUpdates`.
- Issues with `OtherCachedUpdateIDs` during the update scan.
- A missing WSUS client entry used for authentication and authorization of client access.

## Resolution or troubleshooting steps

### Mitigation 1:  Increase `maxInstalledPrerequisites` in WSUS configuration

Edit the `web.config` file on the WSUS server located at *%programfiles%\Update Services\WebServices\ClientWebService\web.config*. Change the value for **maxInstalledPrerequisites** from **400** to **800**.

For more information, see [Error 80244007 when a WSUS client scans for updates](/mem/configmgr/update-management/error-80244007-when-wsus-client-scans-updates).

### Mitigation 2: Decline superseded updates in WSUS

Decline all superseded updates on the WSUS server. Detailed instruction on how to do this can be found at [PowerShell script to decline superseded updates in WSUS](/mem/configmgr/update-management/decline-superseded-updates).

For more information, see [The complete guide to WSUS and Configuration Manager SUP maintenance](/mem/configmgr/update-management/wsus-maintenance-guide).

### Mitigation 2.1: Increase `maxCachedUpdate` in WSUS configuration

Edit the `web.config` file on the WSUS server at *C:\Program Files\Update Services\WebServices\ClientWebService\web.config*. Change the **maxCachedUpdate** value to a larger number.

### Mitigation 3: Resetthe WSUS client

Open an elevated command prompt on the affected WSUS client and run the following commands in this order:

1. `net stop wuauserv`
2. `reg Delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate /v PingID /f`
3. `reg Delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate /v AccountDomainSid /f`
4. `reg Delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate /v SusClientId /f`
5. `reg Delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate /v SusClientIDValidation /f`
6. `net start wuauserv`
7. `wuauclt.exe /resetauthorization /detectnow`

Messages like **ERROR: The system was unable to find the specified registry key or value** are normal and don't need mitigation. Once all the commands are run, wait for 10-15 minutes, go to **Control Panel > All Control Panel Items > Windows Update**, check for updates, and monitor the status.