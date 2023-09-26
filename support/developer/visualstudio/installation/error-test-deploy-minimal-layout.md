---
title: Error when testing or deploying a minimal layout
description: Provides a resolution for an issue that occurs when you test or deploy a minimal layout.
ms.date: 09/26/2023
ms.reviewer: khgupta, raviuppa, aartigoyle, v-sidong
ms.custom: sap:installation
---
# Error when testing or deploying a minimal layout in Visual Studio

_Applies to:_ &nbsp; Visual Studio 2022

## Symptoms

After you successfully create a minimal layout and test it on a system, an error message like the following one is displayed:

Snippet from the log:

```output
[3004:0006][<DateTime>] Unable to select suitable download engine. 
[3004:0006][<DateTime>] Unable to get download engine: Can not download. No suitable download engine found. 
[3004:0006][<DateTime>] Error 0x80131500: Unable to download the channel manifest from https://aka.ms/vs/17/release/channel. at Microsoft.VisualStudio.Setup.ChannelManager.<AddAsync>d__43.MoveNext() 
[3004:0006][<DateTime>] Error 0x80131500: Failed to initialize the app in AppInitializerService.InitializeChannelsAsync: Microsoft.VisualStudio.Setup.ChannelManifestDownloadException 
```

## Cause

The issue can occur if the upgrade is performed from a new profile, or the content under the *%localappdata%\Microsoft\VisualStudio* folder is missing or corrupt. This folder hosts the channel manifest file, which contains details about the product and its upgrades.

Ideally, this behavior shouldn't occur when installing and updating Visual Studio using the same user account. Visual Studio creates the *_channels* folder during the initial installation under *C:\ProgramData\Microsoft\VisualStudio\Packages* and *%localappdata%\Microsoft\VisualStudio\Packages*. During the update process, Visual Studio compares the catalog and channel manifest files from these locations to ensure a smooth update.

## Resolution

To resolve this issue, follow these steps:

1. Copy the *_channels* folder located under *C:\ProgramData\Microsoft\VisualStudio\Packages*.
1. Create a new folder named *Packages* under the *%localappdata%\Microsoft\VisualStudio* directory.
1. Paste the *_channels* folder into the newly created *Packages* folder.
1. Try running the update process again.
