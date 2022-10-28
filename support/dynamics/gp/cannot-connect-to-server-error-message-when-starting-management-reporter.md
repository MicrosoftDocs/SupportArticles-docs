---
title: Cannot connect to the Management Reporter server error when starting Microsoft Management Reporter 2012
description: Describes an error you may receive when you start Microsoft Management Reporter 2012. Provides a resolution.
ms.reviewer: gbyer, kevogt
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Can't connect to the Management Reporter server" error when you start Microsoft Management Reporter 2012

This article provides resolutions for the errors that may occur when you start Microsoft Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2862020

## Symptoms

When you start Microsoft Management Reporter 2012 (MR 2012), you receive one of the following error messages:

> A connection to the server could not be established.  Check the server address and try again or contact your system administrator.

or

> Can't connect to the Management Reporter server.  Do you want to specify a different server address?

To troubleshoot Management Reporter connection problems you need to select **OK** to this message and then select **Test Connection** to get an additional error message. You also need to go to Event Viewer to get additional information on the error. In Event Viewer, select **Windows Logs** and select **Application**. Under the **Source** column, look for Management Reporter Report Designer or Management Reporter Services.

Here is a list of errors received when you select **Test Connection** and the possible associated error(s) seen in Event Viewer. Find your error in the list and use the appropriate Cause and Resolution sections.

- > Connection attempt failed. There is a version mismatch between the client and the server. Contact your system administrator.
  - See Cause 1
- > Connection attempt failed. User does not have appropriate permissions to connect to the server. Contact your system administrator.
  - See Cause 2
- > A connection to the server could not be established. Check the server address and try again or contact your system administrator.

  > [!NOTE]
  > Servername is a placeholder for your actual server name and 4712 is a placeholder for the actual port selected during the MR install. If you check the Event Viewer, you may find the following error messages:

  > Message: System.ServiceModel.Security.SecurityNegotiationException: SOAP security negotiation with `https://servername:4712/SecurityService.svc` for target `https://servername:4712/SecurityService.svc` failed. See inner exception for more details. ---> System.ComponentModel.Win32Exception: The Security Support Provider Interface (SSPI) negotiation failed."
  - See Cause 3
  - See Cause 7
  - See Cause 9
- > Message: System.ServiceModel.EndpointNotFoundException: There was no endpoint listening at `https://servername:4712/InformationService.svc` that could accept the message. This is often caused by an incorrect address or SOAP action. See InnerException, if present, for more details. ---> System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.
  - See Cause 5
- > Message: System.ServiceModel.Security.MessageSecurityException: An unsecured or incorrectly secured fault was received from the other party. See the inner FaultException for the fault code and detail. ---> System.ServiceModel.FaultException: An error occurred when verifying security for the message.
  - See Cause 4
- > Message: System.TimeoutException: The request channel timed out attempting to send after 00:00:40. Increase the timeout value passed to the call to Request or increase the SendTimeout value on the Binding. The time allotted to this operation may have been a portion of a longer timeout. ---> System.TimeoutException: The HTTP request to `https://servername:4712/InformationService.svc` has exceeded the allotted timeout of 00:00:39.9660000. The time allotted to this operation may have been a portion of a longer timeout. ---> System.Net.WebException: The operation has timed out

  or

  > Message: System.ServiceModel.Security.MessageSecurityException: The security timestamp is invalid because its creation time ('2017-09-15T18:08:07.177Z') is in the future. Current time is '2017-09-1T18:00:34.847Z' and allowed clock skew is '00:05:00'.

  > [!NOTE]
  > The date/time indicated above is an example of the actual date/time.
  - See Cause 4
- > Message: System.Data.SqlClient.SqlException (0x80131904): A connection was successfully established with the server, but then an error occurred during the pre-login handshake. (provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.)
  - See Cause 6
- > Message: System.ServiceModel.Security.SecurityNegotiationException: The caller was not authenticated by the service. ---> System.ServiceModel.FaultException: The request for security token could not be satisfied because authentication failed.
  - See Cause 7
- > Message: System.ServiceModel.ProtocolException: The remote server returned an unexpected response: (405) Method Not Allowed. ---> System.Net.WebException: The remote returned an error: (405) Method Not Allowed.
  - See Cause 8
- > Message:Microsoft.Dynamics.Performance.Common.ReportingServerNotFoundException: The server could not be found. Make sure the server address is correct.
  - See Cause 5
- > Message: An error occurred while receiving the HTTP response to server_name\InformationService.svc. This could be due to the service endpoint binding not using the HTTP protocol. This could also be due to an HTTP request context being aborted by the server (possibly due to the service shutting down).  
  - See Cause 10

## Cause

Cause 1

The Management Reporter Client installed is a different version than the MR Server. See Resolution 1 in the Resolution section.

Cause 2

The user trying to run MR has not been set up as a user in MR and therefore cannot connect. See Resolution 2 in the Resolution section.

Cause 3

The computer is not connected to the domain where Management Reporter is installed. See Resolution 3 in the Resolution section.

Cause 4

The time on the client and server is more than five minutes different (differences in time zones are permitted). See Resolution 4 in the Resolution section.

Cause 5

