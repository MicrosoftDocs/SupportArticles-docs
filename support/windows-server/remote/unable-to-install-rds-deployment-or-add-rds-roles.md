---
title: Unable to Install RDS Deployment or Add RDS Roles
description: Helps troubleshoot issues related to the installation of RDS roles.
ms.date: 04/17/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: warrenw
ms.custom:
- sap:remote desktop services and terminal services\deployment,configuration,and management of remote desktop services infrastructure
- pcy:WinComm User Experience
---
# Unable to install RDS deployment or add RDS roles

This article helps troubleshoot issues related to the installation of Remote Desktop Services (RDS) roles. The issue occurs when deploying a brand new RDS deployment or manually adding roles to a system or a currently existing RDS deployment.

There are several possible causes, different possible behaviors, and error messages. This article addresses some of those common reasons.

## Verify whether TLS 1.0 is disabled on the system

> [!NOTE]
> This specific issue applies only to Windows Server 2016 and earlier versions. From Windows Server 2019 and later versions, the RD Connection Broker role can communicate with the Windows Internal Database (WID) using higher Transport Layer Security (TLS) versions, such as TLS 1.2.

### Symptoms

Assume that you use the inbox WID in Windows Server. If you disable TLS 1.0 when you configure security settings, you experience the following issues:

* The RD Connection Broker role can't be installed.
* The RDS service fails.
* An existing RDS deployment that uses RD Connection Broker and WID fails.
* The Remote Desktop Management service (RDMS) doesn't start.
* You receive the following error message when you try to start RDMS:

  > The Remote Desktop Management service on Local Computer started and then stopped. Some services stop automatically if they are not in use by other services or programs.

### Cause

This behavior is expected because of the current dependencies between RDS and WID. RDMS and Connection Broker depend on TLS 1.0 to authenticate with the database. WID doesn't currently support TLS 1.2. So, disabling TLS 1.0 breaks this communication.

> [!NOTE]
> RDS deployments that use Connection Broker must establish an encrypted channel to WID by using one of the following methods:
>
> * TLS
> * SSL 3.0
> * FIPS

### Resolution

To fix this issue, use one of the following methods:

* Don't disable TLS 1.0 on a single Connection Broker deployment.
* Configure a high availability Connection Broker deployment that uses a dedicated SQL Server.
* Upgrade the computers that run the RDS service to Windows Server 2019.

> [!NOTE]
> Microsoft has released [TLS 1.2 support for Microsoft SQL Server](../../sql/database-engine/connect/tls-1-2-support-microsoft-sql-server.md) to enable SQL Server communications to use TLS 1.2.

## Connection Broker role fails to install due to "Logon as a service" permissions being removed for service accounts 

When you try to install the RD Connection Broker role, the installation fails with the following error:

> Unable to install RD Connection Broker role service on server \<ServerName\> - Failed.

This is commonly due to the fact that the object "NT SERVICE\ALL SERVICES" has been removed from the **Logon as a service** security policy, or there's another policy denying the **Logon as a service** privilege to the corresponding service account.

You might also see the following error event in the System event log:

```output
Log Name: System  
Source: Service Control Manager  
Date: mm/dd/yyyy hh:mm:ss pp  
Event ID: 7041  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: MyServer.com  
Description:  
The MSSQL$MICROSOFT##WID service was unable to log on as NT SERVICE\MSSQL$MICROSOFT##WID with the currently configured password due to the following error:  
Logon failure: the user has not been granted the requested logon type at this computer.  

Service: MSSQL$MICROSOFT##WID
Domain and account: NT SERVICE\MSSQL$MICROSOFT##WID

This service account does not have the required user right "Log on as a service."

User Action

Assign "Log on as a service" to the service account on this computer. You can use Local Security Settings (Secpol.msc) to do this. If this computer is a node in a cluster, check that this user right is assigned to the Cluster service account on all nodes in the cluster.

If you have already assigned this user right to the service account, and the user right appears to be removed, check with your domain administrator to find out if a Group Policy object associated with this node might be removing the right.
```

### Resolution

