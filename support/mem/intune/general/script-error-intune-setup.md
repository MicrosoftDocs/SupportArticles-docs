---
title: Script error during Intune setup process in Configuration Manager
description: Fixes an issue in which you receive script error when you set up Microsoft Intune in Configuration Manager.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
---
# Wizard generates a script error when you configure a Microsoft Intune subscription in Configuration Manager

This article helps you fix an issue in which you receive a script error during the Intune setup process in Configuration Manager.

## Symptom

When you try to log in during the Microsoft Intune setup process in Configuration Manager, you receive the following error message:

> Script Error  
> An error has occurred in the script on this page Unable to get property 'Content' of undefined or null reference

## Cause

This issue can occur if the login account is authorized for Delegated Administration on multiple subscriptions. Currently, the multi-account console isn't supported during Microsoft Intune setup on Configuration Manager.

## Solution

To fix this issue, use a Global Administrator account that doesn't have Delegated Administration permissions.
