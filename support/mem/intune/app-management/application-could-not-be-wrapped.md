---
title: Android application could not be wrapped - Intune error
description: Troubleshooting the error message when you try to wrap an LOB app by using the Microsoft Intune App Wrapping Tool for Android.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Intune App SDK
ms.reviewer: kaushika
---
# LOB application could not be wrapped error

This article solves the error message that occurs when you try to wrap a line of business (LOB) app by using the Microsoft Intune App Wrapping Tool for Android.

## Symptoms

When you wrap a LOB app by using the Microsoft Intune App Wrapping Tool for Android, the tool crashes, and you receive an error message that resembles as follows:

> DBG [APKTool] Finish encoding directory into APK file:\<path of .apk>  
> WRN Verbose logs can be found at: \<path of .apk logfile>.  
> ERR The application could not be wrapped.  
> org.jf.util.ExceptionWithContext: Exception occurred while writing code_item for method \<method name>  
> org.jf.dexlib2.writer.DexWriter.writeDebugAndCodeItems(DexWriter.java:825)  
> org.jf.dexlib2.writer.DexWriter.writeTo(DexWriter.java:268)  
> org.jf.dexlib2.writer.DexWriter.writeTo(DexWriter.java:246)  
> brut.androlib.src.SmaliBuilder.build(SmaliBuilder.java:61)  
> brut.androlib.src.SmaliBuilder.build(SmaliBuilder.java:36)  
> brut.androlib.Androlib.buildSourcesSmali(Androlib.java:417)  
> brut.androlib.Androlib.buildSources(Androlib.java:348)  
> brut.androlib.Androlib.build(Androlib.java:300)  
> com.microsoft.intune.mam.apppackager.utils.APKToolWrapper.encodeAPK(APKToolWrapper.java:172)  
> com.microsoft.intune.mam.apppackager.AppPackager.packageApp(AppPackager.java:111)  
> com.microsoft.intune.mam.apppackager.PackagerMain.mainInternal(PackagerMain.java:213)  
> com.microsoft.intune.mam.apppackager.PackagerMain.main(PackagerMain.java:57)  
> org.jf.util.ExceptionWithContext: Error while writing instruction at code offset 0x13  
> org.jf.dexlib2.writer.DexWriter.writeCodeItem(DexWriter.java:1098)  
> org.jf.dexlib2.writer.DexWriter.writeDebugAndCodeItems(DexWriter.java:821)  
> org.jf.dexlib2.writer.DexWriter.writeTo(DexWriter.java:268)  
> org.jf.dexlib2.writer.DexWriter.writeTo(DexWriter.java:246)  
> brut.androlib.src.SmaliBuilder.build(SmaliBuilder.java:61)  
> brut.androlib.src.SmaliBuilder.build(SmaliBuilder.java:36)  
> brut.androlib.Androlib.buildSourcesSmali(Androlib.java:417)  
> brut.androlib.Androlib.buildSources(Androlib.java:348)  
> brut.androlib.Androlib.build(Androlib.java:300)  
> com.microsoft.intune.mam.apppackager.utils.APKToolWrapper.encodeAPK(APKToolWrapper.java:172)  
> com.microsoft.intune.mam.apppackager.AppPackager.packageApp(AppPackager.java:111)  
> com.microsoft.intune.mam.apppackager.PackagerMain.mainInternal(PackagerMain.java:213)  
> com.microsoft.intune.mam.apppackager.PackagerMain.main(PackagerMain.java:57)  
> org.jf.util.ExceptionWithContext: Unsigned short value out of range: <65536 or a value that's greater than 65536>  
> org.jf.dexlib2.writer.DexDataWriter.writeUshort(DexDataWriter.java:116)  
> org.jf.dexlib2.writer.InstructionWriter.write(InstructionWriter.java:348)  
> org.jf.dexlib2.writer.DexWriter.writeCodeItem(DexWriter.java:1058)

## Cause

The problem occurs if the LOB app reaches or nearly reaches the 64K method reference limit of DEX files. In this scenario, the Microsoft Intune Wrapping Tool can't add the necessary Intune code to the app without exceeding this limit.

## Solution

To fix this problem, complete the following steps.

1. Install the latest version of the [Microsoft Intune App Wrapping Tool for Android](https://github.com/msintuneappsdk/intune-app-wrapping-tool-android).
2. [Enable multidex](https://developer.android.com/studio/build/multidex) for your Android app.

Test whether the problem is fixed. If the problem persists, try the following methods in the given order:

- Examine the multidex configuration to see whether you specify any classes in the primary DEX file. You may experience problems if too many classes are added to the primary DEX file. For more information, see [https://developer.android.com/studio/build/multidex#keep](https://developer.android.com/studio/build/multidex#keep).

    To work around this problem, reduce the number of classes that are specified in the primary DEX file.

- Enable code shrinking by using ProGuard. For more information, see [https://developer.android.com/studio/build/shrink-code#shrink-code](https://developer.android.com/studio/build/shrink-code#shrink-code).

    > [!NOTE]
    > Some third-party libraries may require additional ProGuard configuration.

## More information

For more information about the 64K method reference limit of DEX files, see [Enable multidex for apps with over 64K methods](https://developer.android.com/studio/build/multidex).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