Add the "NT SERVICE\ALL SERVICES" group back to the **Log on as a service** security policy. Also, confirm that this group or another service account object (such as Network service) isn't part of the **Deny logon as a service** security policy.

If it still fails after the preceding conditions are met, try adding the service account "NT SERVICE\MSSQL$MICROSOFT##WID" to the **Logon as a service** security policy.

## Issues related to WinRM

Server Manager, RDMS UI (Remote Desktop Management Services User Interface), and RDS PowerShell cmdlets heavily rely on WinRM to operate.

If the issue is related to Server Manager or RDMS UI not operating properly, you might eventually face a WinRM-related issue.

* A common reason is having a proxy set on the system's WinHTTP interface. You can check this by running the following command in an elevated command prompt:

  ```console
  netsh winhttp show proxy
  ```

  If a proxy is configured, you can remove it by using the following command:

  ```console
  netsh wintthp reset proxy
  ```
  
  Alternatively, set exclusions using the following command (we recommend removing the proxy first for testing purposes. Use the preceding steps to confirm the proxy is indeed the cause of the issue):

  For example:

  ```console
  set proxy proxy-server="http=<proxy>;https=<sproxy>:88" bypass-list="\*.contoso.com"
  ```

* You can also check if the system has any WinRM-related Group Policy Objects (GPOs) configured under the following path. It can also be a good test to temporarily remove them for testing purposes.

  **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Windows Remote Management (WinRM)**

* Finally, you can look in the Event Viewer for potential WinRM problematic events under:

  **Applications and Services Logs** > **Microsoft** > **Windows** > **Windows Remote Management** > **Operational**

## Fails to add RD Session Host to a session collection or create a new collection

Adding an RD Session Host to a collection might fail. You might receive different error messages. Usually, the error message starts with "Unable to add the RD Session Host to the collection…" followed by a more descriptive sentence of the underlying reason.

This behavior can be caused by different reasons. Here are some possible causes:

* WinRM-related reasons, as described in previous sections of this article.
* The RD Session Host has existing GPOs configured, especially RDS-related ones, which prevent the deployment from overriding the desired settings. To resolve this issue, temporarily remove the GPOs, add the RD Session Host to the deployment or collection, and then reapply the desired GPOs.

  The error message might vary. Commonly, the error message can be "Unable to configure the RD Session Host Server \<ServerName\>. Invalid Operation."

  > [!NOTE]
  > Here's a list of common GPOS that might cause this behavior, but we recommend removing any RDS-related GPOs and testing:
  >
  > * **Require user authentication for remote connections by using Network Level Authentication**
  > * **Set client connection encryption level**
  > * **Use the specified Remote Desktop license servers**
  >
  > Paths to the preceding GPOs:
  >
  > * **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Security**
  > * **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing**

* If you receive an error message that contains "Some or all identity references could not be translated" while adding an RD Session Host to a collection, this typically indicates issues with resolving the SID(s) of groups that are part of the permission list of the Session Collection.

  There can be various reasons for issues resolving the SID. We recommend that you contact Microsoft Support for a detailed analysis of the situation. To confirm this issue (or temporarily work around it), you can test by gradually removing groups of users from the Session Collection permission list until you identify the group(s) causing the behavior.

* The error message "Unable to connect to the server by using Windows PowerShell Remoting" can be due to different reasons, but a possible cause is that the environment variousariables have been changed or are incorrectly configured.

  To fix this issue, follow these steps:
  
  1. run the `sysdm.cpl` command.
  2. In the **System Properties** window, select the **Advanced** tab, and then select **Environment Variables**.
  3. Under **System variables**, select **Path** > **Edit**.

  You might have several environment variables, and this can vary according to each system, but make sure the following ones are present and correctly configured:

  * **%SystemRoot%\\system32**
  * **%SystemRoot%**
  * **%SystemRoot%\\system32\\Wbem**
  * **%SYSTEMROOT%\\System32\\WindowsPowerShell\\v1.0\\**
  * **%SYSTEMROOT%\\System32\\OpenSSH\\**
