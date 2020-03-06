---
title: IE Enhanced Security changes browsing experience
description: Describes the effects of Internet Explorer Enhanced Security Configuration in Windows Server 2003.
ms.date: 03/05/2020
ms.prod-support-area-path: Internet Explorer
ms.reviewer: Jay Schram
---
# Internet Explorer Enhanced Security Configuration changes the browsing experience

By default, Internet Explorer Enhanced Security Configuration is enabled on Windows Server 2003. When you start Microsoft Internet Explorer, you receive the following message:  
> Microsoft Internet Explorer's Enhanced Security Configuration is currently enabled on your server. This enhanced level of security reduces the risk of attack from Web-based content that is not secure, but it may also prevent Web sites from displaying correctly and restrict access to network resources.

Internet Explorer Enhanced Security Configuration established a configuration for your server and for Microsoft Internet Explorer that decreases the exposure of your server to potential attacks that can occur through Web content and application scripts. As a result, some Web sites may not display or perform as expected.

_Original KB number:_ &nbsp; 815141

## More Information

Internet Explorer Enhanced Security Configuration establishes security settings that define how users browse Internet and intranet Web sites. These settings also reduce the exposure of your server to Web sites that might present a security risk.

This enhanced level of security can prevent Web sites from displaying correctly in Internet Explorer and can restrict access to network resources, such as files on Universal Naming Convention (UNC) shared folders. If you want to view a Web site that requires Internet Explorer functionality that has been disabled, you can add the Web site to the inclusion lists in the **Local intranet** or
**Trusted sites** zones.

### Internet Explorer security zones

In Internet Explorer, you can configure security settings for several built-in security zones: the
**Internet** zone, the
**Local intranet** zone, the
**Trusted sites** zone, and the
**Restricted sites** zone. Internet Explorer Enhanced Security Configuration assigns security levels to these zones as follows:

- For the **Internet** zone, the security level is set to **High**.
- For the **Trusted sites** zone, the security level is set to **Medium**. This permits browsing of many Internet sites.
- For the **Local intranet** zone, the security level is set to **Medium-Low**. This allows your user credentials (name and password) to be passed automatically to sites and applications that need them.
- For the **Restricted sites** zone, the security level is set to **High**.
- By default, all Internet and intranet sites are assigned to the **Internet** zone. Intranet sites are not part of the
**Local intranet** zone unless you explicitly add them to this zone.

### How to browse when Internet Explorer Enhanced Security Configuration is enabled

The Internet Explorer Enhanced Security Configuration increases the level of security on your server. However, it may also affect Internet browsing in the following ways:

- Because ActiveX Controls and scripting are disabled, Internet sites may not display in Internet Explorer as you expect, and applications that use the Internet may not work correctly. If you trust an Internet site and need it to be fully functional, you can add that site to the **Trusted sites** zone in Internet Explorer.

  If you try to view an Internet site that uses scripting or ActiveX Controls, you receive the following message:  
  > Content from the Web site listed below is being blocked by the Internet Explorer Enhanced Security Configuration.
  >
  > If you trust this Web site, you can lower security settings for the site by adding it to the Trusted sites zone. If you know this Web site is on your local intranet, review help for instructions on adding the site to the local intranet zone instead.

Microsoft recommends that you only add a site to the **Trusted sites** zone if you are confident that the site is trustworthy and that the URL is the correct one.

> [!NOTE]
> Adding a Web site to the **Trusted sites** zone will lower the security settings for all content from the Web site for all applications, including Internet Explorer.

