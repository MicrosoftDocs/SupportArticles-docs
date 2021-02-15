---
title: LNK1102 error out of memory
description: This article provides workarounds for linker out of memory problems.
ms.date: 04/23/2020
ms.prod-support-area-path: Language or compilers
ms.reviewer: yongzhu, corob
---
# Linker fatal error: LNK1102: out of memory

This article helps you resolve an out of memory error that's thrown when you build large projects by using x86 (32-bit) tool sets.

_Original product version:_ &nbsp; Visual Studio Professional 2010  
_Original KB number:_ &nbsp; 2891057

## Symptoms

Assume that you build large projects by using x86 (32-bit) tool sets ([Whole Program Optimization](/cpp/build/reference/gl-whole-program-optimization) enabled). This implies link-time code generation (LTCG).

In this scenario, the linker may report out of memory (OOM) issues that result in build failure. For example, [Mozilla Firefox](https://developer.mozilla.org/docs/Mozilla/Developer_guide/Build_Instructions/Building_with_Profile-Guided_Optimization) might take advantage of WPO because the linker exhausted the 32-bit address space on x86.

## Cause

This issue occurs mostly because of the large amount of heap space that is required by the compiler during LTCG. Generally, the linker is disk input/output (I/O) bound and doesn't use as much memory as the compiler. However, the linker does invoke the compiler during LTCG.

The linker and the compiler each have their own heap management scheme. They don't have a mechanism to communicate with one another to help out when address space pressure is met. Additionally, because of heavy and frequently spike memory usage in the compiler, there might be severe fragmentation in address space that results in failure when a small amount of heap space is requested.

## Resolution

In Microsoft Visual Studio 2013, we introduced a mechanism to make sure when heap allocation isn't successful, the compiler will communicate it to the linker, and the linker will free up some heap space by releasing a mapped file. We also implemented a mechanism to make sure when memory pressure increases, the compiler will increase the page size in heap allocation to help with the fragmentation issue. However, we recommended you take advantage of the x64 (64-bit) cross compiler tool set if you're approaching 32-bit address space limits.

In Visual Studio 2013, we also introduced x64 cross tool. It includes 64-bit cross compilers/linkers to build for x86 and arm platforms. It's also to the x86 (32-bit) cross tool set that is available in Visual Studio 2012 and earlier versions. This article contains an overview on how users use the x64 (64-bit) cross tool set. If you can't move to Visual Studio 2013, you can use the following workarounds with Visual Studio 2012 and earlier versions:

- If your application is being targeted for the x64 platform, use the x64 tool set to build your application. You can find instructions on [How to: Enable a 64-Bit, x64 hosted MSVC toolset on the command line](/cpp/build/how-to-enable-a-64-bit-visual-cpp-toolset-on-the-command-line).
- If you're currently building your application on an x86 operating system, move to an x64 operating system. Which raises the available virtual address space from 2 gigabytes (GB) to 4 GB.
- If you're currently compiling on an x86 operating system and can't move to an x64 operating system, use the [/3GB startup switch](/previous-versions/tn-archive/bb124810(v=exchg.65)). This raises the available virtual address space to 3 GB.

## More information

You can find the two x64-based cross tool sets in your `%Install Path%\Microsoft Visual Studio 12.0\VC\bin directory`, as shown in the following figure.

:::image type="content" source="./media/linker-fatal-error-out-of-memory/bin.png" border="false" alt-text="cross tool sets in the bin":::

The *amd64_x86* and *amd64_arm* folders contain everything that you must have to build for x86 and arm targets by using x64 cross tool sets.

### For MSBuild users

If you currently use MSBuild as a part of your build process, you can take advantage of a new project-level property that is called `PreferredToolArchitecture`. This property enables users to select which tool set (x86 or x64) to use to build an application.

When you use the `/p:PreferredToolArchitecture=x64 argument` together with the `msbuild` command, the x64 native tool set (`VC\bin\amd64`) is used when you build applications that target the x64 platform, and the x64 cross tool set (`VC\bin\amd64_x86`) is used when you build applications that target the x86 platform.  

### For Visual Studio IDE users

The x64 cross tools aren't supported out of the box in the Visual Studio Integrated Development Environment (IDE). We'll address it in the future. However, the following workaround should enable you to take advantage of x64 cross tools in the Visual Studio IDE:

1. Start the Visual Studio 2013 developer command prompt. You can find the developer command prompt on the Windows start screen, as shown here.

    :::image type="content" source="./media/linker-fatal-error-out-of-memory/search-for-developer.png"  border="false" alt-text="how to search for developer on the Windows start screen":::

2. At the developer command prompt, set the `PreferredToolArchitecture` property to point to the tool set that you want to use to build your target applications.
3. Start Visual Studio (devenv) from the developer command prompt. You should now be ready to take advantage of the cross tools.

    :::image type="content" source="./media/linker-fatal-error-out-of-memory/develop-command-prompt.png"  border="false" alt-text="Develop command prompt for VS2013 preview":::

    One quick way to verify that the correct tool set is being used is to create and build an application that has the additional compiler flag `/Bt`. The `/Bt` compiler flag spits out verbose information about time that is spent in C1, C1XX, and C2 DLLs. Additionally, it provides details on which tool set is being used to build the target applications. The `/Bt` flag can be applied under the project property pages (**Configuration Properties** > **C++** > **Command Line**). In the following figure, notice the tool set that is being used (amd64_x86).  

    :::image type="content" source="./media/linker-fatal-error-out-of-memory/mfcapplicationthree-property-pages.png" alt-text="Displays output and all options in MFCApplication3 Property Pages" border="false":::
