---
title: Upgrade System Center 2012 Configuration Manager to SP1
description: Describes steps to upgrade System Center 2012 Configuration Manager to System Center 2012 Configuration Manager Service Pack 1.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi
---
# How to upgrade System Center 2012 Configuration Manager to SP1

This article provides steps to upgrade System Center 2012 Configuration Manager to System Center 2012 Configuration Manager Service Pack 1 (SP1).

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2801416

## Introduction

Upgrading a prerelease version of System Center 2012 Configuration Manager SP1 to System Center 2012 Configuration Manager SP1 isn't supported. If you have a prerelease version of System Center 2012 Configuration Manager SP1 installed, uninstall that version before you install System Center 2012 Configuration Manager SP1. For more information, see [Release Notes for System Center 2012 Configuration Manager Service Pack 1](/previous-versions/system-center/system-center-2012-R2/jj739872(v=technet.10)?redirectedfrom=MSDN).

If your Configuration Manager deployment consists of a hierarchy of sites, upgrade the sites from the top of the hierarchy. That is, upgrade the sites in the following order:

1. Central administration site
2. Primary site
3. Secondary site

> [!NOTE]
> You can upgrade the secondary site by using the Configuration Manager console.

## Step 1: Review the upgrade checklist

For more information about upgrade planning and the Configuration Manager SP1 upgrade checklist, see [Planning to Upgrade System Center 2012 Configuration Manager](/previous-versions/system-center/system-center-2012-R2/jj822981(v=technet.10)?redirectedfrom=MSDN).

## Step 2: Uninstall Windows Automated Installation Kit (AIK)

We recommend that you uninstall Windows AIK. This is because Windows Assessment and Deployment Kit (ADK) and Windows AIK should not coexist on the same computer.

## Step 3: Download and install Windows ADK

You must download and install Windows ADK before you run the System Center 2012 Configuration Manager SP1 setup. Windows ADK must be installed on the site server and on any server that is running the SMS Provider.

To download Windows ADK, go to [Download and install the Windows ADK](/windows-hardware/get-started/adk-install).

When you run the Windows ADK setup, select the following features:

- Deployment Tools
- Windows Preinstallation Environment (Windows PE)
- User State Migration Tool (USMT)

> [!NOTE]
> These features are needed to pass the System Center 2012 Configuration Manager SP1 prerequisite check.

## Step 4: Download and install Windows Management Framework 3.0

System Center 2012 Configuration Manager SP1 requires Windows PowerShell 3.0. If you are not running Windows Server 2012, you must download and install [Windows Management Framework (WMF) 3.0](https://www.microsoft.com/download/details.aspx?id=34595).

## Step 5: Make sure that your version of Microsoft SQL Server is supported

Make sure that you have the appropriate SQL Server Service Pack or cumulative update installed. For more information about SQL Server versions that are supported by System Center 2012 Configuration Manager, see [Supported Configurations for Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg682077(v=technet.10)?redirectedfrom=MSDN#bkmk_supconfigsqldbconfig).

> [!NOTE]
> SQL Server 2012 SP1 is supported.

### Step 6: Install System Center 2012 Configuration Manager SP1

Run the System Center 2012 Configuration Manager SP1 setup, and make sure that you select the upgrade option to upgrade the site.
