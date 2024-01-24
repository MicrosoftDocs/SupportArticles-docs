---
title: Error when you use IISReset.exe to restart IIS
description: This article provides resolutions for the error that occurs when you use the  IISReset.exe to restart IIS service.
ms.date: 12/11/2020
ms.custom: sap:IISAdmin Service and Inetinfo Process Operation
ms.subservice: iisadmin-service-inetinfo
---
# Using IISReset.exe to restart IIS results in an error message

This article helps you resolve the problem that occurs when you use the IISReset.exe to restart Information Services (IIS) service.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 969864

[!INCLUDE [Rapid Publishing Disclaimer](../../../../includes/rapid-publishing-disclaimer.md)]

## Symptom

When using the IIReset.exe command-line tool along with the `/NOFORCE` switch to reset the IIS services, an error message that resembles the following may occur:

- Error message 1

    > There was an error while performing this operation.  
    The service cannot accept control messages at this time. (2147943461, 80070425)

- Error message 2

    > Restart attempt failed.  
    The service cannot accept control messages at this time. (2147943461, 80070425)

## Cause

IISReset.exe fails to stop the IIS services in a timely fashion. With the `/NOFORCE` switch included, IISReset.exe will not attempt to forcibly shut down the IIS services if the services do not stop gracefully.

## Resolution

Do not use the IISReset.exe tool to restart the IIS services. Instead, use the `NET STOP` and `NET START` commands. For example, to stop and start the World Wide Web Publishing Service, run the following commands:

```console
C:\> NET STOP w3svc
The World Wide Web Publishing Service service is stopping.
The World Wide Web Publishing Service service was stopped successfully.

C:\> NET START w3svc
The World Wide Web Publishing Service service is starting.
The World Wide Web Publishing Service service was started successfully.
```

To stop and start the IIS Admin Service, run the following commands:

```console
C:\> NET STOP iisadmin /y
```

The following services are dependent on the IIS Admin Service service.
Stopping the IIS Admin Service service will also stop these services.

```console
World Wide Web Publishing Service  
HTTP SSL

The World Wide Web Publishing Service service is stopping.  
The World Wide Web Publishing Service service was stopped successfully.

The HTTP SSL service is stopping.  
The HTTP SSL service was stopped successfully.

The IIS Admin Service service is stopping..  
The IIS Admin Service service was stopped successfully.
```

```console
C:\> NET START w3svc
The World Wide Web Publishing Service service is starting.
The World Wide Web Publishing Service service was started successfully.
```

## More information

There are two benefits to using the `NET STOP/NET START` commands to restart the IIS Services as opposed to using the IISReset.exe tool. First, it is possible for IIS configuration changes that are in the process of being saved when the IISReset.exe command is run to be lost. Second, using IISReset.exe can make it difficult to identify which dependent service or services failed to stop when this problem occurs. Using the NET STOP commands to stop each individual dependent service will allow you to identify which service fails to stop, so you can then troubleshoot its failure accordingly.

[!INCLUDE [Community Solutions Content Disclaimer](../../../../includes/community-solutions-content-disclaimer.md)]
