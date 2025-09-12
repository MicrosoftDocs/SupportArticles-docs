---
title: Issues when you click a hyperlink to SSO Web site
description: Explains you may be unexpectedly redirected or your session cookies may be lost for Web sites that use SSO authentication. This behavior occurs when you try to open Office files from Internet Explorer or by clicking hyperlinks in Office documents.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Security\Auth
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: klaw
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# You're redirected to a logon page or an error page, or you're prompted for authentication information when you click a hyperlink to an SSO Web site in an Office document

## Symptoms

When you click a hyperlink in a Microsoft Office document, you may experience the following behavior before you can open the page that you requested:

- You're redirected to a logon page or an error page
- You're prompted for authentication information.

Typically, this behavior occurs when the following conditions are true:

- You open the Office document in edit mode outside the Web browser.
- The Web site in the hyperlink uses a single sign-on (SSO) authentication system that relies on HTTP session cookies for client identification. Even if you have already provided user credentials, you are prompted to provide the user credentials again.

## Cause

Office lets you edit and author documents on a Web site if the server supports Web authoring and collaboration. First, Office tries to communicate with the Web server. Then Office tries to directly bind to the resource by using the Microsoft Hyperlink Library (Hlink.dll) and the URLMON API.

When Office sends the Web page request, you may be redirected to the Web site logon page for the SSO system. This behavior occurs because the Office session is independent of the Web browser session in which you may have already provided user credentials.

Because the sessions are independent, session cookies aren't shared. If the SSO system exclusively relies on session cookie information, the SSO system may not appear to work because the same user moves from more than one session. This behavior is a fundamental design limitation of an SSO system when the SSO system isn't designed to support SSO authentication across more than one browser or Web-aware application on the client desktop. Because Office is a fully Web-aware application, the issue may appear unique to Office applications if they're the only Web-aware clients that are installed by the client. However, the root cause of this issue isn't limited to Microsoft Office, and this problem may occur when you use third-party software.

## Workaround

The problem is a limitation of the SSO system that is used by the Web server. However, you may be able to reduce the current effects for your SSO-protected Web site by using one of the following methods.

### Hyperlinks from Internet Explorer to Office

If this issue occurs when hyperlinks on a Web page open an Office file and the Web page is hosted in Internet Explorer, you can avoid this issue by explicitly marking the content as a read-only download instead of as an inline navigation.

To do this, add a custom HTTP header to the GET response for the Office file contents. Add the "Content-Disposition: Attachment" header. When a GET response contains this header, Internet Explorer prompts the user to open or save the download. If the user chooses to open the download, the file opens from the Internet Explorer Temporary File cache read-only. The user may choose to modify and save the file locally. However, the user won't be able to save the file to the server or collaborate with Web services for the Web site. Therefore, this solution only works if you intend to make the file read-only.

You can set the "Content-Disposition" header by using code in Microsoft Active Server Pages (ASP), in Microsoft ASP.NET, or in ISAPI when you work with dynamically generated content. If the content is static, you can configure the header for a given file or folder by using IIS Manager and the IIS metabase. For more information about the Content-Disposition HTTP header, see [How to raise a File Download dialog box for a known MIME type](/troubleshoot/browsers/raise-file-download-for-mime-types).

### Hyperlinks from Office to Internet Explorer or to another Web browser

If this issue occurs when you click hyperlinks in Office documents that either directly open HTML Web content or are redirected to HTML content, client users can avoid the problem by enabling a registry key to send the hyperlink navigation to the browser instead of directly binding to the hyperlink from Office. For more information, see [Error message when clicking hyperlink in Office: "Cannot locate the Internet server or proxy server"](cannot-locate-server-when-click-hyperlink.md).

> [!NOTE]
> Regardless of the version of Office that you have installed, add the registry key in the exact location that's specified in [Error message when clicking hyperlink in Office: "Cannot locate the Internet server or proxy server"](cannot-locate-server-when-click-hyperlink.md).

When you use this registry setting, the HLINK component that is used by Office opens the hyperlink in the default Web browser. This registry setting affects all HLINK clients, not just Office. Therefore, use this registry key carefully.

## More Information

To fully resolve this issue, we encourage SSO providers to develop a system that could allow for Web authoring and a client that uses multiple sessions. This configuration adds complexity to the SSO system. However, this configuration also offers clients the most usability options. Microsoft is currently working with key SSO providers for a long-term solution.

Additionally, Microsoft is investigating how end users use Office to better predict and manage the following scenarios:

- The user intends to open a hyperlink in read-only mode. In this scenario, the hyperlink is opened in browse mode.
- The user wants to modify the content. In this scenario, a new session is required for authoring and collaboration.

These configuration changes may reduce the effect of the issue that is described in the "Symptoms" section. These changes may also add flexibility for the user when the user visits an SSO site that does not support configurations that include multiple-session clients.

If you are an SSO designer or developer, you can add support for multiple-session clients. For example, you may use the following methods:

- Use persistent cookie information and session cookie information to identify when a single client has crossed sessions between applications on the desktop. Then, provide Web responses either to transfer the client back into single session or to authenticate the new session.
- Use a client-side component to create an integrated authentication system. Use this integrated authentication system to authenticate all processes that are started under the same user authentication token.
- Use certificates or another security-enhanced but persistent identification method to authenticate the client.
- For an HTTP request that may be a multiple-session client request, issue a client-side redirect response instead of a server-side redirect response. For example, send an HTTP script or a META REFRESH tag instead of an HTTP 302 response. This change forces the client back into the default Web browser of the user. Therefore, the default browser session can handle the call and can keep the call in a single, read-only session.

   This method does not allow for authoring. However, this method makes it clear that the SSO system does not handle multiple-session clients and wants the client to stay in the default browser session only.

The exact approach to this configuration change depends on your design goals and the level of integration that you want to have with the client desktop.
