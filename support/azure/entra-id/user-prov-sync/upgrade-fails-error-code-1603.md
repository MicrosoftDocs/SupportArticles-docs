---
title: Microsoft Entra Connect upgrade fails with error code 1603
description: Error code 1603 and (Unable to install the synchronization service) error in event log when trying to upgrade Microsoft Entra Connect.
ms.date: 07/20/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: users
---
# Error when upgrading Microsoft Entra Connect: Unable to install the synchronization service

_Original product version:_ &nbsp; Office 365 Identity Management, Microsoft Entra ID  
_Original KB number:_ &nbsp; 4054462

## Symptoms

When you try to upgrade Microsoft Entra Connect, you receive the following error message:

> An Error occurred while Upgrading from Azure Active Directory Sync. Unable to upgrade the Synchronization Service. Please see the Event log for additional details.

The detailed event log resembles the following:

> Date/Time[ 12] [INFO ] ServiceControllerProvider: StartService status: Running
Date/Time[ 12] [ERROR] Error during sync engine upgrade. System.Exception: Unable to upgrade the Synchronization Service. Please see the event log for additional details. ---> Microsoft.Azure.ActiveDirectory.Client.Framework.ProcessExecutionFailedException: Error installing msi package 'Synchronization Service.msi'. Full log is available at 'C:\ProgramData\AADConnect\Synchronization Service_Install-DateTime.log'.
>
> Action startTime: DetectServiceAccount.
CustomAction DetectServiceAccount returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)
Action endedTime: DetectServiceAccount. Return value 3.
Action endedTime: INSTALL. Return value 3.
MSI (s) (14:AC)Time: Note: 1: 1708
MSI (s) (14:AC)Time: Product: Microsoft Entra Connect synchronization services -- Installation operation failed.
MSI (s) (14:AC)Time: Windows Installer installed the product. Product Name: Microsoft Entra Connect synchronization services. Product Version: 1.1.614.0. Product Language: 1033. Manufacturer: Microsoft Corporation. Installation success or error status: 1603.
MSI (s) (14:AC)Time: Deferring clean up of packages/files, if any exist
MSI (s) (14:AC)Time: MainEngineThread is returning 1603
MSI (s) (14:80)Time: RESTART MANAGER: Session closed.

## Cause

The underlying service account was configured by using the user principal name (UPN) instead of Domain\SamAccountName.

## Resolution

To resolve this issue, follow these steps:

1. Start the Service Console on the Microsoft Entra Connect server.
2. Locate the **Microsoft Azure AD Sync** service, and then right-click the service.
3. Select **Properties**, and then select **Logons**.
4. Set the account by using Domain\SamAccountName instead of using the UPN.
5. Select **Apply** and **OK**.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
