---
title: Use the SQLIOSim utility on Linux
description: This article describes how to use SQLIOSim utility to simulate SQL Server activity on a disk subsystem on Linux.
ms.date: 06/16/2021
ms.custom: sap:Other tools
ms.reviewer: amitkh, dansha, rafidl, Suresh.Kandoth
ms.topic: how-to
ms.prod: sql
author: HaiyingYu
ms.author: haiyingyu
---
# Use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem on Linux

_Applies to:_ SQL Server 2019 on Linux, SQL Server 2017 on Linux

## Introduction

This article describes the SQLIOSim tool. You can use this tool to perform reliability and integrity tests on disk subsystems for SQL Server on Linux and container platforms. These tests simulate read, write, checkpoint, backup, sort, and read-ahead activities for SQL Server on Linux.

The SQLIOSim tool was first written for and released on the Windows platform. SQLIOSim has a dependency on SQLPAL platform, which enables the execution of the Windows SQLIOSim utility on Linux.

## Supported platforms

| Platform | File system | Installation guide
|---|---|---|
|Red Hat Enterprise Linux 7.9, or 8.0 - 8.3 Server|XFS or EXT4|[Red Hat installation guide](/sql/linux/quickstart-install-connect-red-hat)|
|SUSE Enterprise Linux Server v12 SP4 - SP5|XFS or EXT4|[SUSE Linux Enterprise Server installation guide](/sql/linux/quickstart-install-connect-suse)|
|Ubuntu 18.04 LTS, 20.04 LTS|XFS or EXT4|[Ubuntu installation guide](/sql/linux/quickstart-install-connect-ubuntu)|
|Docker Engine 1.8+ on Windows, Mac, or Linux|N/A|[Run SQL Server container images with Docker guide](/sql/linux/quickstart-install-connect-docker)|

## SQLIOSim on Linux installation instructions

To install SQLIOSim, follow the steps relevant to the Linux distribution the host machine is running.

### Red Hat Enterprise Linux (RHEL)

1. Use the commands below to add the repository:

   - For RHEL 7:

     `sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/prod.repo`.
   - For RHEL 8:

     `sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/prod.repo`.

1. After you've added the repository, run the installation with the commands listed below:

    ```bash
    # Switch to root user
    sudo su 
    # Set the environment variable ACCEPT_EULA to 'yes' this is to accept the Preview EULA.
    export ACCEPT_SQLIOSIM_EULA=y
    # Now you are ready to install SQLIOSim using the command:
    yum install mssql-server-sqliosim
    ```

### SUSE Linux Enterprise Server (SLES)

1. Add the repository using the command: `sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/prod.repo`.
2. To refresh the repository, run the command: `sudo zypper --gpg-auto-import-keys refresh`.
3. Download Microsoft signing key using the command: `sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc`.
4. Now, run the installation using the following commands:

    ```bash
    # Switch to root user
    sudo su
    # Set the environment variable ACCEPT_EULA to 'yes' this is to accept the Preview EULA
    export ACCEPT_SQLIOSIM_EULA=y
    # Run the installation using the following command:
    zypper install mssql-server-sqliosim
    ```

### Ubuntu

1. Import the public repository GPG keys: `wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add`.
1. Use the commands below to add the repository:

   - For Ubuntu 18.04:

     `sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/prod.list)"`.
   - For Ubuntu 20.04:

     `sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"`.

1. Run the installation using the following commands:

    ```bash
    # Switch to root user
    sudo su
    # Set the environment variable ACCEPT_EULA to 'yes' this is to accept the Preview EULA
    export ACCEPT_SQLIOSIM_EULA=y
    # Run the installation using the following command:
    apt-get install mssql-server-sqliosim
    ```

## Run SQLIOSim as a non-root user across all distributions

Non-root users can't install SQLIOSim but can run it. To run SQLIOSim as a non-root user, add the non-root user to the "sqliosim" group.

```bash
# Add your account to the sqliosim group, by default during the installation of the SQLIOSim the group
# "sqliosim" is created and the group is made the owner of the /var/opt/mssql-sqliosim directory.

sudo usermod -a -G sqliosim <accounttoadd>
```

> [!NOTE]
> Log out and log back in with the same user credentials to ensure that group permissions take effect.

Now, you are ready to run SQLIOSim using the command:

`/opt/mssql-sqliosim/bin/sqliosim -cfg /tmp/sqliosim.default.cfg.ini -dir /tmp -log /tmp/sqliosim_log.xml`

## SQLIOSim configuration file

Sample configuration files for various tests can be downloaded from SQL Server support team's [github repo](https://github.com/microsoft/mssql-support/tree/master/sqliosim/sqliosim.cfg.linux).

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

`/opt/mssql-sqliosim/bin/sqliosim -cfg /tmp/sqliosim.default.cfg.ini -dir /tmp -log /tmp/sqliosim_log.xml`

> [!NOTE]
> When you run SQLIOSim in the current release, you'll see an evaluation message similar to "This is an evaluation version. There are [140] days left in the evaluation period." This will be removed in the next CU release.

For more information about various configuration parameters for configuration files and how to run SQLIOSim, see [Use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem](sqliosim-utility-simulate-activity-disk-subsystem.md). The article applies to SQLIOSim for Linux ecosystems as well.
