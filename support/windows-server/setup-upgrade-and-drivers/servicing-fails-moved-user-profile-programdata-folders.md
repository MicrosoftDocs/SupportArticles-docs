---
title: Windows servicing operations fail after you move user profile or ProgramData folders
description: Describes an issue in which upgrade or servicing operations fail after you move the user profile folders or the ProgramData folder to a drive other than the system drive. 
ms.date: 04/23/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, kimberj, v-appelgatet
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Windows servicing operations fail after you move user profile or ProgramData folders

## Summary

In Windows Server and Windows Client, moving the user profile folders or the ProgramData folder to a drive other than the system drive can cause servicing issues. In some cases, updates, hotfixes, service packs, or upgrades don't install correctly.

Microsoft recommends that the user profile folders and the ProgramData folder remain in their default locations. Only move the folder if a supported and validated deployment scenario specifically requires you to move them.

If the folders are moved and you encounter servicing issues, review that configuration as a possible cause.

> [!NOTE]  
> Older Windows Server and Windows Client versions are more likely to experience servicing and upgrade issues in this situation. Newer versions provide better support in some scenarios, depending on the particular folder locations and the method that you use to deploy updates.

## More information

You might want to move the user profile folders or the ProgramData folder to a drive other than the system drive for reasons such as the following examples:

- Simplify backup of user data
- Separate user data from the operating system
- Reduce demand for disk space on the system drive
- Optimize storage layout

Although these goals are valid, moving these folders can cause servicing issues. Some Windows servicing components expect these folders to remain on the system drive. When these folders reside on a different volume, servicing behavior can become unreliable. This behavior might prevent the following components from installing:

- Security updates
- Monthly quality updates
- Hotfixes
- Service packs
- In-place upgrades (particularly on older versions of Windows Server and Windows Client)
