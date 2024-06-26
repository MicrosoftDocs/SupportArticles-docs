---
title: Enable trace logging for Opalis Integration Pack for FTP
description: Describes how to enable trace logging for Opalis Integration Pack for File Transfer Protocol.
ms.date: 06/26/2024
---
# How to enable trace logging for Opalis Integration Pack for File Transfer Protocol (FTP)

This article describes how to enable trace logging for Opalis Integration Pack for File Transfer Protocol (FTP). The trace logging provides details on the commands that were sent to the FTP server as well as the responses to those commands and actions taken based on the responses.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2410910

## Enable trace logging

1. Open Registry Editor and navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Opalis-FTP\FTP`.
2. Edit or create the `TraceLog` value of type **REG_SZ** and set the data to **On**.
3. Edit or create the `TraceLogName` value of type **REG_SZ** and set the data to the path and filename of the desired log output (such as `C:\FTPTraceLogging\MyTraceLog.log`).

## Capture secure FTP session information

For secure FTP sessions (SFTP or FTPS), follow the steps outlined below to capture the secure session information:

1. Open Registry Editor and navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Opalis-FTP\FTP`.
2. Edit or create the `SecureSessionLog` value of type **REG_SZ** and set the data to **On**.
3. Edit or create the `SecureSessionLogName` value of type **REG_SZ** and set the data to the path and filename of the desired log output (such as `C:\FTPTraceLogging\MySecureSessionLog.log`).
