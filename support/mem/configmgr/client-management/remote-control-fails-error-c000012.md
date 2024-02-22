---
title: Remote control fails with error C000012
description: Fixes an issue in which remote control fails with error C0000120 in System Center 2012 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi
---
# Remote control fails with error C000012 in System Center 2012 Configuration Manager

This article helps you resolve an issue in which remote control fails with error C0000120 in System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2716965

## Symptoms

When attempting to use System Center 2012 Configuration Manager to remote control a system, the connection fails. The remote control log and CmRcService.log indicate the following failure:  

> WT_CompleteIO failed. Network shutdown : Unknown error (Error: C0000120; Source: Unknown)

## Cause

Certain **User Configurations** for Remote Desktop Gateway block the remote control session from successfully connecting. The **User Configuration** settings are:

- Enable connection through RD Gateway: **Enabled**

  - Allow users to change this setting: **Enabled**

- Set RD Gateway authentication method: **Enabled**

  - Allow users to change this setting: **Enabled**
  - Set RD Gateway authentication method: **Use locally logged-on credentials**

- Set RD Gateway server address: **Enabled**

  - Allow users to change this setting: **Enabled**
  - Set RD Gateway server address: Enter a generic fully qualified domain name (FQDN)

## Resolution

To resolve this issue, either do not configure **User Configuration** settings for Remote Desktop Gateway (leaving them as **Not Configured** as opposed to **Enabled**) or specify the RDS Gateway settings as part of the Remote Desktop Connection client user interface in the .rdp file.
