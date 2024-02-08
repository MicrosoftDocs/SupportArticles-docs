---
title: When you run an LDAP query against a Windows Server 2008-based domain controller, you obtain a partial attribute list
description: Describes a by-design behavior where LDAP queries against a domain controller return partial attribute list.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, fengli
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# When you run an LDAP query against a domain controller, you obtain a partial attribute list

This article provides workarounds for the issue when you run an LDAP query against a domain controller, you obtain a partial attribute list.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 976063

## Symptoms

When you run a Lightweight Directory Access Protocol (LDAP) request against a Windows Server 2008-based domain controller, you obtain a partial attribute list. However, if you run the same LDAP query against a Windows Server 2003-based domain controller, you obtain a full attribute list in the response.

> [!NOTE]
> You can run this query from the domain controller or from a client computer that is running Windows Vista or Windows Server 2008.

The user account that you use to run the LDAP query has the following properties:

- The account is a member of the built-in Administrators group.
- The account is not the built-in administrator account.
- The account is a member of the Domain Admins group.
- The discretionary access control list (DACL) of the user object contains full control permission for the Administrators group.
- The effective permissions of the object that you query against shows that the user has full control permission.

## Cause

This issue occurs because the Admin Approval Mode (AAM) feature is enabled for the user account in Windows Vista and in Windows Server 2008. It is also known as "User Account Control" (UAC). For local resource access, the security system has a loopback code so it uses the active Access Token from the interactive logon session for the LDAP session and the access checks during the LDAP query processing.

For more information about the AAM feature, visit the following Microsoft TechNet Web site: [https://technet.microsoft.com/library/cc772207(WS.10).aspx](https://technet.microsoft.com/library/cc772207%28ws.10%29.aspx) 

## Workaround

To work around this issue, use one of the following methods.

### Method 1


1. Use the Run as administrator option to open a Command Prompt window.
2. Run the LDAP query in the Command Prompt window.

### Method 2

Specify the No prompt value for the following security setting:  
User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode  
For more information about how to specify the value of this security setting, visit the following Microsoft TechNet Web site: [https://technet.microsoft.com/library/cc772207(WS.10).aspx](https://technet.microsoft.com/library/cc772207%28ws.10%29.aspx) 

### Method 3

1. Create a new group in the domain.
2. Add the Domain Admins group to this new group.
3. Grant the Read permission on the domain partition to this new group. To do this, follow these steps:
   1. Click **Start**, click **Run**, type adsiedit.msc, and then click **OK**.
   2. In the **ADSI Edit** window, right-click **DC=**\<Name\>**,DC=com**, and then click **Properties**.
   3. In the **Properties** window, click the **Security** tab.
   4. On the **Security** tab, click **Add**.
   5. Under **Enter the object names to select**, type the name of the new group, and then click **OK**.
   6. Make sure that the group is selected under **Group or user names**, click to select **Allow** for the Read permission, and then click **OK**.
   7. Close the **ADSI Edit** window.
4. Run the LDAP query again.

## Status

This behavior is by design. 

## More information

By default, the AAM feature is disabled for the built-in administrator account in Windows Vista and in Windows Server 2008. Additionally, the AAM feature is enabled for other accounts that are members of the built-in Administrators group.

To verify this, run the following command in a Command Prompt window.
```
whoami /all
```

If the AAM feature is enabled for the user account, the output resembles the following.
```
USER INFORMATION
----------------

User Name SID 
============== ==============================================
MyDomain\MyUser S-1-5-21-2146773085-903363285-719344707-326360

GROUP INFORMATION
-----------------

Group Name Type SID Attributes 
============================================= ================ ================================================= ===============================================================
Everyone Well-known group S-1-1-0 Mandatory group, Enabled by default, Enabled group 
BUILTIN\Administrators Alias S-1-5-32-544 Group used for deny only

```

The built-in Administrators group has the following attribute:
```
Group used for deny only
```

The "Domain Admins" group is shown as enabled group with "Mandatory group, Enabled by default, Enabled group" in whoami /all, but really is disabled for Allow ACEs. This is a known problem in Windows Server 2008 R2 and Windows Server 2012.

Based on this output, the user account that you used to run the LDAP query has the AAM feature enabled. When you run the LDAP query, you use a filtered access token instead of a full access token. Even if full control permission for the Administrators group is granted to the user object, you still do not have full control permission. Therefore, you obtain only a partial attribute list.
