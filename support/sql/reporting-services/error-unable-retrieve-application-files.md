---
title: Unable to retrieve application files error
description: This article provides resolutions for an error that occurs when you try to start the ClickOnce version of SQL Server Report Builder.
ms.date: 07/22/2020
ms.custom: sap:Reporting Services
ms.reviewer: ramakoni
---
# 'Unable to retrieve application files. Files corrupt in deployment' error when you try to start the ClickOnce version of Report Builder from SQL Server 2012 Reporting Services

This article helps you resolve the **Unable to retrieve application files. Files corrupt in deployment** error that occurs when you try to start the ClickOnce version of SQL Server Report Builder.

_Original product version:_ &nbsp; SQL Server 2012  
_Original KB number:_ &nbsp; 2781227

## Symptoms

When you try to start the ClickOnce version of Microsoft SQL Server Report Builder for Microsoft SQL Server 2012 on a client computer, you may receive an error message that resembles the following:

> Unable to retrieve application files. Files corrupt in deployment.

Additionally, when you click **Details** on the error message dialog box, you see detailed error information that resembles the following:

> ERROR + Exception occurred loading manifest from file MSReportBuilder.exe: the manifest may not be valid or the file could not be opened. + Cannot load internal manifest from component file. ERROR DETAILS Following errors were detected during this operation. * [10/31/2012 9:25:34 AM] System.Deployment.Application.InvalidDeploymentException (ManifestLoad) - Exception occurred loading manifest from file MSReportBuilder.exe: the manifest may not be valid or the file could not be opened. - Source: System.Deployment - Stack trace: at System.Deployment.Application.Manifest.AssemblyManifest.ManifestLoadExceptionHelper(Exception exception, String filePath) at System.Deployment.Application.Manifest.AssemblyManifest.LoadFromInternalManifestFile(String filePath) at System.Deployment.Application.DownloadManager.ProcessDownloadedFile(Object sender, DownloadEventArgs e) at System.Deployment.Application.FileDownloader.DownloadModifiedEventHandler.Invoke(Object sender, DownloadEventArgs e) at System.Deployment.Application.SystemNetDownloader.DownloadSingleFile(DownloadQueueItem next) at System.Deployment.Application.SystemNetDownloader.DownloadAllFiles() at System.Deployment.Application.FileDownloader.Download(SubscriptionState subState) at System.Deployment.Application.DownloadManager.DownloadDependencies(SubscriptionState subState, AssemblyManifest deployManifest, AssemblyManifest appManifest, Uri sourceUriBase, String targetDirectory, String group, IDownloadNotification notification, DownloadOptions options) at System.Deployment.Application.ApplicationActivator.DownloadApplication(SubscriptionState subState, ActivationDescription actDesc, Int64 transactionId, TempDirectory& downloadTemp) at System.Deployment.Application.ApplicationActivator.InstallApplication(SubscriptionState& subState, ActivationDescription actDesc) at System.Deployment.Application.ApplicationActivator.PerformDeploymentActivation(Uri activationUri, Boolean isShortcut, String textualSubId, String deploymentProviderUrlFromExtension, BrowserSettings browserSettings, String& errorPageUrl) at System.Deployment.Application.ApplicationActivator.ActivateDeploymentWorker(Object state) --- Inner Exception --- System.Deployment.Application.DeploymentException (InvalidManifest) - Cannot load internal manifest from component file.

## Cause

This issue occurs because the Microsoft .NET Framework 4 or a later version of the .NET Framework is not installed on the client computer.

## Resolution

To resolve this issue, install the .NET Framework 4. The following file is available for download from the Microsoft Download Center:  

[Download the .NET Framework 4 package now.](https://www.microsoft.com/download/details.aspx?id=17851)

For more information about how to download Microsoft support files, see:
[How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591)

[!INCLUDE [Virus scan claim](../../includes/virus-scan-claim.md)]

### Restart requirement

You must restart your computer after you install this package, and then restart the Report Builder ClickOnce application.

## More information

- For more information about the .NET Framework, see: [.NET](https://dotnet.microsoft.com/)
- For more information about the prerequisites for SQL Server Report Builder, see: [Prerequisites for Tutorials (Report Builder)](/sql/reporting-services/prerequisites-for-tutorials-report-builder)

## Applies to

- SQL Server 2012 Web
- SQL Server 2012 Standard
- SQL Server 2012 Enterprise Core
- SQL Server 2012 Express
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
