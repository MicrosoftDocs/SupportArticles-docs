---
title: Language packs no longer available
description: Discusses that previously installed language packs are no longer available after you upgrade from Windows 8 to Windows 8.1. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, jerrycif, ianham
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Language packs are no longer available after upgrading

This article discusses that previously installed language packs are no longer available after you upgrade from Windows 8 to Windows 8.1.  

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2910256

## Symptoms

After you upgrade from Windows 8 to Windows 8.1, language packs that were installed before the upgrade are no longer available. You can still switch to the keyboard layout of the languages that were installed before the upgrade. However, the only available display language is the base language version of the Windows installation. In some cases, you cannot reinstall the language packs or change the display language of Windows.

## Cause

This behavior is by design. Language packs are not upgraded as part of the operating system upgrade. This issue occurs because Windows 8 and Windows 8.1 each have version-specific language packs. When you upgrade Windows 8 to Windows 8.1, the operating system reverts to its base language version. After the upgrade is finished, you have to reinstall any language packs that you require.  

It is also possible that the Advanced language options are set to cause Windows to use a display language that is not yet installed after the upgrade. It causes a condition that prevents you from being able to change the display language or download language packs.

## Resolution

Follow Resolution 1 to install the language packs. If you have issues downloading or installing language packs, go to Resolution 2.  

### Resolution 1: Install the language packs

The instructions for installing language packs can be found in the following Microsoft Knowledge Base article:  
[Language packs are available for Windows 8 and for Windows RT](https://support.microsoft.com/help/2607607)  

Download a language pack from the Windows website  

Language packs are sometimes unavailable, and you cannot download them in Control Panel. If you experience this issue, try to find and download the language pack that you want on the following Windows website:  
[Language packs](https://windows.microsoft.com/windows/language-packs#lptabs=win8)  
If you cannot download a management pack, go to Resolution 2.

### Resolution 2: Change settings that may block installation

There are advanced language settings that may block the download of language packs. To revert these settings to their defaults values so that you can download language packs, follow these steps:  

1. Open Control Panel. To do it, type Control Panel in the **Search** box, and then tap or click **Control Panel** in the search results list.
2. Tap or click **Clock, Language and Region**. (If you are viewing Control Panel in icon display, select **Language**, and then go to step 4.)
3. Tap or click **Language**.
4. Tap or click **Advanced settings**.
5. Examine the **Override for Windows display language** and **Override for default input method** lists. Make sure that the **Use language list (recommended)**  option is selected for both lists (see Figure 1). Then, tap or click **Save**.

    Figure 1: Advanced settings

    :::image type="content" source="media/language-packs-no-longer-available-after-upgrade/advanced-settings.png" alt-text="Select the Use language list (recommended) options in Advanced settings.":::

6. After you save the settings, you are returned to the standard language settings. In the list of previously installed languages, click **Options** next to the language you want to install.
7. Click the download link to install the language pack (see Figure 2).

    > [!NOTE]
    > After the installation is finished, you are prompted to restart the computer.

    Figure 2: Start the download

    :::image type="content" source="media/language-packs-no-longer-available-after-upgrade/start-the-download.png" alt-text="Select the download link to install the language pack.":::

## More information

During the upgrade from Windows 8 to Windows 8.1, Windows Setup detects whether the display language is the localized language of the operating system. It then displays the following message window to indicate that you might have to reinstall any language packs that were previously installed.

:::image type="content" source="media/language-packs-no-longer-available-after-upgrade/what-needs-your-attention.png" alt-text="The message window indicates that you might have to reinstall any language packs that were previously installed." border="false":::

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
