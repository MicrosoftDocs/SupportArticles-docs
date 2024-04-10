---
title: FTP download session fails when connection is closed
description: This article provides workarounds for the FTP download session fails problem that occurs when FTP control connection is closed.
ms.date: 12/11/2020
ms.custom: sap:FTP Service and Svchost or Inetinfo Process Operation
ms.subservice: ftp-service-svchost-inetinfo
---
# FTP download session fails when FTP control connection is closed

This article helps you resolve the FTP download session fails problem that occurs when FTP control connection is closed.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 254722

## Symptoms

If the control connection is closed during an FTP download session, the download from the IIS FTP site fails.

> [!NOTE]
> This issue usually occurs when a firewall is in use that has been set to close the control connection if no TCP data is transferred after a certain amount of time.

## Cause

This is by design. `RFC-959` states the following:

> ... The protocol requires that the control connections be open while data transfer is in progress. It is the responsibility of the user to request the closing of the control connections when finished using the FTP service, while it is the server who takes the action. The server may abort data transfer if the control connections are closed without command...

## Workaround

To resolve this issue, try the following workarounds:

- Use an FTP utility or firewall setting that keeps the control connection open.
- Use a faster connection.
- Request that the FTP Site owner break the file that the download fails on into multiple, smaller files.

## More information

This scenario usually occurs when you are downloading a large file over a slow connection.
