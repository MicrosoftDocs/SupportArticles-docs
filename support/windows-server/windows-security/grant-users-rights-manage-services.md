---
title: Grant users rights to manage services
description: Describes how to grant users rights to manage services.
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Permissions, access control, and auditing
ms.technology: windows-server-security
---
# How to grant users rights to manage services  

This article describes how to grant users rights to manage services.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325349

## Summary

This article describes how to grant users the authority to manage system services in Windows Server 2003.

By default, only members of the Administrators group can start, stop, pause, resume, or restart a service. This article describes methods that you can use to grant the appropriate rights to users to manage services.

### Method 1: Use Group Policy

You can use Group Policy to change permissions on system services. For additional information, click the following article number to view the article in the Microsoft Knowledge Base:  
 [324802](https://support.microsoft.com/help/324802) HOW TO: Configure Group Policies to Set Security for System Services in Windows Server 2003  

### Method 2: Use Security Templates

To use security templates to change permissions on system services, create a security template following these steps:

1. Click **Start**, click **Run**, type *mmc* in the Open box, and then click **OK**.
2. On the **File** menu, click **Add/Remove Snap-in**.
3. Click **Add**, click **Security Configuration and Analysis**, click **Add**, click **Close**, and then click **OK**.
4. In the console tree, right-click **Security Configuration and Analysis**, and then click **Open Database**.
5. Specify a name and location for the database, and then click **Open**.
6. In the **Import Template** dialog box that appears, click the security template that you want to import, and then click **Open**.
7. In the console tree, right-click **Security Configuration and Analysis**, and then click **Analyze Computer Now**.
8. In the **Perform Analysis** dialog box that appears, accept the default path for the log file that is displayed in the **Error log file path** box or specify the location that you want, and then click **OK**.
9. After the analysis is complete, configure the service permissions as follows:  

    1. In the console tree, click **System Services**.
    2. In the right pane, double-click the service whose permissions you want to change.
    3. Click to select the **Define this policy in the database** check box, and then click **Edit Security**.
    4. To configure permissions for a new user or group, click **Add**. In the **Select Users, Computers, or Groups** dialog box, type the name of the user or group that you want to set permissions for, and then click **OK**.
    5. In the Permissions for **User or Group** list, configure the permissions that you want for the user or group. When you add a new user or group, the **Allow** check box next to the **Start, stop and pause** permission is selected by default. This setting permits the user or group to start, stop, and pause the service.
    6. Click **OK** two times.  

10. To apply the new security settings to the local computer, right-click
 **Security Configuration and Analysis**, and then click **Configure Computer Now**.  

>[!NOTE]
> You can use also the Secedit command-line tool to configure and analyze system security. For more information about Secedit, click Start , and then click Run . Type cmd in the Open box, and then click OK . At the command prompt, type `secedit /?`, and then press ENTER. Note that when you use this method to apply settings, all the settings in the template are reapplied, and this may override other previously configured file, registry, or service permissions.

### Method 3: Use Subinacl.exe

The final method for assigning rights to manage services involves the use of the Subinacl.exe utility from the Windows 2000 Resource Kit. The syntax is as follows:

SUBINACL /SERVICE \\\MachineName\ServiceName /GRANT=[DomainName\]UserName[=Access]

>[!Note]
>
>- The user who runs this command must have administrator rights for it to complete successfully.  
>- If **MachineName** is omitted, the local machine is assumed.  
>- If **DomainName** is omitted, the local machine is searched for the account.
>- Although the syntax example indicates a user name, this will work for user groups too.
>- The values that **Access** can take are as follows:  
>
>     F : Full Control  
     R : Generic Read  
     W : Generic Write  
     X : Generic eXecute  
     L : Read controL  
     Q : Query Service Configuration  
     S : Query Service Status  
     E : Enumerate Dependent Services  
     C : Service Change Configuration  
     T : Start Service  
     O : Stop Service  
     P : Pause/Continue Service  
     I : Interrogate Service  
     U : Service User-Defined Control Commands  
>
>- If **Access** is omitted, "F (Full Control)" is assumed.
>- Subinacl supports similar functionality in relation to files, folders, and registry keys. For more information, see the *Windows 2000 Resource Kit*.

#### Automating Multiple Changes

With Subinacl, there is no option that you can specify that will set the required access for all services on a particular computer. However, the following sample script demonstrates one way that Method 3 can be extended to automate the task:

```vbscript

 strDomain = Wscript.Arguments.Item(0)'domain where computer account is held
 strComputer = Wscript.Arguments.Item(1)'computer netbios name
 strSecPrinc = Wscript.Arguments.Item(2)'user's login name as in: DomainName\UserName
 strAccess = Wscript.Arguments.Item(3)'access granted, as per the list in the KB

 'bind to the specified computer
 set objTarget = GetObject("WinNT://" & strDomain & "/" & strComputer & ",computer")  
 'create a shell object. Needed to call subinacl later  
 set objCMD = CreateObject("Wscript.Shell")  
 'retrieve a list of services
 objTarget.filter = Array("Service")

 For each Service in objTarget

 'call subinacl to se the permissions
 command = "subinacl /service " & Service.name & " /grant=" & strSecPrinc & "=" & strAccess
 objCMD.Run command, 0

 'report the services that have been changed
 Wscript.Echo "User rights changed for " & Service.name & " service"
 next

```

>[!Note]
>
>- Save the script as a .vbs file, such as "Services.vbs," and call it as follows:
>
>      CSRIPT Services.vbs DomainName ComputerName UserName Access
>- Comment out or remove the line 'Wscript.Echo ...' if no feedback is required.
>- This sample does no error checking; therefore, use it carefully.
>- The Windows 2000 Resource Kit documentation mentions another utility (svcacls.exe) that performs the same service management rights manipulation as Subinacl. This is a documentation error.
