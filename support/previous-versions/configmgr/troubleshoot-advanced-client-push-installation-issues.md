---
title: Troubleshoot Advanced Client push installation issues
description: Describes how to troubleshoot Advanced Client push installation issues in Systems Management Server 2003 and System Center Configuration Manager 2007.
ms.date: 08/20/2020
ms.prod: configuration-manager
ms.prod-support-area-path:
ms.reviewer: jarrettr
---
# Troubleshoot Advanced Client push installation issues in SMS 2003 and Configuration Manager 2007

This article describes how to troubleshoot Microsoft Systems Management Server (SMS) 2003 Advanced Client and Microsoft System Center Configuration Manager 2007 client installation issues when you use the client push installation method.

_Original product version:_ &nbsp; Microsoft System Center Configuration Manager 2007, System Center Configuration Manager 2007 R2, Microsoft System Center Configuration Manager 2007 R3  
_Original KB number:_ &nbsp; 925282

## Introduction

There are some issues that can potentially occur when you deploy a client by using the Advanced Client Push install method. This article describes the installation process, some common issues and their solutions, and the tools and procedures for troubleshooting.

The content below reference the SMS 2003 Advanced Client and the Advanced Client Push Installation method but the same information is applicable to the System Center Configuration Manager 2007 client (sometimes referred to as the ConfigMgr 2007 client) as well.

When you use the SMS 2003 Advanced Client Push Installation method to automatically install the SMS 2003 Advanced Client on computers in the SMS site, you may encounter one or more of the following issues:

- The SMS Advanced Client is not installed.
- The SMS Advanced Client is installed. However, it cannot obtain an automatic site assignment.
- The SMS Advanced Client is installed and assigned. However, it cannot communicate with the SMS site server.

In this article, the SMS Advanced Client Push Installation process is divided into three phases. Each phase has its own distinct set of issues.

> [!NOTE]
> Frequently asked questions and answers about SMS Advanced Client issues can be found in the SMS Client FAQ. To view the SMS Client FAQ, see [Clients Frequently Asked Questions](/previous-versions/cc988013(v=msdn.10)).

- Pre-installation phase

    The SMS Client Configuration Manager connects to the target client and verifies the client's operating system and client information. The client installation source files are copied, and then the Setup process downloads the SMS core components to the client computer.

- Installation phase

    The SMS Advanced Client copies the installation files from the site server and then starts Setup.

- Post-installation phase

    After the Setup program is complete, the SMS Advanced Client obtains a site assignment, sends the heartbeat discovery information to the SMS site server, and then contacts the default management point to retrieve the SMS Advanced Client policy.

## Pre-installation phase

1. During the pre-installation phase, SMS discovers the client computer and then generates a client configuration request (CCR) file. The CCR file contains the client computer name and additional information.

2. The SMSClient Configuration Manager connects to the ADMIN$ share on the client. This is based on the information in the CCR file.

3. The Client Configuration Manager connects to the client registry and gathers information about the client. This process is displayed as a log entry in the Ccm.log as connecting to IPC$.

4. The SMS core component files, MobileClient.tcf, and Ccmsetup.exe, are located in the SMS\bin\I386\ folder. These files are downloaded to the *%windir%*\System32\ccmsetup folder on the client computer.

5. The Client Configuration Manager verifies that the Ccmsetup service started successfully before disconnecting. The CCR file is added to the SMS\Inboxes\Ccrretry.box folder for verification that the installation succeeded. On a second verification pass, SMS determines that the SMS Agent Host is running, and then deletes the CCR file.

6. If the Client Configuration Manager encounters any errors during this process, the CCR file is renamed to the name of the target client computer and is put in the SMS\Inboxes\Ccrretry.box folder. The Client Configuration Manager checks for files in this inbox folder every 60 minutes and tries to reprocess them 168 times (seven days) before they are discarded. This information is logged in the Ccm.log.

## Troubleshoot pre-installation issues

### Newly discovered client computers aren't assigned to the current site

This issue typically occurs when the SMS site boundaries are configured incorrectly, or the site boundaries don't align with the type of discovery data that has been gathered. If this is the case, no CCR files are created for the client computers by the SMS Discovery Data Manager, and the installation process does not occur.

For more information about how to configure SMS site boundaries, see the **Client Deployment Planning** section in the [Systems Management Server 2003 Concepts, Planning, and Deployment Guide](/previous-versions/system-center/configuration-manager-2003/cc179958(v=technet.10)).

