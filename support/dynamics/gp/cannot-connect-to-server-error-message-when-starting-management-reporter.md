---
title: Can't connect to the Management Reporter server error when starting Microsoft Management Reporter 2012
description: Describes an error you may receive when you start Microsoft Management Reporter 2012. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Management Reporter
---
# "Can't connect to the Management Reporter server" error when you start Microsoft Management Reporter 2012

This article provides a resolution for the error message that may occur when you start Microsoft Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2862020

## Symptoms

When you start Microsoft Management Reporter 2012 (MR 2012), you receive one of the following error messages:

> A connection to the server could not be established.  Check the server address and try again or contact your system administrator.

> Can't connect to the Management Reporter server.  Do you want to specify a different server address?

To troubleshoot Management Reporter connection problems, you need to select **OK** to this message, and then select **Test Connection** to get another error message. You also need to go to Event Viewer to get additional information on the error. In Event Viewer, select **Windows Logs** and select **Application**. Under the **Source** column, look for Management Reporter Report Designer or Management Reporter Services.

Here's a list of errors received when you select **Test Connection** and the possible associated error(s) seen in Event Viewer. Find your error in the list and use the appropriate Cause and Resolution sections.

- > Connection attempt failed. There is a version mismatch between the client and the server. Contact your system administrator.
  - See [Cause 1: Management Reporter's version is different](#cause-1-management-reporters-version-is-different)
- > Connection attempt failed. User does not have appropriate permissions to connect to the server. Contact your system administrator.
  - See [Cause 2: User isn't set up in Management Reporter](#cause-2-user-isnt-set-up-in-management-reporter)
- > A connection to the server could not be established. Check the server address and try again or contact your system administrator.

  > [!NOTE]
  > Servername is a placeholder for your actual server name and 4712 is a placeholder for the actual port selected during the Management Reporter installation. If you check the Event Viewer, you may find the following error messages:

  > Message: System.ServiceModel.Security.SecurityNegotiationException: SOAP security negotiation with `https://servername:4712/SecurityService.svc` for target `https://servername:4712/SecurityService.svc` failed. See inner exception for more details. ---> System.ComponentModel.Win32Exception: The Security Support Provider Interface (SSPI) negotiation failed."
  - See [Cause 3: Computer isn't connected to the Management Reporter's domain](#cause-3-computer-isnt-connected-to-the-management-reporters-domain)
  - See [Cause 7: The computer can't communicate or authenticate with the domain](#cause-7-the-computer-cant-communicate-or-authenticate-with-the-domain)
  - See [Cause 9: No SPN is created for the domain account that's running Management Reporter services](#cause-9-no-spn-is-created-for-the-domain-account-thats-running-management-reporter-services)
- > Message: System.ServiceModel.EndpointNotFoundException: There was no endpoint listening at `https://servername:4712/InformationService.svc` that could accept the message. This is often caused by an incorrect address or SOAP action. See InnerException, if present, for more details. ---> System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.
  - See [Cause 5: Port isn't set up as an exclusion in Firewall](#cause-5-port-isnt-set-up-as-an-exclusion-in-firewall)
- > Message: System.ServiceModel.Security.MessageSecurityException: An unsecured or incorrectly secured fault was received from the other party. See the inner FaultException for the fault code and detail. ---> System.ServiceModel.FaultException: An error occurred when verifying security for the message.
  - See [Cause 4: Wrong time on the client or server](#cause-4-wrong-time-on-the-client-or-server)
- > Message: System.TimeoutException: The request channel timed out attempting to send after 00:00:40. Increase the timeout value passed to the call to Request or increase the SendTimeout value on the Binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The HTTP request to `https://servername:4712/InformationService.svc` has exceeded the allotted timeout of 00:00:39.9660000. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.WebException: The operation has timed out

  or

  > Message: System.ServiceModel.Security.MessageSecurityException: The security timestamp is invalid because its creation time ('2024-09-15T18:08:07.177Z') is in the future. Current time is '2024-09-1T18:00:34.847Z' and allowed clock skew is '00:05:00'.

  > [!NOTE]
  > The date/time indicated above is an example of the actual date/time.
  - See [Cause 4: Wrong time on the client or server](#cause-4-wrong-time-on-the-client-or-server)
- > Message: System.Data.SqlClient.SqlException (0x80131904): A connection was successfully established with the server, but then an error occurred during the pre-login handshake. (provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.)
  - See [Cause 6: SSL isn't set up when Encrypt connection is enabled](#cause-6-ssl-isnt-set-up-when-encrypt-connection-is-enabled)
- > Message: System.ServiceModel.Security.SecurityNegotiationException: The caller was not authenticated by the service. ---> System.ServiceModel.FaultException: The request for security token could not be satisfied because authentication failed.
  - See [Cause 7: The computer can't communicate or authenticate with the domain](#cause-7-the-computer-cant-communicate-or-authenticate-with-the-domain)
- > Message: System.ServiceModel.ProtocolException: The remote server returned an unexpected response: (405) Method Not Allowed. ---> System.Net.WebException: The remote returned an error: (405) Method Not Allowed.
  - See [Cause 8: WCF HTTP Activation isn't installed on the Management Reporter server](#cause-8-wcf-http-activation-isnt-installed-on-the-management-reporter-server)
- > Message: Microsoft.Dynamics.Performance.Common.ReportingServerNotFoundException: The server could not be found. Make sure the server address is correct.
  - See [Cause 5: Port isn't set up as an exclusion in Firewall](#cause-5-port-isnt-set-up-as-an-exclusion-in-firewall)
- > Message: An error occurred while receiving the HTTP response to server_name\InformationService.svc. This could be due to the service endpoint binding not using the HTTP protocol. This could also be due to an HTTP request context being aborted by the server (possibly due to the service shutting down).
  - See [Cause 10: Named Pipes isn't enabled on the Management Reporter server](#cause-10-named-pipes-isnt-enabled-on-the-management-reporter-server)

## Cause 1: Management Reporter's version is different

The Management Reporter Client installed is a different version than the Management Reporter server.

#### Resolution

Check the Management Reporter Client installed on the workstation and also check the Management Reporter Server installed on the server. To check the version in Management Reporter, select **Help**, and then select **About Management Reporter**. The Management Reporter Client installed needs to be the same version as the Management Reporter server.

## Cause 2: User isn't set up in Management Reporter

The user trying to run Management Reporter hasn't been set up as a user in Management Reporter and therefore can't connect.

#### Resolution

Set up the user receiving the connection error within Management Reporter by takeing the following steps:

1. Run Management Reporter as a user that is set up as a Management Reporter administrator.
2. In Management Reporter, select **Go**, and then select **Security**.
3. Add the user who is receiving the connection error.

> [!NOTE]
> If it is not known what user(s) exist in Management Reporter, you can run `select * from SecurityUser` against the ManagementReporter database to find out.

## Cause 3: Computer isn't connected to the Management Reporter's domain

The computer isn't connected to the domain where Management Reporter is installed.

#### Resolution

Management Reporter will only function while connected to the domain used during the installation. Even if all Management Reporter server components are on one computer, that computer still needs to be connected to the domain you were using when you installed Management Reporter.

> [!NOTE]
> This means that Management Reporter will not work when demonstration laptops are not physically connected to the domain or not connected using a VPN connection.

## Cause 4: Wrong time on the client or server

The time on the client and server is more than five minutes different (differences in time zones are permitted).

#### Resolution

Verify the time on the client and server. Change the time that is incorrect. The time must be within five minutes of each other.

## Cause 5: Port isn't set up as an exclusion in Firewall

The port used during the Management Reporter installation isn't set up as an exclusion within the Firewall software.

#### Resolution

Set up an exception in your Firewall program. Steps will vary depending on the Firewall program used but here are high-level steps:

1. Select **Start**, and then select **Run**. Type _WF.MSC_, and then press Enter.
2. Select **Inbound Rules** > **New Rule**.
3. Select **Port**, and then select **Next**.
4. Select **Specific local ports**, and then type _4712_. If you aren't using the default port of 4712, you'll need to type that here. Select **Next**.
5. Select **Allow the connection**, and then select **Next**.
6. Select **Domain** > **Private** > **Public**, and then select **Next**.
7. Type Management Reporter as the Name, and then select **Finish**.

## Cause 6: SSL isn't set up when Encrypt connection is enabled

The Encrypt connection option was selected during the install but Secure Sockets Layer (SSL) wasn't configured.

#### Resolution

The Management Reporter Install Guide has the following information regarding the encrypt connection option:

You must configure SSL on the server and install certificates before you can use this option. For more information about encryption in Microsoft SQL Server, see the SQL Server documentation [Encrypting Connections to SQL Server](/previous-versions/sql/sql-server-2008-r2/ms189067(v=sql.105)).

You could also modify the config files to turn off Encryption by taking the following steps (make a backup copy of the files before you modify them).

1. In Windows Explorer, go to the Management Reporter installation folder (the default installation file is: _C:\Program Files\Microsoft Dynamics ERP\Management Reporter\2.1_)
2. In the Application Service folder, find the web.config file and right-click the file to open it in Notepad.
3. Locate the \<connectionstrings> and change the setting Encrypt= from **True** to **False**.
4. Save the changes.
5. In the Process Service folder, find the MRProcessService.exe.config file and right-click the file to open it in Notepad.
6. Locate the \<connectionstrings> and change the setting Encrypt= from **True** to **False**.
7. Save the changes.

## Cause 7: The computer can't communicate or authenticate with the domain

#### Resolution

Remove the computer from the domain, and then add it back to the domain.

> [!WARNING]
> A local administrator account will need to be used to logon to the computer one time after it is removed from the domain.

1. Select **Start**, select **Run**, and type _sysdm.cpl_ to open System Properties.
2. Select **Change** and make a note of the Domain name.
3. Select **Workgroup**, type a name (that is, workgroup), select **OK** to accept changes, and then restart the computer.
4. After restarting, select **Start** > **Run**, and type _sysdm.cpl_ to open System Properties.
5. Select **Change**, and then select **Domain**.
6. Enter the domain noted above, select **OK** to accept changes, and then restart the computer.

## Cause 8: WCF HTTP Activation isn't installed on the Management Reporter server

#### Resolution

Install WCF HTTP Activation by taking the following steps:

1. In Windows Server 2008, open Server Manager, and then select **Features**.
2. Select **Add Features**, and then expand **.NET Framework**.
3. Expand **WCF Activation**, and then mark **HTTP Activation**.
4. Select **Next**, and then select **Install**.

## Cause 9: No SPN is created for the domain account that's running Management Reporter services

Management Reporter services are being run as a Domain user and WCF Authentication is failing when using the UPN (User Principal Name).

#### Resolution

Create an SPN on the computer for the domain account running the Management Reporter services. To create an SPN for this domain account, run the Setspn tool at a command prompt on the Management Reporter server with the following commands:

```console
setspn -S HTTP/MRservername domain\customAccountName
setspn -S HTTP/MRservername.fullyqualifieddomainname domain\customAccountName
```

> [!NOTE]
>
> - "MRservername" should be replaced with the Management Reporter server name where the Management Reporter Application Service is installed.
> - "MRservername.FullyQualifiedDomainName" should be replaced with the fully qualified domain name of the Management Reporter server where the Management Reporter Application Service is installed.
> - "domain\customAccountName" should be replaced with the domain account running the Management Reporter services.

When running the `SETSPN` commands, you may receive an error message:

> Registering ServicePrincipalNames for CN=MSADynamicsGP,OU=Services,OU=Accounts,DC=contoso,DC=com  
HTTP/myserver.contoso.com  
Failed to assign SPN on account 'CN=MSADynamicsGP,OU=Services,OU=Accounts,DC=contoso,DC=com', error 0x21c7/8647 -> **The operation failed because SPN value provided for addition/modification is not unique forest-wide.**

This error occurs if the domain is locked down and uses delegated admin accounts. You need to confirm that this server hasn't been moved between domains and is unique. To get a list of all SPNs to verify that the SPN value is unique for a server, run the `Setspn -l <servername>` command. Creating a unique account and then running the commands should also solve this issue.

In this case, run the `SETSPN` commands as a full domain administrator and correct the issues with the client connectivity.

To check group membership, run the `Net user /domain <username>` command. The command result shows the group membership in the "Local Group memberships" and "Global Group memberships". Here's an example:

:::image type="content" source="media/cannot-connect-to-server-error-message-when-starting-management-reporter/check-group-membership-command-example.png" alt-text="An example of how to get the group membership by running the net user command.":::

> [!NOTE]
> When you are logged in as a full domain administrator, the command result shows the ***Domain Admins group**.

## Cause 10: Named Pipes isn't enabled on the Management Reporter server

#### Resolution

On the Management Reporter server, open Server Manager, and then select **Dashboard**. On the right side, select **Add roles and Features**. This will open a wizard. Select **Next** until you get to the **Features** section. Expand **.NET Framework 4.6 Features** (or whatever the highest version available is). Select **Named Pipes Activation**. Select **Next** and finish the wizard.

## More information

If you still receive error messages after making changes, contact Microsoft Management Reporter support with the errors including details from Event Viewer.
