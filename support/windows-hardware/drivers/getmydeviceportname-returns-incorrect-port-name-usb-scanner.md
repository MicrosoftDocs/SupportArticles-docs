---
title: GetMyDevicePortName returns incorrect port name of a USB scanner
description: This article discusses the issue where GetMyDevicePortName may return incorrect port name after you start Windows 11 from the sleep mode.
ms.date: 05/02/2022
ms.custom: sap:Print driver
author: HaiyingYu
ms.author: haiyingyu
ms.technology: windows-hardware-print-driver
---

# GetMyDevicePortName returns incorrect port name after you start Windows 11 from the sleep mode

This article discusses the issue where GetMyDevicePortName method may return incorrect port name when you start Windows 11 device from the sleep mode.

## Symptoms

Consider the following scenario:

1. You've connected multiple USB scanners to your Windows 11 device.
1. Your scanner isn't working properly after the device starts up from the sleep state.
1. The Windows Image Acquisition (WIA) driver is using `IStiDeviceControl::GetMyDevicePortName` inside the `IStiUSD::Initialize` method as in the following code example.

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

The [IStiUSD::Initialize](/windows-hardware/drivers/ddi/stiusd/nf-stiusd-istiusd-initialize) method creates a read or write path for the devices that you connect to the ports by running the `CreateFile` commands.

The WIA driver uses a port name that it obtains for a device by running the [IStiDeviceControl::GetMyDevicePortName](/windows-hardware/drivers/ddi/stiusd/nf-stiusd-istidevicecontrol-getmydeviceportname) method.

In this scenario, if you try to scan a document by using the scanner, the scan process fails and you see the reported errors.

## Cause

This error occurs because the WIA service doesn't update cached information of the port name when a scanner's port name changes after the system resumes from the sleep state. The WIA driver might fail during initialization and report errors. The reported errors may vary depending on the driver's implementation.  

## Status

Microsoft has confirmed that this is a problem in Windows 11 version 21H2.