### Advanced Client Push Installation isn't enabled at the appropriate site

If the Advanced Client Push Installation is not enabled for the site, the SMS Discovery Data Manager doesn't automatically generate a CCR file for client computers that don't reside within its own site boundaries.

### The SMS Client Configuration Manager cannot connect to the client Admin$ share or to the Remote Registry Service (IPC$)

When the Client Configuration Manager cannot connect to Admin$, errors that resemble the following are logged in the Ccm.log file:

> 7260 (0x1C5C)6/6/2006 7:06:31 AM  
> Attempting to connect to administrative share '\\\\\<computername>\Admin$' using account '*domain\account*'SMS_CLIENT_CONFIG_MANAGER 7400 (0x1CE8)6/6/2006 7:06:34 AM  
> WNetAddConnection2 failed (LOGON32_LOGON_NEW_CREDENTIALS) using account *domain\account* (000004b3)SMS_CLIENT_CONFIG_MANAGER 7400 (0x1CE8)6/6/2006 7:06:34 AM  
> WNetAddConnection2 failed (LOGON32_LOGON_INTERACTIVE) using account *domain\account* (000004b3)SMS_CLIENT_CONFIG_MANAGER 660 (0x0294)6/6/2006 7:06:35 AM  
> ERROR: Unable to connect to remote registry for machine name "*computername*", error 53.SMS_CLIENT_CONFIG_MANAGER 660 (0x0294)6/6/2006 7:06:35 AM  
> ERROR: Unable to access target machine for request: "*computername*.KRC", machine name: "*computername*", error code: 53SMS_CLIENT_CONFIG_MANAGER 660 (0x0294)6/6/2006 7:06:36 AM  
> Stored request "*computername*.KRC", machine name "*computername*", in queue "Retry".  
> SMS_CLIENT_CONFIG_MANAGER  

In this situation, an error code 53 is logged when the site server is unable to locate the client:

> The network path was not found.

Error code 53 is usually preceded by the following error message:

> 000004b3 - "No network provider accepted the given network path."  

This log entry may occur before the error 53, or there may be additional information between this log entry and error 53 in the log file.

This issue may occur when one or more of the following conditions are true:

- There are network connectivity problems.
- There are name resolution issues with, for example, Windows Internet Name Service (WINS) or Domain Name System (DNS).
- The Remote Registry service is disabled on the client computer.
- The Windows XP or Windows Server 2003 firewall is blocking communications between the SMS Advanced Client and the SMS site server.
- The Server service on the client isn't started.
- File and Printer Sharing for Microsoft Networks is not installed on the client computer.

  If File and Printer Sharing for Microsoft Networks is not installed on the client, you receive the following error message:

  > Error 67 - The network name cannot be found.

### The SMS Advanced Client Push Installation account is configured incorrectly or is missing or is locked out

When this issue occurs, an error code 5 message appears in the Ccm.log file on the site server. In the following example, *Computer* is the computer name of the SMS Advanced Client computer:

> Attempting to connect to administrative share '\\\\COMPUTER1\Admin$' using account '*domain\account*'  
> WNetAddConnection2 failed (LOGON32_LOGON_NEW_CREDENTIALS) using account *domain\account*(0000052e)  
>
> LogonUser failed (LOGON32_LOGON_INTERACTIVE) using account *domain\account* (0000052e)  
>
> ERROR: Unable to connect to remote registry for machine name "*Computer*", error 5.  
>
> ERROR: Unable to access target machine for request: "*Computer*", machine name: "*Computer*", error code: 5

> [!NOTE]
> Error code 5 is an Access Denied error.

**Resolution**

The Advanced Client Push Installation account must have administrative credentials on the computers where you want to install the SMS Advanced Client components.

On all potential client computers, the Advanced Client Push Installation process requires that you grant administrator rights and permissions to either of the following accounts:

- The SMS Service account when the site is running in standard security mode
- The Advanced Client Push Installation accounts that you define

You can create multiple Advanced Client Push Installation accounts. Clients that are not members of a domain cannot authenticate domain accounts. For clients that are not members of a domain, you can use a local account on the client computers.

For example, if you set up a standard account on each computer for administrative purposes, and all the accounts have the same password, you can define an Advanced Client Push Installation account as *%machinename%\account*.

### The SMS Advanced Client network access account is configured incorrectly, missing, or locked out in a non-Active Directory environment

