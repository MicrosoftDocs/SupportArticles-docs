---
title: SMS Agent Host service isn’t automatically restarted
description: Describes a problem in which the CcmExec.exe service is not automatically restarted after the WMI service is paused and restarted.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo, brshaw
ms.custom: sap:Client Operations\CcmExec Service crashes or does not start
---
# The CcmExec.exe service is not automatically restarted after the WMI service is paused and restarted

This article provides a workaround to solve the issue that the SMS Agent Host service (CcmExec.exe) isn't automatically restarted after the Windows Management Instrumentation (WMI) service is paused and restarted.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2691080

## Symptoms

When the WMI service is paused in Configuration Manager, the SMS Agent Host service (CcmExec.exe) becomes nonfunctional. After the WMI service is restarted, the CcmExec.exe service is not automatically restarted and remains nonfunctional.

## Cause

This problem occurs because WMI cancels all requests when it is paused and does not restart those requests when the service is resumed or restarted.

## Workaround

To work around this problem immediately, manually restart the SMS Agent Host service. The periodic client health check will also detect that the SMS Agent Host service isn't functioning and restart the service when it executes.
