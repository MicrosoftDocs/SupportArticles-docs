---
title: Authentication issues with ADSI WinNT provider
description: Describes user authentication issues with Active Directory Service Interfaces (ADSI) WinNT provider.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-services-interface-adsi, csstroubleshoot
---
# User authentication issues with the Active Directory Service Interfaces WinNT provider

This article describes user authentication issues with Active Directory Service Interfaces (ADSI) WinNT provider.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 218497

## Summary

The **ADSI OpenDsObject** method or the **ADsOpenDsObject C helper** function allows you to provide authentication credentials to the directory server when you open an object. There are a number of issues that you should be aware of when you use this technique with the Active Directory Service Interfaces WinNT provider.

## More information

The Active Directory Service Interfaces WinNT provider uses the **WNetAddConnection2** function to make a connection to \\\\servername\\IPC$ in order to establish these credentials with the remote server. This method is useful because it doesn't require special privileges for NT clients and it works on Windows and it supports authentication across untrusted domains.

Unfortunately, there are several drawbacks inherent in the **WNetAddConnection2** function, and they are as follows:

- If any connection has already been established to the target server by any process running on the client computer, the **WNetAddConnection2** function cannot make a new connection under any credentials other than those used for the existing connection.

    If you try to authenticate a new account, you will get a conflicting credentials error. If you try to authenticate the existing account, any password will work (valid or not). This is a particular problem when you are getting objects from a domain controller where many system processes establish connections to domain controllers.  

- If the Guest account is enabled on the destination computer, it is possible to pass both an invalid username and password and to create a connection.  
- The system does not reference count connections, thus, if any process, including your Active Directory Service Interfaces client process, deletes the connection, then all processes using that connection have to be written to re-establish it when they find it has been deleted.  

When you are using the WinNT provider, we recommend that you authenticate with the target server by logging on to a domain account with appropriate credentials or using the **LogonUser** function (which requires elevated privileges) prior to executing your Active Directory Service Interfaces code. We also recommend that you do not use the Active Directory Service Interfaces OpenDsObject method to validate a user's credentials on any domain that is trusted by your client computer.  

If you are attempting to validate accounts from untrusted domains, use the Active Directory Service Interfaces OpenDsObject method, keeping the issues listed above in mind and understanding that you will be sending unencrypted passwords over the network. You can overcome these restrictions by running validation code as a service on at least one server in each set of untrusted domains using an SSL (or HTTPS) connection to provide encryption. Accomplish this by using a validation .asp file on an IIS server in each set of untrusted domains and connect to it over HTTPS using basic authentication.

The Active Directory Service Interfaces OpenDsObject method uses the credentials of the logged on user to access IIS. The user name and the password that are given as parameters are ignored. You receive the following error message:  
> Access Denied  

However, it works after the logged on user of the client is added to the Administrators group of the server.

It also works if you use the following script code.

```vbscript
Set objLogon = CreateObject("LoginAdmin.ImpersonateUser")  
objLogon.Logon "Administrator", "AdminPassword", "Machinename"  
Set oNS = GetObject("IIS:")
Set oRoot = oNS.OpenDSObject("IIS://SERVER/SHARE", "Mordor\administrator", "Gollum", 1)'User credentials are ignored  
objLogon.Logoff
Set objLogon = Nothing
```
