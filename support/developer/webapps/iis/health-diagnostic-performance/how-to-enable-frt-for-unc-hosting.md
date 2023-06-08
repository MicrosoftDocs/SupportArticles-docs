---
title: "How to Enable Failed Request Tracing for UNC Hosting"
author: rick-anderson
description: "Placing application content and code on a UNC share for hosting scenarios is increasingly important on web application servers. In hosting scenarios, it is i..."
ms.date: 11/23/2007
ms.assetid: 747b3570-6016-4a81-8b07-45e6bad0ff39
msc.legacyurl: /learn/troubleshoot/using-failed-request-tracing/how-to-enable-failed-request-tracing-for-unc-hosting
msc.type: authoredcontent
---
# How to Enable Failed Request Tracing for UNC Hosting

by [Saad Ladki](https://twitter.com/saadladki)

## Configuring Failed Request Tracing and Logging for a Hosting Scenario

Placing application content and code on a UNC share for hosting scenarios is increasingly important on web application servers. In hosting scenarios, it is important to be able to keep the logs alongside the web application content and code. Logs include the Failed Request Tracing log files, as well as the hit logs that IIS logs for the web site. This document walks you through the creation of the appropriate directories, setting the right permissions on them, and then configuring IIS on how to use the directories for the various log files.

The basic naming conventions for the log file directories, user accounts, and permissions settings are consistent with the "Shared Hosting Walkthrough" document also available on this site. This walkthrough also makes distinctions on how to do the various actions via:

- UI : Using the IIS Manager or Explorer to perform the action
- CMD : Using command line (PowerShell, AppCmd, etc.) to perform the action
- XML : Manually edit configuration to perform the action.

## Configuring Failed Requests Tracing for a Hosting Scenario

Failed Request Tracing is a powerful diagnostics feature helps developers and administrators determine where problems occur in their applications and why they are happening. Failed Request Tracing after installation is quite difficult to use by developers who are non-administrators on the machine. This section helps setup Failed Request Tracing to be accessible by developers by:

- Unlocking the sections necessary to allow developers to define their own failed request tracing rules for their applications
- Setting up Failed Request Tracing to log to a UNC share for the application owner

## Delegating &lt;traceFailedRequests&gt; to Non-Administrators

Remember that there are two different sections of configuration for Failed Request Tracing:

- `<traceFailedRequestsLogging>` : This section is always restricted to IIS administrators. This section allows administrators to enable or disable the Failed Request Tracing feature for a site, configure the maximum # of log files, size of the log files, and the directory where the log files are to live. For these reasons, (i.e. controlling the ability to fill the disk with log files) administrators must maintain control over this section.
- `<traceFailedRequests>`: This section is where you create your failure definitions - what URLs to capture traces for and under what conditions to save those traces to disk as XML. *This* is the section that we will allow to be unlocked.

After installation of the Failed Request Tracing Module (see the [Troubleshooting Failed Requests Using Tracing](troubleshooting-failed-requests-using-tracing-in-iis.md) on IIS.net for information regarding the installation and basic usage of Failed Request Tracing), the `<traceFailedRequests>` section is already set for Read/Write permissions. This allows application owners to define their own Failed Request Tracing rules, without the administrator defining these rules for them.

### UI: Verifying &lt;traceFailedRequests&gt; Delegation From the IIS Manager

To verify that &lt;traceFailedRequests&gt; has been setup for delegation from the IIS Manager UI, do the following:

1. Click Start and type in *inetmgr.* Enter administrator credentials if you are not already administrator.
2. Click the Machine name, then *Feature Delegation.*
3. Verify that *Failed Request Tracing Rules* is set to **Read/Write**.

![Screenshot of the Feature Delegation dialog box. Failed Request Tracing Rules is highlighted.](how-to-enable-failed-request-tracing-for-unc-hosting/_static/image1.png)

This allows developers who do not have access to ApplicationHost.config to create their own failure definitions in their application web.config files. Only when the administrator turns on failure request tracing will the rules then take effect.

### XML: Verifying &lt;traceFailedRequests&gt; Delegation in ApplicationHost.config

To verify that &lt;traceFailedRequests&gt; has been setup for delegation via ApplicationHost.config, do the following:

1. Start an administrator-elevated command prompt.
2. Change directories to `%windir%\system32\inetsrv\config`, and run `notepad applicationHost.config`.
3. In applicationHost.config, search for the string *&lt;section name="traceFailedRequests"* - this section is delegated if it is *overrideModeDefault="Allow"*.

[!code-xml[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample1.xml)]

## Configuring the UNC Share and Application Pool IDs

In order for IIS to be able to write its Failed Request Log Files to a UNC share, the worker process identity must be given Full Control on the network share and the filesystem path on the UNC server. This is because it must be able to list directory contents, create new log files and directories, and delete old log files.

If you use one of the built-in accounts (like IUSR or Network Service) as the application Pool ID, these accounts appear as ANONYMOUS on the UNC server. It is **highly** **recommended** that you either:

1. **DOMAIN USAGE** : Create a domain user account for the application pool, then use that application Pool ID to ACL down the share and filesystem directory where the Failure Request Log Files live. Both the web server and the UNC server must be members of the domain.
2. **NON-DOMAIN USAGE** : If the UNC and Web Servers are not joined to the domain, the same account with the same account password must be created on each machine. This is the example used in this walkthrough.

### UI: Creating the New Local Account on the UNC Server and Front End Web Server

These directions should be repeated on both the UNC server as well as the web server. Create a user called "PoolId1", whose password will be "!p4ssw0rd"

1. From an Administrator-elevated command prompt, run **start lusrmgr.msc.**
2. Right-click on the **Users** folder and select **New User...**.
3. Fill in the **New User** dialog entries as follows:  

   - User name : **PoolId1**
   - Password (&amp; Confirm Password) : **!p4ssw0rd**
   - uncheck "User must change password at next logon"
   - check "user cannot change password"
   - Click **Create**, then **Close.**

     ![Screenshot of the New User dialog box is displayed.](how-to-enable-failed-request-tracing-for-unc-hosting/_static/image5.png)

Make sure to create the **PoolId1** user on both the front-end IIS Web Server &amp; the back end UNC server. You also need to add the *PoolId1* to the IIS\_IUSRS group on the Front End Web Server. To do so:

1. Click the **Groups** folder on the *lusrmgr* MMC snapin.
2. Right-click on *IIS\_IUSRS* and select **Add to Group**.
3. Click **Add...**, then put *&lt;servername&gt;\PoolId1* in as the identity to add.

### CMD: Creating the New Local Account on the UNC Server and Front End Web Server

To add the new *PoolId1* identity from the command line, do the following:

1. Run an administrator elevated command prompt.
2. In the command prompt window, run the following commands:  

    [!code-console[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample2.cmd)]

> [!NOTE]
> The "net localgroup" command is only required on the Front End Web Server.

### UI: Create a New Application Pool for the Web Site and Change its Identity

Part of the shared hosting guidance that the IIS team is creating is a new application pool; set its identity to the *PoolId1* that we just created.

1. On the IIS front end server, run Start-&gt;Inetmgr.
2. Click on **Application Pools** node in the UI, then select under *Actions* -&gt; **Add Application Pool...**
3. make the name **Pool\_Site1**, leave all other settings alone, and click **OK**.
4. Right-click the *Pool\_Site1* and select **Advanced Settings...**
5. Under *Process Model*, select the *Identity* row and then on the **...** button.
6. Click the **Set** button and configure the *Custom Identity* to match our user identity we just created - *PoolId1.* Click **OK** and **OK** again to change the identity of the application pool. You see:

![Screenshot of the Advanced Settings dialog box. Identity is highlighted.](how-to-enable-failed-request-tracing-for-unc-hosting/_static/image7.png)

We must also drop a site into this application pool. Use Default Web Site for the purposes of this walkthrough. You can also create a new site for this (SITE1) via INETMGR.exe. Do the following:

1. Click on the **Sites** folder, then on **Default Web Site.**
2. In the right **Actions** pane, select **Basic Settings...**
3. To the right of **Application Pool:** click on **Select...**
4. Choose the new **Pool\_Site1** application Pool we just created and click **OK**, then **OK** again.

### CMD: Create a New Application Pool for the Web Site and Change Its Identity

To do the above steps from the command line:

1. Start an administrator-elevated command prompt.
2. To add the new application pool run the following command:  

    [!code-console[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample3.cmd)]

To set the root application of the Default Web Site to run in Pool\_Site1, run the following command:

[!code-console[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample4.cmd)]

## Creating and Locking Down the ACLs for the UNC Share

Now create and lock down the UNC share &amp; its file system directories.

### CMD: Creating &amp; Locking Down the ACLs for the UNC Share

On the UNC server do the following:

1. Create a filesystem path (call it **content**) where we will dump the content.
2. Underneath that, create a new directory called **Site1**, and under that another directory called **Logs**, and the final directory called **failedReqLogFiles**. What you should see is:  

    - g:\content 

        - Site1 

            - Logs 

                - failedReqLogFIles
3. On g:\content\Site1\Logs\failedReqLogFiles, set the permissions on the filesystem path to give the **PoolId1** full control over the Logs directory. This is required, as the worker process identity must be able to list contents, write new files, create new directories, and delete old files. To do this from an administrator elevated command prompt, run the following command:  

    - Windows Server&reg; 2003 Fileserver:  

        [!code-console[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample5.cmd)]
    - Windows Server 2003 Fileserver:  

        [!code-console[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample6.cmd)]
4. Share the directory out. From the command line, do the following:  

    [!code-console[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample7.cmd)]

## Setting Failed Request Tracing to Log to the UNC Path

Now that Share is shared out and the right permissions established, configure Failed Request Tracing to log to the UNC Path.

### UI: Configuring Failed Request Tracing to Log to UNC

To configure Failed Request Tracing to log to our UNC path, follow these directions on the Web Server:

1. Open INETMGR by running *Start-&gt;Inetmgr*.
2. Click on *Default Web Site*, then under *Configure* click on **Failed Request Tracing...**
3. Check the **Enabled** check box.
4. Under *Directory*, type in the path to the UNC share -&gt; 

    [!code-console[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample8.cmd)]

![Screenshot of the Edit Web Site Failed Request Tracing Settings.](how-to-enable-failed-request-tracing-for-unc-hosting/_static/image9.png)

## Testing

Configure a rule to catch all 200s for all URLs for **All Content** to run a test.

1. In the INETMGR UI again, expand the *Sites* folder and click on *Default Web Site*.
2. Double-click on **Failed Request Tracing Rules**.
3. Under *Actions* on the right, click on **Add...**  
    ![Screenshot of the Add Failed Request Tracing Rule dialog box displaying the Specify Content to Trace page.](how-to-enable-failed-request-tracing-for-unc-hosting/_static/image13.png)
4. Click **Next**, and set the status code to 200:  
    ![Screenshot of the Add Failed Request Tracing Rule dialog box displaying the Define Trace Conditions page.](how-to-enable-failed-request-tracing-for-unc-hosting/_static/image15.png)
5. Click **Next**, and leave the default to collect everything, then click **Finish.**

### XML: Configuring the Failed Request Tracing Rule in web.config

The actual XML looks like the following in the web.config file for the Default Web Site:

[!code-xml[Main](how-to-enable-failed-request-tracing-for-unc-hosting/samples/sample9.xml)]

## Checking the UNC Back End

Browse to the website that we set up in order to log Failed Request Tracing rules to the UNC path (say `http://uncsite/default.aspx`). Check the UNC back end server directory where you are logging. Notice that a new directory called W3SVC1 has been created within the configured Failed Request Log File Directory. Browse into that directory, and see the log file and the FREB.xsl file.
