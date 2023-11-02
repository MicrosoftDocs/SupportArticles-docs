---
title: Terminal Server license for deployment
description: Helps you understand and successfully deploy Terminal Services on computers that are running Microsoft Windows Server 2003.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
ms.technology: windows-server-rds
---
# Windows Server 2003 Terminal Server licensing issues and requirements for deployment

This article helps you understand and successfully deploy Terminal Services on computers that are running Microsoft Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 823313

## Summary

This article discusses the following topics:

- Licensing requirements for computers that access a Windows Server 2003-based terminal server (a server that has Terminal Server enabled)
- Transitional client access licenses (CALs) for Microsoft Windows XP Professional-based client computers
- How to deploy Windows Server 2003 Terminal Services
- Management Limitations for TS User CALs
- Information about how to determine whether to contact Microsoft Product Support Services (PSS) or Microsoft Clearinghouse  

## More information

### Licensing requirements for computers that access a Windows Server 2003-based Terminal Server

The Windows Server 2003 licensing model requires a server license for each copy of the server software that is installed. Terminal Services functionality is included in this Windows Server 2003 license. In addition to a server license, a Windows Server 2003 CAL (Windows CAL) is required. If you want to conduct a Windows session, an incremental Terminal Server Client Access License (TS CAL) is required also. A Windows session is defined as a session where the server software hosts a graphical user interface (GUI) on a device. For Windows sessions, a TS CAL is required for each user or device. The following two types of TS CALs are available:  

- TS Device CAL: A TS Device CAL permits one device (that is used by any user) to conduct Windows sessions on any of your terminal servers.
- TS User CAL: A TS User CAL permits one user (who uses any device) to conduct Windows sessions on any of your terminals servers.  

You may decide to use a combination of TS Device CALs and TS User CALs at the same time. You can have a terminal server request TS User CALs (by selecting the **Per User** licensing option) or TS Device CALs (by selecting the **Per Device** licensing option [the default option]) but not both at the same time.

> [!NOTE]
> To use both User and Device TS CALs at the same time on the same Terminal Server, configure the server to use the **Per User** TS CAL licensing option. Failure to have the appropriate number of User CALs or Device CALs for each device or user who is connecting is a violation of the EULA.

With Microsoft Windows 2000 Terminal Services licensing, if a client device is running the most recent version of the Windows desktop operating system, it does not have to have a TS CAL to satisfy the licensing requirement. However, with Windows Server 2003, a TS CAL is required for each device that or user who is using Terminal Services functionality, regardless of the operating system that is running on that device.

### Transitional CALs for Windows XP Professional-based client computers

Because this change in client access licensing requirements affects you as you move to Windows Server 2003-based terminal servers, Microsoft offered a Windows Server 2003 TS CAL for each Windows XP Professional license that you owned before April 24, 2003. This offer and the related campaign were ended on June 30, 2007.

You can use one of the following methods to obtain transitional CAL licenses, depending on how you obtained the Windows XP Professional operating system licenses.

#### Method 1: For Windows XP Professional licenses that were obtained through the volume licensing program

Use the **Install Licenses** command on the **Action** menu in the Terminal Server Licensing utility. You must provide your volume licensing program information (Enrollment number, Agreement number, or License and Authorization numbers, depending on the program type) together with the requested number and type of terminal server CAL tokens. The information that you enter in the Terminal Server Licensing utility is validated by Microsoft Clearinghouse, and when your request for tokens is within the boundaries of the entitlement program, license tokens are installed in the Terminal Server License Server.

#### Method 2: For Windows XP Professional licenses that were obtained through retail or OEM channels

If you obtained your Windows XP Professional licenses through a retail or an OEM channel, these licenses will have a product key included. You can find the product key on the retail packaging or on the Certificate Of Authenticity (COA) sticker on the computer case. To obtain a transitional CAL license, follow these steps:  

1. Visit the Windows Server 2003 Terminal Server Transition Web site.
2. In the **License Type** list, click the type of license that you want to obtain, type your e-mail address in the **eMail Address** box, and then click **Next**.
3. Confirm your e-mail address, and then click **Next**.
4. Type your Windows XP Professional product key(s) in the **Product Key** **n** box(es), and then click **Next**.

    > [!NOTE]
    > You do not have to include the hyphen ( - ) characters when you enter the product key(s).  

