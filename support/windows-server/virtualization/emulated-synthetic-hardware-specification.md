---
title: Emulated and synthetic hardware specification for Windows Server 2012 Hyper-V
description: Summarizes the specifications for supported emulated and synthetic hardware in a Windows Server 2012 environment.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: samacha, kaushika
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
---
# Emulated and synthetic hardware specification for Windows Server 2012 Hyper-V

This article summarizes the specifications for supported emulated and synthetic hardware in a Windows Server 2012 environment.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2844106

## Summary

Windows Server 2012 Hyper-V makes emulated and synthetic devices available to the virtual machines.

Emulated devices emulate an existing hardware device that exists as physical hardware. The advantage of emulated devices is that most operating systems usually have in-box drivers for them. Emulated devices might experience performance issues because of the overhead of emulation. Additionally, because the emulated devices may not have been designed specifically for virtualization purposes, they could also experience performance issues.

Synthetic devices are high-performance software components that control access to physical hardware devices that are designed for optimal performance in virtualized environments.

## More information

The following table lists basic hardware components and their corresponding emulated hardware:

|Component|Emulated hardware|
|---|---|
|Basic input/output system (BIOS)|American Megatrends (AMI) BIOS using the Intel 440BX chip set with PIIX4 On- board components:<ul><li> Battery-backed CMOS</li> <li> Real-Time clock</li> <li>Two 8327 DMA controllers</li> <li> I/O APIC</li> <li>PCI to ISA bridge (also known as PIIX or PCI-to-ISA / IDE Xcelerator)</li> <li>PCI bus (as found in Intel 440BX chipset)</li> <li>Host to PCI bridge (as found in Intel 440BX chipset)</li> <li>Two cascaded 8259 programmable interrupt controllers (PIC)</li> <li>Programmable Interval Timer (PIT)</li> <li> Power management hardware as provided in the Intel 440BX chipset</li> <li>SMBus</li> <li>Two 16550 UART controllers supporting up to two serial ports</li> <li>Winbond 83977 Super I/O chipset</li> <li> Keyboard Controller Device (I8042)</li> <li>Standard Microsoft 101-Key PS-2 Keyboard or PS/2 Mouse</li> <li>ISA Bus</li> <li>PIC Device: Generic VESA 2.0 Video Device</li> <li>DEC 21140 Ethernet Adapter</li> <li> Floppy disk controller</li> </ul>|
|Floppy disk drive|Supports a single 1.44-MB floppy disk drive and mapping floppy drive images.|
|Serial (COM) port|Emulates up to two serial ports that can be mapped to local named pipes, and files.|
|Mouse|Emulates a standard PS/2 Microsoft IntelliMouse&reg; pointing device.|
|Keyboard|Emulates a standard PS/2 101-key Microsoft keyboard.|
|Network adapter (multifunction)|Emulates the multiport DEC 21140 10/100TX 100-MB Ethernet network adapter with one to four network connections. In some cases, the DEC 21140 may show up on the virtual machine as Intel 21140. These are equivalent network adapters. The virtual network adapters and the network driver that controls them don't support the virtual local area network (VLAN) identifier (ID) in a Tag Header. Up to 4 such adapters can be added to a virtual machine.|
|Memory|Supports 1 TB of RAM per virtual machine.|
|Video card|Emulates a generic graphics adapter with 4 MB of VRAM, VGA, and SVGA support that is compliant with VESA 2.0, hardware cursor, and support for DirectX.|
|IDE/ATAPI storage|Emulates up to 4 IDE devices, hard drives, or CD-ROM or DVD-ROM drives (or ISO images), and virtual hard disks that are up to 2040 MB per IDE channel.|
  
The following table lists hardware components and their corresponding synthetic hardware:

|Component|Associated hardware|
|---|---|
|Microsoft Virtual Machine Bus|High-speed synthetic communication channel between virtual machine and parent partition installed as a part of integration services.|
|Microsoft Virtual Machine Bus Network Adapter|This network adapter is added when the integration services are installed into the OS in the virtual machine and the virtual network adapter is added to the virtual machine.|
|Microsoft Synthetic SCSI Controller|This SCSI adapter is added when the integration services are installed into the OS in the virtual machine and a SCSI adapter is added to the virtual machine. It supports up to 64 devices per controller (max of 4 SCSI controllers per virtual machine).|
|Pass through storage|Pass through storage provides mechanisms to virtual machines to read and write directly to a storage device presented to the virtual machine. The virtual machine sees it as a disk.|
|Microsoft Synthetic Video|This synthetic video adapter is added when the integration services are installed into the OS in the virtual machine.|
|Microsoft Synthetic Mouse|This synthetic mouse is added when the integration services are installed into the OS in the virtual machine.|
|Microsoft Hyper-V Synthetic Virtual Fibre Channel Adapter|This synthetic Virtual Fibre Channel adapter is added to the guest when the integration services are installed into the OS in the virtual machine and a Virtual HBA is added to the virtual machine.|
|Microsoft Hyper-V Virtual PCI Bus|This synthetic Virtual PCI Bus is added when the integration services are installed into the OS in the virtual machine and SR-IOV networking is being used.|
|Microsoft Hyper-V Generation Counter device|This synthetic Virtual Machine Generation Counter device is added when the integration services are installed into the OS. The device provides a 128-bit VM Generation Identifier for a VM that stays the same unless the VM is reverted to a snapshot.|
  
### References

For more information, see [Virtual machine specifications for Hyper-V in Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn592184(v=ws.11)).
