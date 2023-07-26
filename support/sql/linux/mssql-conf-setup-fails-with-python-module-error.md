---
title: mssql-conf setup fails with Python module error
description: This article helps you resolve the mssql-conf setup fails with Python module error. 
ms.date: 03/14/2022
ms.custom: sap:SQL Server 2019 on Linux 
author: ronking-zhu
ms.author: roz
ms.reviewer: rl-msft, v-jayaramanp
ms.topic: troubleshooting
---

# "Module object has no attribute run" error in mssql-conf setup using Python module

This article helps you to resolve an error that occurs when you try to run `mssql-conf` setup by using the Python module. This article also describes the Python requirements for Microsoft SQL Server on Linux, and provides a workaround if you're using an early Python version when you try to configure SQL Server on Linux.

_Applies to_: SQL Server 2019 on Linux  

## Symptoms

When you try to run `mssql-conf` setup after you install Microsoft SQL Server 2019, you receive a "module object has no attribute run" error message if you're using a Python version that's earlier than 3.5.

Consider the following scenarios:

- You install SQL Server on Linux by following the steps in [Installation guidance for SQL Server on Linux](/sql/linux/sql-server-linux-setup?view=sql-server-ver15&preserve-view=true).  

- You try to run `/opt/mssql/bin/mssql-conf` setup. However, you experience a module dependency:

``` bash
testslesvm2:~ # /opt/mssql/bin/mssql-conf setup
Traceback (most recent call last):
  File "/opt/mssql/bin/../lib/mssql-conf/mssql-conf.py", line 17, in <module>
    import mssqlad
  File "/opt/mssql/lib/mssql-conf/mssqlad.py", line 15, in <module>
    import pyadutil
  File "/opt/mssql/lib/mssql-conf/pyadutil.py", line 6, in <module>
    import typing
ImportError: No module named 'typing'
```

You might also receive the following error message even after you fix the "typing" module dependency issue:

```bash
testslesvm2:~ # /opt/mssql/bin/mssql-conf setup
Warning: could not create log file for mssql-conf at /var/opt/mssql/log/mssql-conf/mssql-conf.log.
Traceback (most recent call last):
  File "/opt/mssql/bin/../lib/mssql-conf/mssql-conf.py", line 597, in <module>
    main()
  File "/opt/mssql/bin/../lib/mssql-conf/mssql-conf.py", line 593, in main
    processCommands()
  File "/opt/mssql/bin/../lib/mssql-conf/mssql-conf.py", line 310, in processCommands
    COMMAND_TABLE[args.which]()
  File "/opt/mssql/bin/../lib/mssql-conf/mssql-conf.py", line 93, in handleSetup
    mssqlconfhelper.setupSqlServer(eulaAccepted, noprompt=args.noprompt)
  File "/opt/mssql/lib/mssql-conf/mssqlconfhelper.py", line 964, in setupSqlServer
    if not checkInstall():
  File "/opt/mssql/lib/mssql-conf/mssqlconfhelper.py", line 934, in checkInstall
    return runScript(checkInstallScript, runAsRoot) == 0
  File "/opt/mssql/lib/mssql-conf/mssqlconfhelper.py", line 915, in runScript
    process = subprocess.run([pathToScript], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
AttributeError: 'module' object has no attribute 'run'
```

> [!NOTE]
> The `mssql-conf` setup error can occur on systems on which the Microsoft SQL Server on Linux supported platform (RHEL, SLES, Ubuntu) includes Python 3 or another version that is earlier than 3.5. For more information about SQL Server on Linux-supported platforms, see [Supported platform](/sql/linux/sql-server-linux-setup?view=sql-server-ver15&preserve-view=true#supportedplatforms).

## Cause

The error occurs because SQL Server 2019 and `mssql-conf` code rely on the Python 3.5+ functions.

## Workaround

You have two options to work around this issue:

- Upgrade Python 3 to 3.5 or a later version. Set the system so that when you run the `/usr/bin/env python3 -V` command, it points to Python 3.5 or 3.5+.

   **Note:** We have observed that some system functions that rely on Python versions that are earlier than 3.5 stop working after this upgrade. To avoid this problem, use the next option.

- Create a symlink in your session that points Python 3 to Python 3.5 or 3.5+, and then run the `mssql-conf` commands to configure SQL Server. For more information, see the next section.

## Create symlink (soft link) of Python 3

Follow these steps to create a session-specific symlink in which Python 3 points to Python 3.5 or a later version, and then run the `mssql-conf` setup.

1. Install Python 3.5 or a later version. In this example, install Python 3.6:

    ```bash
    zypper in python36
    ```

1. Install SQL Server.

    ```bash
    sudo zypper addrepo -fc https://packages.microsoft.com/config/sles/12/mssql-server-2019.repo
    sudo zypper --gpg-auto-import-keys refresh
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo zypper install -y mssql-server
    ```

1. Switch to the root user, create the symlink in any folder, and then add the current path to `$PATH`. For example, the */usr/bin/env python3 -V* symlink points to Python 3.6 instead of Python 3.4, as shown in the following code snippet:

    ```bash
    $sudo su
    testslesvm2:~ #:> sudo ln -s /usr/bin/python3.6 python3
    testslesvm2:~ # > PATH=$(pwd):$PATH
    testslesvm2:~ # ll
    total 4
    -rw------- 1 root root 982 Feb  9 20:03 .bash_history
    drwx------ 2 root root 111 Jan 26 08:50 .gnupg
    drwx------ 2 root root  29 Feb  9 19:27 .ssh
    drwxr-xr-x 2 root root   6 Jun 27  2017 bin
    lrwxrwxrwx 1 root root  18 Feb  9 19:47 python3 -> /usr/bin/python3.6
    testslesvm2:~ # /usr/bin/env python3 -V
    Python 3.6.15
    ```

1. Run the `mssql-conf` setup or any other `mssql-conf`-based commands:

     ```bash
     /opt/mssql/bin/mssql-conf setup
     ```

1. If you want to run the `mssql-conf` command in future to configure SQL Server, switch to the root user, and then run the `PATH=$(pwd):$PATH` command to add the current path to the `$PATH` environment variable. Then, run the `mssql-conf` command, as shown in step 4.

## See also

Because Python 3.4 has already reached its EOL (end of life) status and will no longer receive security updates, we recommend that you use a supported, newer version of Python. For more information, see [Python | endoflife.date](https://endoflife.date/python).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
