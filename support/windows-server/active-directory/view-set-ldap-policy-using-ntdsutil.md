---
title: View and set Lightweight Directory Access Protocol (LDAP) policy with Ntdsutil
description: The article describes the most important LDAP query policy limits.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# View and set LDAP policy in Active Directory by using Ntdsutil.exe

This article describes how to manage Lightweight Directory Access Protocol (LDAP) policies by using the Ntdsutil.exe tool.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 315071

## Summary

To make sure that domain controllers can support service-level guarantees, you must specify operational limits for many LDAP operations. These limits prevent specific operations from adversely affecting the performance of the server. They also make the server more resilient to some types of attacks.

LDAP policies are implemented by using objects of the `queryPolicy` class. Query Policy objects can be created in the Query Policies container, which is a child of the Directory Service container in the configuration naming context. For example, cn=Query-Policies,cn=Directory Service,cn=Windows NT,cn=Services **configuration naming context**.

## LDAP administration limits

The LDAP administration limits are:

- InitRecvTimeout - This value defines the maximum time in seconds that a domain controller waits for the client to send the first request after the domain controller receives a new connection. If the client does not send the first request in this amount of time, the server disconnects the client.

    Default value: 120 seconds

- MaxActiveQueries - The maximum number of concurrent LDAP search operations that are permitted to run at the same time on a domain controller. When this limit is reached, the LDAP server returns a **busy** error.

    Default value: 20

    > [!NOTE]
    > This control has an incorrect interaction with the MaxPoolThreads value. MaxPoolThreads is a per-processor control, while MaxActiveQueries defines an absolute number. Starting with Windows Server 2003, MaxActiveQueries is no longer enforced. Additionally, MaxActiveQueries does not appear in the Windows Server 2003 version of NTDSUTIL.

    Default value: 20

- MaxConnections - The maximum number of simultaneous LDAP connections that a domain controller will accept. If a connection comes in after the domain controller reaches this limit, the domain controller drops another connection.

    Default value: 5000

- MaxConnIdleTime - The maximum time in seconds that the client can be idle before the LDAP server closes the connection. If a connection is idle for more than this time, the LDAP server returns an LDAP disconnect notification.

    Default value: 900 seconds

- MaxDatagramRecv - The maximum size of a datagram request that a domain controller will process. Requests that are larger than the value for MaxDatagramRecv are ignored.

    Default value: 4,096 bytes

- MaxNotificationPerConnection - The Maximum number of outstanding notification requests that are permitted on a single connection. When this limit is reached, the server returns a **busy** error to any new notification searches that are performed on that connection.

    Default value: 5

- MaxPageSize - This value controls the maximum number of objects that are returned in a single search result, independent of how large each returned object is. To perform a search where the result might exceed this number of objects, the client must specify the paged search control. It's to group the returned results in groups that are no larger than the MaxPageSize value. To summarize, MaxPageSize controls the number of objects that are returned in a single search result.

    Default value: 1,000

- MaxPoolThreads - The maximum number of threads per-processor that a domain controller dedicates to listening for network input or output (I/O). This value also determines the maximum number of threads per-processor that can work on LDAP requests at the same time.

    Default value: 4 threads per-processor

- MaxResultSetSize - Between the individual searches that make up a paged result search, the domain controller may store intermediate data for the client. The domain controller stores this data to speed up the next part of the paged result search. The MaxResultSize value controls the total amount of data that the domain controller stores for this kind of search. When this limit is reached, the domain controller discards the oldest of these intermediate results to make room to store new intermediate results.

    Default value: 262,144 bytes

- MaxQueryDuration - The maximum time in seconds that a domain controller will spend on a single search. When this limit is reached, the domain controller returns a " timeLimitExceeded" error. Searches that require more time must specify the paged results control.

    Default value: 120 seconds

- MaxTempTableSize - While a query is processed, the `dblayer` may try to create a temporary database table to sort and select intermediate results from. The MaxTempTableSize limit controls how large this temporary database table can be. If the temporary database table would contain more objects than the value for MaxTempTableSize, the `dblayer` performs a much less efficient parsing of the complete DS database and of all the objects in the DS database.

    Default value: 10,000 records

- MaxValRange - This value controls the number of values that are returned for an attribute of an object, independent of how many attributes that object has, or of how many objects were in the search result. In Windows 2000, this control is hard-coded at 1,000. If an attribute has more than the number of values that are specified by the MaxValRange value, you must use value range controls in LDAP to retrieve values that exceed the MaxValRange value. MaxValueRange controls the number of values that are returned on a single attribute on a single object.

  - Minimum Value: 30
  - Default value: 1500

## Start Ntdsutil.exe

Ntdsutil.exe is located in the Support tools folder on the Windows installation CD-ROM. By default, Ntdsutil.exe is installed in the System32 folder.

1. Click **Start**, and then click **Run**.
2. In the **Open** text box, type *ntdsutil*, and then press ENTER. To view help at any time, type `?` at the command prompt.

## View current policy settings

