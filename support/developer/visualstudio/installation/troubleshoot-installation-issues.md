---
title: Troubleshoot installation and upgrade issues
description: Introduces resolutions for common issues with Visual Studio installation and upgrade.
ms.date: 04/17/2025
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: meghaanand, v-jayaramanp, jagbal
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

The first thing to check is whether or not the issue you're encountering is a known issue with the Visual Studio Installer that Microsoft is working on fixing.

To see if there's a workaround for your problem, check [Known Issues of Visual Studio 2019](/visualstudio/releases/2019/release-notes#-known-issues) and [Known Issues of Visual Studio 2022](/visualstudio/releases/2022/release-notes#-known-issues).

#### 2. Try repairing Visual Studio

Try to [repair your installation](/visualstudio/install/repair-visual-studio). It may fix many common update issues.

#### 3. See what the developer community says about the error

If repairing didn't fix the issue, search for your error message in the [Visual Studio Developer Community](https://developercommunity.visualstudio.com/search?space=8). Other members of the community might have found a solution or workaround to your problem.

#### 4. Delete the installer folder (update issues)

If you encountered an issue when updating, try deleting the Visual Studio Installer folder, and then rerunning the installation bootstrapper can solve certain update failures. Doing so reinstalls the Visual Studio Installer files and resets the installation metadata.

