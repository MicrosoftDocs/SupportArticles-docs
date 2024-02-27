---
title: How to suppress AutoDiscover redirect warning
description: An Outlook user receives a message that appears when an AutoDiscover operation redirects from HTTP to HTTPS. Users or administrators may want to suppress the warning for a specific HTTP redirection that is expected for their organization.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, ssheshap
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# How to suppress the AutoDiscover redirect warning in Outlook

_Original KB number:_ &nbsp; 2480582

## Summary

When Microsoft Outlook redirects an AutoDiscover operation from HTTP to HTTPS, you may receive a warning message that resembles the following:

> Allow this website to configure user1@contoso.com server settings?  
`https://mail.cpandl.com/autodiscover/autodiscover.xml`  
Your account was redirected to this website for settings.  
You should only allow settings from sources you know and trust.

When this warning message occurs, you may choose not to be asked about the specific website again.

You or administrators may want to suppress the initial warning message for a specific HTTP redirection that is expected in your organization. This article contains information about how to do this.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To configure Outlook behavior when HTTP redirection occurs, you can set or deploy a registry value. To do this, follow these steps:

1. Close Outlook.
2. Start Registry Editor.
3. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\<xx.0>\Outlook\AutoDiscover\RedirectServers`

    > [!NOTE]
    > You can also use the following registry subkey:  
    > `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<xx.0>\Outlook\AutoDiscover\RedirectServers`  
    > Where \<xx.0\> is 14.0 for Outlook 2010, 15.0 for Outlook 2013, and 16.0 for Outlook 2016, Outlook for Microsoft 365 and Outlook 2019.

4. Select the **Edit** menu, point to **New**, and then select **String Value**.

5. Type the name of the HTTPS server to which AutoDiscover can be redirected without prompting for confirmation from the user, and then press Enter. For example, to allow redirection to `https://adatum.com`, the first String Value (REG_SZ) name would be:

    *adatum.com*

    > [!NOTE]
    > In Outlook 2010 the name of the server is case-sensitive. In Outlook 2013 and Outlook 2016, it is not case-sensitive.

6. There is no need to add text to the **Value data** box. The Data column should remain empty for the string values that you create.
7. To add additional HTTPS servers to which AutoDiscover can be redirected without displaying a warning, repeat steps 4 and 5 for each server.
8. On the **File** menu, select **Exit** to exit Registry Editor.

## References

For more information about the Autodiscover service, see [Overview of the Autodiscover Service](/previous-versions/office/exchange-server-2007/bb124251(v=exchg.80)).