1. At the Ntdsutil.exe command prompt, type `LDAP policies`, and then press ENTER.
2. At the LDAP policy command prompt, type `connections`, and then press ENTER.
3. At the server connection command prompt, type `connect to server <DNS name of server>`, and then press ENTER. You want to connect to the server that you are currently working with.
4. At the server connection command prompt, type `q`, and then press ENTER to return to the previous menu.
5. At the LDAP policy command prompt, type `Show Values`, and then press ENTER.

A display of the policies as they exist appears.

## Modify policy settings

1. At the Ntdsutil.exe command prompt, type `LDAP policies`, and then press ENTER.

2. At the LDAP policy command prompt, type `Set <setting> to <variable>`, and then press ENTER. For example, type *Set MaxPoolThreads to 8*.

    This setting changes if you add another processor to your server.

3. You can use the `Show Values` command to verify your changes.

    To save the changes, use **Commit Changes**.

4. When you finish, type `q`, and then press ENTER.

5. To quit Ntdsutil.exe, at the command prompt, type `q`, and then press ENTER.

> [!NOTE]
> This procedure only shows the Default Domain Policy settings. If you apply your own policy setting, you cannot see it.

## Reboot requirement

If you change the values for the query policy that a domain controller is currently using, those changes take effect without a reboot. However, if a new query policy is created, a reboot is required for the new query policy to take effect.

## Considerations for changing query values

To maintain domain server resiliency, we do not recommend that you increase the timeout value of 120 seconds. Forming more efficient queries is a preferred solution. For more information about creating efficient queries, see [Creating More Efficient Microsoft Active Directory-Enabled Applications](/previous-versions/ms808539(v=msdn.10)).

However, if changing the query isn't an option, increase the timeout value only on one domain controller or only on one site. For instructions, see the next section. If the setting is applied to one domain controller, reduce the DNS LDAP priority on the domain controller, so that clients less likely use the server for authentication. On the domain controller with the increase priority, use the following registry setting to set `LdapSrvPriority`:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

On the **Edit** menu, select **Add Value**, and then add the following registry value:

- Entry name: LdapSrvPriority
- Data type: REG_DWORD
- Value: Set the value to the value of the priority that you want.

For more information, see [How to optimize the location of a domain controller or global catalog that resides outside of a client's site](https://support.microsoft.com/help/306602).

## Instructions for configuring per domain controller or per site policy

1. Create a new query policy under CN=Query-Policies,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration, **forest root**.

2. Set the domain controller or site to point to the new policy by entering the distinguished name of the new policy in the **Query-Policy-Object** attribute. The location of the attribute is as follows:

    - The location for the domain controller is CN=NTDS Settings, CN= **DomainControllerName**, CN=Servers,CN= **site name**,CN=Sites,CN=Configuration, **forest root**.

    - The location for the site is CN=NTDS Site Settings,CN= **site name**,CN=Sites,CN=Configuration, **forest root**.

## Sample script

You can use the following text to create a Ldifde file. You can import this file to create the policy with a timeout value of 10 minutes. Copy this text to Ldappolicy.ldf, and then run the following command, where **forest root** is the distinguished name of your forest root. Leave DC=X as-is. It's a constant that will be replaced by the forest root name when the script runs. The constant X doesn't indicate a domain controller name.

```console
ldifde -i -f ldappolicy.ldf -v -c DC=X DC= forest root
```

### Start Ldifde script

```output
dn: CN=Extended Timeout,CN=Query-Policies,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=X  
changetype: add  
instanceType: 4  
lDAPAdminLimits: MaxReceiveBuffer=10485760  
lDAPAdminLimits: MaxDatagramRecv=1024  
lDAPAdminLimits: MaxPoolThreads=4  
lDAPAdminLimits: MaxResultSetSize=262144  
lDAPAdminLimits: MaxTempTableSize=10000  
lDAPAdminLimits: MaxQueryDuration=300  
lDAPAdminLimits: MaxPageSize=1000  
lDAPAdminLimits: MaxNotificationPerConn=5  
lDAPAdminLimits: MaxActiveQueries=20  
lDAPAdminLimits: MaxConnIdleTime=900  
lDAPAdminLimits: InitRecvTimeout=120  
lDAPAdminLimits: MaxConnections=5000  
objectClass: queryPolicy  
showInAdvancedViewOnly: TRUE
```

After you import the file, you can change the query values by using Adsiedit.msc or Ldp.exe. The MaxQueryDuration setting in this script is 5 minutes.

To link the policy to a DC, use an LDIF import file like this:

```output
dn: CN=NTDS  
Settings,CN=DC1,CN=Servers,CN=site1,CN=Sites,CN=Configuration, DC=X  
changetype: modify  
add: queryPolicyobject  
queryPolicyobject: CN=Extended Timeout,CN=Query-Policies,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=X
```

Import it by using the following command:

```console
ldifde -i -f link-policy-dc.ldf -v -c DC=X DC= **forest root**
```

For a site, the LDIF import file would contain:

```output
dn: CN=NTDS Site Settings,CN=site1,CN=Sites,CN=Configuration, DC=X  
changetype: modify  
add: queryPolicyobject  
queryPolicyobject: CN=Extended Timeout,CN=Query-Policies,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=X
```

> [!NOTE]
> Ntdsutil.exe only displays the value in the default query policy. If any custom policies are defined, they are not displayed by Ntdsutil.exe.
