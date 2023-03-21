---
title: Troubleshooting errors with ClickOnce deployments
description: Describes common errors that can occur when you deploy a ClickOnce application and provides steps to resolve each problem.
ms.date: 11/04/2016
f1_keywords: 
  - Microsoft.VisualStudio.Publish.ClickOnceProvider.ErrorPrompt.UncRequired
  - Microsoft.VisualStudio.Publish.ClickOnceProvider.ErrorPrompt.NoInstallUrl
dev_langs: 
  - VB
  - CSharp
  - C++
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: mikejo
---
# Troubleshoot specific errors in ClickOnce deployments

_Applies to:_&nbsp;Visual Studio

This article introduces common errors that can occur when you deploy ClickOnce application, and provides steps to resolve each problem.

## General errors

#### When you try to locate an application file, nothing occurs, or XML renders in Internet Explorer, or you receive a Run or Save As dialog box

The possible reason for this error is that content types (also known as MIME types) not being registered correctly on the server or client.

First, make sure that the server is configured to associate the _.application_ extension with content type "application/x-ms-application".

If the server is configured correctly, check that the .NET Framework 2.0 is installed on your computer. If the .NET Framework 2.0 is installed, and you're still seeing this problem, try uninstalling and reinstalling the .NET Framework 2.0 to re-register the content type on the client.

#### Error: "Unable to retrieve application. Files missing in deployment" or "Application download has been interrupted, check for network errors and try again later"

This message indicates that one or more files that the ClickOnce manifests reference can't be downloaded. The easiest way to debug this error is to try to download the URL that ClickOnce says it can't download. Here are some possible causes:

