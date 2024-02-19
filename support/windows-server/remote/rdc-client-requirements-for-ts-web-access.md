---
title: Remote Desktop Connection (RDC) client requirements for TS Web Access
description: A guide for IT professionals. Describes the client requirements to use TS Web Access in Windows Server 2008 RC0. Also, provide an overview of TS Web Access.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:application-compatibility, csstroubleshoot
---
# RDC client requirements for Terminal Services Web Access

This article describes the Remote Desktop Connection (RDC) client requirements to use Terminal Services Web Access in Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 943887

## Introduction

Terminal Services (TSWeb) in Windows Server 2008 and Remote Desktop Services (RDWeb) in Windows 2008 R2 are role-based services. They let users start RemoteApp and Desktop Connection from a web browser. RemoteApp and Desktop Connection provides a customized view of RemoteApp programs and virtual desktops to users. When a user starts a RemoteApp program, a Terminal Services session is started on the Windows Server 2008-based terminal server that hosts the RemoteApp program.

To start a RemoteApp program, a user connects to a website that is hosted on the Windows Server 2008-based TS Web Access server. When the user connects to the website, a list of available RemoteApp programs appears. Additionally, TS Web Access lets users connect to the remote desktop of any server or client computer on which the user has the required permissions.

## Resolution

If you're using Windows Server 2008 R2, you must use RDC client version 7.

You must have the RDC client version 6.1 installed to use TS Web Access with the following operating systems:  

- Windows Server 2008
- Windows Vista with Service Pack 1 (SP1)
- Windows XP with Service Pack 3 (SP3)

    > [!NOTE]
    > RDC 6.1 (6.0.6001) supports Remote Desktop Protocol 6.1.
- If you're experiencing this issue on a Windows Vista-based computer, you must have Windows Vista Service Pack 1 installed on your computer.  
- If you're experiencing this issue on a Windows XP-based computer, you must have Windows XP Service Pack 3 or RDC 6.1 installed on your computer.

## Advanced Information

### Information for administrators

When users try to connect to TS Web Access from a computer that has an earlier version of the RDC client installed, they'll receive an error message that includes a URL. This URL points the user to a webpage where they can find more information.

Currently, the URL that is included in the error message points to this Knowledge Base article. However, you can change the URL that is included in the error message. To modify the URL, use one of the following methods.

#### Method 1: Use an `ASP.NET` application setting

To change the URL that is included in the error message, use an `ASP.NET` application setting. To do so, follow these steps:  

1. Select **Start** > **Run**, type `Inetmgr.exe`, and then select
 **OK**.
2. Expand the server name, expand **Sites** > **Default Web Site**, and then select **TS**.

    > [!NOTE]
    > By default, TS Web Access is installed in the default website.
3. Under **`ASP.NET`**, double-click **Application Settings**.
4. In the actions pane, select **Add**.
5. In the **Add Application Setting** dialog box, type rdcInstallURL in the **Name** box.
6. In the **Add Application Setting** dialog box, type the URL for the webpage that includes more information about how to use TS Web Access, and then select **OK**.

#### Method 2: Edit the Web.config file

To change the URL that's included in the error message, you can edit the Web.config file for the TS Web Access website. To do so, follow these steps:  

1. Open the Web.config file for the TS Web Access website in Notepad.

    > [!NOTE]
    > By default, the Web.config file for the TS Web Access website is located in the Web\ts folder.
2. Locate the \<appSettings> section in the Web.config file.
3. In the \<appSettings> section, add the following entry:

    > \<add key="rdcInstallUrl" value="`http://URL`" />

    > [!NOTE]
    > The **URL** placeholder is the URL for the webpage that includes more information about how to use TS Web Access.

4. On the **File** menu, select **Save**.
5. Exit Notepad.

### Information for non-administrators

If you aren't an administrator, contact the system administrator if you have problems when you use TS Web Access. For example, the system administrator can help you obtain and install an updated version of the RDC client.

## More information

### Related topics

Depending on your version of Windows Server, see one of the following articles:

- The [Remote Desktop Services](https://technet.microsoft.com/windowsserver/ee236407.aspx) home page (Windows Server 2008 R2) on the Windows Server TechCenter.
- The [Terminal Services](https://technet.microsoft.com/library/cc754746%28WS.10%29.aspx) home page (Windows Server 2008) on the Windows Server TechCenter.
- [Remote Desktop Services in Windows Server 2008 R2](https://technet.microsoft.com/library/dd647502.aspx) in the Windows Server 2008 Technical Library.
- [Terminal Services in Windows Server 2008](https://technet.microsoft.com/library/cc754746.aspx) in the Windows Server 2008 Technical Library.

## More Resources

Select the following links to find more options if this article can't resolve your problem:  

- [Microsoft Windows Answer](https://answers.microsoft.com/windows/default.aspx)  
- [Troubleshooting Specific Remote Desktop Problems](https://technet.microsoft.com/library/cc756819%28WS.10%29.aspx)  
