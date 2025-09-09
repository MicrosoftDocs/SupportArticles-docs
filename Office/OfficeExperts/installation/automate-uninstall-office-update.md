---
title: How to automate the uninstallation of an Office update programmatically
description: Describes how to uninstall an Office update programmatically by using a command with Office GUID and the update GUID.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - sap:office-experts
  - CSSTroubleshoot
  - CI 162524
ms.reviewer: ericspli
ms.author: meerak
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# How to automate the uninstallation of an Office update programmatically

This article was written by [Eric Ashton](https://social.technet.microsoft.com/profile/EricAshton), Senior Support Escalation Engineer.

This article describes how to uninstall Office updates automatically by using a command line that resembles the following:

`%windir%\System32\msiexec.exe /package {Office GUID} /uninstall {Update GUID} /QN`

## Determine the GUID of the installed Office version

To determine the GUID of the installed Office version, follow these steps:

1. Locate and check the following registry key.

   **For 32-bit OS**

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`

   **For 64-bit OS**

   `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall`

1. Refer to the following articles to find the GUID in the Office version, as appropriate for your situation:

   - [Description of the numbering scheme for product code GUIDs in Office 2016](../../Client/office-suite-issues/numbering-scheme-for-product-guid.md)
   - [Description of the numbering scheme for product code GUIDs in Office 2013](../../Client/office-suite-issues/numbering-scheme-product-code-guids.md)

   > [!NOTE]
   > Verify that you find the correct GUID by verifying the product in the **DisplayName** field of the key listed in the GUID.

## Determine the GUID of the update

To determine the GUID of the update, you have to check the properties of the MSP file that is contained within the update .exe file.

First, you have to extract the MSP file from the update executable. To do this run the following command to extract the file to the c:\temp directory:

`<MSP file name> /extract:c:\temp`

For example, to extract content from the Office 2013 update [4462201](https://www.microsoft.com/download/details.aspx?id=57979) (mso2013-kb4462201-fullfile-x64-glb.exe), run the following command:

`mso2013-kb4462201-fullfile-x64-glb.exe /extract:c:\temp`

When you have the MSP from the update executable, you have to find the GUID of the update. To find the GUID, right-click the MSP file, locate **Properties**, and then look for the **Revision number**.

Sometimes there are many numbers in the **Revision number** section. Copy and paste the list of revision numbers into notepad, and then delete all except the first number. The first number in the list of revision numbers is the GUID.

Now, you know the GUID in the Office version and the GUID of the Office update. You can run the following command to remove the update programmatically.

`%windir%\System32\msiexec.exe /package {Office GUID} /uninstall {Update GUID} /qn`

> [!NOTE]
> Use **/qb** for an automated uninstallation with a progress bar, or use **/qn** for a completely silent uninstallation.

## FAQs

**How can we determine whether the update is installed programmatically if we know the GUID of the update?**

You can do this as soon as you convert the update GUID to the compressed GUID. Here are the steps about how to convert the uncompressed GUID to the compressed GUID.

1. Separate the uncompressed GUID into five sections and drop the dashes. For example, an uncompressed GUID without dashes is displayed as *90110409 6000 11D3 8CFE 0150048383C9*.
1. Reverse the order of each number of the first three sections. In this example, the first three sections are displayed as *90401109 0006 3D11*.
1. In the fourth and fifth sections, you have to transpose every two characters. To do this, follow these steps:

   1. Break up the two sections to every two characters that are separated by spaces. The numbers are displayed as *8C FE 01 50 04 83 83 C9*.
   1. Transpose each section. The numbers are displayed as *C8 EF 10 05 40 38 38 9C*.

1. Put the numbers all together and remove the spaces. The compressed GUID will become *9040110900063D11C8EF10054038389C*.

Then query the compressed GUID at the following registry location:

`HKEY_CLASSES_ROOT\Installer\Patches`

If the GUID exists, it means the update is installed.

**Is it possible to uninstall an update that is not natively uninstallable?**

Although it's neither recommended nor supported by Microsoft, you can uninstall updates that are marked as not uninstallable. Again, you have to convert the update GUID to a compressed GUID by using the previous method.

You can determine whether the update is uninstallable by using the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\Office GUID\Patches\Compressed GUID`

"**Uninstallable**"=dword:00000001

> [!NOTE]
> If the update isn't uninstallable natively, it would be possible to change the **Uninstallable** value at this registry location to **1**, and then the update would be available to uninstall.

**We have an update that has multiple MSP files inside it. Is this normal? Would we have to uninstall them all?**

It is common for Office updates to contain multiple MSP files. If you want to remove the update completely, you have to uninstall each MSP file.

It is also common for Office updates to apply to multiple products. Therefore, they are displayed multiple times in **Uninstall or change a program**. In these cases, to remove the update completely, you have to run the uninstallation command targeting the GUID for each Office product that has the update installed.
