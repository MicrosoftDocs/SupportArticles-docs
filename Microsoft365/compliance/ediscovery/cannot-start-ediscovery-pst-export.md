---
title: You can't start the eDiscovery PST Export Tool from the Exchange admin center in Exchange Online.
description: Describes an issue in which you can't start the eDiscovery PST Export Tool in the Exchange admin center in Exchange Online. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 03/31/2022
---
# You can't start the eDiscovery PST Export Tool from the Exchange admin center in Exchange Online

_Original KB number:_&nbsp;2919825

## Problem

Consider the following scenario. In Microsoft Exchange Online, you create an eDiscovery mailbox search in the Exchange admin center. You're then ready to export the search results to a PST file. You click **Export to a PST file**, and then you're prompted to install the eDiscovery PST Export Tool. However, after you install and start the eDiscovery PST Export Tool, you experience one of the following symptoms:

- If you're using Windows Internet Explorer 9.0 or later, the application tries to connect but then crashes without displaying an error message.
- If you're using a third-party browser, you receive the following error message:
  > Cannot Download the application. The application is missing required files. Contact application vendor for assistance.

## Cause

This issue may occur if one or more of the following conditions are true:

- You're not using the latest version of Windows.
- You're using Internet Explorer 9.0 or later, and you don't have the Microsoft .NET Framework 4.5 or later installed.
- Local intranet zone settings aren't set up correctly in Internet Explorer.
- You're using a third-party browser, and you don't have the ClickOnce browser extension installed.
- You're using an outgoing proxy server, and the connection times out.

## Solution

To resolve this issue, do one or more of the following, as appropriate for your situation.

### Scenario 1: You're not using the latest version of Windows

[Upgrade to Windows 10](https://support.microsoft.com/windows/upgrade-to-windows-10-faq-cce52341-7943-594e-72ce-e1cf00382445).

### Scenario 2: You're using Internet Explorer 9.0 or later, and you don't have the .NET Framework 4.5 or later installed

[Install the .NET Framework 4.5 or a later version](https://www.microsoft.com/download/details.aspx?id=30653).

### Scenario 3: Local intranet zone settings aren't set up correctly in Internet Explorer

Make sure that `https://*.outlook.com` is added to the Local intranet zone in Internet Explorer. To do this, follow these steps:

1. In Internet Explorer, click **Internet Options** on the **Tool** menu.
2. On the **Security** tab, select **Local intranet**.
3. Click **Site**, and then click **Advanced**.
4. Add `https://*.outlook.com` (if it's not already listed).
5. Click **Close**.

Additionally, make sure that the following URLs are not listed as Trusted zone sites:

- `https://*.outlook.com`
- `https://r4.res.outlook.com`
- `https://*.res.outlook.com`

### Scenario 4: You're using a third-party (non-Microsoft) browser, and you don't have the ClickOnce browser extension installed

Install the ClickOnce extension. The extension can be found on the add-on webpage for that browser.

- For Mozilla Firefox: [Firefox browser add-ons](https://addons.mozilla.org/firefox/extensions/?sort=featured)
- For Google Chrome: [Chrome web store](https://chrome.google.com/webstore/category/apps)

### Scenario 5: You're using an outgoing proxy server, and the connection times out

Use the `netsh` command-line tool to open port 8080 on the proxy server. To do this, follow these steps:

1. Open a Command Prompt window, and then run the following command:

   ```powershell
   netsh winhttp show proxy
   ```

2. Run the following command:

   ```powershell
   netsh winhttp set proxy proxyservername:8080
   ```

   For example:

   ```powershell
   netsh winhttp set proxy proxy.contoso.com:8080
   ```

## More information

For more information about eDiscovery, see [eDiscovery solutions in Microsoft 365](/microsoft-365/compliance/ediscovery?view=o365-worldwide&preserve-view=true).

For more information about the latest browser requirements for Microsoft 365, see [System requirements for Office](https://products.office.com/office-system-requirements).

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
