---
title: Use Settings app Group Policy
description: This article describes how to use Group Policies to manage access to the Settings app pages in Windows 10.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# Use the Settings app Group Policy in Windows 10

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4019502

## Overview

Windows 10, version 1703, and later versions introduce Group Policies to manage access to the Settings app pages. It enables IT Administrators to hide pages from users that they don't want them to access while still enabling access to pages that they want or need users to access. Before Windows 10, version 1703, Administrators could only fully lock down the Settings app or enable full access.

## Settings app

Each Settings app page has a URI that can be used to identify the page programmatically. It's how the Settings app Group Policy knows which page to enable or block access to. An administrator will use the URI of the page to tell the Group Policy what page or pages they want to control. For a full list of ms-settings URIs, see [MS-Settings URI Scheme Reference](/windows/uwp/launch-resume/launch-settings-app#ms-settings-uri-scheme-reference).

## Settings app Group Policy

The Settings app Group Policy has two modes. An administrator can either specify a list of Settings app pages to show or a list of Settings app pages to hide. You do so by enabling the Group Policy, and specifying a multi-string value that begins either with **ShowOnly:** or **Hide:** followed by a semicolon-delimited list of the Settings app pages.

## Use Setting app Group Policy

1. Open the Local Group Policy Editor and then go to **Computer Configuration** > **Administrative Templates** > **Control Panel**.
2. Double-click the **Settings Page Visibility** policy and then select **Enabled**.

    :::image type="content" source="media/use-settings-app-group-policy/enable-settings-page-visibility-policy.png" alt-text="Screenshot of the Enabled option in the Settings Page Visibility policy setting page." border="false":::
3. Depending on your need, specify either a **ShowOnly:** or **Hide:** string.

    If you want to show only Proxy and Ethernet, the string would be as follows:

    **`ShowOnly:Network-Proxy;Network-Ethernet`**

    :::image type="content" source="media/use-settings-app-group-policy/showonly-string-example.png" alt-text="Screenshot of the value input box in the Options area of the Settings Page Visibility policy setting window when you input the above string." border="false":::

    If you want to hide Proxy and Ethernet, but enable access to everything else, the string would be as follows:

    **`Hide:Network-Proxy;Network-Ethernet`**

    :::image type="content" source="media/use-settings-app-group-policy/hidden-proxy-and-ethernet.png" alt-text="Screenshot of the Ethernet page of the Network and Internet item in Settings app." border="false":::

## Determine the URI of a Settings app page

To determine the URI of a Settings app page, look up the URI on the [ms-settings: URI scheme reference](/windows/uwp/launch-resume/launch-settings-app#ms-settings-uri-scheme-reference) page.

For example, if you must control access to the Mobile hotspot settings, locate the Mobile hotspot entry on the webpage. The URI is **`ms-settings:network-mobilehotspot`**. Remove the **ms-settings:** part of the string. To restrict access to the Mobile hotspot settings page only, set your string as **`Hide:network-mobilehotspot`**.

If you must restrict more than one page, you must use a semicolon between each URI. For example, to restrict access to Mobile hotspot and Proxy, you would specify the following string:  
**`Hide:network-mobilehotspot;network-proxy`**
