---
title: The problem of missing persistent cookies
description: Describes an issue that occurs when you use hyperlinks to open Office documents in Internet Explorer beginning with version 7. Resolution is provided.
ms.date: 06/09/2020
ms.reviewer: rtaylor, klaw
---
# Persistent cookies are not shared between Internet Explorer and Office applications

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving issues when office applications communicate with the Web server that persistent cookies are not shared between them.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 932118

## Symptoms

Beginning with Windows Vista, if you use hyperlinks to open Microsoft Office documents in Internet Explorer (beginning with version 7), you may experience the following symptoms.

### Missing persistent cookies

When Office applications communicate with the Web server, they do not send persistent cookies that are saved by Internet Explorer back to the Web server. This behavior may result in the following situations for a Web application that expects these cookies:

- Loss of session state
- Loss of transactional awareness

### Missing temporary files

Content that is downloaded by Internet Explorer appears to be missing in the temporary-files cache. This situation may cause the following symptoms:

- Files are downloaded two times before they are opened. (That is, double GET requests are made.)
- Changes that are made to the file in one session may not be available to the other session.

Therefore, the behavior of a Web application may be altered.

### Authentication prompts or logon-page redirections

In the following scenarios, certain Single Sign-On (SSO) solutions that rely on persistent cookies for cross-application awareness may not work as expected:

- An Office application tries to open the document from a Web-service-aware document library such as a SharePoint site.
- An Office application tries to save the document from a Web-service-aware document library such as a SharePoint site.
- An Office application tries to interact with the document from a Web-service-aware document library such as a SharePoint site.

Therefore, these SSO solutions may prompt the user for authentication information. Alternatively, these SSO solutions may redirect the user to a forms logon page.

## Cause

Beginning with Windows Vista, Internet Explorer (beginning with version 7) introduces a new security zone protection feature that is called Protected Mode. This additional layer of security sets up an isolated cache location for files that are saved by Web pages in the protected security zone and for persistent cookies that are saved by Web pages in that security zone. This alternative cache location is isolated from the regular cache that is used by local and trusted sites. Therefore, low-trust sites cannot write content into a folder location that is available to other applications that are running at a higher level of trust than Internet Explorer. This situation helps make Internet Explorer more secure in Windows Vista, Windows 7 and higher. However, this situation causes the following to be isolated to Internet Explorer and higher:

- Files that are set by Web sites under that mode
- Persistent cookies that are set by Web sites under that mode

By default, Protected Mode is enabled in Internet Explorer 7 and higher for the following zones:

- Internet
- Intranet
- Restricted

By default, Protected Mode is disabled in Internet Explorer 7 and higher for the Trusted Sites zone.

To access Protected Mode in Internet Explorer, click **Internet Options** on the **Tools** menu, and then click **Security**. Protected Mode is enabled or disabled on a per-zone basis.

External applications that use the Microsoft Windows Internet (WinINet) API continue to use the regular cache location. These applications use this cache location even if the Web content with which they are working is in a zone that has Protected Mode enabled. This behavior causes a compatibility issue for existing Web clients. However, this behavior prevents the effective sharing of cache information between Internet Explorer and Office.

## Resolution

To resolve this issue, add the Web site with which you are experiencing these symptoms to the list of trusted sites.

By default, Internet Explorer 7 and higher does not use the isolated cache location for the protected security zone. Therefore, when you make the site a trusted site, you enable the Web to save persistent cookies and temporary files to the regular cache. In this location, persistent cookies and temporary files are available to Office applications.

> [!NOTE]
> You can enable Protected Mode for the Trusted Sites zone by using the **Internet Options** dialog box. However, if you take this action, this issue may reappear. Therefore, if you want this resolution to work, you must leave Protected Mode disabled for the Trusted Sites zone.

## Status

This behavior is by design.

When Internet Explorer 7 and higher runs in Protected Mode, Internet Explorer runs under a reduced security token. This token restricts the ability of Internet Explorer to access resources on the computer. The isolated cache is the only writable location that Internet Explorer has when it runs in Protected Mode. Internet Explorer is intentionally isolated from applications that are running under a regular security token. This behavior prevents the accidental elevation of user rights if Internet Explorer becomes compromised. However, this increased isolation comes at the cost of a less seamless interaction with other applications such as Office.

## More information

This issue may also affect clients that are using Microsoft Office SharePoint 2007 together with SSO authentication. SharePoint SSO authentication relies on persistent cookies for cross-application authentication. Therefore, users may see more authentication requests than they expect. To resolve this issue, use the resolution that is mentioned in the "Resolution" section.

For more information about how to use SSO authentication together with Office SharePoint Server 2007, and about the susceptibility of SSO authentication to this issue when SSO authentication is used together, see [Plan authentication settings for Web applications in Office SharePoint Server](/previous-versions/office/sharepoint-2007-products-and-technologies/cc263304(v=office.12)).
