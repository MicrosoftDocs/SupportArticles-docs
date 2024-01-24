---
title: Page can't be displayed when you connect through SSL
description: This article provides resolutions for the problem where page can't be displayed when you connect through SSL.
ms.date: 12/11/2020
ms.custom: sap:Site Behavior and Performance
ms.reviewer: MAJEDA
ms.technology: site-behavior-performance
---
# Page can't be displayed when you connect through SSL

This article helps you resolve the problem where page can't be displayed when you connect through SSL.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 260096

## Symptoms

When you connect to a computer running Internet Information Services (IIS) by using Secure Socket Layer (SSL), the following error message may occur:

> The page cannot be displayed.  
> The page you are looking for is currently unavailable. The Web site might be experiencing technical difficulties, or you may need to adjust your browser settings.

This Web site is usually the second Web site on the server. Connecting to the Web site through HTTP works correctly.

## Cause

This error message can occur if you have SSL set on the default Web site, and you remove the certificate, and then try to set it up on a second Web site.

If you run a `netstat -an` command, you can see that a service is listening on port 443, but you cannot connect to it. This is caused by a new implementation in IIS versions 5.0 and later called Socket Pooling.

## Resolution

> [!NOTE]
> For the purposes of this article, two Web sites are installed: the default Web site and the Administration Web site. By default, SSL is enabled on the default Web site.

1. Open the `Security` properties for the default Web site, and then select **Server Certificate**.
2. In the wizard, click **Assign an existing certificate**, and then select a certificate from the list.
3. When you have completed the wizard, click **Web site** tab, and then click **Advanced**.
4. Delete all the entries that are listed in the SSL window.
5. Click **Server Certificate** again, click Remove the current certificate, and click **OK**.
6. Right-click the computer name in the Microsoft Management Console (MMC), and then click **Restart IIS**.

You should now be able to connect to the server by using SSL.

## Workaround

Restarting the IIS services may resolve the error message. If it does not, follow the steps in the "Resolution" section of this article.

## More information

After SSL is enabled on an IIS Web server, the IIS service begins to listen on all used and unused IP addresses on ports 80 and 443. For multi-IP address servers, you may want to disable this feature. This feature was added the product for performance gain.

This problem usually occurs when you try to set up SSL on the administration Web site. IIS finds the SSL settings for the default Web site and listens on port 443. However, the default Web site does not have a certificate to correspond to that site. Therefore, no connection can be made, which is why you can see a server listening on port 443, but you cannot connect to the site.

## Steps to reproduce this behavior

1. On a computer that has the default Web site and the administration Web site, create a certificate, and then set it on the default Web site. Leave the SSL port on 443.
2. Click the **Security** tab on the default Web site properties, and then click Server Certificate.
3. Click Remove the current certificate, and then click **OK**.
4. Click Server Certificate on the **administration** Web site, choose to assign a certificate, and then select a certificate from the list.
5. Make sure that the port is 443.
6. Try to connect to the administration Web site through SSL (`https://localmachine`). You do not need the port number of the site because SSL is listening on port 443 now.
7. **The page cannot be displayed** error occurs in the browser.
