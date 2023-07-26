---
title: Troubleshoot Web Deploy problems with Visual Studio
description: The article helps you troubleshoot a series of errors when trying to publish from Visual Studio to a server that hasn't been correctly configured via Web Deploy.
ms.date: 04/09/2012
ms.custom: sap:Deployment and migration
ms.technology: iis-deployment-migration
ms.reviewer: johnhart, hulopesv, v-sidong
---
# Troubleshoot Web Deploy problems with Visual Studio

_Applies to:_ &nbsp; Internet Information Services

This article helps you troubleshoot a series of errors when trying to publish from Visual Studio to a server that hasn't been correctly configured via Web Deploy. Although the article is written for specific product versions, the concepts could be applied to newer versions as well.

To collect the following screenshots and errors, use a new ASP.Net MVC 3 project in Visual Studio 2010 SP1. The destination server was a clean install of Windows Server 2008 R2 SP1 with Internet Information Services (IIS). No other configuration was done.

## Cannot connect to the server

The first error you're likely to encounter will look like the following screenshot in Visual Studio's output window. For improved readability, the full text of the message is provided below the screenshot:

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/error-list.png" alt-text="Screenshot that shows the Error List output in Visual Studio." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/error-list.png":::

```Output
Web deployment task failed.(Could not connect to the destination computer ("deployserver").On the destination computer, make sure that Web Deploy is installed and that the required process("The Web Management Service") is started.)
This error indicates that you cannot connect to the server. Make sure the service URL is correct,firewall and network settings on this computer and on the server computer are configured properly,and the appropriate services have been started on the server.
Error details:
Could not connect to the destination computer ("deployserver"). On the destination computer,
make sure that Web Deploy is installed and that the required process
("The Web Management Service") is started.
Unable to connect to the remote server
A connection attempt failed because the connected party did not properly respond after a period
of time, or established connection failed because connected host has failed to respond 1.1.1.1:8172
```

The text highlighted in this error (and the other errors below) is the key to understanding the nature of the problem. Web Deploy didn't get a reply from the server, so Visual Studio can't distinguish between several possible causes. As a result, it gives a list of things to try.

**Is the web management service installed?**

On the IIS server, open **Internet Information Services (IIS) Manager** and select the machine name node. In the **Features** view, scroll down to the **Management** section and look for these icons:

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/management-section-icons.png" alt-text="Screenshot that shows the IIS Manager Permissions icon, IIS Manager Users icon, and Management Service icon." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/management-section-icons.png":::

If they aren't there, you need to install the Management Service through the **Add Role Services** dialog. It can also be installed via the Web Platform Installer from the **Products** tab. Select **Server** in the left column and select **IIS: Management Service**.

> [!NOTE]
> After you install the Management Service, you need to start it, as it isn't started automatically. To do this, double-click the **Management Service** icon. After the **Management Service** pane is displayed, select **Start** in the **Actions** pane on the right.

**Is the service URL correct?**

By default, the Web Management Service listens on port 8172, but this can be changed. The easiest way to check what port is being used is to open the **Management Service** pane as described above, and look at the IP and port information in the Connections section. If the port has been changed to something other than 8172, you need to ensure the new port is allowed through the firewall, and update the service URL in Visual Studio's publishing settings to use the new port.

## (403) Forbidden

Once the Web Management Service is installed, Visual Studio may show the following error:

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/troubleshooting-web-deploy-problems-with-visual-studio-1118.png" alt-text="Screenshot that shows the Error List screen in Visual Studio." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/troubleshooting-web-deploy-problems-with-visual-studio-1118.png":::

```Output
Web deployment task failed.(Could not connect to the destination computer ("deployserver") using
the specified process ("The Web Management Service") because the server did not respond.
Make sure that the process ("The Web Management Service") is started on the destination computer.)
Could not connect to the destination computer ("deployserver") using the specified process
("The Web Management Service") because the server did not respond. Make sure that the process
("The Web Management Service") is started on the destination computer.
The remote server returned an error: (403) Forbidden.
```

This message is somewhat misleading. It states that the server didn't respond, but the 403 error indicates that Web Deploy could contact the server, but the request was actively refused. The HTTP log for the Web Management Service can help confirm the request reached the server and provide details about the actual request that failed. This log can be found at `%SystemDrive%\Inetpub\logs\WMSvc` by default. Like other IIS logs, data isn't written to the log immediately, so you may have to wait a couple of minutes to see the request or restart the Web Management Service to flush the log.

