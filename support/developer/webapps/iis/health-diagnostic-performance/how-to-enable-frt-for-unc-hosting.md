---
title: How to enable Failed Request Tracing and logging for UNC hosting
description: Walks through how to enable Failed Request Tracing and logging for UNC hosting
ms.date: 11/23/2007
ms.author: aartigoyle
author: aartig13
ms.reviewer: johnhart, riande
ms.custom: sap:Health, Diagnostic, and Performance Features\Failed Request Tracing
---
# How to enable Failed Request Tracing and logging for UNC hosting

_Applies to:_ &nbsp; Internet Information Services

Placing application content and code on a UNC share for hosting scenarios is increasingly important on Web application servers. In hosting scenarios, it's important to be able to keep the logs alongside the Web application content and code. Logs include the Failed Request Tracing log files, as well as the hit logs that IIS logs for the website. This article walks you through the creation of the appropriate directories, setting the right permissions on them, and then configuring IIS on how to use the directories for the various log files by:

- UI - Using the IIS Manager or Explorer
- CMD - Using command line (PowerShell, AppCmd, etc.)
- XML - Manually editing configuration.

## Configure Failed Request Tracing for a hosting scenario

Failed Request Tracing is a powerful diagnostics feature that helps developers and administrators determine where problems occur in their applications and why they're happening. Failed Request Tracing after installation is difficult to use by developers who are non-administrators on the machine. This section helps setup Failed Request Tracing to be accessible by developers by:

- Unlocking the sections necessary to allow developers to define their own failed request tracing rules for their applications.
- Setting up Failed Request Tracing to log to a UNC share for the application owner.

## Delegating \<traceFailedRequests\> to non-administrators

There are two different sections of configuration for Failed Request Tracing:

- `<traceFailedRequestsLogging>`: This section is always restricted to IIS administrators. This section allows administrators to enable or disable the Failed Request Tracing feature for a site, configure the maximum # of log files, size of the log files, and the directory where the log files are to live. For these reasons (i.e. controlling the ability to fill the disk with log files), administrators must maintain control over this section.
- `<traceFailedRequests>`: This section is where you create your failure definitions - what URLs to capture traces for and under what conditions to save those traces to disk as XML. This is the section that you'll allow to be unlocked.

After installation of the Failed Request Tracing Module (see the [Troubleshooting Failed Requests Using Tracing](troubleshoot-failed-requests-using-tracing-in-iis-85.md) for information regarding the installation and basic usage of Failed Request Tracing), the `<traceFailedRequests>` section is already set for Read/Write permissions. This allows application owners to define their own Failed Request Tracing rules, without the administrator defining these rules for them.

### UI: Verify \<traceFailedRequests\> delegation from the IIS Manager

To verify that \<traceFailedRequests\> has been set up for delegation from the IIS Manager UI, do the following:

1. Select **Start** and enter _InetMgr_ to open IIS Manager. Enter administrator credentials if you aren't already administrator.
1. Select **\<Your machine name\>**, then **Feature Delegation**.
1. Verify that **Failed Request Tracing Rules** is set to **Read/Write**.

:::image type="content" source="media/how-to-enable-frt-for-unc-hosting/feature-delegation-dialog-frt-highlighted.png" alt-text="Screenshot of the Feature Delegation dialog box. Failed Request Tracing Rules is highlighted.":::

This allows developers who don't have access to _ApplicationHost.config_ to create their own failure definitions in their application _web.config_ files. Only when the administrator turns on Failure Request Tracing, the rules take effect.

### XML: Verify \<traceFailedRequests\> delegation in ApplicationHost.config

To verify that \<traceFailedRequests\> has been set up for delegation via _ApplicationHost.config_, follow these steps:

1. Start an administrator elevated command prompt.
1. Change directories to _%windir%\system32\inetsrv\config_, and run `notepad applicationHost.config`.
1. In _applicationHost.config_, search for the string _\<section name="traceFailedRequests"_ - this section is delegated if it's set _overrideModeDefault="Allow"_.

```xml
<configSections>
...other config sectionGroups...
  <sectionGroup name="system.webServer">
  ...other sections...
    <sectionGroup name="tracing">
      <section name="traceFailedRequests" overrideModeDefault="Allow" />
      ...
    </sectionGroup>
   ...
  </sectionGroup>
</configSections>
```

## Configure the UNC share and application pool IDs

