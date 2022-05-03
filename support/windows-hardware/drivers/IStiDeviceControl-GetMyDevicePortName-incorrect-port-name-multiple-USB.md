---
title: IStiDeviceControl::GetMyDevicePortName may return incorrect port name when multiple USB scanners connected
description: This article discusses the problem that occurs when you connect multiple USB scanners on Windows 11 and GetMyDevicePortName returns incorrect port name of a device.
ms.date: 05/02/2022
ms.custom: sap:Print driver
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.technology: windows-hardware-print-driver
---

# IStiDeviceControl::GetMyDevicePortName may return incorrect port name when multiple USB scanners connected

This article discusses the problem that occurs when you connect multiple USB scanners on Windows 11 and `GetMyDevicePortName` returns incorrect port name of a device.

## Symptoms

Consider the following scenario:

1. You are connecting multiple USB scanners to a Windows 11 device.
1. The scanner device isn't working properly when the device has started up from the sleep state.
1. Your Windows Image Acquisition (WIA) driver is using `IStiDeviceControl::GetMyDevicePortName` under the `IStiUSD::Initialize` method as the following code example.

```cppwinrt
///////////////////////////////////////////////////////////////////////////
// IStiUSD Interface Section (for all WIA drivers)
///////////////////////////////////////////////////////////////////////////
HRESULT CYourWIADriver::Initialize(_In_ PSTIDEVICECONTROL pHelDcb,
                                    DWORD             dwStiVersion,
                               _In_ HKEY              hParametersKey)
{
    HRESULT hr = E_INVALIDARG;

    if ((pHelDcb)&&(hParametersKey))
    {
        TCHAR wszPortName[MAX_PATH];
        DWORD cchPortName = sizeof(wszPortName)/sizeof(wszPortName[0]);
        hr = pHelDcb->GetMyDevicePortName(wszPortName, cchPortName);
        if (SUCCEEDED(hr))
        {
            WIAS_TRACE((g_hInst, "PortName = %ws", wszPortName));
        }
```

The [IStiUSD::Initialize](/windows-hardware/drivers/ddi/stiusd/nf-stiusd-istiusd-initialize) method typically creates a read/write path for the devices that connect to dedicated ports by calling `CreateFile`. The WIA driver uses a device port name that it obtains by calling the [IStiDeviceControl::GetMyDevicePortName](/windows-hardware/drivers/ddi/stiusd/nf-stiusd-istidevicecontrol-getmydeviceportname).

In this scenario, when you try scanning a document from one device, the scan process can't initiate due to errors.

## Cause

This issue occurs because the WIA service on Windows 11 does not refresh port name information that is present in memory storage while the system is in sleep state. The scanner port's path name might change after the sleep state. Therefore, the WIA driver might fail in driver initialization phase and release the errors. The issue that you might see depends on your driver implementation.

## Workaround

To avoid this issue, you can retrieve the port name from registry by using `RegQueryValueEx` with the following code sample. Run this code considering as one of the alternatives to obtain the port name.

```cppwinrt
///////////////////////////////////////////////////////////////////////////
// IStiUSD Interface Section (for all WIA drivers)
///////////////////////////////////////////////////////////////////////////
HRESULT CYourWIADriver::Initialize(_In_ PSTIDEVICECONTROL pHelDcb,
                                    DWORD             dwStiVersion,
                               _In_ HKEY              hParametersKey)
{
    HRESULT hr = E_INVALIDARG;

    if ((pHelDcb)&&(hParametersKey))
    {
        TCHAR wszPortName[MAX_PATH];
        DWORD cbPortName = sizeof(wszPortName);
        DWORD dwType = REG_SZ;

        if (ERROR_SUCCESS == RegQueryValueEx(
                                     hParametersKey,
                                     L"CreateFileName",
                                     NULL,
                                     &dwType,
                                     (BYTE*)wszPortName,
                                     &cbPortName))
        {
            WIAS_TRACE((g_hInst, "PortName = %ws", wszPortName));
        }
```
