---
title: How to download updates that include drivers and hotfixes from the Windows Update Catalog
description: Describes how to obtain updates, WHQL drivers, and hotfixes from the Windows Update Catalog. This information is for advanced users only.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, chughes
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# How to download updates that include drivers and hotfixes from the Windows Update Catalog

This article discusses how to download updates from the Windows Update Catalog.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 323166

## Introduction

The Windows Update Catalog offers updates for all operating systems that we currently support. These updates include the following:

- Device drivers
- Hotfixes
- Updated system files
- New Windows features

We guide you through the steps to search the Windows Update Catalog to find the updates that you want. Then, you can download the updates to install them across your home or corporate network of Microsoft Windows-based computers.

We also discuss how IT Professionals can use Software Update Services, such as Windows Update and Automatic Updates.

> [!IMPORTANT]
> This content is designed for an advanced computer user. We recommend that only advanced users and administrators download updates from the Windows Update Catalog. If you are not an advanced user or an administrator, visit the following Microsoft Web site to download updates directly:  
[Windows Update: FAQ](https://support.microsoft.com/windows/windows-update-faq-8a903416-6f45-0718-f5c7-375e92dddeb2)

## Steps to download updates from the Windows Update Catalog

To download updates from the Windows Update Catalog, follow these steps:

### Step 1: Access the Windows Update Catalog

To access the Windows Update Catalog, visit the following Microsoft Web site:  
[Windows Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx)

To view a list of frequently asked questions about Windows Update Catalog, visit the following Microsoft Web site:  
[Microsoft Update Catalog Frequently Asked Questions](https://www.catalog.update.microsoft.com/faq.aspx)

### Step 2: Search for updates from the Windows Update Catalog

To search for updates from the Windows Update Catalog, follow these steps:

1. In the **Search** text box, type your search terms. For example, you might type *Windows Vista Security*.
2. Click **Search**, or press **Enter**.
3. Browse the list that is displayed to select the updates that you want to download.
4. Click **Download** to download the updates.
5. To search for additional updates to download, repeat steps 2a through 2d.

### Step 3: Download updates

To download updates from the Windows Update Catalog, follow these steps:

1. Click the **Download** button under **Search** box.
2. Click the updates link on the pop-up page and **Save** to the default path, or right-click the link and select **Save target as**  to the specified path. You can either type the full path of the folder, or you can click **Browse**  to locate the folder.
3. Close the **Download** and the **Windows Update Catalog** Window.
4. Find the location that you specified in step 3b.
    > [!NOTE]
    > If you have downloaded device drivers for installation, go to "Installing Drivers."

5. Double-click each update, and then follow the instructions to install the update. If the updates are intended for another computer, copy the updates to that computer, and then double-click the updates to install them.

If all the items that you added to the download list are installed successfully, you are finished.

If you want to learn about additional update services, please see the "Software Update Services for IT Professionals" section.

#### Installing drivers

1. Open a command prompt from the **Start** menu.
2. To extract the driver files, type the following command at the command prompt, and then press **Enter**:

    ```console
    expand <CAB FILE NAME> -F:* <DESTINATION>  
    ```

3. To stage the driver for plug and play installation or for the Add Printer Wizard, use PnPutil Software Update Services for IT Professionals.

> [!NOTE]
> To install a cross-architecture print driver, you must already have installed the local architecture driver, and you will still need the cross-architecture copy of Ntprint.inf from another system.

## Software Update Services for IT Professionals

For general information about Software Update Services, visit the following Microsoft Web site:  
[Overview of Windows as a service](/windows/deployment/update/waas-overview)

### Windows Update

IT Professionals can use the Windows Update service to configure a server on their corporate network to provide updates to corporate servers and clients. This functionality can be useful in environments where some clients and servers do not have access to the Internet. This functionality can also be useful where the environment is highly managed, and the corporate administrator must test the updates before they are deployed.

For information about using Windows Update, visit the following Microsoft Web site:  
[Windows Update: FAQ](https://support.microsoft.com/help/12373/windows-update-faq)

### Automatic Updates

IT Professionals can use the Automatic Updates service to keep computers up to date with the latest critical updates from a corporate server that is running Software Update Services.

Automatic Updates works with the following computers:

- Microsoft Windows 2000 Professional
- Windows 2000 Server
- Windows 2000 Advanced Server (Service Pack 2 or later versions)
- Windows XP Professional
- Windows XP Home Edition computer

For more information about how to use Automatic Updates in Windows XP, click the following article number to view the article in the Microsoft Knowledge Base:  
[306525](https://support.microsoft.com/help/306525) How to configure and use Automatic Updates in Windows XP

## Troubleshooting

You may experience one or more of the following issues when you use Windows Update or Microsoft Update:

- You may receive the following error message:  
    > Software update incomplete, this Windows Update software did not update successfully.

- You may receive the following error message:
    > Administrators Only (-2146828218) To install items from Windows Update, you must be logged on as an administrator or a member of the Administrators group. If your computer is connected to a network, network policy settings may also prevent you from completing this procedure.

    For more information about this issue, click the following article number to view the article in the Microsoft Knowledge Base: [316524](https://support.microsoft.com/help/316524) You receive an "Administrators only" error message when you try to visit the Windows Update Web site or the Microsoft Update Web site

- You may be unable to view the Windows Update site or the Microsoft Update site if you connect to the Web site through an authenticating Web proxy that uses integrated (NTLM) proxy authentication.

## Similar problems and solutions

You can visit the Microsoft Web sites in the following sections for more information:  
[Windows Update troubleshooting](/windows/deployment/update/windows-update-troubleshooting)

### Installing multiple updates with only one restart

The hotfix installer that is included with Windows XP and with Windows 2000 post-Service Pack 3 (SP3) updates includes functionality to support multiple hotfix installations. For earlier versions of Windows 2000, the command-line tool that is named "QChain.exe" is available for download.

For more information about how to install multiple updates or multiple hotfixes without restarting the computer between each installation, click the following article number to view the article in the Microsoft Knowledge Base:  
[296861](https://support.microsoft.com/help/296861) How to install multiple Windows updates or hotfixes with only one reboot

### Microsoft security resources

For the latest Microsoft security resources such as security tools, security bulletins, virus alerts, and general security guidance, see [Security documentation](/security/).

For more information about the Microsoft Baseline Security Analyzer tool (MBSA), see [What is Microsoft Baseline Security Analyzer and its uses?](/windows/security/threat-protection/mbsa-removal-and-guidance).

### The Microsoft Download Center

For more information about how to download files from the Microsoft Download Center, click the following article number to view the article in the Microsoft Knowledge Base:  
[119591](https://support.microsoft.com/help/119591) How to obtain Microsoft support files from online services

### Product-specific download pages

#### Internet Explorer

For Internet Explorer downloads, visit the following Microsoft Web site:  
[Internet Explorer Downloads](https://support.microsoft.com/help/17621/internet-explorer-downloads)

#### Windows Media Player

For Windows Media Player downloads, visit the following Microsoft Web site:  
[Windows Media Player](https://windows.microsoft.com/windows/windows-media-player)

#### Office Updates

For Office updates, visit the following Microsoft Web site:  
[Install Office updates](https://support.microsoft.com/office/2ab296f3-7f03-43a2-8e50-46de917611c5)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
