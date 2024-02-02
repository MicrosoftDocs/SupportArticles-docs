---
title: How to configure Internet printing
description: Describes how to configure Internet printing in Windows Server 2003, and how to manage and connect to printers by using a Web browser.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: v-lanac, jamirc, kaushika
ms.custom: sap:management-and-configuration:-installing-print-drivers, csstroubleshoot
ms.subservice: printing
---
# Configure Internet printing

This article describes how to configure Internet printing in Windows Server 2003, and how to manage and connect to printers by using a Web browser.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323428

## Summary

When you use Internet printing, you can print or manage documents from a Web browser. Internet printing is turned on automatically on a Windows Server 2003-based computer when you install Microsoft Internet Information Services (IIS) and then turn on Internet Printing through the IIS Security Lockdown Wizard. Printing is implemented by way of the Internet Print Protocol (IPP), which is encapsulated in the Hypertext Transfer Protocol (HTTP).

With Internet printing, you can manage any shared printer on the print server from your browser. If you're using a computer that is running Microsoft Internet Explorer 4.01 and later, you can print to a printer over an intranet or the Internet by typing the address of the print server in the **Address** box. For example, type http://**myprintserver**/printers/.

When you click **Connect** on the printers Web page, the server generates a .cab file that contains the appropriate printer driver files and downloads it to the client computer. The printer that is installed is displayed in the Printers folder on the client.

## How to configure Internet printing on a Windows Server 2003-based print server

The following sections describe how to configure Internet printing on a Windows Server 2003-based print server.

### Install IIS

Because Internet printing depends on IIS, you must install IIS on the print server. To install IIS, follow these steps:

1. Insert the Windows Server 2003 CD-ROM into the computer's CD-ROM or DVD-ROM drive. Press and hold down SHIFT as you insert the CD-ROM to prevent it from starting automatically.
2. Click **Start**, point to **Control Panel**, and then click **Add or Remove Programs**.
3. Click **Add/Remove Windows Components**.
4. In the **Components** list of the Windows Components Wizard, double-click **Web Application Server**, click to select the **Internet Information Services (IIS)** check box, and then click **Next**.
5. Click **Finish**, and then click **Close**.  

    > [!NOTE]
    > By default, Internet Printing is installed when you install IIS. If you want to confirm it, double-click **Internet Information Services (IIS)** in the **Web Application Server** dialog box while you install IIS, and then confirm that the **Internet Printing** check box is selected.

### Turn on Internet printing

As described earlier in this article, Internet Printing should be selected and installed by default when you install IIS. However, you must still turn it on by using the IIS Manager or IIS snap-in. To do so, follow these steps:

1. Start IIS Manager or the IIS snap-in.
2. Expand **server_name**.
3. Click **Web Service Extensions**.
4. On the right pane, click **Internet Printing**, and then click **Allow**.
5. Quit IIS Manager.  

    > [!NOTE]
    > An administrator can turn off Internet Printing for specific users and groups by using the **Web-based Printing** Group Policy setting. This setting is located at Computer Configuration **Administrative Templates** Printers. Set this to Disabled .

### Configure security for Internet printing

To configure print server security, either use IIS Manager or the IIS snap-in. To configure the authentication method for Internet printing, follow these steps:

