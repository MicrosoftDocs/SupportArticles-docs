---
title: Stop error on Lenovo ThinkPad that has KB4568831 or a later update and Enhanced Windows Biometric Security enabled in UEFI
description: Describes a problem that causes a Stop error on Lenovo ThinkPad devices that were manufactured in 2019 or 2020 and that have received the KB4568831 update.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits, mapalko, v-tea
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Stop error on Lenovo ThinkPad that has KB4568831 or a later update and Enhanced Windows Biometric Security enabled in UEFI

This article describes a problem that causes a stop error on Lenovo ThinkPad that has KB4568831 or a later update.

_Applies to:_ &nbsp; Windows 10, version 2004  
_Original KB number:_ &nbsp; 4580649

## Symptoms

You have a Lenovo ThinkPad device that has received the [July 31, 2020-KB4568831 (OS Build 19041.423) Preview](https://support.microsoft.com/help/4568831/windows-10-update-kb4568831) update or a newer update. The device also has Enhanced Windows Biometric Security enabled in the UEFI, and it runs Lenovo Vantage software.

The device experiences a Stop error (also known as a bugcheck or blue screen error). The codes that are associated with the error are "SYSTEM_THREAD_EXCEPTION_NOT_HANDLED" (in the Stop error message screen) and "0xc0000005 Access Denied" (in memory dumps files and other logs). The associated process is ldiagio.sys.

## Cause

Windows devices that receive [July 31, 2020-KB4568831 (OS Build 19041.423) Preview](https://support.microsoft.com/help/4568831/windows-10-update-kb4568831)  or newer updates restrict how processes can access [peripheral component interconnect (PCI) device configuration space](/windows-hardware/drivers/pci/accessing-pci-device-configuration-space)  under specific conditions. Processes that have to access PCI device configuration space must use officially supported mechanisms.

Enabling the Enhanced Windows Biometric Security option in the UEFI of Lenovo ThinkPad devices that were manufactured in 2019 or 2020 meet the conditions that trigger this behavior. When Lenovo Vantage software runs, some versions may try to access PCI device configuration space in an unsupported manner. This action causes a Stop error to occur.

## Workaround

To temporarily mitigate this problem, edit the device UEFI configuration (in the **Security** > **Virtualization** section) to disable Enhanced Windows Biometric Security. This change disables the restrictions that are enabled by the SDEV table and VBS.

## Status

Lenovo and Microsoft are working on a fix for this problem. For updated Lenovo Vantage support information about this problem, see [Lenovo HT511000](https://support.lenovo.com/ca/en/solutions/ht511000).

## More information

Windows devices that receive the [July 31, 2020-KB4568831 (OS Build 19041.423) Preview](https://support.microsoft.com/help/4568831/windows-10-update-kb4568831)  or later updates restrict how processes can access peripheral component interconnect (PCI) device configuration space if a [Secure Devices (SDEV) ACPI table](https://uefi.org/sites/default/files/resources/ACPI_6_2.pdf)  is present and [Virtualization-based Security (VBS)](/windows-hardware/design/device-experiences/oem-vbs) is running. Processes that have to access PCI device configuration space must use officially supported mechanisms.

The SDEV table defines secure hardware devices in ACPI. VBS is enabled on a system if security features that use virtualization are enabled. Some examples of these features are Hypervisor Code Integrity or Windows Defender Credential Guard.

The new restrictions are designed to prevent malicious processes from modifying the configuration space of secure devices. Device drivers or other system processes must not try to manipulate the configuration space of any PCI devices, except by using the [Microsoft-provided bus interfaces](/windows-hardware/drivers/ddi/wdm/ns-wdm-_bus_interface_standard) or [IRP](/windows-hardware/drivers/kernel/irp-mn-read-config). If a process tries to access PCI configuration space in an unsupported manner (such as by parsing MCFG table and mapping configuration space to virtual memory), Windows denies access to the process and generates a Stop error.

Enabling the Enhanced Windows Biometric Security option in the UEFI of Lenovo ThinkPad devices that were manufactured in 2019 and 2020 enables an SDEV table. When Lenovo Vantage software runs, some versions may try to access PCI device configuration space in an unsupported manner. This action causes a Stop error. The error is typically displayed as described in the "Symptoms" section.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
