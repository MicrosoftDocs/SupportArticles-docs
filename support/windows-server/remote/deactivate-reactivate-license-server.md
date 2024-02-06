---
title: Deactivate or reactivate a license server
description: How to deactivate or reactivate a license server by using Terminal Services Licensing
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# Deactivate or reactivate a license server by using Terminal Services Licensing

This article describes how to deactivate or reactivate Terminal Services Licensing on a server that is running Microsoft Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 814593

## Summary

You must activate a license server before it can issue licenses to Terminal Services client computers. Use Terminal Services Licensing to activate a license server. When you activate a license server, Microsoft provides the server with a digital certificate that validates server ownership and identity. If you use this certificate, a license server can make subsequent transactions with Microsoft to receive client licenses for the servers that have Terminal Services enabled.

## Open the Licensing Terminal Services window

Before you perform each of the procedures that are described in this article, you must open the Terminal Services Licensing window:

1. Click **Start**, point to **Settings**, and then click **Control Panel**.
2. Double-click **Administrative Tools**, and then double-click **Terminal Services Licensing**.

## Deactivate or reactivate a license server

You may have to deactivate a license server if the certificate of the server has either expired or become damaged, or if you redeploy the server. You are prompted to reactivate the license server when its registration has expired.

### Deactivate a license server

1. Open the Licensing Terminal Services window.
2. In the console tree, right-click the license server that you want to deactivate, point to **Advanced**, and then click **Deactivate Server**.
3. After the Licensing Wizard starts, confirm that your name, your phone number (optional), and your e-mail address that are listed under **Information Needed** are correct, and then click **Next**. Your request to deactivate the license server is sent to Microsoft where it is processed.

    > [!NOTE]
    > Your e-mail address is required if you are using the Internet method.
4. Click **Finish**.

### Reactivate a license server

1. Open the Licensing Terminal Services window.
2. In the console tree, right-click the license server that you want to reactivate, point to **Advanced**, and then click **Reactivate Server**.
3. After the Licensing Wizard starts, confirm that your name, your phone number (optional), and your e-mail address that are listed under **Information Needed** are correct, and then click **Next**.

    > [!NOTE]
    > Your e-mail address is required if you are using the Internet method.
4. Click the reason for reactivating the server in the **Reason** box, and then click **Finish**. Your request to reactivate the license server is sent to Microsoft where it is processed.

## Troubleshoot

- You cannot deactivate or reactivate a license server by using either the fax or World Wide Web connection methods.
- When you use the telephone to reactivate a license server, you receive confirmation that the license server has been reactivated from over the telephone.
- When you use the telephone to deactivate a license server, you receive a confirmation code from the Customer Support representative. Type this code in the Licensing Wizard.
- If you reactivate a license server, a record of your license is retained. Licenses that were already issued remain valid. If you have any unissued licenses, these licensed are also valid, but they must be reissued by Microsoft.
- When you deactivate a license server, you cannot license additional client computers from this server until the license server is reactivated.