In the `WMSVC` log, the error mentioned above looks like the following one:

```Output
2011-06-02 17:59:05 192.168.0.211 POST /msdeploy.axd site=default%20web%20site 8172 - 192.168.0.203 - 403 6 5 1669
```

The `6` after the `403` in the log is the sub-status code, and means that the IP address was rejected. A complete list of the status and sub-status codes for IIS can be found at [HTTP status codes in IIS](../www-administration-management/http-status-code.md).

**Is the Management Service configured to allow remote connections?**

This is the most likely reason for the 403.6 response. Double-click the **Management Service** icon, and verify that **Enable Remote Connections** is checked. You must stop the service to make changes, so be sure to restart it when you're done.

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/management-service-configured-allow-remote-connections.png" alt-text="Screenshot that shows the Management Service dialog box." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/management-service-configured-allow-remote-connections.png":::

**Has the web management service been allowed through Windows Firewall?**

When you install the Web Management Service on the server, an inbound firewall rule is named Web Management Service (HTTP Traffic-In). Verify that this rule is enabled by going to **Start** > **AdministrativeTools** > **Windows Firewall with Advanced Security**. Select **Inbound Rules** and find the **Web Management** rule in the list. It should be enabled for all profiles.

If you're using a third-party firewall, you need to ensure that inbound connections on port 8172 are allowed.

**Have IP restrictions been configured for the Management Service?**

The other common reason you could get a 403 error is if the management service has been configured to deny the IP of the client. By default, it's configured to allow all IPs as long as remote connections are allowed. You can check for IP restrictions by double-clicking the **Management Service** icon. Any configured IP restriction rules are at the bottom of the page in the IPv4 Address Restrictions.

## (404) Not Found

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/ip-restrictions-configured-management-service.png" alt-text="Screenshot that shows the Error List page in Visual Studio. Error Details are in focus." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/ip-restrictions-configured-management-service.png":::

```Output
Web deployment task failed.(Could not connect to the destination computer ("deployserver").
On the destination computer, make sure that Web Deploy is installed and that the required process
("The Web Management Service") is started.
The requested resource does not exist, or the requested URL is incorrect.
Error details: Could not connect to the destination computer ("deployserver").
On the destination computer, make sure that Web Deploy is installed and that the required process
("The Web Management Service") is started.
The remote server returned an error: (404) Not Found.
```

The 404 error indicates that Web Deploy was able to contact the Web Management Service on the server but couldn't find what it needed. The first thing to do is confirm what resource Web Deploy tried to connect to. If you look in the Web Management Service log under *%SystemDrive%\\Inetpub\\logs\\WMSvc* on the destination server, you see an entry in the `WMSVC` log that looks like the following one:

```Output
2011-05-12 15:21:50 192.168.0.211 POST /msdeploy.axd site=default%20web%20site 8172 - 192.168.0.203 - 404 7 0 1606
```

*Msdeploy.axd* is the handler for Web Deploy requests.

**Is Web Deploy installed?**

You can verify that Web Deploy is installed by going to the **Programs and Features** control panel and looking for **Microsoft Web Deploy 2.0** in the list of installed programs. If it isn't there, you can install it via the Web Platform Installer by going to the **Products** tab. It's listed as **Web Deployment Tool 2.1**. You should also ensure the Web Deployment Agent Service (MsDepSvc) is running.

**Is the web deployment handler installed?**

If Web Deploy is installed and you still get this error, make sure the IIS 7 Deployment Handler feature in Web Deploy is installed. In the **Programs and Features** control panel, find **Microsoft Web Deploy 2.0**, right-click and select **Change**. In the Wizard that comes up, select **Next** on the first page and then select **Change** on the second page. Add **IIS 7 Deployment Handler** and everything under it.

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/web-deploy-set-up.png" alt-text="Screenshot that shows the Microsoft Web Deploy 2 dot 0 Setup dialog box. Web Deployment Framework is highlighted." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/web-deploy-set-up.png":::

Select **Next** to complete the Wizard. You need to restart the web management service after making this change.

## (401) Unauthorized

