---
title: Invalid entries passed to switch
description: Provides a workaround for an issue where you receive error messages like invalid entries passed to /FilterFeatureSelectionTree and /InstallSelectableItems switch.
ms.date: 05/20/2022
ms.author: v-sidong
---

# Invalid entries passed to /FilterFeatureSelectionTree and /InstallSelectableItems switch

This article provides a workaround for an issue where you receive error messages when you try to run the same Visual Studio 2015 Update installer again.

_Original product version:_ &nbsp;Visual Studio 2015  
_Original KB number:_ &nbsp;3039361

## Symptoms

When you install a Visual Studio 2015 Update, the setup fails or cancels out. If you try to run the same Visual Studio 2015 Update installer again, you receive the following error messages:

> Invalid entries passed to /FilterFeatureSelectionTree switch. For more details, please see the setup log.
Invalid entries passed to /InstallSelectableItems switch. For more details, please see the setup log.

## Cause

This issue occurs when the initial failed or canceled setup didn't persist the latest _feed.xml_. The next time the Visual Studio Update installer runs, it tries to use the outdated _feed.xml_ that it detects from earlier Visual Studio install sessions.

## Workaround

To work around this issue, run the following command:

```cmd
VS2015.3.exe /overridefeeduri <Path to feed.xml>
```

The path of _feed.xml_ can be a web link from the following table or a local path. If you download the file from the web link and save the _feed.xml_ to your local disk, the "Path to feed.xml" will be your local path.

|Language|Download link|
|-|-|
|Chinese - Traditional (CHT)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x404|
|Chinese - Simplified(CHS)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x804|
|Czech(CSY)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x405|
|English(ENU)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x409|
|French(FRA)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x40C|
|German(DEU)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x407|
|Italian(ITA)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x410|
|Japanese(JPN)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x411|
|Korean(KOR)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x412|
|Polish(PLK)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x415|
|Portuguese(PTB)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x416|
|Russian(RUS)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x419|
|Spanish(ESN)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0xC0A|
|Turkish(TRK)|http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x41f|

> [!NOTE]
> The _feed.xml_ is language specific. Therefore, select the _feed.xml_ that matches the language version of your Visual Studio. If you have multiple languages installed, select the one that you used to install Visual Studio.

For example, you have CHS Visual Studio installed on the computer.

- If the path of _feed.xml_ is a web link, run the following command:

    ```cmd
    VS2015.3.exe /overridefeeduri http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x804
    ```

- If the path of _feed.xml_ is a local path (you download the _feed.xml_ from http://go.microsoft.com/fwlink/?LinkID=564093&clcid=0x804 to your local disk at _d:\VisualStudio\feed.xml_), run the following command:

    ```cmd
    VS2015.3.exe /overridefeeduri d:\VisualStudio\feed.xml
    ```