The port used during the MR installation is not set up as an exclusion within the Firewall software. See Resolution 5 in the Resolution section.

Cause 6

The Encrypt connection option was selected during the install but SSL was not configured. See Resolution 6 in the Resolution"section.

Cause 7

The computer is having problems communicating or authenticating with the domain. See Resolution 7 in the Resolution section.

Cause 8

WCF HTTP Activation is not installed on the MR Server. See Resolution 8 in the Resolution section.

Cause 9

MR Services is being run as a Domain user and WCF Authentication is failing when using the UPN (User Principal Name). See Resolution 9 in the Resolution section.

Cause 10

Named Pipes is not enabled on the MR server. See Resolution 10 in the Resolution section.

## Resolution

### Resolution 1

Check the Management Reporter Client install on the workstation and also check the Management Reporter Server install on the server. To check the version in Management Reporter, select **Help**, and then select**About Management Reporter**. The MR Client install needs to be the same version as the MR Server install.

### Resolution 2

Set up the user receiving the connection error within MR.

- Run MR as a user that is set up as an MR administrator.
- In MR select **Go** and then select **Security**.
- Add the user who is receiving the connection error.

> [!NOTE]
> If it is not known what user(s) exist in MR you can run `select * from SecurityUser` against the ManagementReporter database to find out.

### Resolution 3

Management Reporter will only function while connected to the domain used during the install. Even if all MR server components are on one computer, that computer still needs to be connected to the domain you were using when you installed MR.

> [!NOTE]
> This means that Management Reporter will not work when demonstration laptops are not physically connected to the domain or not connected using a VPN connection.

### Resolution 4

Verify the time on the client and server. Change the time that is incorrect. The time must be within five minutes of each other.

### Resolution 5

Set up an exception in your Firewall program. Steps will vary depending on the Firewall program used but here are high-level steps.

- Select **Start** and then select **Run**. Type _WF.MSC_ and then press Enter.
- Select **Inbound Rules**.
- Select **New Rule**.
- Select **Port** and then select **Next**.
- Select Specific local ports and then type _4712_. If you are not using the default port of 4712, you will need to type that here. Select **Next**.
- Select Allow the connection and then select **Next**.
- Select **Domain**, **Private**, and **Public**. Select **Next**.
- Type Management Reporter as the Name and then select **Finish**.

### Resolution 6

The MR Install Guide has the following information regarding the encrypt connection option:

You must configure SSL on the server and install certificates before you can use this option. For more information about encryption in Microsoft SQL Server, see the SQL Server documentation [Encrypting Connections to SQL Server](/previous-versions/sql/sql-server-2008-r2/ms189067(v=sql.105)).

You could also modify the config files to turn off Encryption (make a backup copy of the files before you modify them).

- In Windows Explorer, go to the MR install folder (the default install is: `C:\Program Files\Microsoft Dynamics ERP\Management Reporter\2.1`)
  - In the Application Service folder, find the web.config file and right-click the file to open it in Notepad.
  - Locate the \<connectionstrings> and change the setting Encrypt= from True to False.
  - Save the changes.
  - In the Process Service folder, find the MRProcessService.exe.config file and right-click the file to open it in Notepad.
  - Locate the \<connectionstrings> and change the setting Encrypt= from **True** to **False**.
  - Save the changes.
  
### Resolution 7

Remove the computer from the domain and then add it back to the domain.

> [!WARNING]
> A local administrator account will need to be used to logon to the computer one time after it is removed from the domain.

- Select **Start**, select **Run** and type _sysdm.cpl_ to open System Properties.
- Select **Change** and make a note of the Domain name.
- Select **Workgroup**, type a name (that is, workgroup), select **OK** to accept changes and then restart the computer.
- After restarting, select **Start**, select **Run** and type _sysdm.cpl_ to open System Properties.
- Select Change and then select **Domain**.
- Enter the domain noted above, select **OK** to accept changes and then restart the computer.

### Resolution 8

Install WCF HTTP Activation.

- In Windows Server 2008, open Server Manager and then select **Features**.
- Select **Add Features** and then expand .NET Framework.
- Expand WCF Activation and then mark HTTP Activation.
- Select **Next** and then select **Install**.

### Resolution 9

Create an SPN on the computer for the domain account running the MR Service. To create an SPN for this domain account, run the Setspn tool at a command prompt on the MR server with the following commands:

```console
setspn -S HTTP/MRservername domain\customAccountName
setspn -S HTTP/MRservername.fullyqualifieddomainname domain\customAccountName
```

> [!NOTE]
>
> - "MRservername" should be replaced with the MR server name where the MR Application Service is installed.
> - "MRservername.FullyQualifiedDomainName" should be replaced with the fully qualified domain name of the MR server where the MR Application Service is installed.
> - "domain\customAccountName" should be replaced with the domain account running the MR Services.

### Resolution 10

On the MR server, open Server Manager and then select **Dashboard**. On the right side, select **Add roles and Features**. This will open a wizard. Select **Next** until you get to the **Features** section. Expand .NET Framework 4.6 Features (or whatever the highest version available is). Select **Named Pipes Activation**. Select **Next** and finish the wizard.

## More information

If you still receive error messages after making changes contact Microsoft Management Reporter support with the errors including details from Event Viewer.
