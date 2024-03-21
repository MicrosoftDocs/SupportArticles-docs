---
title: You can't open the Azure Active Directory module for Windows PowerShell
description: Discusses that you can't open the Azure Active Directory module for Windows PowerShell because the .NET Framework 3.51 is not enabled on the computer. A resolution is provided to enable the .NET Framework 3.51.
ms.date: 06/22/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: domain-services
ms.custom:
---
# You can't open the Azure Active Directory module for Windows PowerShell

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 User and Domain Management, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2461873

## Symptoms

When you try to open the Microsoft Azure Active Directory module for Windows PowerShell, the Windows PowerShell console window opens with many text errors indicating that module packages couldn't be loaded.

## Cause

This issue occurs if you don't have the Microsoft .NET Framework 3.51 enabled on your computer.

## Resolution

To resolve this issue, manually enable the .NET Framework 3.51. To do this, follow these steps, as appropriate for the operating system that you're running:

**In Windows 2008 R2**:

1. Open **Server Manager**.
2. Select **Features**, select **Add Features**, select **.NET Framework 3.51 Features**, and then select **.NET Framework 3.51**.

**In Windows 7**:

1. Open **Programs and Features**.
2. Select **Turn Windows features on or off**.
3. Select to select the **Microsoft NET Framework 3.51** check box, and then select **OK**.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
