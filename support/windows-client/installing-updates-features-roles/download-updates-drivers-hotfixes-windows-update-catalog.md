---
title: How to download updates that include drivers and hotfixes from the Microsoft Update Catalog
description: Describes how to get updates, WHQL drivers, and hotfixes from the Microsoft Update Catalog. This information is for advanced users only.
ms.date: 09/25/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, chughes, riyankadawn
ai-usage: ai-assisted
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Configuring and managing client settings
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# How to download updates that include drivers and hotfixes from the Microsoft Update Catalog

This article discusses how to download updates from the Microsoft Update Catalog.

_Original KB number:_ &nbsp; 323166

## Introduction

The Microsoft Update Catalog offers updates for all operating systems that Microsoft currently supports. These updates include the following:

- Device drivers
- Hotfixes
- Updated system files
- New Windows features

This article guides you through the steps to search the Microsoft Update Catalog to find the updates that you want. Then, you can download the updates to install them across your home or corporate network of Microsoft Windows-based computers.

This article also discusses how IT professionals can use Software Update Services, such as Windows Update and Automatic Updates.

> [!IMPORTANT]
> This content is designed for an advanced computer user. Only advanced users and administrators should download updates from the Microsoft Update Catalog. If you're not an advanced user or an administrator, visit the following Microsoft website to download updates directly:  
[Windows Update: FAQ](https://support.microsoft.com/windows/windows-update-faq-8a903416-6f45-0718-f5c7-375e92dddeb2)

## Steps to download updates from the Microsoft Update Catalog

To download updates from the Microsoft Update Catalog, follow these steps:

### Step 1: Access the Microsoft Update Catalog

To access the Microsoft Update Catalog, visit the following Microsoft website:  
[Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx)

To view a list of frequently asked questions about the Microsoft Update Catalog, visit the following Microsoft website:  
[Microsoft Update Catalog Frequently Asked Questions](https://www.catalog.update.microsoft.com/faq.aspx)

### Step 2: Search for updates from the Microsoft Update Catalog

To search for updates from the Microsoft Update Catalog, follow these steps:

1. In the **Search** text box, enter your search terms. For example, you might type *Windows Vista Security*.
1. Select **Search**, or press **Enter**.
1. Browse the list that's displayed to select the updates that you want to download.
1. Select **Download** to download the updates.
1. To search for more updates to download, repeat steps 2a through 2d.

### Step 3: Download updates

To download updates from the Microsoft Update Catalog, follow these steps:

1. Select the **Download** button under the **Search** box.
1. Select the updates link on the pop-up page and **Save** to the default path, or right-click the link and select **Save target as** to the specified path. You can either type the full path of the folder, or you can select **Browse** to locate the folder.
1. Close the **Download** and the **Microsoft Update Catalog** windows.
1. Find the location that you specified in step 3b.
    > [!NOTE]
    > If you downloaded device drivers for installation, go to "Installing Drivers."

1. Double-click each update, and then follow the instructions to install the update. If the updates are intended for another computer, copy the updates to that computer, and then double-click the updates to install them.

If you successfully install all the items that you added to the download list, you're finished.

If you want to learn about additional update services, see the "Software Update Services for IT Professionals" section.

#### Installing drivers

1. Open a command prompt from the **Start** menu.
1. To extract the driver files, type the following command at the command prompt, and then select **Enter**:

    ```cmd
    expand <CAB FILE NAME> -F:* <DESTINATION>  
    ```

1. To stage the driver for plug and play installation or for the Add Printer Wizard, use PnPutil Software Update Services for IT Professionals.

> [!NOTE]
> To install a cross-architecture print driver, you must already have installed the local architecture driver, and you still need the cross-architecture copy of Ntprint.inf from another system.

## Software update services for IT professionals

For general information about Software Update Services, visit the following Microsoft website:  
[Overview of Windows as a service](/windows/deployment/update/waas-overview)

### Windows Update

IT professionals can use the Windows Update service to configure a server on their corporate network to provide updates to corporate servers and clients. This functionality can be useful in environments where some clients and servers don't have access to the internet. This functionality can also be useful in environments that are highly managed, and the corporate administrator must test the updates before they deploy them.

For information about using Windows Update, visit the following Microsoft website:  
[Windows Update: FAQ](https://support.microsoft.com/help/12373/windows-update-faq)

### Automatic Updates

IT professionals can use the Automatic Updates service to keep computers up to date with the latest critical updates from a corporate server that is running Software Update Services.

Automatic Updates works with the following computers:

- Microsoft Windows 2000 Professional
- Windows 2000 Server
- Windows 2000 Advanced Server (Service Pack 2 or later versions)
- Windows XP Professional
- Windows XP Home Edition computer

For more information about how to use Automatic Updates in Windows XP, click the following article number to view the article in the Microsoft Knowledge Base:  
[306525](https://support.microsoft.com/help/306525) How to configure and use Automatic Updates in Windows XP

## Troubleshooting

When you use Windows Update or Microsoft Update, you might experience one or more of the following issues:

- You might receive the following error message:  
    > Software update incomplete, this Windows Update software did not update successfully.

- You might receive the following error message:
    > Administrators Only (-2146828218) To install items from Windows Update, you must be logged on as an administrator or a member of the Administrators group. If your computer is connected to a network, network policy settings might also prevent you from completing this procedure.

    For more information about this issue, see [316524](https://support.microsoft.com/topic/d2c732b6-21e0-a2ce-8d18-303ed71736c9) You receive an "Administrators only" error message when you try to visit the Windows Update Web site or the Microsoft Update Web site.

- You might be unable to view the Windows Update site or the Microsoft Update site if you connect to the Web site through an authenticating Web proxy that uses integrated (NTLM) proxy authentication.

## Similar problems and solutions

For more information, visit the following Microsoft websites:  
[Windows Update troubleshooting](/windows/deployment/update/windows-update-troubleshooting)

### Installing multiple updates with only one restart

The hotfix installer that is included with Windows XP and with Windows 2000 post-Service Pack 3 (SP3) updates includes functionality to support multiple hotfix installations. For earlier versions of Windows 2000, you can download the command-line tool named **QChain.exe**.

For more information about how to install multiple updates or multiple hotfixes without restarting the computer between each installation, see the following article in the Microsoft Knowledge Base:  
[296861](https://support.microsoft.com/help/296861) How to install multiple Windows updates or hotfixes with only one reboot

### Microsoft security resources

For the latest Microsoft security resources such as security tools, security bulletins, virus alerts, and general security guidance, see [Security documentation](/security/).

For more information about the Microsoft Baseline Security Analyzer tool (MBSA), see [What is Microsoft Baseline Security Analyzer and its uses?](/windows/security/threat-protection/mbsa-removal-and-guidance).

### The Microsoft Download Center

For more information about how to download files from the Microsoft Download Center, see the [Microsoft Download Center](https://www.microsoft.com/en-us/download) Frequently Asked Questions list.

### Product-specific download pages

#### Internet Explorer

For Internet Explorer downloads, visit the following Microsoft website:  
[Internet Explorer Downloads](https://support.microsoft.com/help/17621/internet-explorer-downloads)

#### Windows Media Player

For Windows Media Player downloads, visit the following Microsoft website:  
[Windows Media Player](https://windows.microsoft.com/windows/windows-media-player)

#### Office Updates

For Office updates, visit the following Microsoft website:  
[Install Office updates](https://support.microsoft.com/office/2ab296f3-7f03-43a2-8e50-46de917611c5)

## Data collection

If you need assistance from Microsoft support, collect the information by following the steps in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
