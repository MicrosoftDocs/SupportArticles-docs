---
title: Troubleshoot installation and upgrade issues
description: Introduces resolutions for common issues with Visual Studio installation and upgrade.
ms.date: 11/4/2025
ms.reviewer: meghaanand, v-jayaramanp, jagbal, v-shaywood
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Troubleshoot Visual Studio installation and upgrade issues

_Applies to:_&nbsp;Visual Studio

This troubleshooting guide includes step-by-step instructions to resolve common issues with Visual Studio installation and upgrade.

> [!TIP]
> Having a problem installing? We can help. We offer an [**installation chat**](https://visualstudio.microsoft.com/vs/support/#talktous) (English only) support option.

## Online installations or updates

Try the following possible resolutions that apply to a typical online installation issue in order.

#### 1. Check whether the problem is a known issue

Check if the issue you're encountering is a known issue with the Visual Studio Installer that Microsoft is working on fixing.

To see if there's a workaround for your problem, check:

- [Known Issues of Visual Studio 2026](/visualstudio/releases/2026/release-notes#-known-issues)
- [Known Issues of Visual Studio 2022](/visualstudio/releases/2022/release-notes#-known-issues)
- [Known Issues of Visual Studio 2019](/visualstudio/releases/2019/release-notes#-known-issues)

#### 2. Try repairing Visual Studio

Try to [repair your installation](/visualstudio/install/repair-visual-studio). It might fix many common update issues.

#### 3. See what the developer community says about the error

If repairing didn't fix the issue, search for your error message in the [Visual Studio Developer Community](https://developercommunity.visualstudio.com/search?space=8). Other members of the community might have found a solution or workaround to your problem.

#### 4. Delete the installer folder (update issues)

If you encounter an issue when updating, try deleting the Visual Studio Installer folder, then rerun the installation bootstrapper. This action can solve certain update failures. It reinstalls the Visual Studio Installer files and resets the installation metadata.

1. Close the Visual Studio Installer.
1. Delete the Visual Studio Installer folder. Typically, the folder path is _C:\Program Files (x86)\Microsoft Visual Studio\Installer_.
1. Run the Visual Studio Installer bootstrapper.
    1. You can get the bootstrapper for the latest version of Visual Studio from the [downloads page](https://visualstudio.microsoft.com/downloads). For previous Visual Studio versions, see the [older downloads page](https://visualstudio.microsoft.com/vs/older-downloads).
    1. You can also find the bootstrapper in your _Downloads_ folder. The bootstrapper is named `VisualStudioSetup.exe` for Visual Studio 2022 and later, or `vs_<edition>.exe` for Visual Studio 2019 and earlier.
1. Try to install or update Visual Studio again. If the Visual Studio Installer continues to fail, [report a problem to support](#5-report-the-problem-to-support).

#### 5. Report the problem to support

In some situations, corrupted files cause issues that require case-by-case troubleshooting.

Follow these steps to submit the problem to Microsoft Support:

##### [Visual Studio 2022 and later](#tab/vs-2022-older)

1. Collect your setup logs. See [How to get the Visual Studio installation logs](#collect-installation-logs-for-microsoft-support) for details.
1. Open the Visual Studio Installer, then choose **Report a problem** to open the Visual Studio Feedback tool.

    :::image type="content" source="media/troubleshoot-installation-issues/vs-installer-report-problem.png" alt-text="Screenshot showing the Provide feedback button in the Visual Studio Installer." lightbox="media/troubleshoot-installation-issues/vs-installer-report-problem.png":::

1. Give your problem report a title, and provide the relevant details. The most recent setup log for the Visual Studio Installer is automatically added to the **Additional attachments** section of your problem report.
1. Choose **Submit**.

##### [Visual Studio 2019 and earlier](#tab/vs-2019-earlier)

1. Collect your setup logs. See [How to get the Visual Studio installation logs](#collect-installation-logs-for-microsoft-support) for details.
1. Open the Visual Studio Installer, then select **Report a problem** to open the Visual Studio Feedback tool.
1. Give your problem report a title, and provide relevant details. Select **Next** to go to the **Attachments** section, then attach the generated log file (typically, the file is at `%TEMP%\vslogs.zip`).
1. Select **Next** to review your problem report, then select **Submit**.

---

#### 6. Remove all Visual Studio installation files

As a last resort, you can remove all Visual Studio installation files and product information:

1. [Remove all with InstallCleanup.exe](/visualstudio/install/uninstall-visual-studio#remove).
1. Rerun the Visual Studio Installer bootstrapper.
    1. You can get the bootstrapper for the latest version of Visual Studio from the [downloads page](https://visualstudio.microsoft.com/downloads). For previous Visual Studio versions, see the [older downloads page](https://visualstudio.microsoft.com/vs/older-downloads).
    1. You can also find the bootstrapper in your _Downloads_ folder. The bootstrapper is named `VisualStudioSetup.exe` for Visual Studio 2022 and later, or `vs_<edition>.exe` for Visual Studio 2019 and earlier.
1. Try to reinstall Visual Studio.

#### 7. Rollback to a previous install (Visual Studio 2022 and newer)

If none of the previous steps help you successfully update Visual Studio, you can rollback to your previously installed version by using the Visual Studio Installer or the command line.

> [!IMPORTANT]
> If you're in an organization and are using a layout to update Visual Studio, your IT Administrator is expected to maintain the previous packages in the layout if the client is expected to be able to roll back. Also, rollback might be disabled or your rollback attempt might be undone if you're in an organization that has security compliance or software updating requirements. Contact your IT Administrator for further details.

##### Rollback using the Visual Studio Installer

1. Launch the **Visual Studio Installer** on your computer.
1. In the installer, look for the edition of Visual Studio that you installed.
1. Select **More**.
1. Select **Rollback to previous version**.

    :::image type="content" source="media/troubleshoot-installation-issues/rollback-from-previous-version.png" alt-text="Screenshot of the Rollback to previous version option." lightbox="media/troubleshoot-installation-issues/rollback-from-previous-version.png":::
1. Select **OK** to confirm.

##### Rollback using the command line

You can rollback the update programmatically by using the installer on the client machine and passing in the rollback command alongside the installation path instance. For example:

```powershell
VisualStudioSetup.exe rollback --installPath <VisualStudioInstallPath>
```

For more information, see [Use command-line parameters to install Visual Studio](/visualstudio/install/use-command-line-parameters-to-install-visual-studio).

#### 8. Contact our live chat

If none of the previous steps help you successfully install or upgrade Visual Studio, contact us by using our [**live chat**](https://visualstudio.microsoft.com/vs/support/#talktous) support option (English only) for further assistance.

## Network layout or offline installations

To resolve issues with a [network installation](/visualstudio/install/create-a-network-installation-of-visual-studio), see [Error Codes](/visualstudio/install/create-a-network-installation-of-visual-studio#error-codes) or [Troubleshoot network-related errors when you install or use Visual Studio](troubleshoot-network-related-errors.md).

## Administrator updates

Various situations can prevent administrator updates from applying correctly. For more information, see [Administrator updates troubleshooting error codes](/visualstudio/install/applying-administrator-updates#verification-reports-and-troubleshooting-error-codes).

Use the following methods to provide feedback about Visual Studio administrator updates or report issues that affect the updates:

- Ask questions to the community at the [Visual Studio Setup Q&A Forum](/answers/topics/vs-setup.html).
- Go to the [Visual Studio support page](https://visualstudio.microsoft.com/vs/support/), and check whether your issue is listed in the FAQ.
- [Provide feature feedback or report a problem](https://aka.ms/vs/wsus/feedback) to the Visual Studio team regarding your experience.
- Contact your organization's technical account manager for Microsoft.

## Collect installation logs for Microsoft Support

If you contact Microsoft Support, they might ask you to collect setup logs by using the [Microsoft Visual Studio and .NET Framework log collection tool](https://aka.ms/vscollect). The log collection tool collects setup logs from all components installed by Visual Studio, including .NET Framework, Windows SDK, and SQL Server. It also collects computer information, a Windows Installer inventory, and Windows event log information for the Visual Studio Installer, Windows Installer, and System Restore.

To collect the logs, follow these steps:

1. [Download the tool](https://aka.ms/vscollect).
1. Open an administrative command prompt.
1. Run `Collect.exe` in the folder where you saved the tool.

   You must run the tool under the same user account that you used for the failed installation. If you run the tool from a different user account, set the `-user:<name>` option to specify the user account for the failed installation. Run `Collect.exe -?` from an administrator command prompt for more options and usage information.

The tool generates a _vslogs.zip_ file in your _%TEMP%_ folder, typically at _C:\Users\YourName\AppData\Local\Temp\vslogs.zip_.

Report product issues by using the [Report a Problem](/visualstudio/ide/how-to-report-a-problem-with-visual-studio) tool that appears both in the Visual Studio Installer and in the Visual Studio IDE. If you're an IT administrator and don't have Visual Studio installed, you can submit [IT Admin feedback here](https://aka.ms/vs/admin/feedback).

## Problems installing WebView2

If your organization's Group policies block the installation of the WebView2 component, you can't install Visual Studio because the installer requires WebView2. If this issue occurs, check these policies:

- If the [Microsoft Edge 'Install (WebView)'](/deployedge/microsoft-edge-update-policies#install-webview) policy is configured, it determines whether WebView2 can be installed.
- If the _Microsoft Edge 'Install (WebView)' policy_ isn't configured, the [Microsoft Edge 'InstallDefault'](/deployedge/microsoft-edge-update-policies#installdefault) policy determines whether WebView2 can be installed.

> [!WARNING]
> If neither policy is configured, your organization allows WebView2 installation.
