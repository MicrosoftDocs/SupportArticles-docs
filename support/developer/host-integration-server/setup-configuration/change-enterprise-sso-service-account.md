---
title: Change Enterprise SSO service account
description: This article introduces how to change the Enterprise Single Sign-On service account that is configured to run on the master secret server in HIS and BizTalk Server.
ms.date: 05/11/2020
ms.custom: sap:HIS Setup and Configuration
ms.topic: how-to
---
# Change the Enterprise SSO service account that runs on the master secret server in HIS and BizTalk Server

This article describes steps to change the Enterprise SSO service account that is configured to run on the master secret server in Microsoft Host Integration Server and Microsoft BizTalk Server.

_Original product version:_ &nbsp; BizTalk Server, Host Integration Server  
_Original KB number:_ &nbsp; 884205

## Determine the server that contains the master secret

You must follow these steps only on the Enterprise SSO server that contains the master secret. To determine the server that contains the master secret, follow these steps:

1. Open a Command Prompt window. To do this, select **Start**, type *cmd*, and then press Enter.
2. At the command prompt, change to the Enterprise SSO installation folder, and then type `ssomanage -displaydb`.

> [!NOTE]
> By default, the installation folder for the Enterprise SSO service is `<Drive>:\Program Files\Common Files\Enterprise Single Sign-On`. In this folder name, \<Drive> is the disk drive that contains the Enterprise Single Sign-On directory.

## Change the Enterprise SSO service account

To change the Enterprise SSO service account that is configured to run on the master secret server, follow these steps:

1. Back up the master secret server. To do this, follow these steps:

    1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
    2. At the command prompt, change to the Enterprise Single Sign-On installation directory.

        > [!NOTE]
        > By default, the installation directory is `<Drive>:\Program Files\Common Files\Enterprise Single Sign-On`.
  
    3. At the command prompt, type `ssoconfig -backupsecret <BackupFile>`.

        > [!NOTE]
        > In this command, \<BackupFile> is the path of and the name of the file to which the master secret will be backed up. For example, `D:\Ssobackup.bak`.

    4. Provide a password to help protect this Backup file. You will be prompted to confirm the password and to provide a password hint to help you remember this password.

        > [!IMPORTANT]
        > You must save and store the backup file in a security-enhanced location.

2. At the command prompt, type `net stop entsso` to stop the SSO service.
3. In Control Panel, open **Administrative Tools**, and then double-click **Services**.
4. Right-click the **Enterprise Single Sign-On** service entry, and then select **Properties**.
5. On the **Log On** tab, change the account and the password to the values that you want, and then select **OK**.

    > [!NOTE]
    > This account must be a member of the SSO Administrators group. If it is not, add the account to the SSO Administrators group.

6. Start the Enterprise SSO service.

    After you start the Enterprise SSO service, an error message is logged in the application log on the master secret server. This log entry resembles the following:

    > The secret could not be loaded from the registry. The service account for the SSO service may have been changed or the secret may be corrupted. Restore the secret from a backup file.

    This error message will be resolved when you restore the master secret.

7. Restore the master secret. To do this, follow these steps:

    1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
    2. At the command prompt, change to the Enterprise Single Sign-On installation directory.

        > [!NOTE]  
        > By default, the installation directory is `<Drive>:\Program Files\Common Files\Enterprise Single Sign-On`.

    3. At the command prompt, type `ssoconfig -restoresecret <BackupFile>`.

        > [!NOTE]
        > In this command, \<BackupFile> represents the path of and the name of the backup file.

After you restore the master secret, an informational message about the successful restoration is logged in the application log on the master secret server.

## References

For information about how to change accounts and passwords for other service accounts in BizTalk Server, see [How to Change Service Accounts and Passwords](/biztalk/core/how-to-change-service-accounts-and-passwords).

## Applies to

This article applies to the following products:

- BizTalk Server 2016 Enterprise
- BizTalk Server 2013 R2 Enterprise
- BizTalk Server 2013 Enterprise
- BizTalk Server Enterprise 2010
- Host Integration Server 2016
- Host Integration Server 2013
- Host Integration Server 2010
