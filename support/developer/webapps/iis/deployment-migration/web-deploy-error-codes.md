---
title: Web Deploy error codes
description: For some common error codes, Web Deploy shows an error message. This article helps you to diagnose these issues and provides workarounds to avoid the errors.
ms.date: 04/12/2011
ms.reviewer: chihshen, bilalaslam, v-jayaramanp
ms.topic: troubleshooting
---

# Web Deploy error codes

_Applies to:_ &nbsp; Internet Information Services 7.0, Internet Information Services 7.5, Internet Information Services 8.0

For certain common error cases, Web Deploy displays error messages. This article explains why the error message is shown and provides steps to avoid the errors. The error message may be different depending on how Web Deploy is started. For example, Microsoft WebMatrix chooses to show custom error messages. The error messages listed in the next few sections are shown on the *msdeploy.exe* command line and API:

<a id="MySqlDumpNotFound"></a>

## MySqlDumpNotFound

**Diagnosis**

Web Deploy might not find the *mysqldump.exe* executable. This executable is required for MySQL database deployments.

**Resolution**

You can try either of the following workarounds:

- Place the executable in `C:\Program Files\MySQL\MySQL Server\bin`.
- Set a `REG_SZ` registry key to point to the executable. For example, set  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\IIS Extensions\MSDeploy\<version>\MySqlDumpPath` to `c:\mysqldump\mysqldump.exe`

<a id="RemoteAppNotFound"></a>

## RemoteAppNotFound

**Diagnosis**

The remote application couldn't be found. This error can occur if you try to do a dump of "remotesite/remoteapp" where "remoteapp" doesn't actually exist.

**Resolution**

Specify a remote application name that actually exists.

<a id="FileOrFolderNotFound"></a>

## FileOrFolderNotFound

**Diagnosis**

This error can occur if you try to do a `SetAcl` on a file or folder that doesn't exist.

**Resolution**

Specify a file or folder that exists.

<a id="ERROR_DESTINATION_INVALID"></a>

## ERROR\_DESTINATION\_INVALID

**Diagnosis**

The computer name is mistyped, or the computer isn't reachable.

**Resolution**

Try to check if the computer name is valid. Try pinging the computer manually.

<a id="ERROR_DESTINATION_NOT_REACHABLE"></a>

## ERROR\_DESTINATION\_NOT\_REACHABLE

**Diagnosis**

Web Management Service or Remote Agent isn't installed or unreachable on the remote computer.

**Resolution**

Verify that Remote Agent Service or Web Management Service is started on the remote computer, depending on which one you are connecting to. You can execute `net start wmsvc` and `net start msdepsvc` on the remote computer to ensure these services are started. Also, ensure that a firewall isn't interrupting communications with the destination.

<a id="ERROR_USER_UNAUTHORIZED"></a>

## ERROR\_USER\_UNAUTHORIZED

**Diagnosis**

This error code may be shown because of various reasons. It typically indicates an authentication or authorization problem, and can happen because of any of the following reasons:

- The user doesn't exist.
- The user doesn't have IIS Manager access to site if connecting using Web Management Service.
- The site doesn't exist.
- The password is incorrect.

**Resolution**

To connect using the Web Management Service, follow these steps:

1. Verify that the username and password are correct.
1. Verify that the site exists.
1. Verify that you have the IIS Manager Permissions to the site's scope.

To connect using the Remote Agent Service, follow these steps:

1. Verify that the username and password are correct.
1. Verify that the user account you specified is a member of the Administrators group on the remote computer.

    > [!NOTE]
    > If you aren't using the built-in administrator, create a new group called the "MSDepSvcUsers" group and add your new administrator to that group.

1. Verify that the site exists.

<a id="ERROR_USER_NOT_ADMIN"></a>

## ERROR\_USER\_NOT\_ADMIN

**Diagnosis**

The ERROR\_USER\_NOT\_ADMIN code is shown if you try to connect to the Remote Agent Service but haven't provided appropriate administrator credentials.

**Resolution**

The Remote Agent Service accepts either built-in Administrator or Domain Administrator credentials. If you have a non-domain setup and want to use an account other than built-in administrator, do the following steps:

1. Create a separate user group `MSDepSvcUsers` on remote computer.
1. Create a local account `A` on both local and remote computer.
1. Add `A` to `MSDepSvcUsers` on remote computer.
1. Use account `A` to publish, this allows you to publish without the need of a built-in admin account.

<a id="ERROR_CERTIFICATE_VALIDATION_FAILED"></a>

## ERROR\_CERTIFICATE\_VALIDATION\_FAILED

**Diagnosis**

The certificate presented by the Web Deploy endpoint is untrusted or invalid. This typically happens if the remote server has a self-signed certificate for the Remote Agent Service or the Web Management Service.

**Resolution**

Either install a trusted certificate on the endpoint or try bypassing certificate validation.

1. From the *msdeploy.exe* command line, pass the `-allowUntrusted` flag.
1. From the Visual Studio publish UI, check `Allow Untrusted`.
1. From a Visual Studio deployment package (For example, *MyApp.deploy.cmd*), pass the `-allowUntrusted` flag.
1. Add `<AllowUntrustedCertificate>true</AllowUntrustedCertificate>` to the pubxml file:

    ```xml
    <PropertyGroup>
      <AllowUntrustedCertificate>true</AllowUntrustedCertificate>
    </PropertyGroup>
    ```

<a id="ERROR_PROXY_GATEWAY"></a>

## ERROR\_PROXY\_GATEWAY

**Diagnosis**

A proxy gateway is preventing Web Deploy from communicating with the remote Web Deploy endpoint.

**Resolution**

Web Deploy doesn't read system proxy settings. As a workaround, try disabling the system proxy by doing the following steps:

1. Start Internet Explorer.
1. Select **Tools** > **Options**.
1. Select **Connection**.
1. Select **LAN Settings**.
1. Disable all checkboxes.

<a id="ERROR_SITE_DOES_NOT_EXIST"></a>

## ERROR\_SITE\_DOES\_NOT\_EXIST

**Diagnosis**

The specified IIS site doesn't exist.

**Resolution**

Verify that the specified site actually exists. Sometimes, you may get this error if you have specified `/` instead of `\` in site URL. Try changing `/` to `\`.

<a id="ERROR_APP_DOES_NOT_EXIST"></a>

## ERROR\_APP\_DOES\_NOT\_EXIST

**Diagnosis**

The specified application doesn't exist in IIS.

**Resolution**

Check IIS Manager to make sure you have correctly specified the name of the application path.

<a id="ERROR_USER_NOT_AUTHORIZED_FOR_IISAPP"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_DBFULLSQL"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_DBMYSQL"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_SETACL"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_APPPOOLNETFX"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_APPPOOLPIPELINE"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_RECYCLEAPP"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_CREATEAPP"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_CONTENTPATH"></a>

## ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_IISAPP,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_DBFULLSQL,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_DBMYSQL,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_SETACL,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_APPPOOLNETFX,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_APPPOOLPIPELINE,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_RECYCLEAPP,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_CREATEAPP,  
ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_CONTENTPATH

The group of errors listed share the following diagnosis, resolution, and workaround:

**Diagnosis**

A non-administrative user attempted to perform an operation with a Web Deploy provider for which the user is n't currently authorized.

**Resolution**

Web Deploy setup, by default, creates Management Service Delegation Rules, which allow non-administrators to perform operations with this provider. Check that the delegation rule required for this provider has been set up correctly.  

**Workaround**

 From the **Programs** > **Control Panel**, run **Repair** on Web Deploy. Alternatively, create the delegation rule [manually](/iis/publish/using-web-deploy/configure-the-web-deployment-handler).

<a id="ERROR_USER_NOT_AUTHORIZED_FOR_DEPLOYMENTPROVIDER"></a>

## ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_DEPLOYMENTPROVIDER

**Diagnosis**

A non-administrative user attempted to perform an operation with a Web Deploy provider for which the user isn't currently authorized. This error code is shown if you try to perform an operation with a provider for which Web Deploy's setup doesn't create a delegation rule.

**Resolution**

The Web Deploy setup doesn't create a delegation rule for this provider. Create the delegation rule [manually](/iis/publish/using-web-deploy/configure-the-web-deployment-handler).

<a id="ERROR_INSUFFICIENT_ACCESS_TO_SITE_FOLDER"></a>

## ERROR\_INSUFFICIENT\_ACCESS\_TO\_SITE\_FOLDER

**Diagnosis**

This error can occur when you try to connect over the Web Management Service as a non-administrator:

- To connect using IIS Manager credentials, the Web Management Service's identity (typically Local Service) needs Full Control permissions on the site's root folder to be able to create files and folders underneath.
- To connect using Windows credentials, the Windows user needs full control over the site's root folder to be able to create files and folders.

**Resolution**

Grant the appropriate account Full Control on the site's root folder. Alternatively, do the following steps:

1. Start **IIS Manager** and right click on the site in question.
1. Click **Deploy** > **Configure** for Web Deploy Publishing.
1. Select an appropriate user name.
1. Click **Setup**.

<a id="ERROR_INSUFFICIENT_ACCESS_TO_APPHOSTCONFIG_"></a>

## ERROR\_INSUFFICIENT\_ACCESS\_TO\_APPHOSTCONFIG

**Diagnosis**

The RunAs identity specified for the createApp delegation rule needs Write access to the IIS server's *applicationHost.config* file.

**Resolution**

Provide Write access to the IIS server's *applicationHost.config* file for the RunAs identity of the createApp delegation rule.

<a id="ERROR_INVALID_CONNECTION_STRING"></a>

## ERROR\_INVALID\_CONNECTION\_STRING

**Diagnosis**

An invalid database connection string was specified which caused a `dbFullSql` or `dbMySql` provider to not run correctly. This error can happen if a connection string is malformed (Example, Se ***v*** ver=localhost;...) or if the connection string contains keys, which the target database server doesn't recognize.

**Resolution**

Verify that the connection string is valid.

<a id="ERROR_SQL_EXECUTION_FAILURE"></a>

## ERROR\_SQL\_EXECUTION\_FAILURE

**Diagnosis**

A SQL script execution failure occurred.

**Resolution**

This error can happen for many reasons. For more information, see [Web development on Windows](https://www.microsoft.com/web).

<a id="ERROR_TYPE_NOT_FOUND_IN_ASSEMBLY"></a>

## ERROR\_TYPE\_NOT\_FOUND\_IN\_ASSEMBLY

**Diagnosis**

The `dbFullSql` provider of Web Deploy requires Server Management Objects version 10 or higher.

**Resolution**

The SQL provider can't run because of a missing dependency. Make sure that Microsoft SQL Server Management Objects (Version 10 or higher) is installed.

<a id="ERROR_OBJECT_TO_BE_DELETED_DOES_NOT_EXIST"></a>

## ERROR\_OBJECT\_TO\_BE\_DELETED\_DOES\_NOT\_EXIST

**Diagnosis**

Web Deploy originally found an object to be deleted but when it tried to delete it, the object was missing.

**Resolution**

Make sure there are no other external processes that are modifying the target while performing a sync.

<a id="ERROR_APPPOOL_VERSION_MISMATCH"></a>

## ERROR\_APPPOOL\_VERSION\_MISMATCH

**Diagnosis**

The source application pool version is different from the destination application pool version.

**Resolution**

You can manually change the application pool versions to match between the source and destination, or use the `apppoolnetfx` provider to do it automatically.

<a id="ERROR_CENTRAL_CERT_STORE_SETTINGS_CANNOT_BE_READ"></a>

## ERROR\_CENTRAL\_CERT\_STORE\_SETTINGS\_CANNOT\_BE\_READ

**Diagnosis**

The central certificate store can't be used in your current configuration.

**Resolution**

You need to make sure that you're using IIS 8 or later. If you're running *msdeploy.exe* on a 64-bit server, make sure that you're using the 64-bit version of the executable.

<a id="ERROR_CENTRAL_CERT_STORE_NOT_CONFIGURED_PROPERLY"></a>

## ERROR\_CENTRAL\_CERT\_STORE\_NOT\_CONFIGURED\_PROPERLY

**Diagnosis**

The Centralized SSL Certificate Store is either not installed or set up properly. This feature is also not supported on IIS 7.5 or earlier.

**Resolution**

Verify that the server you're syncing to or from is running IIS 8 or later. Also verify that the Centralized SSL Certificate Store is installed and configured on that server.

<a id="ERROR_MISSING_REQUIRED_DEPENDENCIES"></a>

## ERROR\_MISSING\_REQUIRED\_DEPENDENCIES

**Diagnosis**

The AppHostAuthOverride provider requires IIS 7 or later.

**Resolution**

Make sure that the destination server you're modifying is running IIS 7 or later.

<a id="ERROR_COULD_NOT_CONNECT_TO_REMOTESVC"></a>

## ERROR\_COULD\_NOT\_CONNECT\_TO\_REMOTESVC

**Diagnosis**

Web Deploy can't connect to the remote service.

**Resolution**

Ensure that:

- You can ping the remote machine.
- The `msdepsvc` or `wmsvc` service is started on the remote server.
- Your firewall is not blocking incoming connections of your ports on the destination. If you used the default installation, then it would be 80 for `msdepsvc` and 8172 for `wmsvc`.

<a id="ERROR_FRAMEWORK_VERSIONS_DO_NOT_MATCH"></a>

## ERROR\_FRAMEWORK\_VERSIONS\_DO\_NOT\_MATCH

**Diagnosis**

The ERROR\_FRAMEWORK\_VERSIONS\_DO\_NOT\_MATCH error can occur if you're doing a web server sync between two machines that have different versions of .NET installed.

**Resolution**

By default, Web Deploy prefers using the .NET version specified in its configuration file. If the version of .NET that Web Deploy is using on the client is different from the version on the server, a Web Server sync is blocked to prevent settings from different versions of .NET from being migrated. To resolve this problem, you have two options:

1. Use the `netFxVersion` provider setting to inform Web Deploy exactly which .NET settings to migrate. Here is a command line example, which forces Web Deploy to sync .NET settings:

   `msdeploy.exe -verb:sync -source:webserver,machineconfig32.netfxversion=2,machineconfig64.netfxversion=2,rootwebconfig32.netfxversion=2,rootwebconfig64.netfxversion=2 -dest:webserver,machineconfig32.netfxversion=2,machineconfig64.netfxversion=2,rootwebconfig32.netfxversion=2,rootwebconfig64.netfxversion=2,computername=destServername`

2. Run Web Deploy in the same version of .NET between client and server. On the client side, change the order of the `supportedRuntime` version element in the `%programfiles%\IIS\Microsoft Web Deploy V3\msdeploy.exe.config` file for the version of .NET that's specified first (see [gacInstall provider](https://technet.microsoft.com/library/gg607836(v=WS.10).aspx) for an example). This indicates the version of .NET, assuming it's installed on your system. On the server side, you can do the same for `%programfiles%\IIS\microsoft web deploy\msdepsvc.exe.config`. If you modify this file, make sure to restart the Web Deployment Agent Services that is the `net stop msdepsvc` and `net start msdepsvc`.

<a id="ERROR_HTTPCERT_BINDING_NOT_FOUND"></a>

## ERROR\_HTTPCERT\_BINDING\_NOT\_FOUND

**Diagnosis**

The specified binding couldn't be found.

**Resolution**

Run `netsh http show sslcert` from the command line to verify that the specified binding exists. If it's not found, then you may need to recreate it through IIS Manager.

<a id="ERROR_INCORRECT_PARAMETER_TAG"></a>

## ERROR\_INCORRECT\_PARAMETER\_TAG

**Diagnosis**

An incorrect parameter tag was passed.

**Resolution**

Re-run Microsoft Deploy with the SQL, SQLCE, or MYSQL tag.

<a id="ERROR_INVALID_PATH"></a>

## ERROR\_INVALID\_PATH

**Diagnosis**

The provider path is invalid.

**Resolution**

The path for your provider may differ depending on the provider you use. See [Web Deploy Providers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd569040(v=ws.10)) to know more about the provider you're using.

<a id="ERROR_INVALID_SETTING_SPECIFIED"></a>

## ERROR\_INVALID\_SETTING\_SPECIFIED

**Diagnosis**

The provider setting specified is invalid.

**Resolution**

See [Web Deploy Providers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd569040(v=ws.10)) to know more about the provider you're using.

<a id="ERROR_INVALID_SETTING_VALUE_SPECIFIED"></a>

## ERROR\_INVALID\_SETTING\_VALUE\_SPECIFIED

**Diagnosis**

The provider setting value is invalid.

**Resolution**

See [Web Deploy Providers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd569040(v=ws.10)) to know more about the provider you're using.

<a id="ERROR_SNI_BINDINGS_NOT_SUPPORTED"></a>

## ERROR\_SNI\_BINDINGS\_NOT\_SUPPORTED

**Diagnosis**

SNI Bindings are only supported on IIS 8 or later.

**Resolution**

SNI Bindings can only be created on IIS 8 or later.

<a id="ERROR_FAILED_TO_RESTORE_BACKUP"></a>

## ERROR\_FAILED\_TO\_RESTORE\_BACKUP

**Diagnosis**

Web Deploy was unable to restore a backup.

**Resolution**

Verify the following points:

- The backup specified exists on the server.
- If there is a database within the backup, a connection string is specified in the connection string provider setting.

<a id="ERROR_BACKUPS_ARE_NOT_CONFIGURED_PROPERLY"></a>

## ERROR\_BACKUPS\_ARE\_NOT\_CONFIGURED\_PROPERLY

**Diagnosis**

The backup feature isn't configured properly on the destination server.

**Resolution**

Check the event logs for hints on which settings are misconfigured. Validate that the settings stored in the *applicationHost.config* file conform to the IIS schema file *BackupManagerSchema.xml*.

<a id="ERROR_CANNOT_CREATE_BACKUP"></a>

## ERROR\_CANNOT\_CREATE\_BACKUP

**Diagnosis**

Web Deploy failed to create a new backup on the destination server.

**Resolution**

Verify that:

- If you're doing an `appHostConfig` provider sync, make sure that the path for the provider isn't empty.
- If there are multiple providers in a manifest that uses virtual paths, make sure that all paths point to the same application.
- If you're performing a manual backup, make sure that the feature is turned ON in the server backup settings.
- Check the server event logs if the error message returned to the client doesn't contain the required information.

<a id="ERROR_SETTING_IS_READ_ONLY"></a>

## ERROR\_SETTING\_IS\_READ\_ONLY

**Diagnosis**

The backup setting that you're trying to set is marked as read only and can't be set.

**Resolution**

The server administrator needs to mark the backup setting as "settable" in the *applicationHost.config* file by either manually updating the file, or by using Web Deploy's PowerShell scripts.

<a id="ERROR_FILE_IN_USE"></a>

## ERROR\_FILE\_IN\_USE

**Diagnosis**

A destination file can't be overwritten or deleted because it is currently in use.

**Resolution**

Make sure that the destination file isn't in use before performing a sync. If you're syncing content to a web site hosted on IIS 7 or later (using the `appHostConfig`, `iisApp`, or `contentPath` providers), consider taking the application offline during the sync by enabling the `appOffline` rule.

You can configure the `appOffline` rule in the publishing profile (*.pubxml*). Add the `EnableMSDeployAppOffline` element to the `PropertyGroup` like this:

```xml
<PropertyGroup>
  <EnableMSDeployAppOffline>true</EnableMSDeployAppOffline>
