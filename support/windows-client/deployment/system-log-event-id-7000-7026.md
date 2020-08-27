---
title: Event ID 7000 or 7026 is logged in the System log on a computer running Windows 7, Windows Vista, Windows Server 2008 R2, or Windows Server 2008
description: Describes a problem in which event ID 7000 or event ID 7026 may be logged after you start a computer that's running Windows 7, Windows Vista, Windows Server 2008, or Windows Server 2008 R2.
ms.date: 08/21/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Certificates and public key infrastructure (PKI)
ms.technology: WindowsSecurity
---
# Event ID 7000 or 7026 is logged in the System log on a computer that's running Windows 7, Windows Vista, Windows Server 2008 R2, or Windows Server 2008

This article describes a problem in which event ID 7000 or event ID 7026 is logged after you start a computer that's running Windows 7, Windows Vista, Windows Server 2008, or Windows Server 2008 R2.

_Original product version:_ &nbsp;Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp;933757

## Symptoms

Event ID 7000 or event ID 7026 is logged in the System log on a computer that's running one of the following operating systems:

- Windows 7
- Windows Server 2008 R2
- Windows Vista
- Windows Server 2008

This problem may occur if a device isn't connected to the computer but the driver service of the device is enabled. For example, the following events are logged when the computer doesn't have a parallel port, a DVD drive, or a CD drive.

On a Windows 7-based or Windows Server 2008 R2-based computer

On a Windows Vista-based or Windows Server 2008-based computer

## Workaround

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To work around the problem that's described in the example in the "Symptoms" section, disable the Cdrom or Parport service in the registry to stop the errors from being logged.

If you prefer to fix this problem yourself, go to the "[Let me fix it myself](#let-me-fix-it-myself)" section.

### Let me fix it myself

To do this, change the value of the following registry subkeys to 3 (Manual) or 4 (Disabled)：

```console
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cdrom
Name: Start
Type : REG_DWORD
Data: 3 or 4
```

```console
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\parport
Name: Start
Type : REG_DWORD
Data: 3 or 4
```

Note: If the above registry is changed to 4 (Disabled), the related device isn't usable because a driver used in the device isn't loaded. So if the device will be used in the future, the above registry should be set as 3 (Manual).

### Did this fix the problem?

- Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus/).
- We would appreciate your feedback. To provide feedback or to report any issues with this solution, please leave a comment on the "[Fix it for me](https://blogs.technet.com/fixit4me/)" blog or send us an [email](mailto:fixit4me@microsoft.com?subject=kb).

## References

[935497](https://support.microsoft.com/help/935497) Error message on a Windows Vista-based or Windows Server 2008-based computer that does not have a parallel port: "The Parallel port driver service failed to start"
