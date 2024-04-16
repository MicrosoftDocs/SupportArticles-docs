---
title: Windows Search 4.0 and Multilingual User Interface Pack
description: Describes the features and improvements in Windows Search 4.0. Provides download information.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Desktop and Shell Experience\Windows Search, csstroubleshoot
---
# Description of Windows Search 4.0 and the Multilingual User Interface Pack for Windows Search 4.0

This article discusses the availability of Windows Search 4.0 and the Multilingual User Interface Pack (MUI) for Windows Search 4.0.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 940157

> [!NOTE]
> Support for Windows Vista Service Pack 1 (SP1) ends on July 12, 2011. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2).

## Windows Search 4.0

Windows Search 4.0 lets you perform an instant search of your computer. Windows Search 4.0 helps you find and preview documents, e-mail messages, music files, photos, and other items on the computer.

The search engine in Windows Search 4.0 is a Microsoft Windows service that is also used by programs such as Office Outlook 2007 and Office OneNote 2007. You can use this search engine to index a program's content and to obtain instant results when you search in a particular program.

Windows Search 4.0 includes the following improvements:

- Support for indexing encrypted documents of local file systems
- Reduced effect on Microsoft Exchange when you index e-mail in online mode, and there is no local cache (.ost)
- Support for indexing online delegate mailboxes
- Support forclient-to-client remote query to shared indexed locations
- Improved indexing performance
- Faster previewer updates for Windows XP
- Per-user Group Policy settings
- Windows software updates for Watson errors
- Support for the following new enterprise Group Policy objects:

## Computer policies

- Prevent adding Universal Naming Convention (UNC) locations to index from Control Panel
- Prevent customizing indexed locations in Control Panel
- Prevent automatically adding shared folders to the index
- Allow for indexing of encrypted files
- Disable indexer back-off
- Prevent clients from querying the index remotely
- Allow for indexing of online delegate mailboxes
- Prevent adding user-specified locations to the **All Locations** menu
- Enable throttling for online mail indexing

## Per-user policies

- Prevent adding UNC locations to the index from Control Panel
- Prevent customizing indexed locations in Control Panel
- Prevent indexing certain paths
- Default indexed paths
- Default excluded paths

Windows Search 4.0 packages include the following:

- The Group Policy template (Search.adm or Search.admx /l) for managing Group Policy objects that span multiple versions of Windows Desktop Search and Windows Search.

- The Add-in for Files on Microsoft Networks for Windows XP and Windows Server 2003 packages.

    This add-in lets Windows Search index redirected *My Documents* folders. This add-in also lets Windows Search index shared items on remote networks. By default, this add-in is included for supported 32-bit operating systems.

When you install the Windows Search 4.0 packages, you also install the following items:

- XmlLite
- IFilters

Windows Search 4.0 supports the following operating systems:

- 32-bit versions of Windows Vista with Service Pack 1 (SP1)
- 64-bit versions of Windows Vista with SP1
- 32-bit versions of Windows XP with Service Pack 2 (SP2) or a later version
- 64-bit versions of Windows XP with Service Pack 2 (SP2) or a later version
- 32-bit versions of Windows Server 2003 with SP2
- 64-bit versions of Windows Server 2003 with SP2
- Windows Server 2008
- Windows Home Server

The Windows Search 4.0 installation process automatically upgrades Windows Desktop Search (WDS) 2.6 and later versions of WDS. If you are running a version of WDS that is earlier than WDS 2.6, use the **Add or Remove Programs** tool to remove the earlier version before you install Windows Search 4.0.

> [!NOTE]
> To install Windows Search 4.0 successfully on a computer that is running Windows XP or Windows Server 2003, Terminal Services must be running on the computer. Also, Terminal Services must be running for Windows Search 4.0 to function correctly. By default, Terminal Services is configured to start automatically. However, it may have been disabled manually or by third-party software. If Terminal Services is disabled, the installation of Windows Search 4.0 will fail with error code 643.

To determine the status of Terminal Services, and start the service if it is disabled, follow these steps:

1. Click **Start**, click **Run**, type *services.msc*, and then press ENTER.
2. Locate Terminal Services.
3. If the **Status** of the service is not set to **Started**, right-click the service, and then click **Properties**.
4. In the **Startup type** list, click **Automatic**, click **Apply**, and then click **Start**.

> [!NOTE]
> If the installation of Windows Search 4.0 was not successful because Terminal Services was disabled on the computer, you can now restart the installation of Windows Search 4.0.

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

## The Multilingual User Interface Pack for Windows Search 4.0

The MUI package for Windows XP and for Windows Server 2003 contain an English (EN-US ENU) package installer that also contains resources for the following 30 languages:

- Brazilian Portuguese (pt-BR PTB)
- Bulgarian (bg-BG BGR)
- Chinese - Simplified (zh-CN CHS)
- Chinese - Traditional (zh-TW CHT)
- Croatian (hr-HR HRV)
- Czech (cs-CZ CSY)
- Danish (da-DK DAN)
- Dutch (nl-NL NLD)
- Estonian (et-EE ETI)
- Finnish (fi-FI FIN)
- French (fr-FR FRA)
- German (de-DE DEU)
- Greek (el-GR ELL)
- Hungarian (hu-HU HUN)
- Italian (it-IT ITA)
- Japanese (ja-JP JPN)
- Korean (ko-KR KOR)
- Latvian (lv-LV LVI)
- Lithuanian (lt-LT LTH)
- Norwegian - Bokmål (nb-NO NOR)
- Polish (pl-PL PLK)
- Portuguese (pt-PT PTG)
- Romanian (ro-RO ROM)
- Russian (ru-RU RUS)
- Slovak (sk-SK SKY)
- Slovenian (sl-SI SLV)
- Spanish (es-ES ESN)
- Swedish (sv-SE SVE)
- Thai (th-TH THA)
- Turkish (tr-TR TRK)

The Windows Search 4.0 MUI installation process automatically upgrades the earlier versions of the WDS 2.6 MUI and later versions of the WDS MUI. If you have an English version of Windows and the Windows MUI and if you have an earlier version of WDS that was a stand-alone non-English installation, use the **Add or Remove Programs** tool to remove the earlier version before you install the Windows Search 4.0 MUI.

> [!NOTE]
> The MUI for Windows Server 2003 and Windows XP contains resources for 30 languages.

For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.
