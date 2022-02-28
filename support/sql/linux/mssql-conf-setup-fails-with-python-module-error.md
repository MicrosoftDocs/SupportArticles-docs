---
title: mssql-conf setup fails with python module error
description: This article helps you to troubleshoot version  the python requirement for SQL on Linux and the workaround if you are using a lower python version while configuring SQL Server on Linux.
ms.date: 02/27/2022
ms.custom: sap:SQL Server 2019 on Linux 
ms.technology: 
ms.reviewer: 
ms.topic: article
ms.prod: sql 
---

# mssql-conf setup fails with python module error

This article helps you resolve the mssql-conf setup with python module error. It also  describes the python requirement for SQL on Linux and the workaround if you are experiencing lower python version while configure SQL Server on Linux.

_Applies to: SQL Server 2019 on Linux  
_Original KB number:

## Symptoms

You try to run the `mssql-conf` setup after installing SQL Server 2019. In this scenario, you might see the error "module object has no attribute 'run'", if you are using a Python version lower than 3.5.

Consider the following scenario:

1. Install the SQL Server on Linux by reviewing [installation guidance for SQL Server on Linux](/sql/linux/sql-server-linux-setup?view=sql-server-ver15&preserve-view=true).  

1. Run the `/opt/mssql/bin/mssql-conf` setup. You might experience a module dependency.

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
You may receive the following error even after you fix the 'typing' module dependency issue:

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
> The mssql-conf setup error may occur on systems with Microsoft SQL Server on Linux supported platform (RHEL, SLES, Ubuntu) whose Python 3 version is lower than 3.5. For SQL Server on Linux supported platform, see [Supported platform](/sql/linux/sql-server-linux-setup?view=sql-server-ver15&preserve-view=true).

## Cause

The error occurs because the version of SQL Server and mssql-conf code rely on the Python 3.5+ functions.

## Workaround

You have two options for resolving this issue:

- Upgrade the system's Python 3 to a version greater than 3.5. Set the system so that when you run the command `/usr/bin/env python3 -V`, it points to Python 3.5+. It is observed that some system functions that rely on Python versions lower than 3.5 stop working. To avoid this problem, use the next option.

- You could create a symlink in your session that points python3 to python3.5+ and then run `mssql-conf` commands to configure SQL Server. For more information, see [Create symlink (Soft link) of Python 3](#create-symlink-soft-link-of-python-3).

## Create symlink (Soft link) of Python 3

Use the following steps to create a session-specific symlink where Python 3 points to a Python 3.5 or greater version and then run `mssql-conf`.

1. Install Python 3.5 or a greater version. In this case, install Python 3.6.

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

1. Switch to root user and then create the symlink in any folder, and then add the current path to `$PATH`. For example, the `/usr/bin/env python3 -V` points to Python 3.6 instead of Python 3.4 as shown in the following code snippet:

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

1. Now run the `mssql-conf` setup or any other mssql-conf based commands under the above session:

     ```bash
     /opt/mssql/bin/mssql-conf setup
     ```

1. In future, if you want to run the `mssql-conf` command to configure SQL Server, switch to the root user as shown in step 4. Then, run the command `PATH=$(pwd):$PATH`, which adds the current path to the `$PATH` environment variable and then execute the `mssql-conf` command as shown in step 4.

## See also

Since python 3.4 has already EOL (End of Life) and will no longer receive security updates, as documented in this article [Python | endoflife.date](https://endoflife.date/python), we suggest you to use a supported newer version of Python.