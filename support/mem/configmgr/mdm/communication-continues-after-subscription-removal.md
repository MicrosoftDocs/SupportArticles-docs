---
title: CloudUserSync continues after Intune subscription is removed
description: Describes an issue that occurs when you remove the Intune subscription in Configuration Manager current branch versions 1602 and 1606. In this situation, communication with the Intune service is not stopped as expected. 
ms.date: 02/11/2025
ms.reviewer: kaushika, jarnold, kaushika, cmkbreview
ms.custom: sap:Cloud Services\Co-management
---
# Removing the Intune subscription in Configuration Manager doesn't stop communication with Intune service

This article helps you resolve an issue in which communication with the Microsoft Intune service isn't stopped as expected after removing the Intune subscription.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1602), Configuration Manager (current branch - version 1606)  
_Original KB number:_ &nbsp; 4012668

## Symptoms

In Configuration Manager current branch versions 1602 and 1606, you delete the Intune subscription from a site by using the Configuration Manager console. After you do this, the `CloudDMP` replication group remains enabled, and `CloudUserSync` continues to try to license users. Additionally, the following message is logged in the Cloudusersync.log file:

> HasIntuneSubscription: Site has no Intune subscription

However, if there is telemetry remaining to be sent, the service connection point tries to send it every hour. Each time, Intune forcibly closes the connection, which causes the following error to be logged in the dmpuploader.log file:

> ERROR: UploadTelemetryData exception:  
> [Microsoft.Management.Services.Common.ServiceTooBusyException

## Workaround

To work around this issue, set the following registry key:

|Registry subkey|DWORD name|DWORD value|
|---|---|---|
|`HKEY_LOCAL_MACHINE\Software\Microsoft\SMS\Components\SMS_DMP_UPLOADER`|UploadInterval|7fffffff|

This setting makes the uploader sleep for 4,000 years. However, it will still try to upload every time that the DmpUploader service is restarted.
