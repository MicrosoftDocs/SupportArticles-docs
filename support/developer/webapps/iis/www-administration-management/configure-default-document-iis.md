---
title: Configure the default document in IIS
description: This article describes how to configure the default document in Internet Information Services.
ms.date: 01/29/2021
ms.custom: sap:WWW Administration and Management
ms.topic: how-to
ms.subservice: www-administration-management
---
# Configure the default document in Internet Information Services

This article introduces how to configure the default document in Internet Information Services.

We strongly recommend that all users upgrade to Microsoft Internet Information Services (IIS) version 7.0 running on Microsoft Windows Server 2008. IIS 7.0 significantly increases Web infrastructure security. For more information about IIS, see: [IIS](https://www.iis.net/).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 320051

## Summary

This step-by-step article describes how to configure the default document in IIS 5.0.

The default document is the file that is sent by the Web server when it receives a request for a Uniform Resource Locator (URL) that does not specify a file name (for example, `http://MyWebSite`). The default document can be the home page of a Web site, or an index page that displays a hypertext listing of the contents of the site or folder.

You can configure the default document settings for the Web site or folder. You can specify more than one default document for a Web site or folder. IIS searches for and serves default documents in the order in which they are listed. IIS returns the first document that it finds. If the first document in the list is unavailable, the server displays the next default document in the list. If no match is found and folder browsing is activated for that site or folder, IIS returns a folder listing. If folder browsing is not activated, IIS returns an **HTTP Error 403 - Forbidden** message to the browser.

Examples of default document names include Default.htm, Default.asp, Index.htm, and Index.html.

## How to Configure the Default Document

To configure default document settings in IIS:

1. Start Internet Services Manager, or start the Microsoft Management Console (MMC) that contains the IIS snap-in.
2. Right-click the Web site, virtual folder, or folder whose default document settings you want to configure, and then click **Properties**.
3. Click the **Documents** tab.
4. Click to select the **Enable Default Document** check box. This turns on default document handling for the Web site, virtual folder, or folder that you selected.
5. To add a new default document:
   1. Click **Add**.
   2. In the Default Document Name box, type the name of the default document that you want to add (for example, type *Index.htm*), and then click **OK**.

    > [!NOTE]
    > Make sure that the name of the new default document that you add matches the name of the actual default document file. Also, make sure that the file exists in the appropriate content folder on the Web site.

6. To change the search order priority, click the document that you want to move, and then click the Up or Down button to move the document to the position in the list that you want.
7. To remove a default document, click the document that you want to remove, and then click Remove.
8. Click **OK**, and then quit Internet Services Manager, or the IIS snap-in.

## Troubleshooting

For more information about how to troubleshoot issues with document settings in IIS, see: [Common HTTP status codes and the causes](http-status-code.md).

## References

For more information about IIS, see the IIS documentation. If IIS is installed on the computer, start Microsoft Internet Explorer, type the `http://localhost/iisHelp/` address in the Address box, and then press ENTER.
