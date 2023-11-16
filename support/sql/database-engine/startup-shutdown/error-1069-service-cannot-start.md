---
title: Error 1069 when starting SQL Server Service
description: Provides resolutions for the error 1069 when starting the SQL Server or the SQL Server Agent service. The resolutions for event ID 7041 and event ID 7038 are different.
ms.reviewer: jopilov, joriel, v-jayaramanp
ms.date: 08/31/2023
ms.custom: sap:Administration and Management
---

# Error 1069 occurs when you start SQL Server Service

You receive error 1069 when starting the SQL Server Service, which results in a logon failure. This article provides resolutions for error 1069 related events.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 282254

## Symptoms

When you try to restart Microsoft SQL Server or the SQL Server Agent, the service doesn't start, and you receive the following error messages, depending on how you try to start the service:

- By using the Services applet:

    > Windows could not start the SQL Server service on Local Computer.  
    Error 1069: The service did not start due to a logon failure.

- By using a command prompt:

    > System error 1069 has occurred.  
      The service did not start due to a logon failure.

You may find messages with event ID 7041 or 7038 logged in the System Event Log.

## Cause

This problem occurs because there's an issue either with the service account itself or the information that is currently saved for the service account.

## Resolution for event ID 7041

The entry with event ID 7041 in the System Event Log may contain the following error message:

> Logon failure: the user has not been granted the requested logon type at this computer.

The complete message entry in event log resembles the following one:

```output
Log Name:      System
Source:        Service Control Manager
Date:          <Datetime>
Event ID:      7041
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      <Server name>
Description:
The MSSQLSERVER service was unable to log on as NT Service\MSSQLSERVER with the currently configured password due to the following error:
Logon failure: the user has not been granted the requested logon type at this computer.

Service: MSSQLSERVER  
Domain and account: <AccountName>

This service account does not have the required user right "Log on as a service."

User Action

Assign "Log on as a service" to the service account on this computer. You can use Local Security Settings (Secpol.msc) to do this.
If this computer is a node in a cluster, check that this user right is assigned to the Cluster service account on all nodes in the cluster.

If you have already assigned this user right to the service account, and the user right appears to be removed,
check with your domain administrator to find out if a Group Policy object associated with this node might be removing the right.
```

To fix this issue, check which user rights are assigned to the SQL Server service account.