You must configure the SMS 2003 Advanced Client network access account for the SMS 2003 site before you can use the Advanced Client Push Installation method to deploy the SMS 2003 Advanced Client software on client computers in the following non-Active Directory environments:

- A workgroup
- A Windows NT 4.0 domain
- An untrusted forest

The Advanced Client network access account is a domain-level account that you create for Advanced Clients. If you define the account in a non-Active Directory environment, the account is used to access the Client.msi file and related installation files from the SMSClient share on the SMS site server or on the SMS management point.

> [!NOTE]
> If the SMS Advanced Client network access account is unavailable, SMS uses the currently logged-on user account, the local system account, or the computer account of the destination computer to make this connection.

In this configuration, the SMS Advanced Client network access account resembles the client connection account on an SMS legacy client computer.

## Installation phase

1. Ccmsetup.exe starts, and then scans the MobileClient.tcf file. This file is a configuration file from which Ccmsetup.exe obtains information that is required to locate the Client.msi file on the site server. The MobileClient.tcf file also provides the SMS site code, the management point server name, the site boundary, and other information.

2. Ccmsetup.exe downloads the client.msi file from the SMSClient\i386 shared folder on the SMS management point or from the Client\i386 folder in the SMS_<*site code*> shared folder on the SMS site server. The Advanced Client Installer runs the Client.msi Setup program by using the parameters that the administrator specifies in the SMS Administrator console.

## Troubleshoot installation issues

### The SMS Advanced Client cannot access the installation file on the SMS site server

The Client.msi file resides in the SMSClient\i386 folder on management points or in the Client\i386 folder on the SMS site server.

To troubleshoot access to this file, check the following logs on the SMS Advanced Client computer:

- *%windir%*\System32\Ccmsetup\Ccmsetup.log
- *%windir%*\System32\Ccmsetup\Client.msi.log

**Resolution**

When you try to troubleshoot a failure condition, you can use the SMS Trace utility (Trace32.exe) to review SMS log data and to locate the following error message:

> Return Value 3

The lines that come before this error mention why the installation was not completed successfully.

> [!NOTE]
> When you review the Client.msi.log file on the Advanced Client computer, don't search for the word **Error** to determine why the installation was not completed successfully. The Client.msi.log file includes all the information that is available to the Microsoft Windows Installer application. This information includes error messages and other properties.

The SMS Trace utility is included in the Systems Management Server 2003 Toolkit.

### The SMS Advanced Client cannot access the management point during an upgrade

When the SMS Advanced Client computer cannot access the management point, the Ccmsetup.log contains the following error:

> Server failed to process message and returned status code 404

This problem typically occurs when the management point isn't installed or doesn't start correctly.

**Resolution**

