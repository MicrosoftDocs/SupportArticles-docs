---
title: GetMyDevicePortName may return incorrect port name in Windows 11 when you connect multiple USB scanners
description: This article discusses the problem that occurs when you connect multiple USB scanners on Windows 11 and you see incorrect port name of a device while running GetMyDevicePortName.
ms.date: 05/02/2022
ms.custom: sap:Print driver
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.technology: windows-hardware-print-driver
---

# GetMyDevicePortName may return incorrect port name in Windows 11 when you connect multiple USB scanners

This article discusses the problem that occurs when you connect multiple USB scanners in Windows 11 and you see incorrect port name of a device while running `GetMyDevicePortName`.

## Symptoms

Consider the following scenario:

1. You've connected multiple USB scanners to your Windows 11 device.
1. Your scanner isn't working properly after the device starts up from the sleep state.
1. The Windows Image Acquisition (WIA) driver is using `IStiDeviceControl::GetMyDevicePortName` inside the `IStiUSD::Initialize` method as the following code example.

```cppwinrt
///////////////////////////////////////////////////////////////////////////
// IStiUSD Interface Section (for all WIA drivers)
///////////////////////////////////////////////////////////////////////////
HRESULT CYourWIADriver::Initialize(_In_ PSTIDEVICECONTROL pHelDcb,
                                    DWORD             dwStiVersion,
                               _In_ HKEY              hParametersKey)
{
    HRESULT hr = E_INVALIDARG;
.
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

The [IStiUSD::Initialize](/windows-hardware/drivers/ddi/stiusd/nf-stiusd-istiusd-initialize) method creates read or write path for the devices that you connect to the ports by running the `CreateFile` commands.

The WIA driver uses a port name that it obtains for a device by running the [IStiDeviceControl::GetMyDevicePortName](/windows-hardware/drivers/ddi/stiusd/nf-stiusd-istidevicecontrol-getmydeviceportname).

In this scenario, when you try scanning a document from the device, you're unable to scan due to the errors.

## Cause

It's a known issue that might occur because the WIA service doesn't refresh the port name information on the memory of your Windows 11 device when in sleep state. The scanner port's path name might change after starting up from the sleep state. Therefore, the WIA driver might fail in driver initialization phase and release the errors.
The error that you might see depends on your driver implementation.

## Workaround

We're working on the software update to Windows 11.