1. Start the **Local Security Policy** (Start -> Secpol.msc).
1. Expand **Local Policy** and then select **User Rights Assignment**.
1. Verify the required user rights are assigned to the service account by following the instructions in [Windows Privileges and Rights](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions#Windows). Manually assign any missing permissions.
1. Check if the service account was assigned any **Deny**\* permissions. Remove any **Deny**\* permissions from the SQL Service service account and then retest.

   For example, if the service account was assigned **[Deny log on as a service](/windows/security/threat-protection/security-policy-settings/deny-log-on-as-a-service)** `SeDenyServiceLogonRight` along with **[Log on as a service](/windows/security/threat-protection/security-policy-settings/log-on-as-a-service)** `SeServiceLogonRight`, revoke the `SeDenyServiceLogonRight` right for the logon and restart SQL Server.

## Resolution for event ID 7038

In the log entries that are event ID 7038 related, you may find the following error messages:

- [This user can't sign in because this account is currently disabled](#this-user-cant-sign-in-because-this-account-is-currently-disabled).
- [The user's password must be changed before signing in](#the-users-password-must-be-changed-before-signing-in).
- [The user name or password is incorrect](#the-user-name-or-password-is-incorrect).
- [The referenced account is currently locked out and may not be logged on to](#the-referenced-account-is-currently-locked-out-and-may-not-be-logged-on-to).
- [The specified domain either does not exist or could not be contacted](#the-specified-domain-either-does-not-exist-or-could-not-be-contacted).

### This user can't sign in because this account is currently disabled

The complete message entry in event log resembles the following one:

```output
Log Name:      System
Source:        Service Control Manager
Date:          <Datetime>
Event ID:      7038
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      <Server name>
Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:
This user can't sign in because this account is currently disabled.

To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).
```

To fix this issue, use one of the following methods based on your scenario:

- If SQL Server Startup account is a Local User Account on the computer, open ***Computer Management** (compmgmt.msc) and check if the service account is disabled in **Local Users and Groups**. If it's disabled, enable the account, and restart the SQL Server Service.

- If SQL Server Startup account is a Windows Domain Account, check whether the account is disabled in **Active Directory Users and Computers**. If it's disabled, enable the account, and restart the SQL Server Service.

### The user's password must be changed before signing in

The complete message entry in event log resembles the following one:

```output
Log Name:      System
Source:        Service Control Manager
Date:          <Datetime>
Event ID:      7038
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      <Server name>
Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:
The user's password must be changed before signing in.

To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).
```

To fix this issue, use one of the following methods based on your scenario:

- If the SQL Server Startup account is a Local User Account on the computer:

  1. Open **Computer Management** (compmgmt.msc).
  1. Select **Local Users and Groups** and then select **Users** to locate the account.
  1. Double-click on the user account to open its **Properties**.
  1. Clear the **User must change password at next logon** property for SQL Server Startup Account and press **OK**.
  1. Restart the SQL Server Service.

- If the SQL Server Startup account is a Windows Domain Account:

  1. Open **Active Directory Users and Computers** on a Domain Controller.
  1. Select **Users** under the correct domain.
  1. Double-click the domain account that's used as a SQL Server service account to open its **Properties**.
  1. Go to the **Account** tab to check if **User must change password at next logon** is enabled. If the option is enabled, either clear this option or sign in interactively to a Windows client machine, and then set a new password.
  1. If you changed the password, update the new password for the SQL Server Service by using the **SQL Server Configuration Manager** tool.

### The user name or password is incorrect

For an incorrect password issue, the complete message entry in event log resembles the following one:

```output
Log Name:      System
Source:        Service Control Manager
Date:          <Datetime>
Event ID:      7038
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      <Server name>
Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:
The user name or password is incorrect.

To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).
```

To fix this issue, follow these steps:

#### Scenario 1: Incorrect password

The error message entry indicates that the current login name or password set is incorrect. To verify and solve the issue, follow these steps:

1. Use the `runas` option to test the service account credentials:

   1. Open a Windows Command Prompt.
   1. Run the following command:

      ```console
      runas /user:<localmachine>\<SQLSerivceAccount> cmd
      ```

1. If the command succeeds, carefully type the same credentials in **SQL Server Configuration Manager**, **Services**, **SQL Server service**, and **This account**.
1. If the command fails and reports the same issue, you must reset the password for the Windows logon.
1. If the SQL Server Startup account is a Local User Account on the computer, open **Computer Management** (compmgmt.msc), and reset the password of the local user.
1. If the SQL Server Startup account is a Windows Domain Account, open **Active Directory Users and Computers**, and then update the password for the account under **Users**. After the credentials are updated, return to the **SQL Server Configuration Manager**, **Services**, **SQL Server** and enter the same credentials.
1. Restart the SQL Server service.

   To type the correct password in the SQL Server Service account on the SQL Server host computer, follow the procedures from [SCM Services - Change the Password of the Accounts Used](/sql/database-engine/configure-windows/scm-services-change-the-password-of-the-accounts-used).

#### Scenario 2: gMSA IsManagedAccount Flag is set improperly

If you're using a group Managed Service Accounts (gMSA) account to run the SQL Server Service and the `IsManagedAccount` flag for the given service is set to **false**, you may receive a Service Control Manager event ID 7038 as soon as the cached secret is invalid.

To identify and resolve the issue, follow these steps:
  
1. Verify the account you're using is a gMSA account. Proceed only after confirming gMSA.

   - If the following command succeeds against the account, you're using a gMSG account.
   - If it fails with `Cannot find an object with identity: 'account'`, the service account isn't a gMSA account.

   ```powershell
   Get-ADServiceAccount -Identity 'yourGmsaName' -Properties PasswordLastSet
   ```

   For more information, see [Check the gMSA account](/virtualization/windowscontainers/manage-containers/gmsa-troubleshooting#check-the-gmsa-account).

1. Run the following command in **Command Prompt** and check the status of `IsManagedAccount`. The desired outcome is **true**. If it is **false**, proceed further.

   ```cmd
   sc qmanagedaccount <YourSQLServiceName>
   ```

   An example for a SQL Server named instance SQLPROD:

   ```cmd
   sc qmanagedaccount MSSQL$SQLPROD
   ```

1. Set the flag to true as desired.

   ```cmd
   sc managedaccount <YourSQLServiceName> TRUE
   ```

   An example for a SQL Server named instance SQLPROD:

   ```cmd
   sc managedaccount MSSQL$SQLPROD TRUE
   ```

1. Attempt to start the service again.

#### The referenced account is currently locked out and may not be logged on to

The complete message entry in event log resembles the following one:

```output
Log Name:      System
Source:        Service Control Manager
Date:          <Datetime>
Event ID:      7038
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      <Server name>
Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:
The referenced account is currently locked out and may not be logged on to.

To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).
```

To fix this issue, use one of the following methods based on your scenario:

- If the SQL Server Startup account is a Local User Account on the computer:

  1. Open **Computer Management** (compmgmt.msc) and go to **Local Users and Groups**. Then select **Users**.
  1. Clear the **Account is Locked Out** checkbox for the SQL Server Startup Account under **Local Users and Groups** and select **OK**.
  1. Restart the SQL Server Service.

- If the SQL Server Startup account is a Windows Domain Account:

  1. Open **Active Directory Users and Computers** on the Domain controller.
  1. Under **Users**, double-click on the SQL Server startup account and go to the **Account** tab.
  1. Check if the account is marked as locked.
  1. If the account is locked, select the **Unlock account** box and select **OK**, set a strong password.
  1. Then use same credentials for the SQL Server service account configuration in **SQL Server Configuration Manager**, **Services**, and **SQL Server**.
  1. Restart the SQL Server service.

### The specified domain either does not exist or could not be contacted

The complete message entry in event log resembles the following one:

```output
Log Name:      System
Source:        Service Control Manager
Date:          <Datetime>
Event ID:      7038
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      <Server name>
Description:
The MSSQLSERVER service was unable to log on as xxx with the currently configured password due to the following error:
The specified domain either does not exist or could not be contacted.

To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).
```

To fix this issue, use one of the following methods based on your scenario:

- Configure the SQL Server startup to delayed start for particular Windows servers, which ensures other Windows services such as NetLogon complete first and SQL Server starts without problems. This is the default configuration by SQL Setup starting with SQL Server 2022.
- If the delayed start option doesn't address the issue for your scenario, an alternative option is to change the Recovery options for the SQL Server services. Specify 'Restart the service' as the action for the failure options. You can perform this option from the Services applet of Administrative Tools using the familiar Service Control Manager interfaces.
  - This option isn't recommended for SQL Failover Cluster Instances (FCIs) or Availability Groups (AGs) as setting this could result in delays during automatic failover scenarios.
- If neither of the previous options are feasible, you can configure the SQL Server service to have a dependency on the NETLOGON service using the following command in an elevated command-line console:
  
   ```cmd
   sc config <YourSQLServiceName> depend=keyiso/netlogon
   ```

   An example for a SQL Server named instance SQLPROD:

   ```cmd
   sc config MSSQL$SQLPROD depend=keyiso/netlogon
   ```
