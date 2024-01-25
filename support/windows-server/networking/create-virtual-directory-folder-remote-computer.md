---
title: How to create a virtual directory on an existing Web site to a folder that resides on a remote computer
description: Describes steps to create a virtual directory on an existing Web site to a folder that resides on a remote computer.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
ms.subservice: networking
---
# How to create a virtual directory on an existing Web site to a folder that resides on a remote computer  

This article describes how to create, test, and remove a virtual directory on an existing Web site to a folder that resides on a remote computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 308150

A remote virtual directory is a directory that's not contained within the Web site's home directory but appears to client browsers as though it's within the home directory. A remote virtual directory has an alias that is mapped to a Universal Naming Convention (UNC) share location. A client appends the alias to the URL of the Web site to browse the Web content in that virtual directory. The following table illustrates these mappings:

| Physical location| Alias| URL path |
|---|---|---|
|C:\WWWroot| _home directory_ <br/>(none)|`http://Sales`|
|\\\RemoteServer<br/>\SalesData\ProdCustomers|Customers|`http://Sales/Customers`|
  
Both virtual directories and physical directories (directories without an alias) are listed in Internet Services Manager. A virtual directory is indicated by a folder icon that has a globe in the corner.

## How to configure a remote network share

To create a virtual directory to a remote network share, create the share, and then store the Web content in that share. Set the appropriate sharing permissions, and then add the appropriate NTFS permissions to control access to the folder that contains your content.

> [!NOTE]
> You can also publish Web content to the remote share after the virtual directory is created.

## How to create a virtual directory

1. Log on to the Web server computer using an account that has administrative privileges.
2. Click **Start**, point to **Programs** > **Administrative Tools**, and then click **Internet Services Manager**.
3. In the **Internet Information Services** window, expand **server name** (where **server name** is the name of the server).
4. Right-click the Web site that you want (for example, **Default Web Site**), point to **New**, and then click **Virtual Directory**.
5. On the **Welcome to the Virtual Directory Creation Wizard** page, click **Next**.
6. On the **Virtual Directory Alias** page, type the alias that you want (for example, **Sales**), and then click **Next**.
7. On the **Web Site Content Directory** page, type the UNC path to the remote folder that you've created (for example, \\\\Server\\Share), and then click **Next**.
8. On the **User Name and Password** page, type the user name and password that has sufficient privileges to gain access to the remote folder.
    > [!NOTE]
    > To maintain the highest levels of security, use an account that has the minimum permissions that are necessary to provide access to the remote content.
9. Click **Next**, retype the password that you used in step eight in the **Confirm Password** dialog box, and then click **OK**.
10. On the **Access Permissions** page, click to select the check boxes of the permissions that you want to set for the virtual directory.

    By default, Read permissions and Run scripts permissions are already selected. For example, if you want to allow users to change the content in the virtual directory, click to select the **Write** check box.
11. Click **Next**, and then click **Finish**.

    > [!NOTE]
    > The virtual directory inherits the configuration and security settings of the Web site in which it is created.

## How to test the virtual directory

1. Start Internet Explorer.
2. In the **Address** box, type the URL to your Web server (for example, `http://WebServer`), and then click **Go**.

    Verify that you can view the default Web site.
3. Append the alias of the virtual directory to the address that you typed in step two (for example, `http://WebServer/Sales`), and then click **Go**.

    The virtual directory Web content is displayed in the browser window.

## How to remove a virtual directory

To delete a virtual directory, remove the alias that Internet Information Services (IIS) uses to reference the content stored in that directory.

> [!NOTE]
> When you delete a virtual directory, the network share and its content are not also deleted.

To delete a virtual directory, follow these steps:

1. Click **Start**, point to **Programs** > **Administrative Tools**, and then click **Internet Services Manager**.
2. In the **Internet Information Services** window, click to expand **server name** (where **server name** is the name of the server).
3. Expand the Web site that contains the virtual directory that you want to delete. For example, expand **Default Web Site**.
4. Right-click the virtual directory that you want (for example, **Sales**) and then click **Delete**.
5. Click **Yes** when the following message is displayed:
    > Are you sure you want to delete this item?

    > [!NOTE]
    > The Web content remains in the remote folder to which the virtual directory was mapped.
6. Stop, and then restart the Web site:
    1. Right-click the Web site that you want (for example, **Default Web Site**), and then click **Stop**.
    2. Right-click the Web site, and then click **Start**.
7. Quit the Internet Information Services snap-in.
