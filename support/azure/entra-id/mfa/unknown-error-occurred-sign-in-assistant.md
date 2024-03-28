---
title: Error (An unknown error occurred with the Microsoft Online Services Sign-in Assistant) when you run the Azure Active Directory Sync Tool Configuration Wizard
description: Describes an error that you receive when you run the Azure Active Directory Sync Tool Configuration Wizard. Provides a resolution.
ms.date: 06/22/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: authentication
---
# Error when you run the Azure Active Directory Sync Tool Configuration Wizard: An unknown error occurred with the Microsoft Online Services Sign-in Assistant

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2502710

## Symptoms

When you run the Microsoft Azure Active Directory Sync Tool Configuration Wizard, you receive the following error message:

> An unknown error occurred with the Microsoft Online Services Sign-in Assistant. Contact Support.

## Resolution

To resolve this issue, follow these steps:

1. Select **Start**, type `appwiz.cpl` , and then press **Enter** to open the **Programs and Features** item in **Control Panel**.
2. Uninstall the Microsoft Online Services Sign-In Assistant.
3. Uninstall the Azure Active Directory Sync tool.
4. Reinstall the Azure Active Directory Sync tool. For more information about how to do this, go to [Install or upgrade the Directory Sync tool](https://technet.microsoft.com/library/jj151800.aspx).
5. Check whether the issue is resolved. If the error still occurs after you follow steps 1 through 4, make sure that the Microsoft Online Services Sign-In Assistant service is started. To do this, follow these steps:

   1. Select **Start**, type `services.msc`, and then press **Enter**.
   2. In the list of services, make sure that the entry in the **Status** column for **Microsoft Online Services Sign-In Assistant** is **Started**.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
