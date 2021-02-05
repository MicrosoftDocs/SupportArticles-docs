---
title: Error when password for service account is changed
description: This article provides a resolution for the problem that occurs when the password for the SQL Server service account is changed.
ms.date: 10/29/2020
ms.prod-support-area-path: Administration and Management
ms.prod: sql
---
# Logon failure and SQL Server service does not start

When you try to restart Microsoft SQL Server or the SQL Server Agent, the service doesn’t start, and you receive the following error message, depending on how you try to start the service:

- By using the Services applet:
  
    > `Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.`  
    `Error 1069: The service did not start due to a logon failure.`

- By using a command prompt:

    > `System error 1069 has occurred.`  
      `The service did not start due to a logon failure.`

This problem occurs because there is an issue either with the service account itself or the information that is currently saved for the service account.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 282254

## Prerequisites

To use this troubleshooter, open the System event log, and note the Event ID and description of the event that’s associated with the failure. Then, use the following information to resolve the problem.  

## Event ID: 7041, Logon failure: the user has not been granted the requested logon type at this computer

The complete message entry in event log should resemble the following:

>`Log Name:      System`  
`Source:        Service Control Manager`  
`Date:          <Datetime>`  
`Event ID:      7041`  
`Task Category: None`  
`Level:         Error`  
`Keywords:      Classic`  
`User:          N/A`  
`Computer:      <Server name>`  
`Description:
The MSSQLSERVER service was unable to log on as NT Service\MSSQLSERVER with the currently configured password due to the following error:  
Logon failure: the user has not been granted the requested logon type at this computer.`
>
> `Service: MSSQLSERVER`  
`Domain and account: <Account name>`
>
> `This service account does not have the required user right "Log on as a service."`
>
> `User Action`
>
> `Assign "Log on as a service" to the service account on this computer. You can use Local Security Settings (Secpol.msc) to do this. If this computer is a node in a cluster, check that this user right is assigned to the Cluster service account on all nodes in the cluster.`
>
> `If you have already assigned this user right to the service account, and the user right appears to be removed, check with your domain administrator to find out if a Group Policy object associated with this node might be removing the right.`

**User Action**

Check which permissions are assigned to the \<Account Name> service account using Local Security Settings (Secpol.msc).

1. Verify these rights per the Server permissions. For more information, see [Windows Privileges and Rights](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions#Windows). Manually assign any missing permissions.

1. Review the service account to learn whether it was assigned any Deny* permissions. Remove any Deny* permissions from the SQL Service service account and then retest.  For example, if the service account was assigned Deny Service Logon `SeDenyServiceLogonRight` along with `SeServiceLogonRight`, revoke the `SeDenyServiceLogonRight` right for the logon and restart SQL Server.

## Event ID: 7038, This user can't sign in because this account is currently disabled

The complete message entry in event log should resemble the following:

> `Log Name:      System`  
`Source:        Service Control Manager`  
`Date:          <Datetime>`  
`Event ID:      7038`  
`Task Category: None`  
`Level:         Error`  
`Keywords:      Classic`  
`User:          N/A`  
`Computer:      <Server name>`  
`Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:  
This user can't sign in because this account is currently disabled.`  
>
> `To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).`

**User action**

1. If SQL Server Startup account is a Local User Account on the computer, open Computer Management (compmgmt.msc) and verify that the service account is disabled in **Local Users & Groups**. If it is disabled, enable the account and restart the SQL Server service.

1. If SQL Server Startup account is a Windows Domain Account, check whether the account is disabled in Active Directory Users and Computers. If it is disabled, enable the account, and restart the SQL Server service.

## Event ID: 7038, The user's password must be changed before signing in

The complete message entry in event log should resemble the following:

> `Log Name:      System`  
`Source:        Service Control Manager`  
`Date:          <Datetime>`  
`Event ID:      7038`  
`Task Category: None`  
`Level:         Error`  
`Keywords:      Classic`  
`User:          N/A`  
`Computer:      <Server name>`  
`Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:  
The user's password must be changed before signing in.`  
>  
> `To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).`

**User action**

1. If the SQL Server Startup account is a Local User Account on the computer, open Computer Management (compmgmt.msc) and clear the **User Must change the password at next logon** property for SQL Server Startup Account under **Local Users & Groups**. Then, select **OK**, and restart the SQL Server service.

1. If the SQL Server Startup account is a Windows Domain Account, open Active Directory Users and Computers, and then verify that the SQL Server Startup Account has the User **Must change the password at next logon** property enabled.

1. If the property in step 2 is enabled, you must either clear this option or log in interactively to a Windows client, and then set a new password, then, update the new password for the SQL Server Service by using the SQL Server Configuration Manager tool.

## Event ID: 7038, The user name or password is incorrect

The complete message entry in event log should resemble the following:

> `Log Name:      System`  
`Source:        Service Control Manager`  
`Date:          <Datetime>`  
`Event ID:      7038`  
`Task Category: None`  
`Level:         Error`  
`Keywords:      Classic`  
`User:          N/A`  
`Computer:      <Server name>`  
`Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:  
The user name or password is incorrect.`  
>
> `To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).`

**User action**

1. The error message entry indicates that the current login name or password set is incorrect. To verify the same, you can use the Run-As Windows option to open a Windows Command Prompt window, and then provide the same credentials. If that works without any issues, carefully type the credentials in SQL Server Configuration Manager.

1. If step 1 fails and reports the same issue, you must reset the password for the Windows logon. If the SQL Server Startup account is a Local User Account on the computer, open Computer Management (compmgmt.msc), and reset the password of the local user. If the SQL Server Startup account is a Windows Domain Account, open Active Directory Users and Computers, and then change the credentials. After the credentials are updated, return to SQL Server Configuration Manager, enter the same credentials, and then start the service.

Type the correct password in the SQL Server service account on the SQL Server host computer. To do this, follow the procedures from [SCM Services - Change the Password of the Accounts Used](/sql/database-engine/configure-windows/scm-services-change-the-password-of-the-accounts-used).

## Event ID: 7038, The referenced account is currently locked out and may not be logged on to

The complete message entry in event log should resemble the following:

> `Log Name:      System`  
`Source:        Service Control Manager`  
`Date:          <Datetime>`  
`Event ID:      7038`  
`Task Category: None`  
`Level:         Error`  
`Keywords:      Classic`  
`User:          N/A`  
`Computer:      <Server name>`  
`Description:
The MSSQLSERVER service was unable to log on as .\sqlsrvlogin with the currently configured password due to the following error:  
The referenced account is currently locked out and may not be logged on to.`  
>
> `To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).`

**User action**

1. If SQL Server Startup account is a Local User Account on the computer, open Computer Management (compmgmt.msc), and clear the **Account is Locked Out** checkbox for the SQL Server Startup Account under **Local Users & Groups**. Then, select **OK**, and restart the SQL Server service.

1. If SQL Server Startup account is a Windows Domain Account, open Active Directory Users and Computers, and verify that the SQL Server Startup Account has the **Account is Locked Out** property enabled.

1. If the property in step 2 is enabled, you must clear this option, set a strong password, and use the same credentials for the SQL Server Startup Account configuration by using SQL Server Configuration Manager.
