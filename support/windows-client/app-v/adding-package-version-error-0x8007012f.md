---
title: Adding a package version in Microsoft Application Virtualization returns error 0x8007012F
description: This article describes the steps to take if error 0x8007012F is returned when adding an App-V v5 package.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: pfreitas
---
# Adding a package version in Microsoft Application Virtualization returns error 0x8007012F

_Original product version:_ &nbsp; App-V 5.0 for Remote Desktop Services, App-V 5.0 for Windows Desktops  
_Original KB number:_ &nbsp; 2780304

## Summary

Removing and then adding the same package version in the Microsoft Application Virtualization console fails and returns error 0x8007012F.

## More Information

When an App-V v5 package version is added, the package files are created in %programdata%\App-V\{PackagID}\{VersionId} . When the package version is removed the package files in %programdata%\App-V are also removed. Any files that the App-V v5 client is unable to remove are marked for deletion at the next system restart.

If all of the package version files were successfully removed then the same package version can be added immediately without a system restart, however if any of the files could not be removed then adding the same package version that was just deleted returns error 0x8007012F. This is by design.

To work around this issue, reboot the computer before adding the same package version again. The system restart will complete the removal of the package version after which the same package version can be successfully added again.

This scenario is most likely to occur in a test environment as in production there's no reason to remove a package version and then add the same package version again. However, if this were to occur in production and if a system restart cannot be performed, there is an alternative workaround that does not require a system restart. As an alternative, you can create a new version of the same package. To do this, open the package in the Sequencer and then save it. The new package version will not be affected by the partially deleted state of the prior version and so it can be added without restarting the system.

> [!NOTE]
>  If this problem occurs in a full infrastructure scenario then at the next "Refresh" this error will be logged in the App-V Client Admin event log.
