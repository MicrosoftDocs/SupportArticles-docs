---
title: Use the SQLIOSim utility on Linux
description: This article describes how to use SQLIOSim utility to simulate SQL Server activity on a disk subsystem on Linux.
author: aartig13
ms.author: aartigoyle
ms.reviewer: amitkh, dansha, rafidl, sureshka, randolphwest, jopilov
ms.date: 04/08/2025
ms.topic: how-to
ms.custom: sap:SQL Server Management, Query and Data Tools, linux-related-content
---
# Use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem on Linux

_Applies to:_ SQL Server 2022 on Linux, SQL Server 2019 on Linux

## Introduction

This article describes the SQLIOSim tool. You can use this tool to perform reliability and integrity tests on disk subsystems for SQL Server on Linux and container platforms. These tests simulate read, write, checkpoint, backup, sort, and read-ahead activities for SQL Server on Linux.

The SQLIOSim tool was first written for and released on the Windows platform. SQLIOSim has a dependency on the SQLPAL platform, which enables the execution of the Windows SQLIOSim utility on Linux.

## Supported platforms

| Platform | File system | Installation guide
| --- | --- | --- |
| Red Hat Enterprise Linux 7.9, or 8.x Server | XFS or EXT4 | [Red Hat installation guide](/sql/linux/quickstart-install-connect-red-hat) |
| SUSE Enterprise Linux Server v12 (SP4 - SP5), or v15 (SP1 - SP4) | XFS or EXT4 | [SUSE Linux Enterprise Server installation guide](/sql/linux/quickstart-install-connect-suse) |
| Ubuntu 18.04 LTS, 20.04 LTS | XFS or EXT4 | [Ubuntu installation guide](/sql/linux/quickstart-install-connect-ubuntu) |
| Docker Engine 1.8+ on Windows, macOS, or Linux | N/A | [Run SQL Server container images with Docker guide](/sql/linux/quickstart-install-connect-docker) |

## SQLIOSim on Linux installation instructions

To install SQLIOSim, follow the steps relevant to the Linux distribution the host machine is running.

### [Red Hat Enterprise Linux (RHEL)](#tab/rhel)

1. Use the following commands to add the repository:

   - For RHEL 7:

     - SQL Server 2019:

       ```bash
       sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2019.repo
       ```

   - For RHEL 8:

     - SQL Server 2019:

       ```bash
       sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/mssql-server-2019.repo
       ```

     - SQL Server 2022:

       ```bash
       sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/mssql-server-2022.repo
       ```

1. After you've added the repository, run the installation with the following commands:

   1. Switch to the root user:

      ```bash
      sudo su
      ```

   1. Set the environment variable `ACCEPT_EULA` to `y`, to accept the End-User License Agreement:

      ```bash
      export ACCEPT_SQLIOSIM_EULA=y
      ```

   1. Install SQLIOSim:

      ```bash
      yum install mssql-server-sqliosim
      ```

### [SUSE Linux Enterprise Server (SLES)](#tab/sles)

1. Add the repository:

   - For SLES v12:

     - SQL Server 2019:

       ```bash
       sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/mssql-server-2019.repo
       ```

   - For SLES v15:

     - SQL Server 2019:

       ```bash
       sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/15/mssql-server-2019.repo
       ```

     - SQL Server 2022:

       ```bash
       sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/15/mssql-server-2022.repo
       ```

1. Refresh the repository:

   ```bash
   sudo zypper --gpg-auto-import-keys refresh
   ```

1. Download Microsoft signing key:

   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   ```

1. Now, run the installation using the following commands:

   1. Switch to the root user:

      ```bash
      sudo su
      ```

   1. Set the environment variable `ACCEPT_EULA` to `y`, to accept the End-User License Agreement:

      ```bash
      export ACCEPT_SQLIOSIM_EULA=y
      ```

   1. Install SQLIOSim:

      ```bash
      zypper install mssql-server-sqliosim
      ```

### [Ubuntu](#tab/ubuntu)

1. Import the public repository GPG keys:

   ```bash
   wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add
   ```

1. Add the repository:

   - For Ubuntu 18.04:

     - SQL Server 2019:

       ```bash
       sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"
       ```

   - For Ubuntu 20.04:

     - SQL Server 2019:

       ```bash
       sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)"
       ```

     - SQL Server 2022:

       ```bash
       sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
       ```

1. Run the installation using the following commands:

   1. Switch to the root user:

      ```bash
      sudo su
      ```

   1. Set the environment variable `ACCEPT_EULA` to `y`, to accept the End-User License Agreement:

      ```bash
      export ACCEPT_SQLIOSIM_EULA=y
      ```

   1. Install SQLIOSim:

      ```bash
      apt-get install mssql-server-sqliosim
      ```

---

## Run SQLIOSim as a non-root user across all distributions

Non-root users can't install SQLIOSim but can run it. To run SQLIOSim as a non-root user, add the non-root user to the "sqliosim" group. In this example, replace `<account_to_add>` with the account you wish to add.

```bash
sudo usermod -a -G sqliosim <account_to_add>
```

Sign out and sign back in with the same user credentials to ensure that group permissions take effect.

Now, you're ready to run SQLIOSim:

```bash
/opt/mssql-sqliosim/bin/sqliosim -cfg /tmp/sqliosim.default.cfg.ini -dir /tmp -log /tmp/sqliosim_log.xml
```

## SQLIOSim configuration file

Sample configuration files for various tests can be downloaded from SQL Server support team's [GitHub repository](https://github.com/microsoft/mssql-support/tree/master/sqliosim/sqliosim.cfg.linux).

```bash
wget https://raw.githubusercontent.com/microsoft/mssql-support/master/sqliosim/sqliosim.cfg.linux/sqliosim.default.cfg.ini -P /tmp
wget https://raw.githubusercontent.com/microsoft/mssql-support/master/sqliosim/sqliosim.cfg.linux/sqliosim.hwcache.cfg.ini -P /tmp
wget https://raw.githubusercontent.com/microsoft/mssql-support/master/sqliosim/sqliosim.cfg.linux/sqliosim.nothrottle.cfg.ini -P /tmp
wget https://raw.githubusercontent.com/microsoft/mssql-support/master/sqliosim/sqliosim.cfg.linux/sqliosim.seqwrites.cfg.ini -P /tmp
wget https://raw.githubusercontent.com/microsoft/mssql-support/master/sqliosim/sqliosim.cfg.linux/sqliosim.sparse.cfg.ini -P /tmp
```

> [!NOTE]  
> `/tmp` is an example path. Change it to your own path.

### Sample command to run SQLIOSim with the default.ini file

```bash
/opt/mssql-sqliosim/bin/sqliosim -cfg /tmp/sqliosim.default.cfg.ini -dir /tmp -log /tmp/sqliosim_log.xml
```

For more information about various configuration parameters for configuration files and how to run SQLIOSim, see [Use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem](sqliosim-utility-simulate-activity-disk-subsystem.md). The article applies to SQLIOSim for Linux ecosystems as well.
