---
title: Suppress AutoDiscover redirect warning in Outlook
description: Describes how to suppress the warning for a specific HTTP redirection.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Autodiscover
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, ssheshap
appliesto: 
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 03/27/2025
---
# Suppress AutoDiscover redirect warning in Outlook

_Original KB number:_ &nbsp; 2480582

When Microsoft Outlook redirects an AutoDiscover operation from HTTP to HTTPS, you might receive a warning that resembles the following message:

> Allow this website to configure user1@contoso.com server settings?  
`https://mail.cpandl.com/autodiscover/autodiscover.xml`  
Your account was redirected to this website for settings.  
You should only allow settings from sources you know and trust.

When this warning message occurs, you can choose not to be asked about the specific website again.

If a specific HTTP redirection is expected in your organization, you can suppress the warning message for that website.

## Configure Outlook to allow connection to a specific endpoint

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

To configure the Outlook behavior when HTTP redirection occurs, you can set or deploy a registry value. Use the following steps:

1. Close Outlook.
2. Start Registry Editor.
3. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\<xx.0>\Outlook\AutoDiscover\RedirectServers`

  **NOTE**: You can also use the following registry subkey:  
  `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\AutoDiscover\RedirectServers`  
  where \<xx.0\> is 16.0 for Outlook 2021, Outlook 2019, Outlook 2016, and Outlook for Microsoft 365.
4. Select the **Edit** menu, point to **New**, and then select **String Value**.
5. Type the name of the HTTPS server to which the AutoDiscover service can be redirected without prompting for a confirmation from the user, and then press Enter. For example, to allow redirection to `https://adatum.com`, use <i>adatum.com</i> as the name for the first String Value (REG_SZ).
6. Leave the **Value data** box empty. The Data column should remain empty for the string values that you create.
7. To add other HTTPS servers to which the AutoDiscover service can be redirected without displaying a warning, repeat steps 4 and 5 for each server.
8. On the **File** menu, select **Exit** to exit the Registry Editor.
