---
title: Troubleshoot common problems related to Web Deploy
description: This article describes how to diagnose and fix common problems with Web Deploy, including common errors seen while publishing from Visual Studio 2010.
ms.date: 04/20/2012
ms.custom: sap:Deployment and migration
ms.technology: deployment-migration
ms.reviewer: johnhart, ellhamai, chihshen, v-sidong
---
# Troubleshoot common problems related to Web Deploy

_Applies to:_ &nbsp; Internet Information Services

This article describes how to diagnose and fix common problems with Web Deploy, including common errors seen while publishing from Visual Studio 2010.

## Logging

When you run into issues related to Web Deploy, there are several logging options depending on where the problem occurs. By default, Web Deploy logs to the Event Log under **Applications** > **Microsoft Web Deploy**. It's a great place to start looking for errors on the destination server.

If you can't diagnose the problem using the Event Log, here are some other options:

- Use Web Deploy MSI logs located under *%programfiles%\\IIS\\Microsoft Web Deploy v3* to diagnose installation problems.
- If Web Management Service or Remote Agent Service fails to start, see the error details by going to **Event Viewer (Local)** > **Windows Logs** > **System** for Service Control Manager.
- You can further configure [tracing for Web Management Service](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee461173(v=ws.10)).

## Error codes

For certain common error cases, Web Deploy shows a message and an error code that may be useful in getting more information to troubleshoot an issue. For a full list of error codes, see [Web Deploy error codes](/iis/publish/troubleshooting-web-deploy/web-deploy-error-codes).

> [!NOTE]
> The error message may be different depending on how Web Deploy is invoked. For example, Microsoft WebMatrix chooses to show custom error messages instead of error codes, whereas the command line will always show error codes if they're logged.

## Installation problems

### 1. Couldn't install Web Deploy on a valid OS

| **Symptoms** | The Operating System (OS) is correct, and the version and bitness of Web Deploy are correct, but the installation doesn't succeed. |
| --- | --- |
| **Root cause** | Unknown |
| **Fix/Workaround** | Look in the install log, located in *%programfiles%\\IIS\\Microsoft Web Deploy V3*. |

### 2. Web Deploy doesn't function after an upgrade

| **Symptoms** | Web Deploy doesn't work after a version upgrade. |
| --- | --- |
| **Root cause** | Web Deploy doesn't restart services after an upgrade. |
| **Fix/Workaround** | If you're upgrading an existing installation of Web Deploy, make sure to restart the handler and agent services by running the following commands at an administrative command prompt:<br> `net stop msdepsvc` <br>`net start msdepsvc` <br>`net stop wmsvc` <br>`net start wmsvc` |

### 3. Couldn't install Web Deploy 32-bit version on 64-bit hardware

| **Symptoms** | :::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-32-bit-on-64-bit.png" alt-text="Screenshot of the Web Deployment Tool Setup dialog box. The text shows that 32-bit version is incompatible with 64-bit Windows." lightbox="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-32-bit-on-64-bit.png"::: |
| --- | --- |
| **Root cause** | Trying to install 32-bit on 64-bit OS is a check inside the Web Deploy MSI that fails because it doesn't support WoW64 mode. |
| **Fix/Workaround** | Install the same version that matches the architecture of your OS. |

### 4. Couldn't install Web Deploy 64-bit version on 32-bit hardware

| **Symptoms** | :::image type="content" source="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-64-bit-on-32-bit.png" alt-text="Screenshot that shows the Windows Installer dialog box. The text says that this processor type doesn't support this installation package. Contact your product vendor." lightbox="media/troubleshoot-common-problems-with-web-deploy/could-not-install web-deploy-64-bit-on-32-bit.png"::: |
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
| **Root cause** | *msdepsvc.exe* or other files are missing from *%programfiles%\\IIS\\Microsoft Web Deploy v3*. |
| **Fix/Workaround** | Reinstall the product. |

### 2. Remote Agent Service isn't started

| **Symptoms** | Microsoft.Web.Deployment.DeploymentAgentUnavailableException: Remote agent (URL `http://DestinationServer/msdeployagentservice`) could not be contacted. Make sure the remote agent service is installed and started on the target computer. ---\> System.Net.WebException: The remote server returned an error: (404) Not Found. |
| --- | --- |
| **Root cause** | Remote Agent Service isn't started. |
| **Fix/Workaround** | Start the service: `net start msdepsvc`. |

### 3. Trying to connect to a server where HTTP isn't listening or allowed

| **Symptoms** | Microsoft.Web.Deployment.DeploymentAgentUnavailableException: Remote agent (URL `http://DestinationServer/msdeployagentservice`) could not be contacted. Make sure the remote agent service is installed and started on the target computer. ---\> System.Net.WebException: Unable to connect to the remote server ---\> System.Net.Sockets.SocketException: No connection could be made because the target machine actively refused it DestinationServer:80 |
| --- | --- |
| **Root cause** | HTTP isn't listening. |
| **Fix/Workaround** | Make sure HTTP traffic is allowed to the Remote Agent Service. |

### 4. Trying to connect to a server with the Method Not Allowed error

| **Symptoms** | Microsoft.Web.Deployment.DeploymentException: Could not complete the request to remote agent URL '`http://DestinationServer/`'. ---\> System.Net.WebException: The remote server returned an error: (405) Method Not Allowed. |
| --- | --- |
| **Root cause** | The request was picked up by Internet Information Services (IIS) itself instead of MS Deploy because the path to *msdepsvc.exe* is missing. |
| **Fix/Workaround** | Change the URL to include `/MSDeployAgentService`. |

### 5. Trying to access Remote Agent Service as a non-administrator

| **Symptoms** | Microsoft.Web.Deployment.DeploymentException: Could not complete the request to remote agent URL '`http://DestinationServer/msdeployAgentService`'. ---\>; System.Net.WebException: The remote server returned an error: (401) Unauthorized. |
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
| **Root cause** | Some versions don't work together, so Web Deploy blocks them from working together. It's typically done to block pre-release versions from operating with released versions. |
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

| **Symptoms** | Couldn't complete an operation with the specified provider \<ProviderName\> when connecting using the Web Management Service. This can occur if the server administrator hasn't authorized the user for this operation. |
| --- | --- |
| **Root cause** | A non-administrator user tried to perform a restricted action with a provider. This action usually indicates that a matching delegation rule wasn't found. Either the username, provider, operation, or provider path is wrong. |
| **Fix/Workaround** | The workaround is to fix the delegation rule or create one. For more information about delegation rules, see [Configure the Web Deployment Handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler). |

## Errors when publishing from Visual Studio

For more information on troubleshooting common errors that you may encounter when trying to publish from Visual Studio to a server that hasn't been correctly configured via Web Deploy, see [Troubleshooting Web Deploy problems with Visual Studio](troubleshoot-web-deploy-problems-with-visual-studio.md).
