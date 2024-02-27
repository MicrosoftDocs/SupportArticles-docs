---
title: Suppress AutoDiscover mismatch warning
description: Provides information about how to suppress the AutoDiscover mismatch warning in Outlook 2007 and later versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: aruiz, grtaylor
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
ms.date: 01/30/2024
---
# How to suppress the AutoDiscover mismatch warning in Outlook 2007 and later versions

_Original KB number:_ &nbsp; 2783881

## Summary

When Microsoft Outlook performs an AutoDiscover operation and tries to connect to a service endpoint where the expected name isn't present on the server's Secure Sockets Layer (SSL) certificate, you may receive a warning message that resembles the following message:

> The name on the security certificate is invalid or does not match the name of the site.  
> Do you want to proceed?

When this warning message occurs, you can click **Yes** to accept the warning. However, it may reappear the next time AutoDiscover runs.

You or administrators may want to suppress the warning message for a specific HTTP endpoint that is in your organization. This article contains information about how to do this.

## Cause

You receive the warning when all of the following conditions are true:

- DNS and the IIS service are installed on the same server, for example `DC1.contoso.com`.
- A Name Server (NS) record is created for the server.
- The IIS service is configured to use Secure Sockets Layer (SSL).

Outlook uses the domain name part of the user's SMTP address to query DNS. In this example, the domain name is `contoso.com`. Outlook resolves `contoso.com` to an NS record for the DNS server. On the DNS server, IIS is configured to use an SSL certificate. The SSL certificate subject is `DC1.contoso.com`. However, Outlook tries to connect to `https://contoso.com/autodiscover/autodiscover.xml`. The certificate name mismatch causes Outlook to present the warning described earlier.

## Workaround 1: Reissue certificate that includes domain name as Subject Alternative Name

Reissue a certificate that includes the domain name (`contoso.com`) as the Subject Alternative Name. This solution may be appropriate if you can't implement client-side registry keys, or have only a limited number of domains.

## Workaround 2: Don't install IIS service and DNS on the same server

Install the IIS and DNS roles on separate servers.

## Workaround 3: Don't install or bind SSL certificate on DNS server running IIS

If the IIS site doesn't require SSL, you can remove the certificate. Or, you can unbind TCP 443 (SSL port) from the Default Web Site.

## Workaround 4: Configure Outlook to allow connection to mismatched domain name

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To configure Outlook to ignore the name mismatch and connect to a specific HTTP endpoint, you can set or deploy a registry value. To do this, follow these steps:

1. Close Outlook.
1. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.

   - Windows 10 and Windows 8: Press Windows Key + R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
   - Windows 7: Click **Start**, type *regedit.exe* in the search box, and then press Enter.

1. Locate and then click to select the following registry subkey:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook\AutoDiscover\RedirectServers`

    > [!NOTE]
    > You can also use the following registry subkey:  
    > HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Outlook\AutoDiscover\RedirectServers

    Where *xx* is 12.0 for Outlook 2007, 14.0 for Outlook 2010, 15.0 for Outlook 2013, and 16.0 for Outlook 2016, Outlook for Microsoft 365 and Outlook 2019

1. Click the **Edit** menu, point to **New**, and then click **String Value**.

1. Type the name of the HTTPS server to which AutoDiscover can be connected without warning for the user, and then press ENTER. For example, to allow a connection to `https://contoso.com`, the first String Value (REG_SZ) name would be as follows:

    *contoso*.*com*

1. You don't have to add text to the **Value data** box. The Data column should remain empty for the string values that you create.

1. To add more HTTPS servers to which AutoDiscover can connect without displaying a warning, repeat steps 4 and 5 for each server.

1. On the **File** menu, click **Exit** to exit Registry Editor.

## References

[Overview of the Autodiscover Service](/previous-versions/office/exchange-server-2007/bb124251(v=exchg.80))
