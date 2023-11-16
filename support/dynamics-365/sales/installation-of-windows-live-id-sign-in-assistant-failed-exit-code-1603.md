---
title: Installation of Windows Live ID Sign-in Assistant failed error when installing
description: This article describes how to troubleshoot an installation issue with the Windows Live ID Sign-In Assistant that is a pre-requisite of the Microsoft Dynamics CRM 2011 client for Outlook.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Installation of Windows Live ID Sign-in Assistant failed Exit code 1603 when installing Microsoft Dynamics CRM 2011 client for Outlook

This article provides a resolution for the error **Installation of Windows Live ID Sign-in Assistant failed** that occurs when installing Microsoft Dynamics CRM 2011 client for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2549386

## Symptoms

During the process of installing the prerequisites for the Microsoft Dynamics CRM 2011 client for Outlook, the Windows Live ID Sign-in Assistant installation fails, causing the Microsoft Dynamics CRM 2011 client for Outlook installation to end prematurely. Examination of the crm50setup.log file will report the following error message:

> Installation of Windows Live ID Sign-in Assistant failed. Exit code: 1603. Result: Fatal error during installation.

## Cause

On some systems, the Windows Live ID Sign-in Assistant install will fail if an additional installation parameter is not specified. By default, the Microsoft Dynamics CRM 2011 client for Outlook does not specify this additional parameter.

## Resolution

To resolve the issue, perform the following steps:

1. Download the Windows Live ID Sign-in Assistant and save it to a folder on the local hard drive.
2. Go to **Start** > **Programs** > **Accessories** > **Command Prompt**.
3. Type in `cd c:\<folder name>`. `<folder name>` is the location where you downloaded the Assistant to.
4. Type in `Msiexec /i wllogin_32.msi /l*v C:\setupLogs.log NOMU=1`.
5. Once the Windows Live ID Sign-in Assistant installation is complete, start the installation of the Microsoft Dynamics CRM 2011 client for Outlook again.
