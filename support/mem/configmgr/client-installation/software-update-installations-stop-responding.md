---
title: Software update installations stop responding
description: Describes an issue that software update installations stop responding in Configuration Manager current branch version 1810 and 1806.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Operations\CcmExec Service crashes or does not start
---
# Update installations to clients stop responding in Configuration Manager

This article describes an issue that software update installations stop responding in Configuration Manager current branch version 1810 and 1806.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1806), Configuration Manager (current branch - version 1810)  
_Original KB number:_ &nbsp; 4491117

## Symptoms

After you install Configuration Manager current branch version 1810 or 1806 to clients, software update installations stop responding until the SMS Agent Host is restarted. The symptoms of this issue vary. The most common symptoms include the following:

- Folders are created in \%SystemRoot%\ccmcache for the new content. However, none (or only some) of the updates are downloaded to these folders.

- **DataTransferService** jobs are created and completed. However, ContentTransferManager logs don't indicate that they were notified that the downloads were completed.

- Software center may show that updates are being installed and that some have a pending restart. Also, the **Programs and Features** > **View Installed Updates** item in Control Panel shows that the updates installed completely. However, the updates never actually finish.

- For Operating System Deployment (OSD) scenarios, the task sequence stops responding on the **Install Software Updates** step.

This issue occurs most frequently on Windows 10, version 1709. However, other versions of Windows are also affected.

## Resolution

To resolve this issue for Configuration Manager, see [Update installations stop responding or never show completion in Configuration Manager, version 1810](https://support.microsoft.com/help/4490575).

## Workaround

To work around this issue for Configuration Manager current branch version 1806, restart the SMS Agent Host service (Ccmexec.exe).
