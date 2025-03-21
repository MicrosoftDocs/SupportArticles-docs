---
title: SSIS package does not run when called from a job step
description: This article provides resolutions for the problem that occurs when you call an SSIS package from a SQL Server Agent job step.
ms.date: 03/21/2025
ms.custom: sap:Integration Services
ms.reviewer: craigg
---
# SSIS package does not run when called from a SQL Server Agent job step

This article helps you resolve the problem that occurs when you call an SSIS package from a SQL Server Agent job step.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 918760

## Symptoms

When you call a Microsoft SQL Server Integration Services (SSIS) package from a SQL Server Agent job step, the SSIS package does not run. However, if you do not modify the SSIS package, it will run successfully outside SQL Server Agent.

## Resolution

To resolve this problem, use one of the following methods. The most appropriate method depends on the environment and the reason that the package failed. Reasons that the package may have failed are as follows:

- The user account that is used to run the package under SQL Server Agent differs from the original package author.
- The user account does not have the required permissions to make connections or to access resources outside the SSIS package.

The package may not run in the following scenarios:

- The current user cannot decrypt secrets from the package. This scenario can occur if the current account or the execution account differs from the original package author, and the package's ProtectionLevel property setting does not let the current user decrypt secrets in the package.
- A SQL Server connection that uses integrated security fails because the current user does not have the required permissions.
- File access fails because the current user does not have the required permissions to write to the file share that the connection manager accesses. For example, this scenario can occur with text log providers that do not use a login and a password. This scenario can also occur with any task that depends on the file connection manager, such as a SSIS file system task.
- A registry-based SSIS package configuration uses the `HKEY_CURRENT_USER` registry keys. The `HKEY_CURRENT_USER` registry keys are user-specific.
- A task or a connection manager requires that the current user account has correct permissions.

To resolve the issue, use following methods:

- Method 1: Use a SQL Server Agent proxy account.
    Create a SQL Server Agent proxy account. This proxy account must use a credential that lets SQL Server Agent run the job as the account that created the package or as an account that has the required permissions.

    This method works to decrypt secrets and satisfies the key requirements by user. However, this method may have limited success because the SSIS package user keys involve the current user and the current computer. Therefore, if you move the package to another computer, this method may still fail, even if the job step uses the correct proxy account.

- Method 2: Set the SSIS Package `ProtectionLevel` property to ServerStorage.
    Change the SSIS Package ProtectionLevel  property to ServerStorage. This setting stores the package in a SQL Server database and allows for access control through SQL Server database roles.

- Method 3: Set the SSIS Package `ProtectionLevel` property to `EncryptSensitiveWithPassword`.
    Change the SSIS Package `ProtectionLevel` property to `EncryptSensitiveWithPassword`. This setting uses a password for encryption. You can then modify the SQL Server Agent job step command line to include this password.

- Method 4: Use SSIS Package configuration files.
    Use SSIS Package configuration files to store sensitive information, and then store these configuration files in a secured folder. You can then change the `ProtectionLevel` property to `DontSaveSensitive` so that the package is not encrypted and does not try to save secrets to the package. When you run the SSIS package, the required information is loaded from the configuration file. Make sure that the configuration files are adequately protected if they contain sensitive information.

- Method 5: Create a package template.
    For a long-term resolution, create a package template that uses a protection level that differs from the default setting. This problem will not occur in future packages.

## Steps to reproduce the problem

1. Log in as a user who is not part of the SQLServerSQLAgentUser group. For example, you can create a local user.
2. Create an SSIS package, and then add an ExecuteSQL task. Use an OLE DB connection manager to the local msdb file by using the following string: `'Windows Authentication' -SQLSourceType: "Direct Input" -SQLStatement: "sp_who"`.
3. Run the package to make sure that it runs successfully.
4. The `ProtectionLevel` property is set to `EncryptSensitiveWithPassword`.
5. Create a SQL Server Agent job and a job step. In the **Run As** list, click **SQL Server Agent Service** to run the job step. The text in the SQL Server Agent Job History displays information that resembles the following:

## Decrypt package secrets

The default setting for the SSIS package `ProtectionLevel` property is `EncryptSensitiveWithUserKey`. When the package is saved, SSIS encrypts only the parts of the package that contain properties that are marked `sensitive`, such as passwords, usernames, and connection strings. Therefore, when the package is reloaded, the current user must satisfy the encryption requirements for the `sensitive` properties to be decrypted. However, the current user does not have to satisfy the encryption requirements to load the package. When you run the package through a SQL Server Agent job step, the default account is the SQL Server Agent Service account. This default account is most likely a different user than the package author. Therefore, the SQL Server Agent job step can load and start to run the job step, but the package fails because it cannot complete a connection. For example, the package cannot complete an OLE DB connection or an FTP connection. The package fails because it cannot decrypt the credentials that it must have to connect.