To help troubleshoot this issue, see the [Troubleshoot management point issues](#troubleshoot-management-point-issues) section.

### Clients that are deployed by using Capinst.exe aren't installed successfully

When you deploy the Advanced Client by using Capinst.exe, you must make sure that a server locator point (SLP) is available. The SLP returns a list of management points.

**Resolution**

Install a server locator point, and then make sure that the SLP is published in Active Directory or is registered in the WINS database.

1. Install a server locator point. An SLP can be added as a site system role in the SMS Administrator console. To do this, follow these steps:
  
   1. Click **Start**, point to **Programs**, point to **Systems Management Server**, and then click **SMS Administrator Console**.

   2. In the SMS Administrator console, expand **Site Database** > **Site Hierarchy** > **SiteCode-SiteName** > **Site Settings**.

   3. Click **Site Systems**, right-click the server that is acting as the management point, and then click **Properties**.

   4. In the **\\\ServerName Site Systems Properties** dialog box, select the **Server Locator Point** tab, and then select the **Use this site system as a server locator point** check box.

   5. In the list that is next to **Database**, you can select the site database or another database. Make a selection, and then click **OK**.

2. If the SLP already exists, make sure that it's published in Active Directory or registered in the WINS database if you have not extended the Active Directory schema. WINS is also used as a fallback if the Lightweight Directory Access Protocol (LDAP) query fails.

### BITS installation issues

Background Intelligent Transfer Service (BITS) installation issues can be difficult to detect if the BITS installation that runs as part of Client.msi is causing the Advanced Client Push Installation to fail. If the BITS installation is not successful, the Advanced Client Push Installation will not be successful.

**Resolution**

Run the BITS install manually to determine any errors. You can do this by using the following methods:

1. Download and install the [BITS 1.5 Client](https://www.microsoft.com/download/details.aspx?id=22250) (Bits_v15_client_setup.exe).

2. Run `msiexec /a client.msi` at the command prompt to extract the Bits_v15_client_setup.exe file out of the Client.msi file, and then double-click the bitssetup_clnt_installer.exe file. If the BITS installation doesn't start successfully, you must check the Bitssetup.log file for errors. If the BITS installation is successful, try running Client.msi file again.

### XML file registration is unsuccessful

An SMS 2003 Advanced Client computer may not obtain configuration settings from the site server. When this occurs, you may receive an error message that resembles the following in the Ccmexec.log file on the SMS Advanced Client computer:

> Error creating XML DOM (0x80040154) CForwarder_Base::Send failed (0x80004005).

In this case, the Msxml3.dll file may not be registered or is missing.

**Resolution**

Download the Msxml3.msi file and install it on the computers that require Microsoft XML Parser (MSXML) 3.0 Service Pack 7 (SP7) or later versions to be installed. Installing the Msxml3.msi file also registers the additional DLL files.

## Post-installation phase

1. By default, if the Advanced Client Push Installation properties specify that the client is automatically assigned to a site by using the property `SMSSITECODE=AUTO`, the client queries Active Directory for its site assignment.

2. If Active Directory isn't installed, or the SMS schema isn't extended, the client searches for a server locator point from which to obtain the site assignment and the management point information.

3. If the Active Directory schema is extended, the client obtains its site assignment and management point information by using an LDAP query to Active Directory.

4. When the client uses an SLP lookup or Active Directory lookup to locate the default management point, the client requests the initial policy from the management point.

## Troubleshoot post-installation issues

### The SMS Advanced Client is installed successfully, but doesn't appear as installed or assigned

1. You must verify that the SMS Agent Host service is running on the client. If the SMS Agent Host service is not running, the client may not send a heartbeat discovery record to report that the client is installed and assigned.

2. Double-click the **SMS Client** Control Panel item on the SMS Advanced Client computer, and then select the **Advanced** tab in the **Systems Management Properties** box. If no site code is listed, select **Automatically Discover**. If the discovery fails, it may be because of one or more of the following reasons:

   - The Active Directory schema has not been extended for SMS 2003. If you ran ExtADSch.exe manually to extend the Active Directory schema, the ExtADSch.log file will contain information about the Active Directory update and whether Active Directory was extended successfully. This log file is located in the root of the system drive.

     > [!NOTE]
     > You must be an Enterprise Administrator to extend the Active Directory schema.

   - SMS site systems have not been published in Active Directory. You can view \SMS\Logs\Sitecomp.log on the SMS server to see whether the SMS site systems have been published. For more information about how to grant permissions on the System Management container in Active Directory, see [Site Component Manager may log status messages after installing SMS 2003 or Configuration Manager 2007](site-component-manager-log-status-messages.md)

   - The server locator point cannot be located. The SLP must be published in Active Directory or registered in WINS in non-Active Directory environments.

### The SMS Advanced Client is installed successfully but doesn't receive a site assignment

The client computer appears in collections with the following values:

|Site code|Client|Assigned|Client type|
|---|---|---|---|
|ABC|Yes|No|Advanced|
|||||

In this case, the SMS Advanced Client may be listed as a client. However, it's not assigned to the site. This occurs for the following reasons:

- The collection information has not been updated. Collection updates run on a daily or weekly schedule. In this case, you must make sure that the collection information has been updated. You can manually update the collection membership, and then update the collection view.

- The client may also be a client for another site and not assigned to the one that you are viewing in the SMS Administrator console. You must check the Advanced properties of the client's Systems Management item in Control Panel and see whether a different site is listed.

### The SMS Advanced Client displays a site assignment but doesn't appear as installed

The Client computer appears in collections with the following values:

|Site code|Client|Assigned|Client type|
|---|---|---|---|
|ABC|No|Yes|Advanced|
|||||

This occurs when one or more of the following conditions are true:

- The collection information has not been updated. Collection updates usually run on a daily or weekly schedule. In this case, you must make sure that the collection information has been updated. You can manually update the collection membership, and then update the collection view.

- The client computer shares the same SMSID with another client computer. This issue can occur when you use a disk image to install the SMS Advanced Client. Duplicate SMSIDs are also referred to as duplicate GUIDs. You must determine whether duplicate SMSIDs exist on the client computers. For more information about how to detect duplicate GUIDs and how to use Tranguid.exe to create a New SMS GUID for the affected clients, see [How to locate and clean Advanced Client Duplicate GUIDs in SMS 2003](https://support.microsoft.com/help/837374).

- The SMS Advanced Client is assigned. However, the SMS Advanced Client isn't installed. You must verify that the SMS Advanced Client is installed successfully and is assigned to the site that you are viewing.

- The Network Discovery method is enabled. When you use the Network Discovery method in Systems Management Server (SMS), it populates the `IsClient` fields in the database by using a **Null** value. If other discovery methods are enabled, the computer will appear in the collection as **Assigned** with no client installed even though the client is installed. To resolve this issue, disable the Network Discovery method. Also, verify that the Heartbeat Discovery method that is enabled by default has not been disabled. Then, wait for the specified Heartbeat Discovery polling interval to pass. When the clients send up new discovery data, the database is updated to reflect the correct values.

    > [!NOTE]
    > Only the Heartbeat Discovery method will set the client installation status to **Yes**. The Active Directory System discovery method does not update the `IsClient` field in the SMS database.

- Heartbeat Discovery has not reported since the client was installed.

  **Resolution**

  1. Verify that a heartbeat has occurred on the client by reviewing the inventoryagent.log. This log is located in the `%windir%\System32\ccm\logs` folder. You must locate the `Inventory: Action=Discovery ReportType=Full` string.

  2. You can use the Advanced Client Spy utility to view the status of discovery data. This utility is part of SMS 2003 Toolkit 1.

     In the discovery record properties, you can view the discovery method that reported the discovery, and the last time that the discovery process ran. You can review the record to determine whether the issue is a failure to run a discovery property. If the data that is provided by Heartbeat Discovery is current, this issue may occur because of a client assignment issue on the SMS Advanced Client computer. If the correct Heartbeat Discovery data is not present, a communication problem may exist between the client, the management point, the site, and the site database.

  **Troubleshoot Heartbeat Discovery**

  You can use Systems Management to manually initiate a Heartbeat Discovery on the client. To do this, follow these steps:

  1. Click **Start**, point to **Control Panel**, and then double-click **Systems Management**.
  2. Click the **Actions** tab, select the **Discovery Data Collection Cycle**, and then click **Initiate Action**.
  
  Note whether the **Clear Install Flag** task is selected, and compare the **Client Rediscovery** interval to the **Heartbeat Discovery** interval. If the **Client Rediscovery** interval is less than the **Heartbeat Discovery** interval, you must change this to make sure that the **Client Rediscovery** interval is a value that is larger than the **Heartbeat Discovery** interval. To do this, follow these steps:

  1. In the SMS 2003 Administrator console, expand **Site Database** > **Site Hierarchy** > *your site code* > **Site Settings** > **Site Maintenance** > **Tasks**.

  2. Double-click **Clear Install Flag**, make sure that the **Schedule** interval is a value that is larger than the **Heartbeat Discovery** interval, and then click **OK**.

  > [!NOTE]
  > The Heartbeat Discovery setting is located in the SMS Administrator console under **Site Database** > **Site Hierarchy** > *your site code* > **Site Settings** > **Discovery Methods**.

### SMS Advanced Client doesn't receive a policy after installation

This issue occurs when the SMS management point is not installed or is not functioning. More information about this issue is available in the [Troubleshoot management point issues](#troubleshoot-management-point-issues) section.

### SMS Advanced Clients are not installed on secondary sites

When you perform an automatic Advanced Client Push Installation from a primary SMS site, the SMS Advanced Client is installed on computers that reside in the primary site. However, the SMS Advanced Client is not installed on computers that reside in the secondary site.

This issue occurs when the **Include only clients assigned to this site** option is enabled in the **Client Push Installation Properties** dialog box. You can resolve this issue by using one of the following methods:

1. Start the Advanced Client Push Installation Wizard, and then clear the **Include only clients assigned to this site** check box.

    > [!NOTE]
    > You cannot enable the **Include only clients assigned to this site** option at the command line. It must be done manually in the Advanced Client Push Installation Wizard.

2. Make sure that the Advanced Client Push Installation method is turned on at the secondary site. Additionally, make sure that the necessary discovery methods are enabled at the site.

    > [!NOTE]
    > When you perform the Advanced Client Push Installation method from a secondary site to install the SMS Advanced Client, you must not set the `SMSSITECODE={Secondary Sitecode}` site code, where *Secondary Sitecode* is the secondary site code. If you set the secondary site code in this manner, the SMS Advanced Client is installed to a state where it appears to be assigned and managed by the secondary site.

## Troubleshoot management point issues

To help determine whether you are experiencing management point issues, you can have the client computer request a Machine policy from the management point. To request a Machine policy from the management point, follow these steps:

1. Click **Start**, point to **Control Panel**, and then double-click **Systems Management**.
2. Click the **Actions** tab, select **Machine Policy Retrieval & Evaluation Cycle**, and then click **Initiate Action**.
3. To update the Systems Management Control Panel item, you must close and reopen the Systems Management Control Panel item.

For more information about how to troubleshoot SMS management point issues, see [Troubleshooting Tools](/previous-versions/system-center/configuration-manager-2003/cc180193(v=technet.10)).

## Tools and procedures to help troubleshoot SMS Advanced Client installation issues

To help troubleshoot SMS Advanced Client installation issues, you may have to follow these steps:

- Use a CCR file to manually trigger the client installation.
- Use the SMS Administrator console to force a full reinstallation of the SMS Advanced Client.
- Use the Ccmclean.exe tool to remove the SMS 2003 Advanced Client.
- Gather the SMS server log files and the SMS Advanced Client log files for analysis.

### Use a CCR file to manually trigger the client installation

When you enable the Advanced Client Push Installation method, SMS automatically creates a CCR file. The CCR file is useful for troubleshooting issues with client installations. The CCR file can also be created and applied to the server manually. To do this, follow these steps:

1. Click **Start**, click **Run**, type notepad, and then click **OK**.
2. In Notepad, type the following two lines:

   [NT Client Configuration Request]  
   Machine Name=*NetBIOSName*

    > [!NOTE]
    > In this example, *NetBIOSName* is the name of the computer where you want to install the SMS Advanced Client.

3. Click **File**, and then click **Save As**.
4. In the **Save As** dialog box, type "test.ccr", and then click **OK**. You must include the quotation marks.
5. After the CCR file is manually created, copy and paste it into the SMS\Inboxes\Ccr.box folder on the SMS Site Server. When the CCR file is processed, the file is moved to the **SMS\Inboxes\Ccr.box\Inproc** folder. When the process is complete, the CCR file is moved to the SMS\Inboxes\Ccrretry.box folder and is renamed to the name of the destination computer.

### Use the SMS Administrator console to force a full reinstallation of the SMS Advanced Client

1. Click **Start**, point to **Programs**, select **Systems Management Server** > **SMS Administrator Console**.
2. Expand **Site Database** > **Collections** > **All Systems**.
3. In the right pane, right-click a discovered SMS 2003 client, select **All Tasks**, and then select **Install Client**.
4. On the **Welcome to the Client Push Installation Wizard** screen, select **Next**.
5. On the **Client Installation Options** page, select the **Always install (repair or upgrade existing client)** check box.
6. Click **Next**, and then click **Finish**.

The following log files are used when you perform an Advanced Client Push Installation from the SMS Administrator console:

- The Smsprov.log file contains information about CCR creation.
- The Ccm.log file contains information about the client installation process.

> [!NOTE]
> These log files are located in the \SMS\Logs folder on the SMS site server. The SMS Provider log may reside on the remote SQL Server if the SQL Server doesn't reside on the SMS site server computer. However, if the client is installed from a secondary site, you must review the Ccm.log from the secondary site and not from the parent site.

### Use the Ccmclean.exe tool to remove the SMS 2003 Advanced Client

The Ccmclean.exe tool is a component of the SMS 2003 Toolkit. You can use the tool to remove the SMS 2003 Advanced Client, the SMS 2003 management point, or both.

The following is the syntax that is used by the Ccmclean tool:

- `Ccmclean /client`: This removes an SMS Advanced Client.
- `Ccmclean /mp`: This removes a management point.
- `Ccmclean /all`: This removes both the SMS Advanced Client and a management point if both are installed.

### Gather the SMS server and the SMS Advanced Client log files for analysis

We recommend that you use the Trace32 tool (SMSTrace) that is part the SMS Toolkit to view log files because it lets you view the log files in real time. SMSTrace also lets you perform error code lookups. Press **CTRL+L** in SMSTrace to display the error lookup dialog box. You can then enter the error code. If it's an error code that SMSTrace can decrypt, such as a Win32 error or a WMI error, the text of the error code is also displayed.
