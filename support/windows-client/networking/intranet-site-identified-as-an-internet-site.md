---
title: Intranet site is identified as Internet site
description: Works around an issue where an Intranet site is identified as an Internet site.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:ip-address-management-ipam, csstroubleshoot
---
# Intranet site is identified as an Internet site when you use an FQDN or an IP address

This article provides a workaround for an issue where an Intranet site is identified as an Internet site when you use a fully qualified domain name (FQDN) or an IP address.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 303650

## Symptoms

When you access a local area network (LAN), an intranet share, or an intranet Web site by using an Internet Protocol (IP) address or a FQDN, the share or Web site may be identified as in the Internet zone instead of in the Local intranet zone. For example, this behavior may occur if you access shares or Web sites with Microsoft Internet Explorer or Windows Internet Explorer, with Microsoft Windows Explorer, with a command prompt, or with a Windows-based program when you use an address in any one of the following formats:

- `\\Computer.childdomain.domain.com\Share`  
- `http://computer.childdomain.domain.com`
- `\\157.54.100.101\share`
- `file://157.54.100.101/share`
- `http://157.54.100.101`

This behavior can occur regardless of whether any or all of the following settings are configured:

- In Microsoft Internet Explorer or in Windows Internet Explorer, you have added the FQDN (or *.domain.com) or the IP address (or the address range) to the **Do not use proxy server for addresses beginning with** box under the **Exceptions** section in the **Proxy Settings** dialog box.

    > [!NOTE]
    > To locate the **Proxy Settings** dialog box in Internet Explorer, click **Tools**, click **Internet Options**, click **Connections**, and then click **Proxy Settings**.
- You have selected the **Bypass proxy server for local addresses** check box that is on the **Local Area Network (LAN) Settings** dialog box.

    > [!NOTE]
    > To locate the **Local Area Network (LAN) Settings** dialog box in Internet Explorer, click **Tools**, click **Internet Options**, click **Connections**, and then click **Local Area Network (LAN) Settings**.
- You have selected the **Include all sites that bypass the proxy server** and **Include all network paths (UNCs)** check boxes on the **Local intranet** dialog box.

    To locate the **Local intranet** dialog box in Internet Explorer, click **Tools**, click **Internet Options**, click **Security**, and then click **Local intranet**.

This behavior can cause Internet Explorer to prompt you for credentials when you access the intranet Web sites that require authentication. Or you may be prompted or prevented from opening files on an intranet Web site or Universal Naming Convention (UNC) share in programs that use the Internet Explorer Security Manager to determine whether a file is located in a trusted security zone. For example, you may receive the following error message when you try to open an Access database (.mdb) file on a local intranet share (by using the FQDN or IP address) with Access 2002:

> Microsoft Access cannot open this file.  
> This file is located outside your intranet or on an untrusted site. Microsoft Access will not open the file due to potential security problems.  
> To open the file, copy it to your computer or an accessible network location.

> [!NOTE]
> Windows Server 2003 includes a new, optional component named Internet Explorer Enhanced Security Configuration. This component assigns all intranet Web sites and all UNC paths that are not explicitly listed in the Local intranet zone to the Internet zone. By default, the Internet zone uses the High security level. Therefore, you may experience these symptoms when you access intranet Web sites and UNC paths by using the NetBIOS name. For example, if you use `http://server` or \\\server\share, or when you use the IP address or FQDN, you may experience these symptoms.