1. Start IIS Manager or start the IIS snap-in.
2. Expand **server_name**, where **server_name** is the name of the server.
3. Expand **Web Sites**, expand **Default Web Site**, right-click **Printers**, and then click **Properties**.
4. Click the **Directory Security** tab, and then click **Edit** under **Authentication and access control**.
5. Click any of the following authentication methods that you want to use, and then click **OK**:

    - **Enable anonymous access**: When you use anonymous access, IIS automatically logs you on by using the anonymous user account (by default, this account is IUSR_**computer_name**). You don't have to enter a user name and password. To change the user account that is used for anonymous access, click Browse under**Anonymous access**.
    - **Integrated Windows authentication**: Windows Integrated authentication (formerly called NTLM, or Windows NT Challenge/Response authentication) can use both the Kerberos version 5 authentication protocols and NTLM authentication protocol. This authentication method provides enhanced security. However, this method is supported only in Microsoft Internet Explorer 2.0 or later, and it doesn't work over HTTP proxy connections.
    - **Digest authentication for Windows domain servers**: When you use Digest authentication, user credentials are sent across the network while security is maintained. Digest authentication is available only for Internet Explorer 5.0 and later and for Web servers that belong to a Windows 2000 domain.
    - **Basic authentication (password is sent in clear text)**: When you use Basic authentication, you're prompted for your logon information, and your user name and password are sent across the network in clear text. This authentication method provides a low level of security because it's possible for someone who is equipped with network monitoring tools to intercept user names and passwords. However, this type of authentication is supported by most Web clients. Use this authentication method if you want the freedom to manage printers from any browser. If you turn on basic authentication, type the domain name that you want to use in the **Default domain** box.
    - **Microsoft .NET Passport authentication**: .NET Passport authentication provides single sign-in security that provides users with access to diverse services on the Internet. When you use this option, requests to IIS must contain valid .NET Passport credentials on either the query string or in the cookie. If IIS does not detect .NET Passport credentials, requests are redirected to the .NET Passport logon page.

    > [!NOTE]
    > When you select this option, all other authentication methods are unavailable (dimmed).
6. You can also control access to Internet printers based on the requesting host instead of on user credentials. To grant or deny access to specific computers, groups of computers, or domains, click **Edit** under **IP Address and Domain Name Restrictions**.
7. In the **IP Address and Domain Name Restrictions** dialog box that is displayed, complete one of the following procedures:

    - To grant access:

        1. Click **Denied Access**, and then click **Add**.
        2. In the **Grant Access On** dialog box, select the option that you want, and then click **OK**.

        The computer, group of computers, or domain that you selected is added to the **Granted** list.

        -or-

    - To deny access:

        1. Click **Granted Access**, and then click **Add**.
        2. In the **Deny Access On** dialog box that is displayed, specify the option that you want, and then click **OK**.

        The computer, group of computers, or domain that you specified is added to the **Denied** list.
    - Click **OK**.  

8. Click **OK**, and then quit IIS Manager or the IIS snap-in.

## How to manage printers by using a Web browser

To manage printers by using a Web browser, follow these steps:

1. In Internet Explorer or any other browser, complete any of the following procedures:

    - To view a list of printers that are located on the print server, type the following address, where **print_server** is the name of the print server: http://**print_server**/printers/  

        For example, to view a list of all the printers that are located on a print server that is named "MyPrintServer," type the following: `http://myprintserver/printers/`  

        A list of all the printers on the print server is displayed in your browser window. In the list of available printers, click the name of the printer that you want to manage.

        -or-
    - To view a specific printer's Web page, type the address of the printer by using the following format, where **print_server** is the name of the print server and **printer** is the name the printer: http://**print_server**/**printer**/

        For example, if you want to go directly the page of a printer that is named "Laser" and which is shared from a server that is named "MyPrintServer," type the following address: `http://myprintserver/laser/`  

2. On the **Printer** on the **Print_server** page, click the links that are displayed in the left pane to view more information about the printer or to perform a printer or a document action.

## How to connect to a printer by using a Web browser

To connect to a printer by using a Web browser, follow these steps:

1. Start Internet Explorer.
2. In the **Address** box, type the address of the printer:

    - If you don't know the name of the printer that you want to connect to, type the following address, where **print_server** is the name of the print server: http://**print_server**/printers/  

        For example, to view a list of all of the printers that are located on a print server that is named "MyPrintServer," type the following address: `http://myprintserver/printers/`  

        A list of all the printers on the print server appears. In the list of available printers, click the name of the printer that you want to connect to.

        -or-  
    - If you know the name of the printer that you want to connect to, type the address of the printer by using the following format, where **print_server** is the name of the print server and **printer** is the name of the printer: http://**print_server**/**printer**/  

        For example, if you want to go directly to the page of a printer that is named "Laser" and which is shared from a server that is named "MyPrintServer," type the following address: `http://MyPrintServer/Laser/`  

3. To connect to the printer, click **Connect** under **Printer Actions**. When you connect to the printer, the print server downloads the appropriate printer driver to your computer. After the installation is complete, the printer's icon is added to the Printers folder on your computer. You can use, monitor, and administer the printer as if it were attached to your computer.