In order for IIS to be able to write its Failed Request Log Files to a UNC share, the worker process identity must be given full control on the network share and the filesystem path on the UNC server. This is because it must be able to list directory contents, create new log files and directories, and delete old log files.

If you use one of the built-in accounts (like IUSR or Network Service) as the application pool ID, these accounts appear as ANONYMOUS on the UNC server. It's **highly recommended** that you either:

- **DOMAIN USAGE**: Create a domain user account for the application pool, then use that application pool ID to ACL down the share and filesystem directory where the Failure Request Log Files live. Both the Web server and the UNC server must be members of the domain.
- **NON-DOMAIN USAGE**: If the UNC and Web Servers aren't joined to the domain, the same account with the same account password must be created on each machine. This is the example used in this walkthrough.

In the following sections, you'll create a new user with a sample name _PoolId1_ and with a sample password _!p4ssw0rd_, and a new application pool with a sample name _Pool\_Site1_.

### UI: Create the new local account on the UNC server and front end Web server

These directions should be repeated on both the UNC server as well as the Web server. Create a user called _PoolId1_, whose password is _!p4ssw0rd_.

1. From an administrator elevated command prompt, run `start lusrmgr.msc`.
1. Right-click on **Users** and select **New User...**.
1. Fill in the **New User** dialog entries as follows:  

   - **User name**: _PoolId1_
   - **Password** (and **Confirm Password**): _!p4ssw0rd_
   - Clear **User must change password at next logon**
   - Select **user cannot change password**
   - Select **Create** -> **Close.**

     :::image type="content" source="media/how-to-enable-frt-for-unc-hosting/new-user-dialog.png" alt-text="Screenshot of the New User dialog box is displayed.":::

Make sure to create the _PoolId1_ user on both the front-end IIS Web Server and the back end UNC server. You also need to add the _PoolId1_ to the **IIS\_IUSRS** group on the front end Web server. To do so, follow these steps:

1. Select the **Groups** folder on the **lusrmgr** MMC snap-in.
1. Right-click on **IIS\_IUSRS** and select **Add to Group**.
1. Select **Add...**, then enter _\<servername\>\\PoolId1_ as the identity to add.

### CMD: Create the new local account on the UNC server and front end Web server

To add the new _PoolId1_ identity from the command line, follow these steps:

1. Run an administrator elevated command prompt.
1. In the command prompt window, run the following commands:  

    ```console
    net user PoolId1 !p4ssw0rd /ADD /passwordchg:no
    
    net localgroup IIS_IUSRS PoolId1 /ADD
    ```

> [!NOTE]
> The `net localgroup` command is only required on the front end Web server.

### UI: Create a new application pool for the website and change its identity

Part of the shared hosting guidance is a new application pool; set its identity to the _PoolId1_ that is just created.

1. On the IIS front end server, run **Start**-> **InetMgr**.
1. Select **Application Pools**, then select under **Actions** -> **Add Application Pool...**.
1. Make the name _Pool\_Site1_, leave all other settings alone, and then select **OK**.
1. Right-click **Pool\_Site1** and select **Advanced Settings...**.
1. Under **Process Model**, select the **Identity** row and then select the **...** button.
1. Select **Set** and configure the **Custom Identity** to match the user identity you just created - _PoolId1_. Select **OK** and **OK** again to change the identity of the application pool.

:::image type="content" source="media/how-to-enable-frt-for-unc-hosting/advanced-settings-dialog-id-highlighted.png" alt-text="Screenshot of the Advanced Settings dialog box. Identity is highlighted.":::

Drop a site into this application pool. Use the default website for this sample. You can also create a new site (for example, _SITE1_) with IIS Manager. Do the following:

1. Select **Sites** -> **Default Web Site**.
2. In the right **Actions** pane, select **Basic Settings...**.
3. To the right of **Application Pool:**, select **Select...**.
4. Select the new **Pool\_Site1** application pool, select **OK**, and then **OK** again.

### CMD: Create a new application pool for the website and change its identity

1. Start an administrator elevated command prompt.
1. To add the new application pool, run the following command:  

    ```console
    %windir%\system32\inetsrv\appcmd add AppPool -name:Pool_Site1 -processModel.username:ERICDE-DELL-W\PoolId1 -processModel.password:!p4ssw0rd -processModel.identityType:SpecificUser
    ```