For more information about how to add a Web site to the **Trusted sites** zone, see the [Add Sites to the Trusted Sites Zone](#add-sites-to-the-trusted-sites-zone) section of this article.

- Access to intranet sites, Web-based applications that run over a local intranet, and other files on shared network resources may be restricted. If you trust an intranet site or shared folder and need it to be functional, you can add it to the **Local intranet** zone.

  For more information about how to do this, see the [Add Sites to the Local Intranet Zone](#add-sites-to-the-local-intranet-zone) section of this article.

### Effects of Internet Explorer Enhanced Security Configuration

Internet Explorer Enhanced Security Configuration adjusts the security levels for the existing security zones. The following table describes how each zone is affected:

|Zone|Security level|Result|
|---|---|---|
|Internet zone|High|The Internet zone has the same security settings as the **Restricted sites** zone. By default, all Internet and intranet sites are assigned to this zone.</br> Web pages may not be displayed in Internet Explorer as you expect, and applications that require the browser may not work correctly because scripts, ActiveX Controls, the Microsoft virtual machine (Microsoft VM) for HTML content, and file downloads have been disabled. If you trust an Internet site and need it to be functional, you can add that site to the **Trusted sites** zone in Internet Explorer.</br> For more information about how to do this, see the [Add Sites to the Trusted Sites Zone](#add-sites-to-the-trusted-sites-zone) section of this article.|
|Local intranet zone|Medium-Low|Access to scripts, executable files, and other files on Universal Naming Convention (UNC) shared folders is restricted unless the shared folder is added to the **Local intranet** zone explicitly.</br>For more information, see the [Add Sites to the Local Intranet Zone](#add-sites-to-the-local-intranet-zone) section of this article.</br>When you visit intranet sites, you may be repeatedly prompted for credentials (your user name and password) as a result of the enhanced security configuration. In the past, Internet Explorer automatically passed your credentials to intranet sites. The enhanced security configuration disables the automatic detection of intranet sites. If you want your credentials to be passed automatically to certain intranet sites, add those sites to the **Local intranet** zone.</br>For more information about how to do this, see the [Add Sites to the Local Intranet Zone](#add-sites-to-the-local-intranet-zone) section of this article.</br>Do not add Internet sites to the Local intranet zone, because your credentials will be passed automatically to the site if they are requested.|
|Trusted sites zone|Medium|This zone is for the Internet sites whose content you trust.</br>For more information, see the [Add Sites to the Trusted sites zone](#add-sites-to-the-trusted-sites-zone) section of this article.|
|Restricted sites zone|High|This zone contains sites you do not trust, such as sites that may damage your computer or data if you try to download or run files from them.|

Internet Explorer Enhanced Security Configuration also adjusts the Internet Explorer extensibility and security settings to reduce exposure to possible future security threats. These settings are on the **Advanced tab** of **Internet Options** in **Control Panel**. The following table describes the settings:

|Feature|Entry|New setting|Result|
|---|---|---|---|
|Browsing|Display enhanced security configuration dialog box.|On|Displays a dialog box to notify you when an Internet site tries to use scripting or ActiveX Controls.|
|Browsing|Enable Browser Extensions.|Off|Disables features you installed for use with Internet Explorer that were created by companies other than Microsoft.|
|Browsing|Enable Install on Demand (Internet Explorer).|Off|Disables installing Internet Explorer components on demand, if needed by a Web page.|
|Browsing|Enable Install on Demand (Other).|Off|Disables installing Web components on demand, if needed by a Web page.|
|Microsoft VM|Just-in-time (JIT) compiler for virtual machine enabled (requires restart).|Off|Disables the Microsoft VM compiler.|
|Multimedia|Do not display online content in the media bar.|On|Disables playback of media content in the Internet Explorer media bar.|
|Multimedia|Play sounds in Web pages.|Off|Disables music and other sounds.|
|Multimedia|Play animations in Web pages.|Off|Disables animations.|
|Multimedia|Play videos in Web pages.|Off|Disables video clips.|
|Security|Check for server certificate revocation (requires restart).|On|Automatically checks a Web site's certificate to see whether the certificate has been revoked before accepting the certificate as valid.|
|Security|Check for signatures on downloaded programs.|On|Automatically verifies and displays the identity of programs that you download.|
|Security|Do not save encrypted pages to disk.|On|Disables saving secured information in your Temporary Internet Files folder.|
|Security|Empty Temporary Internet Files folder when browser is closed.|On|Automatically clears the Temporary Internet Files folder when you close the browser.|

These changes reduce the functionality in Web pages, Web-based applications, local network resources, and applications that use a browser to display online help, support, and general user assistance.

For more information about using the **Local intranet** or **Trusted sites** zones' inclusion lists, see the [Managing Internet Explorer Enhanced Security Configuration](#managing-internet-explorer-enhanced-security-configuration) section of this article.

When Internet Explorer Enhanced Security Configuration is enabled, the following additional settings are configured:

- The Windows Update Web site is added to the **Trusted sites** zone. This allows you to continue to receive important updates for your operating system.
- The Windows error reporting site is added to the **Trusted sites** zone. This allows you to report problems encountered with your operating system and search for fixes.
- Several local computer sites (for example, http://localhost, https://localhost, and hcp://system) are added to the **Local intranet** zone. This allows applications and code to work locally so that you can complete common administrative tasks.
- The **Platform for Privacy Preferences (P3P)** level is set to **Medium** for the **Trusted sites** zone. If you want to change the P3P level for any zone other than the Internet Zone, click the **Privacy** tab of **Internet Options** in **Control Panel**, and then click **Import** to apply a custom privacy policy.

#### Internet Explorer Enhanced Security Configuration and Terminal Services

The enhanced security configuration applies to different user accounts according to the type of installation. The following table describes how the users are affected:

|Type of Installation|Enhanced security configuration is applied to||| |
|---|---|---|---|---|
||Administrators?|Power Users?|Limited Users?|Restricted Users?|
|Upgrading the operating system|Yes|Yes|No|No|
|Unattended installation of the operating system|Yes|Yes|No|No|
|Manual installation of Terminal Services|Yes|Yes|Yes**|Yes**|

**During the manual Terminal Services installation, you are prompted to disable
**Internet Explorer Enhanced Security Configuration** for users. This allows users to run a Terminal Services session without restrictions.

System administrators should carefully consider the risks of using of Internet-connected applications on a multi-user server before they disable Enhanced Security Configuration. Although disabling Enhanced Security Configuration will improve the web-browsing experience for users, it will also increase the risk of users becoming victims of web-hosted attacks that may then lead to a system-wide security compromise. For more information about applying the enhanced security configuration, see the [Apply Internet Explorer Enhanced Security Configuration to specific users](#apply-internet-explorer-enhanced-security-configuration-to-specific-users) section of this article.

#### Effects of Internet Explorer Enhanced Security Configuration on the Internet Explorer user experience

The following table describes how Internet Explorer Enhanced Security Configuration affects each user's experience with Internet Explorer:

|Task|Can be completed by| | | |
|---|---|---|---|---|
||Administrators?|Power Users?|Limited Users?|Restricted Users?|
|Turn on/off Internet Explorer Enhanced Security Configuration|Yes|No|No|No|
|Adjust the security level for a particular zone in Internet Explorer|Yes|Yes|No|No|
|Add sites to the Trusted sites zone|Yes|Yes|Yes|Yes|
|Add sites to the Local intranet zone|Yes|Yes|Yes|Yes|

All other Internet Explorer tasks can be completed by all user groups, unless the server administrator additionally restricts user access.

### Managing Internet Explorer Enhanced Security Configuration

Internet Explorer Enhanced Security Configuration is designed to reduce your server's exposure to security threats. To make sure that you receive the most benefit from the enhanced security configuration, consider these browser management recommendations:

- By default, all Internet and intranet sites are assigned to the **Internet** zone. If you trust an Internet or intranet site and need it to be functional, add the Internet site to the **Trusted sites** zone, or if it is an intranet site, add the intranet site to the **Local intranet** zone. For more information about the security levels for each zone, see the [Effects of Internet Explorer Enhanced Security Configuration](#effects-of-internet-explorer-enhanced-security-configuration) section of this article.
- If you want to run a browser-based client application over the Internet, it is best to add the Web page that hosts the application to the **Trusted sites** zone. For more information about how to do this, see the [Add Sites to the Trusted Sites Zone](#add-sites-to-the-trusted-sites-zone) section of this article.
- If you want to run a browser-based client application over a protected and secure local intranet, it is best to add the Web page that hosts the application to the **Local intranet** zone. For more information about how to do this, see the [Add Sites to the Local intranet Zone](#add-sites-to-the-local-intranet-zone) section of this article.
- Add internal sites and local servers to the **Local intranet** zone to make sure you have access to applications and can run these applications from your servers.
- Use Unattend.txt to add intranet sites and UNC servers to the **Local intranet** zone inclusion list as part of the installation process. For more information about how to do this, see the Readme file in Deploy.cab on the Windows product CD.
- Use client computers to download files such as drivers and service packs, and avoid browsing on servers.
- If you use disk imaging to install operating systems on your servers, add the intranet sites and UNC servers you trust to the **Local intranet** zone and add the Internet sites that you trust to the **Trusted sites** zone on the base image. You can then change the list for images relative to different server types and requirements.

#### Add sites to the Trusted Sites zone

When Internet Explorer Enhanced Security Configuration is enabled on your server, the security settings for all Internet sites are set to **High**. If you trust a Web page and need it to be functional, you can add that page to the
**Trusted sites** zone in Internet Explorer.

To do this, follow these steps:

1. Visit the site that you want to add.  
   - If you are already viewing the site that you want to add, go to step 2.
   - If you know the URL of the site that you want to add, start Internet Explorer, type the site URL in the **Address** bar, and then wait for the site to load.

2. On the **File** menu, click **Add this site to**, and then click **Trusted Sites Zone**.

3. In the **Trusted sites** dialog box, click **Add** to move the site to the list, and then click **Close**.

4. Refresh the page to view the site from its new zone.

5. Check the status bar of the browser to confirm that the site is in the **Trusted sites** zone.

> [!NOTE]
> - If an Internet site tries to use scripting or ActiveX Controls, a dialog box appears to notify you. You can add the Internet site to the **Trusted sites** zone directly from this dialog box. If you have disabled this dialog box, you can re-enable the dialog box in Internet Explorer: On the **Tools** menu, click **Internet Options**. On the **Advanced** tab, select **Display enhanced security configuration dialog**.
> - A Web page can be part of only one zone at a time. You cannot add a page to both the **Trusted sites** zone and the **Local intranet** zone.
> - When you add a Web page to the **Trusted sites** zone, you are adding the domain for that page. Therefore, all pages in that domain are also added. For example, if you add
http://www.microsoft.com/windowsxp/expertzone/ to your **Trusted sites** zone, you are adding http://www.microsoft.com. If you then want to view the Windows Help and Support site, you must add http://support.microsoft.com separately, because the Windows Help and Support site is a separate domain.
> - Internet Explorer maintains two different lists of sites for the **Trusted Sites** zone. One list is in effect when the enhanced security configuration is enabled, and a separate list is in effect when the enhanced security configuration is disabled. When you add a Web page to the **Trusted sites** zone, you are adding it only to the list that is currently in effect.
> - You can use wildcard characters to add all subdomains for a particular domain. For example, you can add *.microsoft.com to the list. This adds both www.microsoft.com and support.microsoft.com.
> - Many Internet sites use more than one domain to host their content. You may have to add several domains to the **Trusted sites** zone to have full functionality for one site.
> - During installation, you can add many sites at the same time to the **Trusted sites** zone by using certain settings in Unattend.txt. For more information about how to do this, see the Readme file in Deploy.cab on the Windows product CD. You can also use Group Policy to add and manage multiple sites. For more information about how to do this, see the Microsoft Windows Server 2003 Deployment Kit.

#### Add sites to the Local Intranet zone

When Internet Explorer Enhanced Security Configuration is enabled, the security settings for all intranet sites are set to **High**. Therefore, you are prompted for your credentials (your user name and password) each time you visit intranet sites that have not been added to the
**Local intranet** zone. If you regularly use intranet sites and you know those sites are trustworthy, you can add them to the **Local intranet zone** in Internet Explorer. To do this, follow these steps:

1. Visit the site that you want to add.
   - If you are already viewing the site that you want to add, go to step 2.
   - If you know the URL of the site that you want to add, start Internet Explorer, type the site URL in the **Address** bar, and then wait for the site to load.
2. On the **File** menu, click **Add this site to**, and then click **Local Intranet Zone**.
3. In the **Local intranet** dialog box, click **Add** to move the site to the list, and then click **Close**.
4. Refresh the page to view the site from its new zone.
5. Check the status bar of the browser to confirm that the site is in the **Local intranet** zone.

> [!Note]
> - Do not add Internet sites to the **Local intranet** zone, because your credentials are passed automatically to the site if they are requested.
> - A Web page can be part of only one zone at a time. You cannot add a page to both the **Trusted sites** zone and the **Local intranet** zone.
> - The enhanced security configuration also restricts access to scripts, executable files, and other potentially unsafe files on a UNC path unless the UNC path is added to the **Local Intranet** zone explicitly. For example, if you want to access \\\\**server**\share\setup.exe, you must add \\\\**server** to the **Local intranet** zone.
> - When you add a Web page to the **Local intranet** zone, you are adding the domain for that page. Therefore, all pages in that domain are also added. For example, if you add
http://**YourIntranetServer/SubWeb** to your **Local intranet** zone, you are adding http://**YourIntranetServer**.
> - Internet Explorer maintains two different lists of sites for the **Local intranet** zone. One list is in effect when the enhanced security configuration is enabled, and a separate list is in effect when the enhanced security configuration is disabled. When you add a Web page to the **Local intranet** zone, you are adding it only to the list that is currently in effect.
> - During installation, you can add many sites at the same time to the **Local intranet** zone by using certain settings in Unattend.txt. For more information about how to do this, see the Readme file in Deploy.cab on the Windows product CD. You can also use Group Policy to add and manage multiple sites. For more information, see the Microsoft Windows Server 2003 Deployment Kit.

#### Apply Internet Explorer Enhanced Security Configuration to specific users

Internet Explorer Enhanced Security Configuration allows you to control the level of Internet Explorer access allowed to certain user groups on your server.

To do this, follow these steps:

1. Open **Control Panel**, click **Add or Remove Programs**, and then click **Add/Remove Windows Components**.

2. Select **Internet Explorer Enhanced Security Configuration**, and then click **Details**.

3. Click to select the check box for the users or groups that you want to apply the enhanced security configuration to: **For administrator groups**, **For all other groups**, or both, and then click **OK**.

4. Click **Next**, and then click **Finish**.

5. Restart Internet Explorer to apply the enhanced security settings.

> [!NOTE]
> - When you apply Internet Explorer Enhanced Security Configuration to the Administrators group, the settings are applied to administrators and power users. When you apply Internet Explorer Enhanced Security Configuration to the Users group, the settings are applied to limited and restricted users.
> - For up-to-date information about Internet Explorer security zones, see: [About URL Security Zone Templates](https://msdn.microsoft.com/library/ms537186.aspx).

#### Apply Windows 2000 default Internet Explorer security settings

If Internet Explorer Enhanced Security Configuration is enabled on your server, you may decide to use the default Internet Explorer security settings used by Windows 2000.

To do this, follow these steps:

1. Open **Control Panel**, click **Add or Remove Programs**, and then click **Add/Remove Windows Components**.

2. Select **Internet Explorer Enhanced Security Configuration**, click to clear the selection, and then click **OK**.

3. Click **Next**, and then click **Finish**.

4. Restart Internet Explorer to apply the changes.

> [!IMPORTANT]
> - When you use the Windows 2000 security settings for Internet Explorer, you restore the lists of **Trusted sites** and **Local intranet** sites that were in effect at the time Internet Explorer Enhanced Security Configuration was applied.
> - Applying the Windows 2000 default Internet Explorer security settings increases your server's exposure to potential attacks from malicious Web-based content.

#### Strengthen Internet Explorer security settings manually on your server

If you do not use Internet Explorer Enhanced Security Configuration in your environment, you can easily strengthen Internet Explorer by using
**Internet Options** in **Control Panel** to manually raise the security settings on your server.

To do this, follow these steps:

1. Start Internet Explorer, and then on the
**Tools** menu, click **Internet Options**.

2. On the **Security** tab, select the Web content zone that you want to adjust: **Internet**, **Local intranet**, **Trusted sites**, or **Restricted sites**.

3. Under **Security level for this zone**, click **Default Level** to use the default security level for the zone, or click **Custom Level**, and then select the settings you want.

> [!Note]
> - For Restricted sites, click **Custom Level**, and then click a level in the **Reset to** list.
> - For up-to-date information about Internet Explorer security zones, see [About URL Security Zone Templates](https://msdn.microsoft.com/library/ms537186.aspx).

### Browser Security best practices

Using servers for Internet browsing is not sound security practice because Internet browsing increases the exposure of your server to potential security attacks. Regardless of the browser you use, it is a good idea to restrict browsing on your server. To reduce the risk to your server of potential attacks from malicious Web-based content:

- Do not use servers for browsing general Web content.
- Use client computers to download files such as drivers and service packs.
- Do not view sites that you cannot confirm are secure.
- Use a limited user account instead of an administrator account for general Web browsing.
- Use Group Policy to keep unauthorized users from making inappropriate changes to browser security settings.

## References

For more information, see
[Enhanced Security Configuration for Windows Internet Explorer](https://msdn.microsoft.com/library/ms537180.aspx).

## Applies To

- Microsoft Windows Server 2003 Web Edition
- Microsoft Windows Server 2003 Standard Edition (32-bit x86)
- Microsoft Windows Server 2003 Enterprise Edition (32-bit x86）
- Microsoft Windows Server 2003 Datacenter Edition (32-bit x86)
- Microsoft Windows Server 2003 Enterprise x64 Edition
