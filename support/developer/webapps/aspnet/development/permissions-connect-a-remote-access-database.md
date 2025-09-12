---
title: Permissions of connect to a remote Access database
description: This article describes the permissions to connect to a remote Access database.
ms.date: 12/11/2020
ms.custom: sap:General Development
---
# Permissions to connect to a remote Access database from ASP.NET

This article introduces the permissions to connect to a remote Access database.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 307901

## Summary

This article lists the minimum security settings that are required to connect to a *remote* Microsoft Access database from ASP.NET, including:

- Windows NT File System (NTFS) settings
- Microsoft Internet Information Services (IIS) settings
- Local security policy settings
- ASP.NET configuration file (*Web.config*) settings

This article does not include how to configure database connections.

## More information

When users browse to an ASP.NET Web site, they request that some code run on the server. All processes run within the security context of a specific account. By default, IIS uses the system account. The system account has full access to the IIS server computer but is not allowed to access shared folders on other computers (which are sometimes called NTFS resources). Therefore, you must configure the IIS computer so that it uses an account other than the system account. The [Configure the IIS Server](#configure-the-iis-server) section describes several ways to select an alternate account.

After IIS is set to run under another account, you must give that account permission to all of the files and folders that are needed to use the remote Access database, including:

- Temp folder on the IIS server.
- Share on the remote computer.
- NTFS file system permissions for the database file and its folder.
- Access to the remote computer from the network.
- Permission to log on to the remote computer.

The [Configure the Access Server](#configure-the-access-server) section describes how to set these permissions on the account.

## Configure the IIS Server

This section describes how to configure the IIS server.

### Use the Web.config file to enable impersonation

To connect to a remote Access database, ASP.NET must pass a security token for the user that it impersonates to the remote server. If you do not enable impersonation in the *Web.config* file, ASP.NET uses the system account by default. However, the system account cannot authenticate across the network. To use a different account, add an `<identity impersonate="true" />` tag in the *Web.config* file for a given ASP.NET application. For example:

```xml
<configuration>
  <system.web>
     ...
     <identity impersonate="true" />
     ...
  </system.web>
</configuration>
```

Under this configuration, ASP.NET impersonates the authenticated user from IIS.

### Use an authentication method to select an identity

Use one of the following authentication methods to select an identity:

- *Anonymous authentication*  
You can configure which account to use in Internet Services Manager. By default, this is set to the Internet guest account, or IUSR_**ComputerName**. Whichever account you use, if you use a local account (rather than a domain account), you must follow the steps in the [Replicate the IIS Computer's Local User Accounts](#replicate-the-iis-computers-local-user-accounts) section.

- *Basic authentication*  
This authentication method requires that the end user types a user name and a password that are defined on your IIS computer or on a domain that your IIS computer trusts. Because this allows multiple user IDs, you must add all of those IDs to a group. Wherever this article indicates to grant permissions to the impersonated user, grant those permissions to this group instead.

If any of these accounts is a local account to the IIS computer, you must replicate each local account on the remote Access computer. To do this, follow the steps in the [Replicate the IIS Computer's Local User Accounts](#replicate-the-iis-computers-local-user-accounts) section.

- *Integrated Windows authentication*  
This authentication method only works if your network is set up to use `Kerberos` authentication and if the computers and accounts are set up as trusted for delegation. Otherwise, you cannot use Integrated Windows authentication to access data on a remote NTFS resource. This is because Integrated Windows authentication only allows you access to the IIS server and not additional NTFS resources that the IIS server accesses remotely.

- *Web.config setting*  
Use the *Web.config* file to configure ASP.NET to impersonate a specific domain account that has the necessary access permissions on the remote computer. By default, IIS is set to prevent others who view your Web site from seeing the contents of the *Web.config* file. However, this method requires that you store the user name and password in clear text on the server.

```xml
<configuration>
  <system.web>
     ...
     <identity impersonate="true" userName="<supplied username>" password="<supplied password>" />
     ...
  </system.web>
</configuration>
```

- *Override authentication*
The preceding instructions use the `<identity impersonate="true" />` tag and authentication methods so that the ASP code runs as a user account rather than the system account. Regardless of the impersonation or authentication settings, there are other, less common ways to run as a user account. The following list outlines two of these alternate methods, though details for these methods are beyond the scope of this article.

  - *Separate process*
    You can place all of your data access functions in an ActiveX dynamic-link library (DLL) and place that DLL in Component Services. You must then configure the Component Services settings for that component so that it runs as its own process (server library). On the Identity tab in Component Services, specify the user account that you want to use.
  
  - *Impersonation application programming interfaces*
    You can create an ActiveX DLL that uses application programming interfaces (APIs) to switch from the user account that is currently in use to any other account. You can then use the Access database while you run as this other user.

### Configure Access to the temp folder

The Microsoft Jet database engine writes temporary files to the Temp folder on the local computer (which is the IIS server in this case). You must set the appropriate permissions for this Temp folder.

- *NTFS Permissions*
This setting requires that the user identity (which is determined by the preceding impersonation instructions) has NTFS full control permissions on the Temp folder.

- *TEMP and TMP environment variables*
You may need to define the TEMP and TMP environment variables for the system. If the TEMP and TMP variables are not configured on the IIS server, the Jet engine tries to write these files to the `Windows\System32` folder. Because this may not be acceptable for most Web sites, it is common to configure TEMP and TMP variables.

These variables are often already configured for interactive users on the computer. However, because processes that you start from IIS do not have access to these variables, you may need to configure TEMP and TMP variables for the system. To configure TEMP and TMP variables for the system, follow these steps in Microsoft Windows 2000:

1. On the IIS computer, right-click **My Computer**, and then click **Properties**.
2. On the **Advanced** tab, click **Environment Variables**.
3. Under **System variables**, search for the TEMP variable. If this variable does not exist, follow these steps to add it:

    1. In the **Environment Variables** dialog box, click **New**.
    2. In the **New System Variable** dialog box, in the **Variable Name** text box, type *TEMP*.
    3. In the **Variable Value** text box, type the location of the Temp folder on the computer, and then click **OK**.
4. Repeat steps 3a through 3c for the TMP variable.

## Configure the Access Server

This section describes how to configure the Microsoft Access server.

### Configure NTFS permissions

However you choose to impersonate accounts within ASP.NET, if the file system on the remote computer is NTFS, you must set the permissions on the remote computer correctly. For example, you must set the following permissions on the database file:

- Read
- Write
- Execute
- Change

In addition, you must set the following permissions on the folder in which the file resides:

- Read
- Write
- Execute
- Delete
- Change

If there are multiple possible user accounts, such as in Basic or Digest authentication, create a group, add the user accounts to this group, and then grant privileges to the group.

### Configure Share Permissions

Like NTFS file system permissions, you must also set share permissions to allow access for the same user, users, or group.

You may be tempted to use the administrative shares, which Windows creates for each drive (such as the C drive). However, it is better to create a new share because the administrative shares require that you add all users who use the share to the Administrators group.

If the database is stored on a platform other than a Microsoft Windows platform, you must configure this share appropriately for the destination platform.

### Replicate the IIS Computer's local user accounts

To grant share and NTFS permissions to the impersonated user, the Access computer must recognize that user account. If the account is a domain account, you can add it to the permissions lists on both computers. If one or more of the accounts is a local account on the IIS computer, it will not be recognized on the Access computer. To resolve this problem, use the same user name and the same password to create a duplicate local account on the Access computer.

### Configure local security policy permissions

You must also give the same account, accounts, or group permission to access the computer in the local security policy, unless the account or accounts already belong to a group that has permission (such as the Everyone group). You must grant the following permissions:

- Log on locally
- Access this computer from the network

To access the local security policy editor, follow these steps:

1. In Control Panel, double-click **Administrative** tools, and then double-click **Local Security Policy**.
2. Expand the **Security Settings** node, the Local Policies node, and the User Rights Assignment node to access the **Log on locally** permission and the **Access this computer from the network** permission.