Once Web Deploy and the Web Management Service are correctly configured, you need to set up delegation rules to allow users to update content. For permissions issues, there are several different errors you may see in Visual Studio. For example:

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/errors-delegation-rules.png" alt-text="Screenshot that shows the Error List in Visual Studio displaying permission issue errors." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/errors-delegation-rules.png":::

```Output
Web deployment task failed.(Connected to the destination computer ("deployserver")
using the Web Management Service, but could not authorize.
Make sure that you are using the correct user name and password, that the site you are connecting
to exists, and that the credentials represent a user who has permissions to access the site.
Make sure the site name, user name, and password are correct. If the issue is not resolved,
please contact your local or server administrator.
Error details:
Connected to the destination computer ("deployserver") using the Web Management Service,
but could not authorize. Make sure that you are using the correct user name and password,
that the site you are connecting to exists, and that the credentials represent a user who
has permissions to access the site.
The remote server returned an error: (401) Unauthorized.
```

In the WMSvc log, you can see the following message:

```Output
2011-05-12 15:50:12 192.168.0.211 POST /msdeploy.axd site=default%20web%20site 8172 - 192.168.0.203 - 401 2 5 1653
2011-05-12 15:50:12 192.168.0.211 POST /msdeploy.axd site=default%20web%20site 8172 user1 192.168.0.203 - 401 1 1326 124
```

The highlighted http status in the Visual Studio output is an Access Denied error. The highlighted win32 status in the error log maps to "Logon failure: unknown user name or bad password," so this is a simple logon failure. If the user is authenticated but doesn't have the rights needed to publish, the log entry looks like the following one:

```Output
2011-05-12 15:55:38 192.168.0.211 POST /msdeploy.axd site=default%20web%20site 8172 - 192.168.0.203 - 401 2 5 0
```

To allow this user to publish, you need to set up delegation per the instructions at [Configure the Web Deployment Handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler).

## Operation not authorized

If the account is able to log in but hasn't been granted the rights needed to publish the content, you can see the following error message:

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/web-deployment-task-failed.png" alt-text="Screenshot that shows the Error List page in Visual Studio displaying an error related to user permissions." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/web-deployment-task-failed.png":::

```Output
Web deployment task failed. (Unable to perform the operation ("Create Directory")  for the specified
directory ("bin"). This can occur if the server administrator has not authorized this operation for
the user credentials you are using.
```

The `WMSvc` log shows HTTP 200 responses for these requests. Fortunately, Web Deploy 2.1 also writes information to the Microsoft Web Deploy service log. To view it, select **Event Viewer (Local)** > **Applications and Services Logs** > **Microsoft Web Deploy**.

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/microsoft-web-deploy.png" alt-text="Screenshot that shows the Event Viewer menu. Microsoft Web Deploy is highlighted." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/microsoft-web-deploy.png":::

For this particular error, the event log contains extra details (truncated for brevity):

```Output
User: DEPLOYSERVER\User1
Client IP: 192.168.0.203
Content-Type: application/msdeploy
Version: 8.0.0.0
MSDeploy.VersionMin: 7.1.600.0
MSDeploy.VersionMax: 7.1.1070.1
MSDeploy.Method: Sync
MSDeploy.RequestId: 50de0746-f10d-4640-9b3d-4ba773520e38
MSDeploy.RequestCulture: en-US
MSDeploy.RequestUICulture: en-US
Skip: objectName="^configProtectedData$"
Provider: auto, Path: 
Tracing deployment agent exception. Request ID '50de0746-f10d-4640-9b3d-4ba773520e38'. Request Timestamp: '5/12/2011 9:18:12 AM'. Error Details:
Microsoft.Web.Deployment.DeploymentDetailedUnauthorizedAccessException: Unable to perform the operation ("Create Directory")
for the specified directory ("C:\inetpub\wwwroot\bin"). This can occur if the server administrator has not authorized this
operation for the user credentials you are using.
---> Microsoft.Web.Deployment.DeploymentException: The error code was 0x80070005. ---> System.UnauthorizedAccessException:
Access to the path 'C:\inetpub\wwwroot\bin' is denied.
   at Microsoft.Web.Deployment.Win32Native.RaiseIOExceptionFromErrorCode(Win32ErrorCode errorCode, String maybeFullPath)
   at Microsoft.Web.Deployment.DirectoryEx.CreateDirectory(String path)
   at Microsoft.Web.Deployment.DirPathProvider.CreateDirectory(String fullPath, DeploymentObject source)
   at Microsoft.Web.Deployment.DirPathProvider.Add(DeploymentObject source, Boolean whatIf)
   --- End of inner exception stack trace ---
   --- End of inner exception stack trace ---
```

