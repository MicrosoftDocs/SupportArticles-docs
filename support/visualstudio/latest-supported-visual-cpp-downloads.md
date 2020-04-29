---
title: Latest supported Visual C++ downloads
description: Lists the download links for the latest versions of Visual C++.
ms.date: 04/17/2020
ms.prod-support-area-path:
---
# The latest supported Visual C++ downloads

This article lists the download links for the latest versions of Microsoft Visual C++.

_Original product version:_ &nbsp; Visual Studio 2010, 2012, 2013, 2015, 2017, 2019  
_Original KB number:_ &nbsp; 2977003

> [!NOTE]
>
> - Some of the downloads that are mentioned in this article are currently available on [My.VisualStudio.com](https://my.visualstudio.com/). Make sure to log in by using a Visual Studio Subscription account so that you can access the download links.
> - If you are asked for credentials, use your existing Visual Studio subscription account or create a free account by selecting [Create a new Microsoft account](https://login.microsoftonline.com/common/oauth2/authorize?client_id=499b84ac-1321-427f-aa17-267ca6975798&site_id=501454&response_mode=form_post&response_type=code+id_token&redirect_uri=https%3A%2F%2Fapp.vssps.visualstudio.com%2F_signedin&nonce=95942429-1297-4a7b-ab5c-0d6fcce90df4&state=realm%3Dmy.visualstudio.com%26reply_to%3Dhttps%253A%252F%252Fmy.visualstudio.com%252FDownloads%253Fpid%253D2082%26ht%3D3%26nonce%3D95942429-1297-4a7b-ab5c-0d6fcce90df4&resource=https%3A%2F%2Fmanagement.core.windows.net%2F&cid=95942429-1297-4a7b-ab5c-0d6fcce90df4&wsucxt=1).

## Visual Studio 2015, 2017 and 2019

Download the [Microsoft Visual C++ Redistributable for Visual Studio 2015, 2017 and 2019](https://www.visualstudio.com/downloads/). The following updates are the latest supported Visual C++ redistributable packages for Visual Studio 2015, 2017 and 2019. Included is a baseline version of the Universal C Runtime, see [Universal CRT deployment](/cpp/windows/universal-crt-deployment?view=vs-2019) for details.

- x86: [vc_redist.x86.exe](https://aka.ms/vs/16/release/vc_redist.x86.exe)
- x64: [vc_redist.x64.exe](https://aka.ms/vs/16/release/vc_redist.x64.exe)
- ARM64: [vc_redist.arm64.exe](https://aka.ms/vs/16/release/VC_redist.arm64.exe)

Visual C++ 2015, 2017 and 2019 all share the same redistributable files. For example, installing the Visual C++ 2019 redistributable will affect programs built with Visual C++ 2015 and 2017 also. However, installing the Visual C++ 2015 redistributable won't replace the newer versions of the files installed by the Visual C++ 2017 and 2019 redistributable files. This is different from all previous Visual C++ versions, as they each had their own distinct runtime files, not shared with other versions.

## Visual Studio 2013 (VC++ 12.0)

- Download the [Microsoft Visual C++ Redistributable Packages for Visual Studio 2013](https://support.microsoft.com/help/4032938). This is the latest supported Visual C++ redistributable package for Visual Studio 2013.
- Download [Multibyte MFC Library for Visual Studio 2013](https://my.visualstudio.com/Downloads?pid=1430). This add-on for Visual Studio 2013 contains the multibyte character set (MBCS) version of the Microsoft Foundation Class (MFC) Library.
- Download [Visual C++ 2013 Runtime for Sideloaded Windows 8.1 apps](https://download.microsoft.com/download/5/f/0/5f0f8404-9329-44a9-8176-ed6f7f746f25/vclibs_redist_packages.zip).

For more information, see [C++ Runtime for Sideloaded Windows 8.1 apps](https://devblogs.microsoft.com/cppblog/c-runtime-for-sideloaded-windows-8-1-apps/) on [the VC++ Team Blog](https://devblogs.microsoft.com/cppblog/).

## Visual Studio 2012 (VC++ 11.0)

Download the [Microsoft Visual C++ Redistributable Packages for Visual Studio 2012 Update 4](https://my.visualstudio.com/Downloads?pid=1452). This is the latest supported Visual C++ redistributable package for Visual Studio 2012.

## Visual Studio 2010 (VC++ 10.0) SP1

- Download the [Visual Studio 2010 Service Pack 1 (Installer)](https://my.visualstudio.com/Downloads?pid=963). This is the latest supported Visual C++ service pack for Visual Studio 2010.

    > [!NOTE]
    > This web installer requires an internet connection. This installer downloads and installs Visual Studio 2010 Service Pack 1. It works for all editions of Visual Studio 2010 (Express, Professional, Premium, Ultimate, and Test Professional).

- Download the [Microsoft Visual C++ 2010 Service Pack 1 Redistributable Package MFC Security Update](https://www.microsoft.com/download/details.aspx?id=26999). This is the latest supported Visual C++ redistributable package update for Visual Studio 2010.

## Visual C++ redistributable packages

Visual C++ redistributable packages install runtime components of Visual C++ Libraries on a computer that doesn't have Visual C++ installed. The libraries are required to run applications that are developed by using the corresponding version of Visual C++.

### Microsoft Foundation Class Library Security Update

A security issue was identified. This issue causes a Microsoft Foundation Class Library application vulnerability in your Windows-based system that uses the Visual C++ Redist. The Microsoft Foundation Class Library Security Update packages in this article have the most current redistributable files for Visual Studio.
