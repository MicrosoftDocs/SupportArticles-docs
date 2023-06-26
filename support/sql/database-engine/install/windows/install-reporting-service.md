---
title: Install SQL Server 2008 Reporting services
description: This article introduces that how to install SQL Server 2008 X64 and SQL Server 2008 Reporting services X86 side by side on Windows 2008 X64.
ms.date: 07/22/2020
ms.custom: sap:Installation, Patching and Upgrade
ms.topic: how-to
---
# Install SQL Server 2008 X64 and SQL Server 2008 Reporting services X86 side by side on Windows 2008 X64

This article shows how to install SQL Server 2008 x64 and SQL Server 2008 Reporting services X86 side by side on Windows 2008 X64.

_Original product version:_ &nbsp; Microsoft SQL Server  
_Original KB number:_ &nbsp; 2000404

## Symptoms

Consider the following scenario:

You run a Windows 2008 server that is running x64 version of SQL Server 2008 database engine component.
In this scenario, if you try to install x86 version of the SQL Server 2008 Reporting services component by using 'Add features to existing instance of SQL Server 2008', the setup program will report the following error message in the Installation Rules page.

|Rule|Status|
|---|---|
|Same architecture installation|Failed|
  
If you click on the **Failed** status, you will see the following message:

> Rule "same architecture installation" failed.  
The CPU architecture of installing feature(s) is different than the instance specified. To continue, add features to this instance with the same architecture.

## Cause

The behavior is by design. When you chose the option to add features to the existing instance the `Same architecture installation` rule checks whether the features that are being added are of the same CPU architecture as existing features for that instance, and if they are not, it blocks the installation. In other words, you cannot install a 64-bit version of one component (like Database engine) and a 32-bit version of another component (like Reporting services) for the same instance of SQL server.

## Resolution

Use the following procedure to install 32-bit edition of Reporting services component:

1. Launch SQL Server Installation Center by running setup.exe from the installation media.
2. In the **Options** section, select the **Processor type** as x86.
3. In the Installation section, select **New SQL Server Stand alone installation or add features to an existing installation**.
4. On the **Installation Type** screen during the setup process, select **Perform a new instance of SQL Server 2008** and continue with the setup to do a [Files-Only Installation (Reporting Services)](/sql/reporting-services/install-windows/files-only-installation-reporting-services) installation of reporting services instance and configure the same at a later stage using Reporting services Configuration manager.
