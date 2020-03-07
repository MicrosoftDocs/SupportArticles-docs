---
title: Cannot visit SSL sites with FIPS compliant cryptography
description: This article provides methods to solve the issue that occurs when you visit an SSL web site after you enable the Federal Information Processing Standard (FIPS) compliant cryptography.
ms.date: 03/05/2020
ms.prod-support-area-path: Internet Explorer
---
# Cannot visit SSL sites after you enable FIPS compliant cryptography

This article describes the error message that occurs when you visit a Secure Sockets Layer (SSL) web site using Internet Explorer. You can choose one of the methods that are provided in the Resolution section of this article to solve this issue.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 811834

## Symptoms

When you use Microsoft Internet Explorer to visit a Secure Sockets Layer (SSL) Web site, "Cannot find server" is displayed the title bar, and you receive the following error message in the content pane of Internet Explorer:  
>The page cannot be displayed.
>
>The page you are looking for is currently unavailable. The Web site might be experiencing technical difficulties, or you may need to adjust your browser settings.
>
>Please try the following:
>
> - Click the Refresh button, or try again later.
> - If you typed the page address in the Address bar, make sure that it is spelled correctly.
> - To check your connection settings, click the Tools menu, and then click Internet Options. On the Connections tab, click Settings. The settings should match those provided by your local area network (LAN) administrator or Internet service provider (ISP).
> - If your Network Administrator has enabled it, Microsoft Windows can examine your network and automatically discover network connection settings
> - If you would like Windows to try and discover them, click Detect Network Settings.
> - Some sites require 128-bit connection security. Click the Help menu and then click About Internet Explorer to determine what strength security you have installed.
> - If you are trying to reach a secure site, make sure your Security settings can support it. Click the Tools menu, and then click Internet Options. On the Advanced tab, scroll to the Security section and check settings for SSL 2.0, SSL 3.0, TLS 1.0, PCT 1.0.
> - Click the Back button to try another link. Finally, at the very bottom of the IE content pane you see the error Cannot find server or DNS Error.

When you use the Microsoft Windows Update Web site [Windows Update: FAQ](https://support.microsoft.com/help/12373/windows-update-faq) and click the **Scan for Updates** button, you may receive the following error message:  
>Windows Update Error

This is error number 0x800C0008. This error occurs because Windows Update fails to download the software update catalog through SSL.

## Cause

This error may occur if you have enabled the following local security setting (or the setting has been enabled as part of a domain Group Policy setting):  
**System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing.**

If this setting is enabled, the security channel provider of the operating system is forced to use only the following security algorithms: TLS_RSA_WITH_3DES_EDE_CBC_SHA. This behavior forces the security channel provider to negotiate only the stronger Transport Layer Security (TLS) 1.0 protocol when you use applications such as Microsoft Windows Messenger, Microsoft MSN Messenger, and Internet Explorer to visit SSL sites.

You receive the error that is described in the "Symptoms" section when one of the following scenarios is true:

- You visit a Web site that uses Microsoft Internet Information Services (IIS) 4.0 or later, and Internet Explorer is not configured to support TLS 1.0. By default, TLS 1.0 is not enabled in all versions of Internet Explorer.
- You visit a Web site that is running software other than Internet Information Services that does not support encryption, hashing, or signing algorithms that are Federal Information Processing Standard (FIPS) compliant. For example, the protocol SSL3 is used by many non-IIS Web servers for HTPPS. However, because SSL3 uses the MD5 algorithm (an algorithm that is not FIPS compliant), users whose local security policy forced the use of only FIPS compliant algorithms experience the documented error.

## Resolution

To solve this problem, use one of the following methods:

### Method 1

Enable TLS 1.0 protocol support in Internet Explorer first. If you visit a Web site that is running Internet Information Services 4.0 or higher, configuring Internet Explorer to support TLS 1.0 helps to secure your connection (if the remote Web server that you are trying to use supports this protocol). To configure Internet Explorer to support TLS 1.0, follow these steps:

1. On the **Tools** menu, click **Internet Options**.

2. On the **Advanced** tab, under **Security**, make sure that the following check boxes are selected:  
   - **Use SSL 2.0**
   - **Use SSL 3.0**
   - **Use TLS 1.0**
  
3. Click **Apply**, and then click **OK**. After you enable TLS 1.0, try to visit the Web site again. If you still cannot use SSL, the remote Web server probably does not support TLS 1.0.

### Method 2

If the Web server that you visit does not support TLS 1.0, you must disable the system policy that requires FIPS compliant algorithms. To do this, follow these steps:

1. In Control Panel, click **Administrative Tools**, and then double-click **Local Security Policy**.

2. In **Local Security Settings**, expand **Local Policies**, and then click **Security Options**.

3. Under **Policy** in the right pane, double-click **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing**, and then click **Disabled**.

The change takes effect after the local security policy is reapplied.
