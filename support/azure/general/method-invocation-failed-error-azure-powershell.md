---
title: Method invocation failed error when you run Azure PowerShell cmdlets
description: Describes how to to resolve the "System.Object[] doesn't contain a method named RemoveAll" error in Azure PowerShell
author: genlin
ms.author: genli
ms.service: azure-powershell
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# "Method invocation failed" error when you run Azure PowerShell cmdlets

_Original product version:_ &nbsp; Azure Active Directory, Cloud Services (Web roles/Worker roles)  
_Original KB number:_ &nbsp; 3072418

## Symptoms

When you run Windows Azure PowerShell cmdlets, you receive an error message that resembles the following message:

Method invocation failed because [System.Object[]] doesn't contain a method named 'RemoveAll'.

## Cause

This problem occurs for either of the following reasons:
- You are using an outdated version of Azure PowerShell.
- You are using a method name that does not exist.

## Resolution

To resolve this problem, do either of the following:
- Install the latest version of Azure PowerShell. To upgrade the program, go to the following Azure website:

[How to install and configure Azure PowerShell](https://azure.microsoft.com/documentation/articles/powershell-install-configure/) 

- Make sure that you are using the correct method name.