5. On the **License Code Request Successfully Processed** page, click **Finish**.

    The Windows Server 2003 Terminal Server Client Access License tokens are sent to the e-mail address that you specified.
6. In the Terminal Server Licensing utility, enter the license token(s) that you received. You can enter license tokens by using the **Automatic connection (recommended)** option, the **Web Browser** connection option, or the **Telephone** connection option.

### How to deploy Windows Server 2003 Terminal Services

A Windows Server 2003-based terminal server communicates only with a Windows Server 2003-based Terminal Server License Server. You cannot install Windows Server 2003 TS CALs on a Windows 2000-based Terminal Server License Server. When you upgrade Windows 2000-based terminal servers to Windows Server 2003, you must install and activate Windows Server 2003 Terminal Server License Server or upgrade an existing Windows 2000 License Server to Windows Server 2003. Windows Server 2003 Terminal Server License Servers can communicate with both Windows 2000-based and Windows Server 2003-based terminal servers. When you deploy Windows Server 2003 Terminal Services in a Windows 2000 domain, you have the following licensing options:  

- Upgrade existing Windows 2000 domain controllers that host the Windows 2000 license server to Windows Server 2003 domain controllers.
- Install Windows Server 2003 Terminal Server License Server on a member server that is running Windows Server 2003.
- Demote the Windows 2000-based license server to a member server, upgrade this computer to Windows Server 2003, and then add additional domain controllers as required.  

Windows Server 2003-based terminal servers can automatically discover a Terminal Server License Server that is installed on a member server that is running Windows Server 2003 and that is configured as an Enterprise License Server in the Active Directory directory services site.

If the Windows Server 2003-based Terminal Server License Server is a domain license server, you must modify the registry on each of your Windows Server 2003-based terminal servers so that they can discover a compatible license server. You must configure the registry settings on Windows 2000-based and Windows Server 2003-based terminal servers that are running in application mode so that they can discover the license server that issues the Windows 2000 or Windows Server 2003 TS CALs.  

### Management limitations for user CALs

A Windows Server 2003-based Terminal Server Licensing Server that is running in TS User CAL licensing mode does not decrement the number of available Windows Server 2003 TS CALs when each user connects to the terminal server. This limitation does not remove the responsibility from administrators to make sure that a valid TS CAL is obtained for each connected user, per the End User License Agreement (EULA).  

### How to determine whether to contact Microsoft Clearinghouse or Microsoft PSS

Contact Microsoft Clearinghouse to activate a Terminal Server License Server or to install TS CALs. To contact Microsoft Clearinghouse by telephone, use the following number:  
    (888) 571-2048  
If you purchased TS CALs through the Select, Enterprise Agreement, Campus, School, or Open licensing method, you can use the **Automatic connection (recommended)** option or the **Web Browser** connection option to activate and install TS CAL tokens. To use the automatic connection method to install TS CALs, follow these steps:  

1. Start the Terminal Server Licensing utility.
2. On the **View** menu, click **Properties**.
3. Click the **Required Information** tab, and then type the required user information.
4. Click the **Installation Method** tab, click **Automatic connection (recommended)** in the **Installation method** list, and then click **OK**.
5. On the **Action** menu, click **Install Licenses**.
6. Follow the steps in the Terminal Server Client Licensing Wizard to install your TS CALs.  

If you have difficulty installing TS CALs by using the Internet, or if you purchased the TS CALs through a retail channel and have previously activated your license codes, contact Microsoft Clearinghouse. Do not contact Microsoft Clearinghouse if you have difficulty obtaining a TS CAL through the discovery process or for other issues that require troubleshooting of the operating system.

Contact Microsoft PSS if you experience issues that are related to either of the following:  

- You cannot connect to a terminal server when valid TS CALs are installed on the Terminal Server Licensing Server.
- You cannot obtain a license when valid TS CALs are installed on the Terminal Server Licensing Server.
- You receive an error message when you enter the required alphanumeric license ID or Keypack.  

Microsoft PSS cannot help you activate a Terminal Server Licensing Server or help you install CALs.

> [!NOTE]
> Microsoft PSS and Microsoft Clearinghouse cannot help you to locate your licensing purchase agreement or authorization number(s) to install license key packages. To obtain this information, contact the reseller where you obtained your Microsoft product.