This message tells you where permissions need to be granted for this particular error. You may also see the following permissions error in Visual Studio:

:::image type="content" source="media/troubleshoot-web-deploy-problems-with-visual-studio/permissions-need-to-be-granted.png" alt-text="Screenshot that shows the Error List page in Visual Studio with a permissions error in focus." lightbox="media/troubleshoot-web-deploy-problems-with-visual-studio/permissions-need-to-be-granted.png":::

```Output
Web deployment task failed.((5/12/2011 11:31:41 AM) An error occurred when the request was processed on the remote computer.)

(5/12/2011 11:31:41 AM) An error occurred when the request was processed on the remote computer.
The server experienced an issue processing the request. Contact the server administrator for more information.
```

This particular error doesn't give you much to go on, but the picture becomes clearer if you look at the Web Deploy error log in Event Viewer.

```Output
User: DEPLOYSERVER\User1
Client IP: 192.168.0.203
Content-Type: application/msdeploy
Version: 8.0.0.0
MSDeploy.VersionMin: 7.1.600.0
MSDeploy.VersionMax: 7.1.1070.1
MSDeploy.Method: Sync
MSDeploy.RequestId: 63b2f3d1-1817-444f-8280-9fa4f6f85d53
MSDeploy.RequestCulture: en-US
MSDeploy.RequestUICulture: en-US
Skip: objectName="^configProtectedData$"
Provider: auto, Path: 
Tracing deployment agent exception. Request ID '63b2f3d1-1817-444f-8280-9fa4f6f85d53'. Request Timestamp: '5/12/2011 9:31:41 AM'. Error Details:
System.UnauthorizedAccessException: Attempted to perform an unauthorized operation.
   at System.Security.AccessControl.Win32.SetSecurityInfo(ResourceType type, String name, SafeHandle handle, SecurityInfos securityInformation, SecurityIdentifier owner, SecurityIdentifier group, GenericAcl sacl, GenericAcl dacl)
   at System.Security.AccessControl.NativeObjectSecurity.Persist(String name, SafeHandle handle, AccessControlSections includeSections, Object exceptionContext)
   at System.Security.AccessControl.NativeObjectSecurity.Persist(String name, AccessControlSections includeSections, Object exceptionContext)
   at Microsoft.Web.Deployment.FileSystemSecurityEx.Persist(String path)
   at Microsoft.Web.Deployment.SetAclProvider.Add(DeploymentObject source, Boolean whatIf)
   at Microsoft.Web.Deployment.DeploymentObject.Update(DeploymentObject source, DeploymentSyncContext syncContext)
   at Microsoft.Web.Deployment.DeploymentSyncContext.HandleUpdate(DeploymentObject destObject, DeploymentObject sourceObject)
   at Microsoft.Web.Deployment.DeploymentSyncContext.SyncChildrenOrder(DeploymentObject dest, DeploymentObject source)
   at Microsoft.Web.Deployment.DeploymentSyncContext.ProcessSync(DeploymentObject destinationObject, DeploymentObject sourceObject)
```

From this output, we can see that `User1` doesn't have the rights to set security information. In this case, the user doesn't have "Modify permissions" on the content. Granting "Change Permissions" to the content resolves the problem.

## Others

If you can't browse a .NET 4.0 application after it has been successfully published, it could be that .NET 4.0 hasn't been registered correctly with IIS. Other symptoms are that .NET 4.0 is installed, but there are no .NET 4.0 application pools or handler mappings in IIS. This happens when .NET 4.0 is installed before IIS is installed. To fix this problem, start an elevated command prompt and run this command:

```cmd
%systemdrive%\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -iru
```

## More information

- [Configure the Web Deployment Handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler)
- [HTTP status codes in IIS](../www-administration-management/http-status-code.md)
- [Configuring Web Management Service Logging and Tracing](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee461173(v=ws.10))