</PropertyGroup>
```

<a id="ERROR_FAILED_TO_BRING_APP_ONLINE"></a>

## ERROR\_FAILED\_TO\_BRING\_APP\_ONLINE

**Diagnosis**

Web Deploy wasn't able to remove the *app_offline.htm* file from the site after the sync has completed.

**Resolution**

You may either rerun the sync with the `appOffline` rule enabled, or manually delete the *app_offline.htm* file from the root of your site on the destination server. For details on the reason for the failure, check the server event logs.

You can configure the `appOffline` rule in the publishing profile (*.pubxml*). Add the `EnableMSDeployAppOffline` element to the `PropertyGroup` like this:

```xml
<PropertyGroup>
  <EnableMSDeployAppOffline>true</EnableMSDeployAppOffline>
</PropertyGroup>
```

<a id="ERROR_HIGHER_FXVERSION_REQUIRED"></a>

## ERROR\_HIGHER\_FXVERSION\_REQUIRED

**Diagnosis**

Web Deploy failed to perform a sync using SQL Dedicated Administrator Connection (DAC) because SQL DAC requires .NET 4.0.

**Resolution**

Ensure that the server making the SQL connection using DAC has .NET 4.0 installed. If you're connecting using the *msdeploy.exe* client, ensure that it has .NET 4.0 listed as its first option in the *msdeploy.exe* config file. If you're connecting to the `msdepsvc` server endpoint (Web Deployment Agent service), ensure that it has .NET 4.0 listed as its first option in the `msdepsvc.exe` config file.

<a id="ERROR_MAX_NUM_APPLICATIONS_EXCEEDED"></a>

## ERROR\_MAX\_NUM\_APPLICATIONS\_EXCEEDED

**Diagnosis**

You have created more web applications than allowed on the target server.

**Resolution**

Request more applications from your server administrator or delete some of your existing applications.

<a id="ERROR_API_NOT_SUPPORTED"></a>

## ERROR\_API\_NOT\_SUPPORTED

**Diagnosis**

The API being called doesn't exist on the target server because the server is using an earlier version of Web Deploy.

**Resolution**

Install the latest version of Web Deploy on the server.

<a id="DacFxNeededForSQLProvider"></a><a id="ERROR_SCRIPTDOM_NEEDED_FOR_SQL_PROVIDER"></a><a id="ERROR_SQLCLRTYPES_NEEDED_FOR_SQL_PROVIDER"></a>

## DacFxNeededForSQLProvider, ERROR\_SCRIPTDOM\_NEEDED\_FOR\_SQL\_PROVIDER, ERROR\_SQLCLRTYPES\_NEEDED\_FOR\_SQL\_PROVIDER

The group of three errors share the following diagnosis and resolution:

**Diagnosis**

SQL DAC and its dependencies aren't installed.

**Resolution**

Use Web Platform Installer to install:

- Microsoft SQL Server 2012 Data-Tier Application Framework
- SQL Server 2012 Transact-SQL ScriptDom
- SQL Server System CLR Types 11.0

<a id="ERROR_PACKAGE_TOO_LARGE"></a>

## ERROR\_PACKAGE\_TOO\_LARGE

**Diagnosis**

The package or backup being created exceeds the maximum size of 4 GB.

**Resolution**

Use the `archiveDir` provider when creating a package instead. Now, there is no solution for this limit with respect to automatic backups.

<a id="ERROR_TIMED_OUT"></a>

## ERROR\_TIMED\_OUT

**Diagnosis**

MySqlDump took too long to respond to a given query.

**Resolution**

You can change how long Web Deploy waits for MySqlDump to return from a query by changing the value of the `WaitAttemptsSettingInfo` and `WaitIntervalSettingInfo` provider settings.

<a id="ERROR_ASSEMBLY_NOT_FOUND"></a>

## ERROR\_ASSEMBLY\_NOT\_FOUND

**Diagnosis**

Required dependencies couldn't be loaded.

**Resolution**

If you installed Web Deploy manually through the MSI, try reinstalling Web Deploy using Web Platform Installer, which helps to install required dependencies for you.

<a id="ERROR_SMO_NEEDED_FOR_SQL_PROVIDER"></a><a id="ERROR_USER_NOT_AUTHORIZED_FOR_IISAPP"></a><a id="ERROR_SCRIPTER_NEEDED_FOR_SQLCE_PROVIDER"></a>

## ERROR\_SMO\_NEEDED\_FOR\_SQL\_PROVIDER, ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_IISAPP, ERROR\_SCRIPTER\_NEEDED\_FOR\_SQLCE\_PROVIDER

The error codes ERROR\_SMO\_NEEDED\_FOR\_SQL\_PROVIDER, ERROR\_USER\_NOT\_AUTHORIZED\_FOR\_IISAPP, and 
ERROR\_SCRIPTER\_NEEDED\_FOR\_SQLCE\_PROVIDER codes share the following diagnosis and resolution:

**Diagnosis**

SQL Shared Management Objects (SMO) wasn't found or the installed version is too old.

**Resolution**

Install the latest version of SMO using Web Platform Installer.

<a id="ERROR_CANNOT_CONNECT_TO_DATABASE"></a>

## ERROR\_CANNOT\_CONNECT\_TO\_DATABASE

**Diagnosis**

This error occurs because a connection couldn't be made to a database.

**Resolution**

Verify that:

- Your connection string is correct.
- The account specified in the connection string has access to the database.
- The database server you are connecting to allows remote connections.
- The database server can be accessed from the machine running Web Deploy. If you are connecting to a remote Web Deploy server and specified a database, then you need to make sure that the remote Web Deploy server has access to your database.

<a id="ERROR_DACPAC_EXTRACTION_TIMEDOUT"></a>

## ERROR\_DACPAC\_EXTRACTION\_TIMEDOUT

**Diagnosis**

The DAC PAC action took too long to complete.

**Resolution**

Increase the amount of time that Web Deploy waits for a command to complete by specifying the `CommandTimeout` provider setting.

## ERROR\_NOT\_SUPPORTED

**Diagnosis**

Azure Websites doesn't support creating new virtual applications or modifying existing application configuration on the server during a Web Deploy publish operation.

**Resolution**

You can create new virtual applications or modify existing configuration settings for your website through the Azure portal (https://portal.azure.com/). To do this,

1. Log in to the portal.
1. Open your site settings.
1. Select the **Configure** tab.
1. In the **Configure** tab, modify your site to match the configuration settings of the application you're trying to deploy. In most cases, this is simply a matter of changing the .NET Framework version, but in some cases this may also require you to add a new virtual application.

## ERROR\_EXCEPTION\_WHILE\_CREATING\_OBJECT

Typically, this indicates an issue with validating the providers on the source. For instance, if you're trying to sync content from a source file share and you don't have access to the file share, you may see this error code. For such issues, ensure that you have access to all of the source data you would like to publish from.

## ERROR\_EXECUTING\_METHOD

A generic error code to indicate that there was a problem publishing a database. Typically the stack trace and message associated with this code should indicate the actual error being thrown by either SQL Management Objects or SQL Data-Tier Application Framework.
