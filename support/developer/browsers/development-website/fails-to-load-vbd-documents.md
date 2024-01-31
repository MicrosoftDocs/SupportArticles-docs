---
title: Internet Explorer 9 cannot load VBD documents
description: Provides the resolution to allow VBD documents to load in Internet Explorer 9.
ms.date: 03/23/2020
---
# Internet Explorer 9 fails to load VBD documents

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces the steps for you to make sure the VBD documents can be loaded successfully in Internet Explorer 9.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2556013

## Symptoms

When you try to load VBD documents using Internet Explorer 9, a prompt to download the .vbd file is shown instead of properly rendering the content as expected.

## Cause

This issue occurs because structured storage sniffing is disabled in urlmon.dll by default. This impacts VBD file types such that they are not rendered in the browser by default.

## Resolution

To solve this problem, the following conditions need to be in place:

- Have the URL action `URLACTION_ALLOW_STRUCTURED_STORAGE_SNIFFING` enabled in the relevant security zone (this is enabled by default in the Local Intranet and Trusted sites zones);
- Disable the sniffing restriction for the relevant process, by specifying the `FEATURE_RESTRICT_CDL_CLSIDSNIFF` feature key.

As an example, to allow VBD documents to load in Internet Explorer 9 for the Local Intranet zone, take the following steps:

Step1: Make sure the URL action is in place

:::image type="content" source="media/fails-to-load-vbd-documents/2703-zone-1.png" alt-text="Screenshot of 2703 item under Zones.":::

The URL action is also available in the `HKEY_LOCAL_MACHINE` part of the registry, which is read when the `HKEY_CURRENT_USER` value is not available or the **Security Zones: Use only machine settings** policy is enabled. Additionally, if VBD documents are being loaded from a different zone, for instances, the Local Machine zone, the URL action needs to be set to 0 for that specific zone.

Step 2: Set the feature key accordingly

:::image type="content" source="media/fails-to-load-vbd-documents/feature-restrict-cdl-clsidsniff.png" alt-text="Screenshot of feature_restrict-col_clsidsniff registry.":::

The above key is created in a 64-bit system and targets the Internet Explorer 9 32-bit version. The following variations need to be considered:

- To define the feature in a 32-bit Windows, we have to create the feature key under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl`.

- To define the feature key in a 64-bit Windows:
  - To target 32-bit applications, we have to create the feature key under `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\MAIN\FeatureControl`.
  - To target 64-bit applications, we have to create the feature key under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl`.

 Finally, the respective DWORD created for this feature key is not tied to only iexplore.exe. If an application that implements the WebBrowser control loads VBD content, the DWORD has to be created to match the name of the application (name_of_app.exe=0).

 After following the above steps, VBD documents will load successfully in Internet Explorer 9.

## More information

More information about the relevant URL Action and Feature control key can be found here:

- [URL Action flags](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms537178(v=vs.85))
- [GetClassFileOrMime Function](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms775108(v=vs.85))
