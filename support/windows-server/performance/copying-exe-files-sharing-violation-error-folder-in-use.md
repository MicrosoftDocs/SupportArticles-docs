---
title: Copying .EXE files may result in a sharing violation error - Folder In Use
description: Provides a resolution to a sharing violation error when copying .exe files.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, raackley
ms.custom: sap:applications, csstroubleshoot
---
# Copying .EXE files may result in a sharing violation error - Folder In Use

This article provides a resolution to a sharing violation error that occurs when copying .exe files.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2503886

## Symptoms

When copying an .EXE file or a folder containing .EXE files, you may periodically experience the following sharing violation error:

> Folder In Use  
The action can't be completed because the folder or a file in it is open in another program

After waiting approximately two minutes without retrying, you can click the **Try Again** button and it will copy successfully.

## Cause

This issue can occur if the Application Experience (AeLookupSvc) service is set to Disabled.

## Resolution

The recommended resolution is to set the Application Experience (AeLookupSvc) service back to the Manual startup type. This allows the operating system to dynamically start the service when needed.

## More information

Application Compatibility attempts to check if the .EXE file requires any application compatibility shims when it is accessed. This causes the system to obtain a handle to the file. The system queues a lookup request to the Application Experience (AeLookupSvc) service, but since the service is disabled, the request is not serviced in time and Explorer cannot copy the file because it is in use. After two minutes, the queued request to the Application Experience service times out and is dropped, releasing the handle and allowing the copy to proceed.

This issue only occurs when copying with Explorer.
