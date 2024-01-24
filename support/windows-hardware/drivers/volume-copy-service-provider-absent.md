---
title: Volume Copy Service Provider is absent
description: This article provides a resolution for the issue where Microsoft Volume Copy Service Provider is absent from the list of services.
ms.date: 08/27/2020
ms.reviewer: twarwick
ms.subservice: general
---
# MS Software Shadow Copy Provider service does not start on Windows Embedded POSReady 2009

This article helps you resolve the issue where Microsoft Volume Copy Service Provider is absent from the list of services.

_Original product version:_ &nbsp; Windows Embedded POSReady 2009  
_Original KB number:_ &nbsp; 2519872

## Symptoms

Multiple symptoms can occur:

- Applications, such as Norton Ghost, cannot run.
- Error code 12292 is written to the Application Event Log when Running Defrag.
- 0x80110401 errors in Application Event Log every time one runs a Backup.

## Cause

The Volume Copy Service Provider is absent from the list of services. This is because it is not registered properly and fails to start.

## Resolution

To resolve this problem, perform the following commands from a Command Prompt or in a Command Script, then reboot the system for the changes to take affect.

```console
cd /d %windir%\system32
Net stop vss
Net stop swprv
regsvr32 /s ole32.dll
regsvr32 /s oleaut32.dll
regsvr32 /s vss_ps.dll
vssvc /register
regsvr32 /s /i swprv.dll
regsvr32 /s /i eventcls.dll
regsvr32 /s es.dll
regsvr32 /s stdprov.dll
regsvr32 /s msxml.dll
regsvr32 /s msxml3.dll
```

## More information

> [!NOTE]
> The command `Net stop swprv` may appear to fail with the error **MS Software Shadow Copy Provider service is not started**. This is expected behavior if the MS Software Shadow Copy Provider is the cause of the Event Log error. Stopping the service is necessary if this sequence is used to resolve other issues with the Volume Shadow Copy Service.
