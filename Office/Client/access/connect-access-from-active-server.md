---
title: Connect to a remote Access database from Active Server Pages
description: Explains the detailed configuration steps about how to set up the connection string to connect to a remote Microsoft Access database from Active Server Pages on an IIS Web server.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to connect to a remote Access database from Active Server Pages

## Summary

It is possible to connect to a remote Microsoft Access database from Active Server Pages on an IIS Web server. To do this, you need to set up your connection string just as you would if the database were on the local server as described in the "References" section of this article. However, when the database is on a remote server, there are a number of additional configuration steps that should be taken to ensure that this works correctly.

## More information

IIS Anonymous Authentication

IIS must pass the security token for the user it impersonates to the remote server. If IIS is using anonymous authentication and the Internet Guest account is configured as a local computer account, then an account of the same name using the same password must be created on the remote server and given the Log On Locally right in User Manager for Domains under Microsoft Windows NT 4.0.

Alternate Authentication Methods

You can also authenticate users in IIS by using Basic Authentication to connect to the database, or you can configure the Internet Guest account to be a domain account. You cannot use Windows NT Challenge/Response to access data on a remote NTFS resource because the password for the user is never passed to IIS. Rather, a hash of the password is passed which IIS uses to query the domain controller. The domain controller then responds and either verifies or denies the user access to IIS.

NTFS File and Directory Permissions

However you choose to authenticate users in IIS, if the file system on the remote computer is NTFS, the permissions on the remote computer must be correctly set. They must include Read, Write, Execute, and Change for the file itself, and Read, Write, Execute, Delete, and Change for the directory in which the file resides.

Share Permissions and Configuration

This is the share on which the Access database must allow access for the same users as the NTFS file and directory. This share cannot be an administrative share unless all users authenticating will be administrators on the machine. Because this is unlikely, it is best to create a non-administrative share for accessing the database. If the database is stored on a non-Windows platform, this share must be configured appropriately for the destination platform. For more information on using Access databases through a Novell file share, see the "References" section.

Temp Directory Configuration

As well as accessing the file on the remote resource, the Jet engine needs to be able to write temporary files to the local computer (the IIS server, in this case). If TEMP and TMP variables are not configured on the IIS server, the Jet engine tries to write these files to the WINNT\System32 directory. This is probably not acceptable for most Web sites, so it is common to configure TEMP and TMP variables. These variables are often already configured for interactive users on the computer. However, processes launched from IIS do not have access to these variables, so it may be necessary to configure TEMP and TMP variables on the IIS computer manually. 

To do this, follow these steps:

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

1. On the IIS computer, right-click **My Computer**, and then click **Properties**.   
2. In the **System Properties** dialog box, click the **Advanced** tab, and then click **Environment Variables**.   
3. In the **Environment Variables** dialog box, locate the **System variables** section. In the
**Variable** column, locate the TEMP variable.

    > [!NOTE]
    > If the TEMP system variable does not exist, you must create the TEMP system variable. To do this, follow these steps:
    >    1. In the **System variables** section of the **Environment Variables** dialog box, click **New**.   
    >    2. In the **New System Variable** dialog box, type TEMP in the **Variable name** box, and then click **OK**.
  
4. Select the **TEMP** variable, and then click **Edit**.   
5. In the **Variable value** box of the **Edit System Variable** dialog box, type the location of the Temp folder on the computer.   
6. Click **OK**.   
7. Repeat steps 3 through 6 for the TMP system variable.   

Finally, you must make sure that the users or groups that IIS impersonates have full control of the Temp folder and the files in the folder.

## References

[How To Open ADO Connection and Recordset Objects](https://support.microsoft.com/help/168336)
