---
title: Unable to update Visual Studio using the Help menu
description: Provides a resolution for an issue where you can't update Visual Studio using the Help menu.
ms.date: 09/26/2023
ms.reviewer: khgupta, raviuppa, aartigoyle, v-sidong
ms.custom: sap:installation
---
# Unable to update Visual Studio using the Help menu

_Applies to:_ &nbsp; Visual Studio Professional 2022

## Symptoms

You can't update Visual Studio to the latest version using the **Help** menu in the Integrated Development Environment (IDE) (by selecting **Help** > **Check for Updates** > **Update option**).

You may also see the following error in the logs:

```output
Error 0x80070057: Failed to read instance <InstanceNum>
at System.ThrowHelper.ThrowArgumentException(ExceptionResource resource) 
at System.Collections.Generic.Dictionary`2.Insert(TKey key, TValue value, Boolean add) 
at System.Linq.Enumerable.ToDictionary[TSource,TKey,TElement](IEnumerable`1 source, Func`2 keySelector, Func`2 elementSelector, IEqualityComparer`1 comparer) 
at Microsoft.VisualStudio.Setup.Installer.Extensions.GetReleaseNotesUris(IChannel channel) 
at Microsoft.VisualStudio.Setup.Installer.Models.Readers.ChannelReader.ReadFromChannel(ChannelNode`1 channelProduct) 
at Microsoft.VisualStudio.Setup.Installer.Models.Readers.ProductSummaryReader.ReadFromInstance(IInstance instance) 
at Microsoft.VisualStudio.Setup.Installer.Services.ProductsProviderService.TryGetInstalledProductSummary(IInstance instance) 

[4b94:000d][<DateTime>] Warning: Failed to initialize the update dialog: No instance registered for path "C:\Program Files\Microsoft Visual Studio\2022\Professional" 
[4b94:0001][<DateTime>] Navigate to Page: Final, Action: None, Message: The operation did not complete successfully 
```

## Cause

This issue occurs when you use an outdated version of the Visual Studio Installer (earlier than 3.1.2188) that's incompatible with Visual Studio 2022. Error code 0x80070057 indicates that the installer can't read certain parameters. The older version of the Visual Studio Installer can't recognize and process the new parameters introduced in the latest updates.

## Resolution

1. Download [vs_Professional.exe](https://aka.ms/vs/17/release/vs_Professional.exe) and save it to the *C:\Temp* folder.
1. Delete the *C:\Program Files (x86)\Microsoft Visual Studio\Installer* folder, or update the Visual Studio Installer by right-clicking *C:\Temp\vs_Professional.exe* and selecting **Run as Administrator**.
1. Select the **Update** button to start the update process.
