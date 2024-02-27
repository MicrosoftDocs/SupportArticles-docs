---
title: How To Set Up Routing and Remote Access
description: Describes how to set up routing and remote access for an Intranet.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# How to set up Routing and Remote Access for an Intranet  

This article describes how to set up routing and remote access for an Intranet.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 323415

## Summary

This step-by-step guide describes how to set up a Routing and Remote Access service on Windows Server 2003 Standard Edition or Windows Server 2003 Enterprise Edition to allow authenticated users to remotely connect to another network by way of the Internet. This secure connection provides access to all internal network resources, such as messaging, file and print sharing, and Web server access. The remote character of this connection is transparent to the user, so the overall experience of using remote access is similar to that of working at a workstation on a local network.

### Installing the Routing and Remote Access Service

By default, the Routing and Remote Access service is installed automatically during the Windows Server 2003 installation, but it is disabled.

#### To Enable the Routing and Remote Access Service

1. Click Start, point to Administrative Tools, and then click **Routing and Remote Access**.
2. In the left pane of the console, click the server that matches the local server name.

    If the icon has a red arrow in the lower-right corner, the Routing and Remote Access service isn't enabled. Go to step 3.

    For a green arrow pointing up in the lower-right corner, the service is enabled. If so, you may want to reconfigure the server. To reconfigure the server, you must first disable Routing and Remote Access. You may right-click the server, and then click **Disable Routing and Remote Access**. Click Yes when it is prompted with an informational message.
3. Right-click the server, and then click **Configure and Enable Routing and Remote Access** to start the Routing and Remote Access Server Setup Wizard. Click Next.
4. Click **Remote access (dial-up or VPN)** to permit remote computers to dial in or connect to this network through the Internet. Click Next.
5. Click VPN for virtual private access, or click Dial-up for dial-up access, depending on the role you want to assign to this server.
6. On the VPN Connection page, click the network interface that is connected to the Internet, and then click Next.
7. On the IP Address Assignment page, do one of the following:

    - If a DHCP server will be used to assign addresses to remote clients, click Automatically, and then click Next. Go to step 8.
    - To give remote clients addresses only from a pre-defined pool, click **From a specified range of addresses**.

    > [!NOTE]
    > In most cases, the DHCP option is simpler to administer. However, if DHCP is not available, you must specify a range of static addresses. Click Next .

    The wizard opens the Address Range Assignment page.

    1. Click New.
    2. In the **Start IP address** box, type the first IP address in the range of addresses that you want to use.
    3. In the **End IP address** box, type the last IP address in the range.

    Windows calculates the number of addresses automatically.
    4. Click OK to return to the Address Range Assignment page.
    5. Click Next.
8. Accept the default setting of **No, use Routing and Remote Access to authenticate connection requests**, and then click Next.
9. Click Finish to enable the Routing and Remote Access service and to configure the remote access server.  
After you set up the server to receive dial-up connections, set up a remote access client connection on the client workstation.

### To Set Up a Client for Dial-Up Access

To set up a client for dial-up access, follow these steps on the client workstation.

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.  

1. Click Start, click Control Panel, and then double-click **Network Connections**.  
2. Under Network Tasks, click **Create a new connection**, and then click Next.
3. Click **Connect to the network at my workplace** to create the dial-up connection, and then click Next.
4. Click **Dial-up connection**, and then click Next.
5. On the **Connection Name** page, type a descriptive name for this connection, and then click Next.
6. On the **Phone Number to Dial** page, type the phone number for the remote access server in the Phone Number dialog box.
7. Do one of the following, and then click Next:  
    - If you want to allow any user who logs on to the workstation to access to this dial-up connection, click **Anyone's use**.
    - If you want this connection to be available only to the currently logged-on user, click **My use only**.
8. Click Finish to save the connection.

### To Set Up a Client for VPN Access

To set up a client for virtual private network (VPN) access, follow these steps on the client workstation.

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.  