1. Close the Visual Studio Installer.
1. Delete the Visual Studio Installer folder. Typically, the folder path is _C:\Program Files (x86)\Microsoft Visual Studio\Installer_.
1. Run the Visual Studio Installer bootstrapper. You might find the bootstrapper in your _Downloads_ folder with a file name _VisualStudioSetup.exe_ (Visual Studio 2022) or _vs\_\<edition>*.exe_ (Visual Studio 2019 and previous versions). Or, you can download the bootstrapper from the download pages for [Visual Studio 2022](https://visualstudio.microsoft.com/downloads) or [Visual Studio 2019 and previous versions](https://visualstudio.microsoft.com/vs/older-downloads). Then, run the executable to reset your installation metadata.
1. Try to install or update Visual Studio again. If the Visual Studio Installer continues to fail, [report a problem to support](#5-report-the-problem-to-support).

#### 5. Report the problem to support

In some situations, when there are corrupted files, issues might require case-by-case troubleshooting.

Follow these steps to submit the problem to Microsoft Support:

- For Visual Studio 2022:

    1. Collect your setup logs. See [How to get the Visual Studio installation logs](#collect-installation-logs-for-microsoft-support) for details.
    1. Open the Visual Studio Installer, and then choose **Report a problem** to open the Visual Studio Feedback tool.

        :::image type="content" source="media/troubleshoot-installation-issues/vs-installer-report-problem.png" alt-text="Screenshot showing the Provide feedback button in the Visual Studio Installer." lightbox="media/troubleshoot-installation-issues/vs-installer-report-problem.png":::

    1. Give your problem report a title, and provide the relevant details. The most recent setup log for the Visual Studio Installer is automatically added to the **Additional attachments** section of your problem report.
    1. Choose **Submit**.

- For Visual Studio 2019 and previous versions:

    1. Collect your setup logs. See [How to get the Visual Studio installation logs](#collect-installation-logs-for-microsoft-support) for details.
    1. Open the Visual Studio Installer, and then select **Report a problem** to open the Visual Studio Feedback tool.
    1. Give your problem report a title, and provide relevant details. Select **Next** to go to the **Attachments** section, and then attach the generated log file (typically, the file is at `%TEMP%\vslogs.zip`).
    1. Select **Next** to review your problem report, and then select **Submit**.

#### 6. Remove all Visual Studio installation files

As a last resort, you can remove all Visual Studio installation files and product information:

1. [Remove all with InstallCleanup.exe](/visualstudio/install/uninstall-visual-studio#remove).
1. Rerun the Visual Studio Installer bootstrapper. You might find the bootstrapper in your _Downloads_ folder with a file name _VisualStudioSetup.exe_ (Visual Studio 2022) or _vs_\<edition>*.exe_ (Visual Studio 2019 and previous versions). Or, you can download the bootstrapper from the download pages for [Visual Studio 2022](https://visualstudio.microsoft.com/downloads) or [Visual Studio 2019 and previous versions](https://visualstudio.microsoft.com/vs/older-downloads).
1. Try to reinstall Visual Studio.

#### 7. Roll back to a previous install (for Visual Studio 2022 only)

Before you try to roll back, learn more about the [rollback feature in Visual Studio](https://aka.ms/vs/rollback).

If none of the previous steps helped you successfully upgrade Visual Studio, you can try to roll back to your previously installed version. Since Visual Studio 2022 version 17.4, you can roll back to your previously installed version if your original version was on the current channel version 17.1.7 or higher, or on the 17.0 Fall 2021 LTSC channel 17.0.10 or higher.  

You can roll back to your previously installed version by using the Visual Studio Installer or by using the command line.

> [!IMPORTANT]
> If you're in an organization and are using a layout to update Visual Studio, your IT Administrator is expected to maintain the previous packages in the layout if the client is expected to be able to roll back. Also, rollback may be disabled or your rollback attempt may be undone if you're in an organization that has security compliance or software updating requirements. Contact your IT Administrator for further details.

To roll back with the Visual Studio Installer, follow these steps:

1. Launch the **Visual Studio Installer** on your computer.
1. In the installer, look for the edition of Visual Studio that you installed.
1. Select **More**.
1. Select **Rollback to previous version**.

    :::image type="content" source="media/troubleshoot-installation-issues/rollback-from-previous-version.png" alt-text="Screenshot of the Rollback to previous version option." lightbox="media/troubleshoot-installation-issues/rollback-from-previous-version.png":::
1. Select **OK** to confirm.

#### 8. Contact our live chat

If none of the previous steps help you successfully install or upgrade Visual Studio, contact us by using our [**live chat**](https://visualstudio.microsoft.com/vs/support/#talktous) support option (English only) for further assistance.

## Network layout or offline installations

To resolve issues with a [network installation](/visualstudio/install/create-a-network-installation-of-visual-studio), see [Error Codes](/visualstudio/install/create-a-network-installation-of-visual-studio#error-codes) or [Troubleshoot network-related errors when you install or use Visual Studio](troubleshoot-network-related-errors.md).

## Administrator updates

Administrator updates may not be applied correctly due to various situations. For more information, see [Administrator updates troubleshooting error codes](/visualstudio/install/applying-administrator-updates#verification-reports-and-troubleshooting-error-codes).

You can use the following methods to provide feedback about Visual Studio administrator updates or report issues that affect the updates:

- Ask questions to the community at the [Visual Studio Setup Q&A Forum](/answers/topics/vs-setup.html).
- Go to the [Visual Studio support page](https://visualstudio.microsoft.com/vs/support/), and check whether your issue is listed in the FAQ.
- [Provide feature feedback or report a problem](https://aka.ms/vs/wsus/feedback) to the Visual Studio team regarding your experience.
- Contact your organization's technical account manager for Microsoft.

## Collect installation logs for Microsoft Support

If you contact Microsoft Support, you might be asked to collect setup logs by using the [Microsoft Visual Studio and .NET Framework log collection tool](https://aka.ms/vscollect). The log collection tool collects setup logs from all components installed by Visual Studio, including .NET Framework, Windows SDK, and SQL Server. It also collects computer information, a Windows Installer inventory, and Windows event log information for the Visual Studio Installer, Windows Installer, and System Restore.

To collect the logs, follow these steps:

1. [Download the tool](https://aka.ms/vscollect).
1. Open an administrative command prompt.
1. Run `Collect.exe` in the folder where you saved the tool.

   The tool must be run under the same user account that the failed installation was run under. If you're running the tool from a different user account, set the `-user:<name>` option to specify the user account under which the failed installation was run. Run `Collect.exe -?` from an administrator command prompt for more options and usage information.

The tool generates a _vslogs.zip_ file in your _%TEMP%_ folder, typically at _C:\Users\YourName\AppData\Local\Temp\vslogs.zip_.

Report product issues to us using the [Report a Problem](/visualstudio/ide/how-to-report-a-problem-with-visual-studio) tool that appears both in the Visual Studio Installer and in the Visual Studio IDE. If you are an IT Administrator and don't have Visual Studio installed, you can submit [IT Admin feedback here](https://aka.ms/vs/admin/feedback).

## Problems installing WebView2

If your organization's Group policies block the installation of the WebView2 component, you won't be able to install Visual Studio because the installer requires WebView2 to be installed. If this happens, check these policies:

- If the [Microsoft Edge 'Install (WebView)'](/deployedge/microsoft-edge-update-policies#install-webview) is configured, it determines whether WebView2 can be installed.
- If the Microsoft Edge 'Install (WebView)' policy isn't configured, the [Microsoft Edge 'InstallDefault'](/deployedge/microsoft-edge-update-policies#installdefault) policy determines whether WebView2 can be installed.

> [!WARNING]
> If neither policy is configured, WebView2 installation is allowed by your organization.
