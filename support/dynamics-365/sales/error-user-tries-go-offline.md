---
title: Error when a user tries to go offline
description: This article provides a resolution for the problem that occurs when you try to go offline in the Microsoft Dynamics CRM Client for Outlook.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "An error occurred during deleting database" error when a user tries to go offline in the Microsoft Dynamics CRM Client for Outlook

This article helps you resolve the problem that occurs when you try to go offline in the Microsoft Dynamics CRM Client for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2496443

## Symptoms

Consider the following scenario:

- A client computer is used by more than one user or is used in a Terminal Server or Citrix environment.
- A user goes offline. Then, a second user clicks **Go Offline**.

In this scenario, the second user cannot go offline. In fact, no other users can go offline. Additionally, you receive the following error message:

> An error occurred during deleting database. Contact your Microsoft Dynamics CRM administrator for assistance and try going offline again.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Cause

Only one user can be configured to go offline in the Microsoft Dynamics CRM Client for Microsoft Office Outlook.

## Resolution

This behavior is by design. In Microsoft Dynamics CRM 2011, you can install and then configure the Microsoft Dynamics CRM Client for Outlook. Then, you can install the offline components by clicking the **Go Offline** button.

If you do not want users to be able to click the **Go Offline** button, you can use one of the following options.

- Option 1

    Remove the Go Offline permissions for the users whom you do not want to be able to see the **Go Offline** button. To do this, follow these steps:

    1. For a user who has permissions to change a CRM Security Role, click **Settings**, click **Administration**, and then click **Security Roles**.
    2. Click to open the Security Role that you have to change. (For example, click **Sales Manager**)
    3. Click the **Business Management** tab, and then click to clear the **Go Offline** check box in the **Miscellaneous Privileges** section.
    4. Click **Save,** and then click **Close**.

       > [!NOTE]
       > It may take 5 minutes or more before the button disappears on the client toolbar if the client is already configured.

- Option 2

    Disable the **Go Offline** button for all users on each computer, and then install the Microsoft Dynamics CRM Client for Outlook together by using the `disableofflinecapability` switch. To do this, follow these steps:

    1. Click **Start**, click **Run**, and then type the path of the Setupclient.exe file.

    2. se the `/disableofflinecapability` switch to install the Microsoft Dynamics CRM Client for Outlook. (For example, use the `C:\Client\i386\SetupClient.exe/disableofflinecapability` command.)

    3. Click **Install Now** or use the `/q` switch to do a quiet installation without user prompts.

- Option 3

    > [!WARNING]
    > Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

    If you have already installed the Microsoft Dynamics CRM Client for Outlook, you can change the LightClient registry keys so that any new users who run the configuration do not see the **Go Offline** button. To do this, follow these steps:

    1. Click **Start**, click **Run**, type *Regedit*, and then click **OK**.
    2. Locate the registry subkey: `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`.
    3. Right-click the **LightClient** registry key, and then click **Modify**.
    4. Change the **Value** to **1**, select **Decimal**, and then click **OK**.
    5. Start the Microsoft Dynamics CRM Client for Outlook.

       > [!NOTE]
       > It may take 5 minutes or more before the button disappears on the client toolbar if the client is already configured.

    6. Locate the registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRMClient`.

       > [!NOTE]
       > If you are using a 64-bit client computer and have a 3- bit version of Microsoft Office installed, the appropriate registry subkey is as follows:  
       > `HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\MSCRMClient`.

    7. Right-click the **LightClient** registry key, and then click **Modify**.
    8. Change the **Value** to **1**, select **Decimal**, and then click **OK**. When a new configuration is run, the **Go Offline** button will be removed.

    > [!NOTE]
    > When you change the registry entry in `HKEY_CURRENT_USER`, the change will affect only the user who is currently logged in. To apply the change to multiple users, locate their record under `HKEY_Users\`. Or, apply the key by using a Group Policy to `multiple/other users`.

## More information

If a user has already gone offline and a different user must be able to go offline on the same computer, you have to drop the database from the previous user. For more information about how to drop a SQL Express database, see [DROP DATABASE (Transact-SQL)](/sql/t-sql/statements/drop-database-transact-sql).