> [!IMPORTANT]
> Consider the development process and the environment to determine which accounts are needed and used on each computer. The EncryptSensitiveWithUserKey setting of the `ProtectionLevel` property is a powerful setting. This setting should not be discounted because it causes deployment complications at first. You can encrypt the packages when you are logged in to the appropriate account. You can also use the Dtutil.exe SSIS command prompt utility to change the protection levels by using a .cmd file and the SQL Server Agent command subsystem. For example, follow these steps. Because you can use the Dtutil.exe utility in batch files and loops, you can follow these steps for several packages at the same time.

1. Modify the package that you want to encrypt by using a password.
2. Use the Dtutil.exe utility through an **Operating System (cmd Exec)** SQL Server Agent job step to change the `ProtectionLevel` property to `EncryptSensitiveWithUserKey`. This process involves decrypting the package by using the password, and then re-encrypting the package. The user key that is used to encrypt the package is the SQL Server Agent job step setting in the **Run As** list.

    > [!NOTE]
    > Because the key includes the user name and the computer name, the effect of moving the packages to another computer may be limited.

## Make sure that you have detailed error information about the SSIS package failure

Instead of relying on the limited details in the SQL Server Agent Job History, you can use SSIS logging to make sure that you have error information about the SSIS package failure. You can also run the package by using the exec subsystem command instead of the SSIS subsystem command.

### About SSIS logging

SSIS logging and log providers let you capture details about the package execution and failures. By default, the package does not log information. You must configure the package to log information. When you configure the package to log information, detailed information is displayed that resembles the following. In this case, you will know that it is a permissions issue:

```output
OnError,DOMAINNAME,DOMAINNAME\USERNAME,FTP Task,{C73DE41C-D0A6-450A-BB94-DF6D913797A1},{2F0AF5AF-2FFD-4928-88EE-1B58EB431D74},4/28/2006 1:51:59 PM,4/28/2006 1:51:59 PM,-1073573489,0x,Unable to connect to FTP server using "FTP Connection Manager".
```

```output
OnError,DOMAINNAME,DOMAINNAME\USERNAME,Execute SQL Task,{C6C7286D-57D4-4490-B12D-AC9867AE5762},{F5761A49-F2F9-4575-9E2B-B3D381D6E1F3},4/28/2006 4:07:00 PM,4/28/2006 4:07:00 PM,-1073573396,0x,Failed to acquire connection "user01.msdb". Connection may not be configured correctly or you may not have the right permissions on this connection.
```

### About the exec subsystem command and output information

By using the exec subsystem command approach, you add verbose console logging switches to the SSIS command line to call the Dtexec.exe SSIS command-line executable file. Additionally, you use the Advanced job feature of the output file. You can also use the **Include Step Output in the history** option to redirect the logging information to a file or to the SQL Server Agent Job History.

Here's an example of a command line:

```console
 dtexec.exe /FILE "C:\_work\SSISPackages\ProtectionLevelTest\ProtectionLevelTest\AgentTesting.dtsx" /MAXCONCURRENT " -1 " /CHECKPOINTING OFF /REPORTING V /CONSOLELOG NCOSGXMT
```

The console logging returns details that resemble the following messages:

```output
Error: 2006-04-27 18:13:34.76 Code: 0xC0202009 Source: AgentTesting Connection manager "(local).msdb" Description: An OLE DB error has occurred. Error code: 0x80040E4D. An OLE DB record is available. Source: "Microsoft SQL Native Client" Hresult: 0x80040E4D Description: "Login failed for user 'DOMAINNAME\username'.". End Error
```

```output
Error: 2006-04-28 13:51:59.19 Code: 0xC0016016 Source: Description: Failed to decrypt protected XML node "DTS:Property" with error 0x80070002 "The system cannot find the file specified.". You may not be authorized to access this information. This error occurs when there is a cryptographic error. Verify that the correct key is available. End Error
```

```output
Log: Name: OnError Computer: COMPUTERNAME Operator: DOMAINNAME\username Source Name: Execute SQL Task Source GUID: {C6C7286D-57D4-4490-B12D-AC9867AE5762} Execution GUID: {7AFE3D9E-5F73-42F0-86FE-5EFE264119C8} Message: Failed to acquire connection "(local).msdb". Connection may not be configured correctly or you may not have the right permissions on this connection. Start Time: 2006-04-27 18:13:34 End Time: 2006-04-27 18:13:34 End Log
```

## References

- For more information about a similar problem, see [You receive an 'Error loading' error message when you try to run a SQL Server Integration Services package](../integration-services/error-loading-message-run-integration-services-package.md).
- [Connectivity error 0x80004005 occurs when you run an SSIS package as a SQL Agent job](../database-engine/connect/sql-server-faces-connectivity-issue-ssispack-fail.md).
- For more information about how to create package templates, see [Create a package in SQL Server Data Tools using the Package Template](/sql/integration-services/create-packages-in-sql-server-data-tools#create-a-package-in-sql-server-data-tools-using-the-package-template).
- For more information about SSIS package security and the `ProtectionLevel` property, see [Protection Level Setting and the SSISDB Catalog](/sql/integration-services/security/access-control-for-sensitive-data-in-packages#protection-level-setting-and-the-ssisdb-catalog).