1. Click Start, click Control Panel, and then double-click **Network Connections**.
2. Under Network Tasks, click **Create a new connection**, and then click Next.
3. Click **Connect to the network at my workplace** to create the dial-up connection, and then click Next.
4. Click **Virtual Private Network connection**, and then click Next.
5. On the Connection Name page, type a descriptive name for this connection, and then click
 Next.
6. Do one of the following, and then click Next.

    - If the computer is permanently connected to the Internet, click **Do not dial the initial connection**.
    - If the computer connects to the Internet by way of an Internet service provider (ISP), click **Automatically dial this initial connection**. And then click the name of the connection to the ISP.
7. Type the IP address or the host name of the VPN server computer (for example,
 VPNServer.SampleDomain.com).
8. Do one of the following, and then click Next:

    - If you want to allow any user who logs on to the workstation to access to this dial-up connection, click **Anyone's use**.
    - If you want this connection to be available only to the currently logged-on user, click **My use only**.
9. Click Finish to save the connection.

### Granting Users Access to Remote Access Servers

You can use remote access policies to grant or deny authorization, based on criteria such as the time of day, day of the week, the user's membership in Windows Server 2003-based security groups, or the type of connection that is requested. If a remote access server is a member of a domain, you can configure these settings by using the user's domain account.

If the server is a stand-alone server or a member of a workgroup, the user must have a local account on the remote access server.

#### Grant Remote Access Rights to Individual User Accounts

If you manage remote access on a user account basis, follow these steps to grant remote access rights:

1. Click Start, point to All Programs, point to Administrative Tools, and then click **Active Directory Users and Computers**.
2. Right-click the user account that you want to grant remote access rights to, click Properties, and then click the **Dial-in** tab.
3. Click **Allow access** to grant the user permission to dial in, and then click OK.

#### Configure Remote Access Rights Based on Group Membership

If you manage remote access on a group basis, follow these steps to grant remote access rights:

1. Create a group that contains members who are permitted to create VPN connections.
2. Click Start, point to Administrative Tools, and then click **Routing and Remote Access**.
3. In the console tree, expand **Routing and Remote Access**, expand the server name, and then click Remote Access Policies.
4. Right-click the right pane, point to New, and then click Remote Access Policy.
5. Click Next, type the policy name, and then click Next.
6. Click VPN for virtual private access, or click Dial-up for dial-up access, and then click Next.
7. Click Add, type the name of the group that you created in step 1, and then click Next.
8. Follow the on-screen instructions to complete the wizard.  

If the VPN server already permits dial-up networking remote access services, do not delete the default policy; instead, move it so that it is the last policy to be evaluated.

### To Establish a Remote Connection

Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.  

1. On the client workstation, click Start, click Network Connections, and then click the new connection that you created.
2. In the User Name box, type your user name.

    If the network to which you want to connect has multiple domains, you may have to specify a domain name. Use the
 **domain_name** \ **user name** format in the User Name box.
3. In the Password box, type your password.
4. If you use a dial-up connection, check the phone number listed in the Dial box to make sure it is correct. Make sure that you've specified any additional numbers that you must have to obtain an external line or to dial long distance.
5. Click Dial or Connect (for VPN connections).

    Your computer establishes a connection to the remote access server. The server authenticates the user and registers your computer on the network.

### Troubleshooting

This section describes how to troubleshoot some issues that you may have when you try to set up remote access.

#### Not All of the User's Dial-in Configuration Settings Are Available

If the Windows Server 2003-based domain is using mixed mode, not all of the configuration options are available. Administrators can only grant or deny access to the user and specify callback options, which are the access permission settings available in Microsoft Windows NT 4.0. The remaining options become available after the domain has been switched to native mode.

#### Users Can Contact the Server, But Not Authenticated

Make sure that the user account has been granted permission to remotely connect and authenticated with Active Directory as described in section 2. The Remote Access server must also be a member of the "RAS and IAS Servers" group.

For additional information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[323381](https://support.microsoft.com/help/323381) How To Allow Remote User Access to Your Network in Windows Server 2003  
