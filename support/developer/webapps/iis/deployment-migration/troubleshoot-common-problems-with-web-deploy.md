---
title: Troubleshoot common problems related to Web Deploy
description: This article describes how to diagnose and fix common problems with Web Deploy, including common errors seen while publishing from Visual Studio 2010.
ms.date: 04/20/2012
ms.custom: sap:Deployment and migration
ms.technology: iis-deployment-migration
ms.reviewer: johnhart, ellhamai, chihshen
ms.author: v-sidong
author: sevend2
---
# Troubleshoot common problems related to Web Deploy

This article describes how to diagnose and fix common problems with Web Deploy, including common errors seen while publishing from Visual Studio 2010.

## Logging

When you run into issues related to Web Deploy, there are several logging options depending on where the problem occurs. By default, Web Deploy logs to the Event Log under **Applications** > **Microsoft Web Deploy**. This is a great place to start looking for errors on the destination server.

If you can't diagnose the problem using the Event Log, here are some other options:

- Use Web Deploy MSI logs located under `%programfiles%\\IIS\\Microsoft Web Deploy v3` to diagnose installation problems.
- If Web Management Service or Remote Agent Service fails to start, see the errors by going to **Event Log** > **System for Service Control Manager**.
- You can further configure [tracing for Web Management Service](https://technet.microsoft.com/library/ee461173(WS.10).aspx).

## Error codes

For certain common error cases, Web Deploy will show a message and an error code that may be useful in getting more information to troubleshoot an issue. For a full list of error codes, see [https://go.microsoft.com/fwlink/?LinkId=221672](https://go.microsoft.com/fwlink/?LinkId=221672).

> [!NOTE]
> The error message may be different depending on how Web Deploy is invoked. For example, Microsoft WebMatrix chooses to show custom error messages instead of error codes, whereas the command line will always show error codes if they're logged.

## Installation problems

<a id="\_Toc295395132"></a>

### 1. Couldn't install Web Deploy on a valid OS

| **Symptoms** | The Operating System (OS) is correct, and the version and bitness of Web Deploy are correct, but the installation doesn't succeed. |
| --- | --- |
| **Root cause** | Unknown |
| **Fix/Workaround** | Look in the install log, located in `%programfiles%\\IIS\\Microsoft Web Deploy V2`. |

### 2. Web Deploy doesn't function after an upgrade

| **Symptoms** | Web Deploy doesn't work after a version upgrade. |
| --- | --- |
| **Root cause** | Web Deploy doesn't restart services after an upgrade. |
| **Fix/Workaround** | If you're upgrading an existing installation of Web Deploy, make sure to restart the handler and agent services by running the following commands at an administrative command prompt:<br> `net stop msdepsvc` <br>`net start msdepsvc` <br>`net stop wmsvc` <br>`net start wmsvc` |

### 3. Couldn't install Web Deploy 32-bit version on 64-bit hardware

| **Symptoms** | :::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-32-bit-on-64-bit.png" alt-text="Screenshot that shows the Web Deployment Tool Setup dialog box. The text shows that 32-bit version is incompatible with 64-bit Windows." lightbox="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-32-bit-on-64-bit.png"::: |
| --- | --- |
| **Root cause** | Trying to install 32-bit on 64-bit OS is a check inside the Web Deploy MSI that fails because it doesn't support WoW64 mode. |
| **Fix/Workaround** | Install the same version that matches the architecture of your OS. |

### 4. Couldn't install Web Deploy 64-bit version on 32-bit hardware

| **Symptoms** | :::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-64-bit-on-32-bit.png" alt-text="Screenshot that shows the Windows Installer dialog box. The text says that This installation package isn't supported by this processor type. Contact your product vendor." lightbox="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-64-bit-on-32-bit.png"::: |
| --- | --- |
| **Root cause** | Trying to install 64-bit on 32-bit OS is a check inside Web Deploy's MSI that will fail. |
| **Fix/Workaround** | Install the same version that matches the architecture of your OS. |

### 5. Couldn't register the URL namespace due to pre-existing namespace

| **Symptoms** | Unable to install Web Deploy. |
| --- | --- |
| **Root cause** | The URL namespace that Web Deploy tries to create during installation is already registered. |
| **Fix/Workaround** | - Remove the conflicting registration. <br>- Change Web Deploy URL during installation <br>`msiexec /i wdeploy.msi /passive ADDLOCAL=ALL LISTENURL=http://+:8080/MSDEPLOY2/`. <br>For more information about URL customization, see [Customizing and Securing the Remote Service](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd569093(v=ws.10)). |

## Remote Agent Service problems

### 1. Couldn't initialize Microsoft.Web.Deployment.Dll during start-up

| **Symptoms** | Remote Agent Service fails to start. |
| --- | --- |
| **Root cause** | *msdepsvc.exe* or other files are missing from `%programfiles%\\IIS\\Microsoft Web Deploy v2`. |
| **Fix/Workaround** | Reinstall the product. |

<a id="\_Toc239408310"></a>

### 2. Remote Agent Service isn't started

| **Symptoms** | Microsoft.Web.Deployment.DeploymentAgentUnavailableException: Remote agent (URL `http://DestinationServer/msdeployagentservice`) could not be contacted. Make sure the remote agent service is installed and started on the target computer. ---&gt; System.Net.WebException: The remote server returned an error: (404) Not Found. |
| --- | --- |
| **Root cause** | Remote Agent Service isn't started. |
| **Fix/Workaround** | Start the service: `net start msdepsvc`. |

### 3. Trying to connect to a server where HTTP isn't listening or allowed

| **Symptoms** | Microsoft.Web.Deployment.DeploymentAgentUnavailableException: Remote agent (URL `http://DestinationServer/msdeployagentservice`) could not be contacted. Make sure the remote agent service is installed and started on the target computer. ---&gt; System.Net.WebException: Unable to connect to the remote server ---&gt; System.Net.Sockets.SocketException: No connection could be made because the target machine actively refused it DestinationServer:80 |
| --- | --- |
| **Root cause** | HTTP isn't listening. |
| **Fix/Workaround** | Make sure HTTP traffic is allowed to the Remote Agent Service. |

### 4. Trying to connect to a server with the Method Not Allowed error

| **Symptoms** | Microsoft.Web.Deployment.DeploymentException: Could not complete the request to remote agent URL '`http://DestinationServer/`'. ---&gt; System.Net.WebException: The remote server returned an error: (405) Method Not Allowed. |
| --- | --- |
| **Root cause** | The request was picked up by Internet Information Services (IIS) itself instead of MS Deploy because the path to *msdepsvc.exe* is missing. |
| **Fix/Workaround** | Change the URL to include `/MSDeployAgentService`. |

### 5. Trying to access Remote Agent Service as a non-administrator

| **Symptoms** | Microsoft.Web.Deployment.DeploymentException: Could not complete the request to remote agent URL '`http://DestinationServer/msdeployAgentService`'. ---&gt; System.Net.WebException: The remote server returned an error: (401) Unauthorized. |
| --- | --- |
| **Root cause** | Remote Agent Service requires that the caller is a member of the Administrators group or from a domain account that has been added to the Administrators group. A local administrator that isn't the built-in account won't work with the Remote Agent Service because of a bug in Web Deploy 2.0. |
| **Fix/Workaround** | Provide administrative credentials. |

### 6. Remote Agent Service hangs during operation

| **Symptoms** | Service may stop responding for a long time, up to several hours. |
| --- | --- |
| **Root cause** | Unknown. |
| **Fix/Workaround** | Stop the operation and attempt to repeat it. |

### 7. Client and server aren't compatible (version mismatch)

| **Symptoms** | Timestamp=24638007621418 MsDepSvc.exe Error: 0 : An error occurred. The exception details are as follows: Microsoft.Web.Deployment.DeploymentClientServerException: The client and server aren't compatible. The lowest version supported by the client is '7.1.538.0'. The highest version supported by the server is '7.1.537.0'. |
| --- | --- |
| **Root cause** | Some versions don't work together, so Web Deploy blocks them from working together. This is typically done to block pre-release versions from operating with released versions. |
| **Fix/Workaround** | Match the versions. |

### 8. Remote Agent Service couldn't start listening on the URL

| **Symptoms** | The Remote Agent Service couldn't start listening on the URL '{0}'. Make sure that the URL isn't in use. |
| --- | --- |
| **Root cause** | Usually indicates a URL conflict. |
| **Fix/Workaround** | Try reinstalling if you want the default URL or setting a custom URL as specified in the documentation. For more information about URL customization, see [Customizing and Securing the Remote Service](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd569093(v=ws.10)). |

## Web Management Service problems

### 1. Web Management Service isn't started

| **Symptoms** | Web Management Service isn't started. |
| --- | --- |
| **Root cause** | Unknown. The service should be started by default. |
| **Fix/Workaround** | Start the Web Management Service service: `Net Start WMSVC`. |

### 2. Not Authorized: User not authorized by deployment handler rules

| **Symptoms** | Couldn't complete an operation with the specified provider &lt;provider name&gt; when connecting using the Web Management Service. This can occur if the server administrator hasn't authorized the user for this operation. |
| --- | --- |
| **Root cause** | A non-administrator user tried to perform a restricted action with a provider. This usually indicates that a matching delegation rule wasn't found. Either the username, provider, operation, or provider path is wrong. |
| **Fix/Workaround** | The workaround is to fix the delegation rule or create one. For more information about delegation rules, see [Configure the Web Deployment Handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler). |

## Case study: diagnose publishing errors in Visual Studio 2010

This case study shows how to diagnose common errors encountered in Visual Studio 2010. The following steps walk through the series of errors you're likely to encounter when trying to publish from Visual Studio to a server that hasn't been correctly configured.

To collect the screenshots and errors below, we used a new ASP.NET MVC3 project. The destination server was a clean install of Windows Server 2008 R2 SP1 with IIS. No additional configuration was done.

### 1. Cannot connect to the server

The first error you're likely to encounter will look something like this in Visual Studio's output window. For improved readability, the full text of the message is provided below the screenshot.

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/conlud-not-connect -to-destination-computer.png" alt-text="Screenshot that shows the Error List page. An error description is shown." lightbox="media/troubleshoot-common-problems-with-web-deploy/conlud-not-connect -to-destination-computer.png":::

```Output
Web deployment task failed.(Could not connect to the destination computer ("deployserver"). On the destination computer, make sure that Web Deploy is installed and that the required process ("The Web Management Service") is started.)

This error indicates that you cannot connect to the server. Make sure the service URL is correct, firewall and network settings on this computer and on the server computer are configured properly, and the appropriate services have been started on the server.

Error details:

Could not connect to the destination computer ("deployserver"). On the destination computer, make sure that Web Deploy is installed and that the required process ("The Web Management Service") is started.

Unable to connect to the remote server

A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond 192.168.0.211:8172
```

**Is the web management service installed?**

On the destination server, open **IIS Manager** and select the machine name node. In the **Features** view, scroll down to the **Management** section and look for the following icons:

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/management-section-icons.png" alt-text="Screenshot that shows the IIS Manager Permissions icon, the IIS Manager Users icon, and the Management Service icon." lightbox="media/troubleshoot-common-problems-with-web-deploy/management-section-icons.png":::

If they aren't there, you need to install the Web Management Service using one of the following options:

- Through the **Add Role Services** dialog in Server Manager.

- Through the **Web Platform Installer** from the **Products** tab. Select **Server** in the left column and select **IIS: Management Service**.

> [!NOTE]
> After you install the Management Service, you need to start it, as it isn't started automatically.

### 2. (403) Forbidden

Once the Web Management Service is installed, Visual Studio may show the following error:

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/403-forbidden.png" alt-text="Screenshot that shows an error page in Visual Studio. An error description is shown." lightbox="media/troubleshoot-common-problems-with-web-deploy/403-forbidden.png":::

```Output
Web deployment task failed.(Could not connect to the destination computer ("deployserver") using the specified process ("The Web Management Service") because the server did not respond. Make sure that the process ("The Web Management Service") is started on the destination computer.)

Could not connect to the destination computer ("deployserver") using the specified process ("The Web Management Service") because the server did not respond. Make sure that the process ("The Web Management Service") is started on the destination computer.

The remote server returned an error: (403) Forbidden.
```

**Is the Web Management Service configured to allow remote connections?**

Start **IIS Manager**, double-click the **Management Service** icon, and verify that **Enable Remote Connections** is checked. You must stop the service to make changes, so be sure to restart it.

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/web-management service-configured-allow-remote-connections.png" alt-text="Screenshot that shows the Management Service page. The Enable remote connections checkbox is checked." lightbox="media/troubleshoot-common-problems-with-web-deploy/web-management service-configured-allow-remote-connections.png":::

**Is Windows Firewall blocking the request?**

The Web Management Service creates an Inbound rule named **Web Management Service (HTTP Traffic-In)** and enables it. Verify that this rule is enabled by going to **Start** >  **Administrative tools** > **Windows Firewall with Advanced Security**. Select **Inbound Rules** and find the **Web Management** rule in the list. It should be enabled for all profiles.

If you're using a third-party firewall, make sure inbound TCP connections on port 8172 are allowed.

### 3. (404) Not Found

If Visual Studio is able to contact the Management Service, the error message changes:

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/404-not-found.png" alt-text="Screenshot that shows the Visual Studio Error List page. A description of an error is shown." lightbox="media/troubleshoot-common-problems-with-web-deploy/404-not-found.png":::

```Output
Web deployment task failed.(Could not connect to the destination computer ("deployserver"). On the destination computer, make sure that Web Deploy is installed and that the required process ("The Web Management Service") is started.)

The requested resource does not exist, or the requested URL is incorrect.

Error details:

Could not connect to the destination computer ("deployserver"). On the destination computer, make sure that Web Deploy is installed and that the required process ("The Web Management Service") is started.

The remote server returned an error: (404) Not Found.
```

If you look in the Web Management Service log under `%SystemDrive%\\Inetpub\\logs\\WMSvc` on the destination server, you see an entry that looks like the following one:

[!code-console[Main](cmdsample/troubleshooting-common-problems-with-web-deploy/sample1.cmd)]

**Is Web Deploy installed?** 

You can verify that Web Deploy is installed by going to the **Programs and Features** control panel and looking for **Microsoft Web Deploy 2.0** in the list of installed programs. If it isn't there, you can install it via the Web Platform Installer by going to the **Products** tab. It's listed as **Web Deployment Tool 2.1**.

**Is the Web Deployment IIS7 Deployment Handler installed?** 

If Web Deploy is installed and you still get this error, make sure the **IIS 7 Deployment Handler** feature in Web Deploy is installed. In **Add Remove Programs**, find **Microsoft Web Deploy 2.0**, right-click, and select **Change**. In the Wizard that comes up, select **Next** on the first page and then choose **Change** on the second page. Add **IIS 7 Deployment Handler** and everything under it.

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/iis7-deployment-handler-installed.png" alt-text="Screenshot that shows the Microsoft Web Deploy two dot zero Setup wizard. The Web Development Framework option is selected." lightbox="media/troubleshoot-common-problems-with-web-deploy/iis7-deployment-handler-installed.png":::

Select **Next** to complete the Wizard.

### 4. (401) Unauthorized

Once Web Deploy and the Web Management Service are correctly configured, you need to set up Web Management Service delegation rules to allow users to update content. For permissions issues, there are several different errors you may see in Visual Studio. For example:

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/401-unauthorized.png" alt-text="Screenshot that shows the Visual Studio Error List page. An error appears along with a description of the error." lightbox="media/troubleshoot-common-problems-with-web-deploy/401-unauthorized.png":::

```Output
Web deployment task failed.(Connected to the destination computer ("deployserver") using the Web Management Service, but could not authorize. Make sure that you are using the correct user name and password, that the site you are connecting to exists, and that the credentials represent a user who has permissions to access the site.)

Make sure the site name, user name, and password are correct. If the issue is not resolved, please contact your local or server administrator.

Error details:

Connected to the destination computer ("deployserver") using the Web Management Service, but could not authorize. Make sure that you are using the correct user name and password, that the site you are connecting to exists, and that the credentials represent a user who has permissions to access the site.

The remote server returned an error: (401) Unauthorized.
```

In the `Web Management Service` log, you see the following messages:

[!code-console[Main](cmdsample/troubleshooting-common-problems-with-web-deploy/sample2.cmd)]

[!code-console[Main](cmdsample/troubleshooting-common-problems-with-web-deploy/sample3.cmd)]

The highlighted HTTP status in the Visual Studio output is an "Access Denied" error. The highlighted Win32 status in the error log maps to "Logon failure: unknown user name or bad password." This is a simple logon failure. If the user is authenticated but doesn't have the rights needed to publish, the log entry will look like:

[!code-console[Main](cmdsample/troubleshooting-common-problems-with-web-deploy/sample4.cmd)]

You need to set up delegation for this user per the instructions at [Configure the Web Deployment Handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler).

### 5. Operation not authorized

If the account is able to log in but hasn't been granted the rights needed to publish the content, you'll see the following error message:

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/unable-perform-operation.png" alt-text="Screenshot that shows the Visual Studio Error List page. A description of an error says that the Web deployment task failed." lightbox="media/troubleshoot-common-problems-with-web-deploy/unable-perform-operation.png":::

```Output
Web deployment task failed. (Unable to perform the operation ("Create Directory") for the specified directory ("bin"). This can occur if the server administrator has not authorized this operation for the user credentials you are using.
```

The `WMSvc` log will show HTTP 200 responses for these requests. The most likely cause is file system permissions. Web Deploy will also write events to the "Microsoft Web Deploy" service log. To view it, go to **Event Viewer** > **Applications and Services Logs** > **Microsoft Web Deploy**.

:::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/event-viewer-microsoft-web-deploy.png" alt-text="Screenshot that shows the Event Viewer navigation tree. The Microsoft Web Deploy option is selected." lightbox="media/troubleshoot-common-problems-with-web-deploy/event-viewer-microsoft-web-deploy.png":::

For this particular error, the event log contains extra details (truncated for brevity):

[!code-console[Main](cmdsample/troubleshooting-common-problems-with-web-deploy/sample5.cmd)]

This message tells you where permissions need to be granted for this particular error. You may also see the following permissions error in Visual Studio:

```Output
Web deployment task failed.((5/12/2011 11:31:41 AM) An error occurred when the request was processed on the remote computer.)

(5/12/2011 11:31:41 AM) An error occurred when the request was processed on the remote computer.  
The server experienced an issue processing the request. Contact the server administrator for more information.
```

This particular error doesn't give you much to go on, but the picture becomes much clearer if you look at the Web Deploy error log in Event Viewer.

[!code-console[Main](cmdsample/troubleshooting-common-problems-with-web-deploy/sample6.cmd)]

From this, we can see that User1 doesn't have the rights to set security information. In this case, the user doesn't have "Modify permissions" on the content. Granting "Change Permissions" to the content resolves the problem.


### 6. Others

If you can't browse a .NET 4.0 application after it has been successfully published, it could be that .NET 4.0 hasn't been registered correctly with IIS. Other symptoms are that .NET 4.0 is installed, but there are no .NET 4.0 application pools or handler mappings in IIS. This happens when .NET 4.0 is installed before IIS is installed. To fix this problem, start an elevated command prompt and run this command:

[!code-console[Main](cmdsample/troubleshooting-common-problems-with-web-deploy/sample7.cmd)]
