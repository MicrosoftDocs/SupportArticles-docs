---
title: Installing a .NET Framework patch fails
description: This article lists expected updates for .NET Framework. It also provides informatin about resolving the .NET Framework patch installation failure.
ms.date: 05/07/2020
ms.prod-support-area-path:
ms.reviewer: kelho
---
# .NET Framework 2.0 or 3.0 patch install fails with an error: This patch package could not be opened. Verify that the patch package exists and that you can access it

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 2549353

## Symptoms

The information for Microsoft .NET Framework updates in the **Add and Remove Programs** or **Programs and Features** for Windows Vista and later operation system might be missing or they might be named *Update*. See the [More information](#more-information) section for the full list of expected updates.

you might see the following log snippet of an error when installing a patch for the .NET Framework or when repairing the .Net Framework.

> MSI (s) (8C:14) [15:32:57:584]: Couldn't find local patch 'C:\WINDOWS\Installer\459e775f.msp'. Looking for it at its source.  
> MSI (s) (8C:14) [15:32:57:584]: Resolving Patch source.....  
> MSI (s) (8C:14) [15:32:57:584]: SOURCEMGMT: Attempting to use LastUsedSource from source list.  
> MSI (s) (8C:14) [15:32:57:584]: SOURCEMGMT: Trying source f:\51f62649eea433f0b7e0\wcu\dotnetframework\dotnetfx30\.  
> MSI (s) (8C:14) [15:32:57:584]: Note: 1: 2203 2: F:\51f62649eea4adf0b7e0\wcu\dotnetframework\dotnetfx30\WCF.msp 3: -2147287037  
> MSI (s) (8C:14) [15:32:57:584]: SOURCEMGMT: Source is invalid due to missing/inaccessible package.  
> MSI (s) (8C:14) [15:32:57:584]: Note: 1: 1706 2: -2147483647 3: WCF.msp  
> MSI (s) (8C:14) [15:32:57:584]: SOURCEMGMT: Processing net source list.  
> MSI (s) (8C:14) [15:32:57:584]: SOURCEMGMT: Trying source PatchSourceList.  
> MSI (s) (8C:14) [15:33:27:739]: Note: 1: 1314 2: PatchSourceList  
> MSI (s) (8C:14) [15:33:27:739]: ConnectToSource: CreatePath/  CreateFilePath failed with: -2147483648 1314 -2147483648  
> MSI (s) (8C:14) [15:33:27:739]: ConnectToSource (con't): CreatePath/CreateFilePath failed with: -2147483648 -2147483648  
> MSI (s) (8C:14) [15:33:27:739]: SOURCEMGMT: net source 'PatchSourceList' is invalid.  
> MSI (s) (8C:14) [15:33:27:739]: Note: 1: 1706 2: -2147483647 3: WCF.msp  
> MSI (s) (8C:14) [15:33:27:739]: SOURCEMGMT: Processing media source list.  
> MSI (s) (8C:14) [15:33:27:739]: SOURCEMGMT: Resolved source to: 'WCF.msp'....  
> MSI (s) (8C:5C) [15:33:57:863]: Note: 1: 2262 2: Error 3: -2147287038
>
> This patch package could not be opened. Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package.

## Cause

Registry information or files from the Installer Cache may be missing.

## Resolution

1. Run the fix in [How to fix MSI software update registration corruption issues](https://support.microsoft.com/help/971187) to correct damage patch registry keys.

2. Extract .NET Framework files.

    The .NET Framework 2.0 and 3.0 can be refreshed by repairing the framework. The .MSI and .MSP source files need to be extracted. The 32 or 64 bit command line will be used to match the bitness of the target operating system.

    The steps for extracting the files:

    To download the full package, rather than the bootstrapper, .NET Framework 3.5 Service Pack 1 is available at [here](https://download.microsoft.com/download/2/0/e/20e90413-712f-438c-988e-fdaa79a8ac3d/dotnetfx35.exe).

    .NET Framework 2.0, 3.0, both 32 and 64 bit are included in this download. We won't be using the 3.5 or the itanium (ia64) files.

    *dotnetfx35.exe /x*  

    To address each of the framework version and 32 verses 64 bit target computers, extract the files into four separate directories. Here is the list of files.

    - .NET Framework 3.0 32 bit

        - Netfx30a_x86.msi
        - WCF.msp
        - WCS.msp
        - WF.msp
        - WF_32.msp
        - WPF1.msp
        - WPF_Other.msp
        - XPS.msp
        - WPF2_32.msp
        - WPF_Other_32.msp

    - .NET Framework 3.0 64 bit

        - WCF.msp
        - WCF_64.msp
        - WCS.msp
        - WCS_64.msp
        - WF.msp
        - WF_32.msp
        - WF_64.msp
        - WPF1.msp
        - WPF1_64.msp
        - WPF2.msp
        - WPF2_32.msp
        - WPF2_64.msp
        - WPF_Other.msp
        - WPF_Other_32.msp
        - WPF_Other_64.msp
        - XPS.msp

    - .NET Framework 2.0 32 bit

        - Netfx20a_x86.msi
        - NetFX_CA.msp
        - crt.msp
        - NetFX_Core.msp
        - CLR.msp
        - ASPNET.msp
        - NetFX_Other.msp
        - prexp.msp
        - winforms.msp
        - dw.msp

    - .NET Framework 2.0 64 bit

        - ASPNET.msp
        - ASPNET_64.msp
        - clr.msp
        - clr_64.msp
        - crt.msp
        - crt_64.msp
        - dw.msp
        - dw_64.msp
        - NetFX_CA.msp
        - NetFX_Core.msp
        - NetFX_Core_64.msp
        - NetFX_Other.msp
        - NetFX_Other_64.msp
        - prexp.msp
        - winforms.msp
        - winforms_64.msp

3. Run windows installer command line.

    Run the following commands to repair the framework. You will need to replace `<FullPathToFiles>` with the path to the files. The double quotes ("") are required. This is a single command line and shouldn't contain any return characters. The order of the patches are significant. The properties are case sensitive.

    - .NET Framework 2.0 32 bit

        ```console
        msiexec /i <FullPathToFiles>\Netfx20a_x86.msi PATCH="<FullPathToFiles>\NetFX_CA.msp;<FullPathToFiles>\crt.msp;<FullPathToFiles>\NetFX_Core.msp;<FullPathToFiles>\CLR.msp;<FullPathToFiles>\ASPNET.msp;<FullPathToFiles>\NetFX_Other.msp;<FullPathToFiles>\prexp.msp;<FullPathToFiles>\winforms.msp;<FullPathToFiles>\dw.msp" REINSTALLMODE=vomus REINSTALL=ALL VSEXTUI=1 /l*v %temp%\patchs.2.0.txt
        ```

    - .NET Framework 2.0 64 bit

        ```console
        msiexec /i <FullPathToFiles>\Netfx20a_x64.msi PATCH="<FullPathToFiles>\ASPNET.msp;<FullPathToFiles>\ASPNET_64.msp;<FullPathToFiles>\clr.msp;<FullPathToFiles>\clr_64.msp;<FullPathToFiles>\crt.msp;<FullPathToFiles>\crt_64.msp;<FullPathToFiles>\dw.msp;<FullPathToFiles>\dw_64.msp;<FullPathToFiles>\NetFX_CA.msp;<FullPathToFiles>\NetFX_Core.msp;<FullPathToFiles>\NetFX_Core_64.msp;<FullPathToFiles>\NetFX_Other.msp;<FullPathToFiles>\NetFX_Other_64.msp;<FullPathToFiles>\prexp.msp;<FullPathToFiles>\winforms.msp;<FullPathToFiles>\winforms_64.msp" REINSTALLMODE=vomus REINSTALL=ALL VSEXTUI=1 /l*v %temp%\patchs.2.0.txt
        ```

    - .NET Framework 3.0 32 bit

        ```console
        msiexec /i <FullPathToFiles>\Netfx30a_x86.msi PATCH="<FullPathToFiles>\WCF.msp;<FullPathToFiles>\WCS.msp;<FullPathToFiles>\WF.msp;<FullPathToFiles>\WF_32.msp;<FullPathToFiles>\WPF1.msp;<FullPathToFiles>\WPF_Other.msp;<FullPathToFiles>\XPS.msp;<FullPathToFiles>\WPF2_32.msp;<FullPathToFiles>\WPF_Other_32.msp" REINSTALLMODE=vomus REINSTALL=ALL VSEXTUI=1 /l*v %temp%\patchs.3.0.TXT
        ```

    - .NET Framework 3.0 64 bit

        ```console
        msiexec /i <FullPathToFiles>\Netfx30a_x64.msi PATCH="<FullPathToFiles>\WCF.msp;<FullPathToFiles>\WCF_64.msp;<FullPathToFiles>\WCS.msp;<FullPathToFiles>\WCS_64.msp;<FullPathToFiles>\WF.msp;<FullPathToFiles>\WF_32.msp;<FullPathToFiles>\WF_64.msp;<FullPathToFiles>\WPF1.msp;<FullPathToFiles>\WPF1_64.msp;<FullPathToFiles>\WPF2.msp;<FullPathToFiles>\WPF2_32.msp;<FullPathToFiles>\WPF2_64.msp;<FullPathToFiles>\WPF_Other.msp;<FullPathToFiles>\WPF_Other_32.msp;<FullPathToFiles>\WPF_Other_64.msp;<FullPathToFiles>\XPS.msp" REINSTALLMODE=vomus REINSTALL=ALL VSEXTUI=1 /l*v %temp%\patchs.3.0.TXT
        ```

## More information

The following list are the expected framework updates.

- .NET Framework 2.0 Service Pack 2
  - .NET Framework CA
  - .NET Framework CRT
  - .NET Framework PreXP
  - .NET Framework CLR
  - .NET Framework 1
  - .NET Framework 2
  - .NET Framework A5P .NET
  - .NET Framework WinForms
  - Dr. Watson

- .NET Framework 3.0 Service Pack 2
  - XPS
  - WPF2
  - WF_32
  - WPF_Other
  - WCS
  - WPF_Other_32
  - WF
  - WPF_1
  - WCF
  - WPF2_32
