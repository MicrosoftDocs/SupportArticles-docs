---
title: WMI-Activity Event 5858 ResultCode 0x80041032
description: WMI-Activity Event ID 5858 is logged with ResultCode 0x80041032 when applications issue WMI queries.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, steved, cmyu, ssutari
ms.custom: sap:wmi, csstroubleshoot
ms.technology: windows-client-system-management-components
---
# WMI-Activity Event 5858 logged frequently with ResultCode 0x80041032

This article provides a resolution to solve the WMI-Activity event ID 5858 that's logged with ResultCode = 0x80041032 in Windows Server 2012 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3124914

## Symptoms

When using Windows Server 2012 R2 with applications that issue WMI queries using `IWbemServices:ExecQuery`, the administrator may observe the following event in Event Viewer:

```output
Log Name:  Microsoft-Windows-WMI-Activity/Operational
Source:    WMI-Activity
Event ID:  5858
Level:     Error
Id = {guid}; ClientMachine = <computer>; User = <user>; ClientProcessId = <process ID>; Component = Unknown; Operation = Start IWbemServices::ExecQuery - <WMI namespace>: <Select Query Statement>; ResultCode = 0x80041032; PossibleCause = Unknown
where 0x80041032 indicates WBEM_E_CALL_CANCELLED.
```

> [!NOTE]
> This event can occur with many different ResultCode values. The problem described in this article only applies when `ResultCode = 0x80041032 (WBEM_E_CALL_CANCELLED)`.

## Cause

WMI-Activity Error 5858 with ResultCode = 0x80041032 (WBEM_E_CALL_CANCELLED) indicates that the WMI caller has successfully issued `IWbemServices:ExecQuery`, but has released the `IWbemContext` object before retrieving the full result set using the `IEnumWbemClassObject::Next` method. If the WMI service is still holding data for the client when the client terminates the link (by releasing the `IWbemContext` object), this event will be logged.

This error can happen if the WMI application calls `IEnumWbemClassObject::Next` with a timeout value (lTimeout) that is not long enough to retrieve the object being queried, and is not checking for a return code of `WBEM_S_TIMEDOUT (0x40004)` in order to issue the request again.

## Resolution

The WMI client application should be modified to issue calls to `IEnumWbemClassObject::Next` to retrieve the full result set, before releasing the IWbemContext object. If no objects are received, make sure that the timeout value (lTimeout) is greater than **0** and that `WBEM_S_TIMEDOUT (0x40004)` is not being returned.

## More information

For more information, see:

- [IEnumWbemClassObject interface](/windows/win32/api/wbemcli/nn-wbemcli-ienumwbemclassobject)

  > [!NOTE]
  > The sample code included at the end of this page shows `IEnumWbemClassObject::Next` being called with a timeout value (lTimeout) of **0**, and is not checking for the **WBEM_S_TIMEDOUT** error.

- [IWbemServices::ExecQuery method](/windows/win32/api/wbemcli/nf-wbemcli-iwbemservices-execquery)
- [IEnumWbemClassObject::Next method](/windows/win32/api/wbemcli/nf-wbemcli-ienumwbemclassobject-next)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).