1. To set the root application of the Default Web Site to run in Pool\_Site1, run the following command:

    ```console
    %windir%\system32\inetsrv\appcmd set app -app.name:"Default Web Site/" -applicationPool:Pool_Site1
    ```

## Create and lock down the ACLs for the UNC share

Now create and lock down the UNC share and its file system directories.

### CMD: Create and lock down the ACLs for the UNC share

On the UNC server, do the following steps:

1. Create a filesystem path _content_ where you will dump the content.
1. Under that, create a new directory _Site1_, and under that another directory _Logs_, and the final directory _failedReqLogFiles_. You see:
    - g:\content
        - Site1
            - Logs
                - failedReqLogFIles
1. On _g:\content\Site1\Logs\failedReqLogFiles_, set the permissions on the filesystem path to give the _PoolId1_ account full control over the Logs directory. This is required, as the worker process identity must be able to list contents, write new files, create new directories, and delete old files. To do this from an administrator elevated command prompt, run the following command:  

    - Windows Server&reg; 2003 File Server:

        ```console
        icacls g:\content\Site1\Logs\failedReqLogFiles /g PoolId1:F
        ```

    - Windows Server 2003 File Server:

        ```console
        cacls g:\content\Site1\Logs\failedReqLogFiles /g PoolId1:F /e
        ```

1. Share the directory out. From the command line, run the following command:  

    ```console
    net share content$=g:\content /GRANT:Users,CHANGE
    ```

## Set Failed Request Tracing to log to the UNC path

Now that Share is shared out and the right permissions established, configure Failed Request Tracing to log to the UNC Path.

### UI: Configure Failed Request Tracing to log to UNC

To configure Failed Request Tracing to log to our UNC path, follow these directions on the Web server:

1. Open IIS Manager by running **Start** -> **Inetmgr**.
1. Select **Default Web Site**, and then under **Configure** select **Failed Request Tracing...**
1. Select the **Enabled** checkbox.
1. Under **Directory**, enter the path to the UNC share:

    ```console
    \\<UncServerName>\UNCContent\Site1\Logs\FailedReqLogFiles
    ```

    :::image type="content" source="media/how-to-enable-frt-for-unc-hosting/edit-web-site-frt-setting.png" alt-text="Screenshot of the Edit Web Site Failed Request Tracing Settings.":::

## Test

Configure a rule to catch all HTTP 200 requests for all URLs for **All Content** to run a test.

1. In the IIS Manager UI again, expand the **Sites** and select **Default Web Site**.
1. Double-click on **Failed Request Tracing Rules**.
1. Under **Actions** on the right, select **Add...**  
    :::image type="content" source="media/how-to-enable-frt-for-unc-hosting/add-frt-dialog-specify-content.png" alt-text="Screenshot of the Add Failed Request Tracing Rule dialog box displaying the Specify Content to Trace page.":::
1. Select **Next**, and set the status code to _200_:  
    :::image type="content" source="media/how-to-enable-frt-for-unc-hosting/add-frt-dialog-define-trace.png" alt-text="Screenshot of the Add Failed Request Tracing Rule dialog box displaying the Define Trace Conditions page.":::
1. Select **Next**, leave the default to collect everything, and then Select **Finish.**

### XML: Configure the Failed Request Tracing rule in web.config

The actual XML looks like the following in the _web.config_ file for the default website:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
    <tracing>
      <traceFailedRequests>
        <add path="*">
          <traceAreas>
            <add provider="ASP" verbosity="Verbose" />
            <add provider="ASPNET" areas="Infrastructure,Module,Page,AppServices" verbosity="Verbose" />
            <add provider="ISAPI Extension" verbosity="Verbose" />
            <add provider="WWW Server" areas="Authentication,Security,Filter,StaticFile,CGI,Compression,Cache,RequestNotifications" verbosity="Verbose" />
           </traceAreas>
          <failureDefinitions statusCodes="200" />
        </add>
      </traceFailedRequests>
    </tracing>
  </system.webServer>
</configuration>
```

## Check the UNC back end

Browse to the website that you set up in order to log Failed Request Tracing rules to the UNC path (similar to `http://<uncsite>/default.aspx`). Check the UNC back end server directory where you're logging. Notice that a new directory called _W3SVC1_ has been created within the configured Failed Request log file directory. Browse into that directory, and see the log file and the _FREB.xsl_ file.
