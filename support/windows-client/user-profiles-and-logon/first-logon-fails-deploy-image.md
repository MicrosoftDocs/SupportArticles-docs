---
title: First sign-in fails with the universal unique identifier (UUID) type is not supported
description: A user receives a UUID error message at the first logon of a Windows 8 or Windows 8.1 image. This issue occurs when the image was deployed by using System Center 2012 Configuration Manager or System Center 2012 R2 Configuration Manager.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-logon-fails, csstroubleshoot
---
# First logon fails with error: The universal unique identifier (UUID) type is not supported

This article describes a situation in which a user receives a UUID error message at the first logon of a Windows 8 or Windows 8.1 image. This issue occurs when the image was deployed by using System Center 2012 Configuration Manager or System Center 2012 R2 Configuration Manager.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2976660

## Symptoms

Assume that you use System Center 2012 Configuration Manager or System Center 2012 R2 Configuration Manager to deploy a Windows 8 or Windows 8.1 image. When a user starts the system that has the image (physical or virtual) and tries to sign in for the first time, they receive the following error message:
> The Group Policy Client service failed the sign-in.  
> The universal unique identifier (UUID) type is not supported.

:::image type="content" source="media/first-logon-fails-deploy-image/group-policy-client-service-failed-error.png" alt-text="Screenshot of the UUID type is not supported error message at the logon screen." border="false":::


This error message appears at first user logon after initial deployment of the image. However, in some scenarios, later user logons also result in the error message.

After the message is displayed and the user selects **OK**, the logon screen is displayed again.

## Cause

Winlogon communicates with the Group Policy service (GPSVC) through an RPC call upon system startup for computer policy. And it communicates with user logon for user policy. System Center Configuration Manager installs a Client-Side Extension (CSE) in the Windows image, which is detected by the Group Policy service on first start. The Group policy service then isolates itself into a separate SVCHOST process. The service was originally running in a shared process with other services. Because RPC communications have already been established before the service isolation, `Winlogon` can no longer contact the Group Policy service. This situation results in the error message that's described in the Symptoms section.

On later restarts, GPSVC is appearing in a separate process from the beginning of the operating system session. So, the RPC runtime has no problem finding the correct server process instance.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

The following workarounds can be used to avoid the error message. Both workarounds involve modifying the image build-in System Center Configuration Manager instead of implementing them in the already deployed image.

### Workaround 1

Add a restart to the end of the task sequence list for the image build. Modify the System Center Configuration Manager task sequence for the image by using SMSTSPostAction **`shutdown /r /t 0`** as the last task before completing the build.

### Workaround 2

Separate the Group Policy service into a separate SVCHOST instance. Implement the following command in the System Center Configuration Manager task sequence to set the corresponding registry entry:

```console
cmd /c reg add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v Type /t REG_DWORD /d 0x10 /f
```

By default, GPSVC isolates itself when detecting a CSE. This workaround will force GPSVC to always start in an isolated SVCHOST instance, including the first start. It prevents the registration of the RPC communications in different SVCHOST processes, and lets `Winlogon` successfully connect to the correct process.