For more information about Internet Explorer Enhanced Security Configuration, see [FAQ about Internet Explorer Enhanced Security Configuration (ESC)](https://support.microsoft.com/help/4551931).

## Cause

This behavior may occur if an FQDN or IP address contains periods. If an FQDN or IP address contains a period, Internet Explorer identifies the Web site or share as in the Internet zone.

## Workaround

To work around this issue, add the appropriate IP address range or fully qualified domain names (FQDNs) to your local intranet. Or change the security level of the Internet zone. On user authentication option, change from automatic logon only on Intranet zone to automatic logon with current user name and password.

If you are using Internet Explorer's Enhanced Security Configuration with Windows Server 2003, and you use the NetBIOS name to access intranet sites, use any of the following methods to work around this issue:

- Add the sites to the Local intranet zone. To add a site to the Local intranet zone, open the site in Internet Explorer, click **File**, point to **Add this site to**, click **Local intranet zone**, click **Add** in the **Local intranet** dialog box, and then click **Close**.

- Add the sites to the Trusted sites zone. To add a site to the Trusted sites zone, open the site in Internet Explorer, click **File**, point to **Add this site to**, click **Trusted sites zone**, click **Add** in the **Trusted sites** dialog box, and then click **Close**.

- Turn off Enhanced Security Configuration. You must be an administrator to turn off Enhanced Security Configuration. You can turn off Enhanced Security Configuration for users (such as Limited Users and Restricted Users) and leave it on for administrators. To turn off Enhanced Security Configuration for users, open **Control Panel**, click **Add or Remove Programs**, click **Add/Remove Windows Components**, click **Internet Explorer Enhanced Security Configuration**, click **Details**, click **Users**, click **OK**, click **Next**, click **Finish**, and then restart Internet Explorer to apply the new settings.

Administrators can use client settings or server settings to add the appropriate IP address range or FQDNs to the Local intranet. For example, administrators can use TCP/IP suffixes, add *.domain.com, or add the appropriate IP address range to the **Local intranet sites** zone in Internet Explorer on the client. On the server, administrators can use a proxy automatic configuration script. The following workaround adds *.domain.com or the appropriate IP address range to the Local intranet sites zone in Internet Explorer for all the client computers.

### Users

To work around this behavior, each user must add *.domain.com or the appropriate IP address range to the **Local Intranet Sites** dialog box:

1. In Internet Explorer, click **Tools**, and then click **Internet Options**.
2. On the **Security** tab, click **Local intranet**, and then click **Sites**.
3. Click **Advanced**, and then type **.domain.com*, or an IP address range (for example, 157.54.100-200.*) in the **Add this Web site to the zone** box, where `domain.com` is your company and top-level domain names.
4. Click **Add**, click **OK**, click **OK**, and then click **OK** again to close the **Internet Options** dialog box.
5. Restart the computer.

### Administrators

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Administrators can deploy this setting by making the following changes to the registry:

1. For each domain that should be included in the Local intranet zone, add a `domain.com` key to the appropriate registry key under either **HKEY_CURRENT_USER** (for a currently logged-on user only) or **HKEY_LOCAL_MACHINE** (for all users on the local computer):

   - `Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains` (For 32-bit versions of Internet Explorer or 64-bit versions of Internet Explorer on 64-bit versions of Windows XP or Windows Server 2003, if Enhanced Security Configuration is turned off.)

   - `Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains` (For 32-bit versions of Internet Explorer on 64-bit versions of Windows XP or 64-bit versions of Windows Server 2003, if Enhanced Security Configuration is turned off.)

   - `Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\ESCDomains` (For Internet Explorer on 32-bit versions of Windows Server 2003, or the 64-bit version of Internet Explorer on 64-bit versions of Windows Server 2003, if Enhanced Security Configuration is turned on.)

   - `Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\ESCDomains` (For the 32-bit version of Internet Explorer on 64-bit versions of Windows Server 2003, if Enhanced Security Configuration is turned on.)

    > [!NOTE]
    > By default, security zones settings are stored in the **HKEY_CURRENT_USER** registry key. Because this key is dynamically loaded for each user, the settings for one user do not affect the settings of another. Only the local machine settings will be used if the **Security Zones: Use only machine settings** setting is enabled in group policy or the Security_HKLM_only DWORD value is set to 1 in the following key:  
    > `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings`  
    > With this policy setting enabled, only machine settings will be used instead of user settings.

2. Add a DWORD value named the asterisk character (*) to the `domain.com` key and set it to 1.

3. For each IP address range that must be included in the Local intranet zone, add a Range**x** key (where x is 1, 2, 3, and so on) to the following registry key under **HKEY_CURRENT_USER** (for a currently logged-on user only) or **HKEY_LOCAL_MACHINE** (for all users on the local computer):

   - `Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges` (For 32-bit versions of Internet Explorer or 64-bit versions of Internet Explorer on 64-bit versions of Windows XP or Windows Server 2003.)

   - `Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges` (For 32-bit versions of Internet Explorer on 64-bit versions of Windows XP or 64-bit versions of Windows Server 2003.)

    > [!NOTE]
    > By default, security zones settings are stored in the **HKEY_CURRENT_USER** registry key. Because this key is dynamically loaded for each user, the settings for one user do not affect the settings of another. Only the local machine settings will be used if the **Security Zones: Use only machine settings** setting is enabled in group policy, or if the Security_HKLM_only DWORD value is set to 1 in the following key:  
    > `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings`  
    > With this policy setting is enabled, only machine settings will be used instead of user settings.

4. Add a DWORD value named the asterisk character (*) to the Range**x** key and set it to 1.

5. Add a String value named *:Range* (the colon character followed by the word Range) to the Range**x** key, and then set it to the IP address range (for example, 157.54.100-200.*).

> [!NOTE]
> Administrators can deploy settings in an Active Directory environment.

For more information about how to do so, see [How to set advanced settings in Internet Explorer by using Group Policy objects](/troubleshoot/browsers/advanced-settings).

> [!IMPORTANT]
> This workaround does not work for UNC or file:// addresses that use an IP address. For example, Internet Explorer identifies \\\157.54.100.101\share, or file://157.54.100.101/share, as being in the Internet zone, even if you add the appropriate IP address range to the Local Intranet Sites list. In this case, you must use a file:// URL that has the NetBIOS name (for example, **\\\server\share**) for the site to be identified in the Local intranet zone. Also, some applications may not be able to open files by using an http:// address even if the Web site is on your LAN and you use the NetBIOS name (for example, `http://server`). For example, Access 2002 cannot open files from http:// addresses. If you try to open an Access database file (.mdb) on an intranet Web site by using either the IP address, FQDN, or NetBIOS name, Access 2002 will incorrectly report that the file is outside your intranet or on an untrusted site by displaying the error message in the [Symptoms](#symptoms) section of this article.

## Status

This behavior is by design.