- If the log file says "(403) Forbidden" or "(404) Not found," verify that the Web server is configured so that it doesn't block download of this file. For more information, see [Server and Client Configuration Issues in ClickOnce Deployments](/visualstudio/deployment/server-and-client-configuration-issues-in-clickonce-deployments).
- If the _.config_ file is being blocked by the server, see [Download error when you try to install a ClickOnce application that has a .config file](#download-error-when-you-try-to-install-a-clickonce-application-that-has-a-config-file).
- Determine whether this error occurred because the `deploymentProvider` URL in the deployment manifest is pointing to a different location than the URL used for activation.
- Ensure that all files are present on the server; the ClickOnce log should tell you which file wasn't found.
- See whether there are network connectivity issues; you can receive this message if your client computer went offline during the download.

#### Download error when you try to install a ClickOnce application that has a .config file

By default, a Visual Basic Windows-based application includes an _App.config_ file. You may encounter a problem if you try to install from a Web server that uses Windows Server 2003, because that operating system blocks the installation of _.config_ files for security reasons. To enable the _.config_ file to be installed, select **Use ".deploy" file extension** in the **Publish Options** dialog box.

You also must set the content types (also known as MIME types) appropriately for _.application_, _.manifest_, and _.deploy_ files. For more information, see your Web server documentation.

For more information, see [Windows Server: Locked-down content types](/visualstudio/deployment/server-and-client-configuration-issues-in-clickonce-deployments##windows-server-locked-down-content-types).

#### Error: Application is improperly formatted; Log file contains "XML signature is invalid"

Ensure that you updated the manifest file and signed it again. Republish your application by using Visual Studio or use Mage to sign the application again.

#### You updated your application on the server, but the client doesn't download the update

This problem might be solved by completing one of the following tasks:

- Examine the `deploymentProvider` URL in the deployment manifest. Ensure that you're updating the bits in the same location that `deploymentProvider` points to.
- Verify the update interval in the deployment manifest. If this interval is set to a periodic interval, such as one time every six hours, ClickOnce won't scan for an update until this interval has passed. You can change the manifest to scan for an update every time that the application starts. Changing the update interval is a convenient option during development time to verify updates are being installed, but it slows down application activation.
- Try starting the application again on the Start menu. ClickOnce may have detected the update in the background, but will prompt you to install the bits on the next activation.

#### During update, you receive an error that has the following log entry: "The reference in the deployment does not match the identity defined in the application manifest"

This error may occur because you've manually edited the deployment and application manifests, and have caused the description of the identity of an assembly in one manifest to become out of sync with the other. The identity of an assembly consists of its name, version, culture, and public key token. Examine the identity descriptions in your manifests, and correct any differences.

#### First time activation from local disk or CD-ROM succeeds, but subsequent activation from Start Menu doesn't succeed

ClickOnce uses the Deployment Provider URL to receive updates for the application. Verify that the location that the URL is pointing to is correct.

#### Error: Cannot start the application

This error message usually indicates that there's a problem installing this application into the ClickOnce store. Either the application has an error or the store is corrupted. The log file might tell you where the error occurred.

To resolve this issue, follow these steps:

1. Make sure that the identity of the deployment manifest, identity of application manifest, and identity of the main application EXE are all unique.
1. Make sure that your file paths aren't longer than 100 characters. If your application contains file paths that are too long, you may exceed the limitations on the maximum path you can store. Try shortening the paths and then reinstall.

#### PrivatePath settings in application config file aren't honored

To use PrivatePath (Fusion probing paths), the application must request full trust permission. Try changing the application manifest to request full trust, and then try again.

#### During uninstall a message appears saying, "Failed to uninstall application"

This message usually indicates that the application has already been removed or the store is corrupted. After you select **OK**, the **Add/Remove Program** entry will be removed.

#### During installation, a message appears that says the platform dependencies are not installed

You're missing a prerequisite in the GAC (global assembly cache) that the application needs in order to run.

## Publishing with Visual Studio

#### Publishing in Visual Studio fails

Ensure that you have the right to publish to the server that you're targeting. For example, if you're logged in to a terminal server computer as an ordinary user, not as an administrator, you probably won't have the rights required to publish to the local Web server.

If you're publishing with a URL, ensure that the destination computer has FrontPage Server Extensions enabled.

#### Error: Unable to create the Web site '\<site>'. The components for communicating with FrontPage Server Extensions are not installed

Ensure that you have the Microsoft Visual Studio Web Authoring Component installed on the machine that you're publishing from. For Express users, this component isn't installed by default.

#### Error: Could not find file 'Microsoft.Windows.Common-Controls, Version=6.0.0.0, Culture=\*, PublicKeyToken=6595b64144ccf1df, ProcessorArchitecture=\*, Type=win32'

This error message appears when you attempt to publish a WPF application with visual styles enabled. To resolve this issue, see [How to: Publish a WPF Application with Visual Styles Enabled](/visualstudio/deployment/how-to-publish-a-wpf-application-with-visual-styles-enabled).

## Using Mage

#### You tried to sign with a certificate in your certificate store and a received blank message box

In the **Signing** dialog box, you must:

1. Select **Sign with a stored certificate**.
1. Select a certificate from the list; the first certificate isn't the default selection.

#### Clicking the "Don't Sign" button causes an exception

This issue is a known bug. All ClickOnce manifests are required to be signed. Just select one of the signing options, and then select **OK**.

## More errors

The following table shows some common error messages that a client-computer user may receive when the user installs a ClickOnce application. Each error message is listed next to a description of the most probable cause for the error.

| Error message | Description |
| - | - |
| Application cannot be started. Contact the application publisher.<br/><br/> Cannot start the application. Contact the application vendor for assistance. | These are generic error messages that occur when the application cannot be started, and no other specific reason can be found. Frequently this means that the application is somehow corrupted, or that the ClickOnce store is corrupted. |
| Cannot continue. The application is improperly formatted. Contact the application publisher for assistance.<br/><br/> Application validation did not succeed. Unable to continue.<br/><br/> Unable to retrieve application files. Files corrupt in deployment. | One of the manifest files in the deployment is syntactically not valid, or contains a hash that cannot be reconciled with the corresponding file. This error may also indicate that the manifest embedded inside an assembly is corrupted. Re-create your deployment and recompile your application, or find and fix the errors manually in your manifests. |
| Cannot retrieve application. Authentication error.<br/><br/> Application installation did not succeed. Cannot locate applications files on the server. Contact the application publisher or your administrator for assistance. | One or more files in the deployment can't be downloaded because you don't have permission to access them. This can be caused by a 403 Forbidden error being returned by a Web server, which may occur if one of the files in your deployment ends with an extension that makes the Web server treat it as a protected file. Also, a directory that contains one or more of the application's files might require a username and password in order to access. |
| Cannot download the application. The application is missing required files. Contact the application vendor or your system administrator for assistance. | One or more of the files listed in the application manifest cannot be found on the server. Check that you've uploaded all the deployment's dependent files, and try again. |
| Application download did not succeed. Check your network connection, or contact your system administrator or network service provider. | ClickOnce cannot establish a network connection to the server. Examine the server's availability and the state of your network. |
| URLDownloadToCacheFile failed with HRESULT '\<number>'. An error occurred trying to download '\<file>'. | If a user has set Internet Explorer Advanced Security option "Warn if changing between secure and not secure mode" on the deployment target computer, and if the setup URL of the ClickOnce application being installed is redirected from a nonsecure to a secure site (or vice-versa), the installation will fail because the Internet Explorer warning interrupts it.<br/><br/> To resolve this error, you can do one of the following tasks:<br/><br/> -   Clear the security option.<br/>-   Make sure the setup URL isn't redirected in such a way that changes security modes.<br/>-   Remove the redirection completely and point to the actual setup URL. |
| An error has occurred writing to the hard disk. There might be insufficient space available on the disk. Contact the application vendor or your system administrator for assistance. | This may indicate insufficient disk space for storing the application, but it may also indicate a more general I/O error when you're trying to save the application files to the drive. |
| Cannot start the application. There is not enough available space on the disk. | The hard disk is full. Clear off space and try to run the application again. |
| Too many deployed activations are attempting to load at once. | ClickOnce limits the number of different applications that can start at the same time. This is largely to help protect against malicious attempts to instigate denial-of-service attacks against the local ClickOnce service; users who try to start the same application repeatedly, in rapid succession, will only end up with a single instance of the application. |
| Shortcuts cannot be activated over the network. | Shortcuts to a ClickOnce application can only be started on the local hard disk. They cannot be started by opening a URL that points to a shortcut file on a remote server. |
| The application is too large to run online in partial trust. Contact the application vendor or your system administrator for assistance. | An application that runs in partial trust can't be larger than half of the size of the online application quota, which by default is 250 MB. |

## References

- [ClickOnce security and deployment](/visualstudio/deployment/clickonce-security-and-deployment)
- [Troubleshoot ClickOnce deployments](/visualstudio/deployment/troubleshooting-clickonce-deployments)
