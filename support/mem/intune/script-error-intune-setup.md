---
title: Script error during Intune setup process
description: Fixes an issue in which you receive script error during Intune setup process in Configuration Manager.
ms.date: 01/19/2021
ms.prod-support-area-path: 
---
# Wizard generates a script error when you configure a Microsoft Intune subscription in Configuration Manager

This article helps you fix an issue in which you receive a script error during Intune setup process in Configuration Manager.

_Original product version:_ &nbsp; Microsoft Intune, Configuration Manager  
_Original KB number:_ &nbsp; 3117659

## Symptom

When you try to log in during the Microsoft Intune setup process in Configuration Manager, you receive the following error message:

> Script Error  
> An error has occurred in the script on this page Unable to get property 'Content' of undefined or null reference

## Cause

This issue may occur if the login account is authorized for Delegated Administration on multiple subscriptions. Currently the multi-account console isn't supported during Microsoft Intune setup on Configuration Manager.

## Resolution

To fix this issue, use a Global Administrator account that doesn't have Delegated Administration permissions.
