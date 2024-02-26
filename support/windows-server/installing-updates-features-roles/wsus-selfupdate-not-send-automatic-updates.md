---
title: WSUS SelfUpdate doesn't send automatic updates
description: Provides a resolution to a problem that occurs when a WSUS SelfUpdate service does not send automatic updates and client computers do not report to the server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, cclay
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# WSUS SelfUpdate service doesn't send automatic updates

This article provides a solution to an issue where the client computers don't receive updates when you use a Microsoft Windows Server Update Services (WSUS) SelfUpdate service to send automatic updates.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 920659

## Symptoms

When you try to use the WSUS SelfUpdate service to send automatic updates to client computers, the client computers do not receive the updates. Additionally, the client computers do not report to the WSUS server.

When this occurs, the WSUS Administration console logs the following error message:

> Check your server configuration. One or more Update Service components could not be contacted. Check your server status and ensure that the Windows Server Update Service is running.  
Non-running services: SelfUpdate

The event log may also include the following event:

## Cause

This problem may occur if one or more of the following conditions are true:

- The permissions on the `C:\Program Files\Update Service\SelfUpdate` directory are missing or incorrectly configured, or the IUSR_ **ComputerName** account has been removed from the Users group.
- The SelfUpdate virtual directory is missing from the WSUS server.
- The SelfUpdate virtual directory is not configured for the default site on port 80.
- The SelfUpdate virtual directory does not have anonymous access permissions.
- The default Web site is configured to use specified IP addresses and is missing an entry for 127.0.0.1.
- The default Web site does not have anonymous access permissions.
- The WSUS server also has Microsoft Windows SharePoint Services installed. The WSUS resources have not been excluded from SharePoint management.
- The Selfupdate.msi installation was defective. Therefore, files are missing from the ~\Selfupdate subfolders.

## Resolution

To resolve this problem, you must have the following minimum permissions on the C:\Program Files\Update Service\SelfUpdate directory.

|Group|Permissions|
|---|---|
|Administrators|Full Control|
|System|Full Control|
|Domain/Users or Local/Users|Read&Execute, Read, List Folders|
|IUSR_ **ComputerName**|Read&Execute, Read, List Folders|
  
> [!NOTE]
> IUSR_ **ComputerName** represents the host name of the server that is running IIS where WSUS is installed. If this account is a member of the Users group, you do not have to explicitly define these permissions.

To resolve a problem where the SelfUpdate virtual directory is missing or there is no SelfUpdate virtual directory listed under the Web site that is bound to port 80, run the Selfupdate.msi file that is located in the Program files\Update services\Setup folder.

To resolve issues where the SelfUpdate virtual directory does not have anonymous access permissions, open IIS Manager, expand the default Web site, right-click the SelfUpdate virtual directory, and then click **Properties**. On the **Directory Security** tab, click **edit** under **Authentication and access control**. Make sure that anonymous access is enabled.

> [!NOTE]
> This step should be performed for the default Web site as well. The SelfUpdate tree does not work if you have a Web site that is bound to a specific IP address in your IIS configuration. The workaround is either to set your IIS configuration to respond to "All unassigned" addresses or to add 127.0.0.1 to the list of IP addresses used for SelfUpdate.

Use Internet Information Services (IIS) Management console to verify that the server is set up with one of the following two configurations.

### Configuration 1: WSUS is installed on the default Web site

Configure the default Web site by using the following settings:

- SelfUpdate
- Content
- ClientWebService
- SimpleAuthWebService
- WSUSAdmin
- ReportingWebService
- DssAuthWebService
- ServerSyncWebService

### Configuration 2: WSUS is installed on a custom Web site

Configure the default Web site on port 80 by using the following settings:

- SelfUpdate
- ClientWebService

Configure WSUS Administration on port 8530 with the following settings:

- SelfUpdate
- Content
- ClientWebService
- SimpleAuthWebService
- WSUSAdmin
- ReportingWebService
- DssAuthWebService
- ServerSyncWebService

Regardless of the configuration that you select, you must also verify the following settings:

- You must configure the SelfUpdate virtual directory under the default Web site or any other Web site to listen on Port 80.
- The SelfUpdate virtual directory points to C:\Program Files\Update Service\SelfUpdate.
- The WSUSAdmin virtual directory is the only virtual directory in IIS that should have security set to Integrated Windows Authentication. Set all other virtual directories security to **Anonymous Access Enabled**.

## Status

Microsoft has confirmed that this is a problem.

## More information

When you use IIS, you can move the SelfUpdate directory to a different Web site. To do this, follow these steps:

1. Click **Start**, click **Run**, type _Control admintools_, and then double-click **Internet Information Services (IIS) Manager**.
2. Expand the **Web Sites** folder, and then click the **WSUS Administration** node.
3. Right-click the **SelfUpdate** node, point to **All Tasks**, and then click **Save Configuration to File**.
4. Type a name for the file and then save the file to another folder. You will use this file in steps 9 through 12.
5. Right-click the **ClientWebService** node, select **All Tasks**, and then click **Save Configuration to File**.
6. Type a name for the file and save the file to the same folder that you used in step 4. You will use this file in steps 13 through 15.
7. Select the default Web site or another Web site that is running on port 80.
8. Right-click the Web site, point to **New**, and then click **Virtual Directory (from file)**.
9. Select the directory where you saved the SelfUpdate and the ClientWebService.xml files in steps 4 and 6.
10. Select the SelfUpdate.xml file, and then click **Open**.
11. Click **Read File**, click the SelfUpdate file that is now listed under **Select a configuration to import**, and then click **OK**.
12. In the **IIS Manager** dialog box, type the name for a new virtual directory in the **Alias** box, and then click **OK**.
13. Select the **ClientWebService**.xml file, and then click **Open**.
14. Click **Read File**, click the SelfUpdate file that is now listed under **Select a configuration to import**, and then click **OK**.
15. In the **IIS Manager** dialog box, type the name for a new virtual directory in the **Alias** box, and then click **OK**.
16. If this is a new Web site, start the Web site from IIS Manager. If this is an existing Web site, restart the Web site from IIS Manager.

## References

For more information about automatic updates in Windows, see [Description of the Automatic Updates feature in Windows](https://support.microsoft.com/help/294871).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
