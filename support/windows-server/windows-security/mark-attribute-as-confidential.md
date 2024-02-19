---
title: Mark an attribute as confidential
description: Describes how to use the confidential attributes feature in Windows Server 2003 Service Pack 1 (SP1). The confidential attribute feature is introduced by Windows Server 2003 SP1.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# Mark an attribute as confidential in Windows Server 2003 Service Pack 1

This article describes how to mark an attribute as confidential in Windows Server 2003 Service Pack 1.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 922836

## Summary

In the Active Directory directory service for Microsoft Windows Server 2000 and for Microsoft Windows Server 2003, it is difficult to prevent an authenticated user from reading an attribute. Generally, if the user requests READ_PROPERTY permissions for an attribute or for its property set, read access is granted. Default security in Active Directory is set so that authenticated users have read access to all attributes. This article discusses how to prevent read access for an attribute in Windows Server 2003 Service Pack 1 (SP1).  

## More information

Windows Server 2003 SP1 introduces a way to mark an attribute as confidential. To do this, you modify the value of the searchFlags attribute in the schema. The searchFlags attribute value contains multiple bits that represent various properties of an attribute. For example, if bit 1 is set, the attribute is indexed. Bit 7 (128) designates the attribute as confidential.

### Requirements and constraints

Only domain controllers that are running Windows Server 2003 SP1 or a later version enforce the read access check for confidential attributes. The confidential attributes feature is tied to the installation of Windows Server 2003 SP1 or a later version. This feature does not depend on whether a domain or a forest functional level is enabled.

Do not use the confidential attributes feature unless the following conditions are true:

- All Windows Server 2003-based domain controllers have Windows Server 2003 SP1 or a later version installed.
- All Windows 2000-based domain controllers have been upgraded or removed. If a domain contains a mix of domain controllers that are running Windows 2000 Server, the original release version of Windows Server 2003, and Windows Server 2003 SP1, the following scenario may occur:

- If an unauthorized client queries the Windows 2000 Server-based and Windows Server 2003-based domain controllers for confidential attribute data, the client can read the data.
- If an unauthorized client queries the Windows Server 2003 SP1-based domain controller for confidential attribute data, the client cannot read the data. You cannot mark a base schema attribute as confidential. An employee ID is an example of a base schema attribute. This attribute cannot be marked as confidential because its systemsFlags attribute value is set to 0x10 (base schema). For more information, see the "How to determine whether an attribute is a base schema attribute" section and the "How to determine the searchFlags attribute value when you use an existing attribute" section.

### Testing

As you would test any change to Active Directory and any schema extension, we recommend that you thoroughly test attribute changes in a lab that mirrors your production forest. Testing helps guarantee that the procedure works smoothly and that problems are detected.

### Access control checks

After Windows Server 2003 SP1 is installed and after Active Directory performs a read access check, Active Directory checks for confidential attributes. If confidential attributes exist and if READ_PROPERTY permissions are set for these attributes, Active Directory will also require CONTROL_ACCESS permissions for the attributes or for their property sets.

> [!NOTE]
> The Full Control permission setting includes the CONTROL_ACCESS permission.

Active Directory performs a read access check on an object in the following cases:

- When you evaluate whether the object matches the search filter.
- When you return attributes of an object that match the search filter. By default, only administrators have CONTROL_ACCESS permissions to all objects. Therefore, only Administrators can read confidential attributes. Administrators may delegate these permissions to any user or to any group.

### Generic and object-specific access control entries

Every object in Active Directory has access control information that is associated with it. This information is known as a security descriptor. The security descriptor controls the type of access that is available to users and to groups. The security descriptor is automatically created when the object is created.

The set of permission entries in a security descriptor is known as a discretionary access control list (DACL). Each permission entry in the DACL is known as an access control entry (ACE).

You can grant permissions to the object or grant CONTROL_ACCESS permissions to confidential attributes by using a generic or object-specific access control entry on the object. You can grant permissions by stamping them explicitly on the object or by using inheritance. Inheritance means that you set an inheritable access control entry on a container that is higher in the container hierarchy.

Generic and object-specific access control entries are basically the same. What sets them apart is the degree of control that the access control entries offer over inheritance and over object access. Generic access control entries apply to the whole object. Object-specific access control entries offer more control over what objects inherit the access control entry. When you use an object-specific access control entry, you can specify the attribute or the property set of the object that will inherit the access control entry.

When you use the confidential attributes feature, CONTROL_ACCESS permission is granted by assigning a generic access control entry to a user. If CONTROL_ACCESS permission is granted by assigning an object-specific access control entry, the user will only have CONTROL_ACCESS permission to the confidential attribute.

The following permissions are granted when you use a generic access control entry:  

- All Extended Rights
- Allowed to Authenticate
- Change Password
- Receive As
- Reset Password
- Send As  

Permissions that are granted when you use a generic access control entry may provide more access than is desired over the whole object. If this is a concern, you can set an object-specific access control entry on the object so that the access control entry applies only to the confidential attribute. When you use object-specific access control entries, you can control the property or the property set to which the access control entry applies.

The user interface in Windows Server 2003 does not expose Control_Access permissions. You can use the Dsacls.exe tool to set Control_Access permissions by assigning a generic access control entry. However, you cannot use this tool to assign an object-specific access control entry. The only tool that can set Control_Access permissions by assigning an object-specific access control entry is the Ldp.exe tool.

> [!NOTE]
> An in-depth discussion of access control is beyond the scope of this article. For more information about access control, visit the following Microsoft Web sites:  
[Access Control (Authorization)](https://msdn.microsoft.com/library/aa374860%28vs.85%29.aspx)  
[Identity Management and Access Control](https://technet.microsoft.com/library/cc749433.aspx)  

### How to use inheritance

In a large domain, it is not practical to manually assign control access to a user or to a group for every object that has a confidential attribute. The solution is to use inheritance to set an inheritable access control entry that is higher in the container hierarchy. This access control entry applies to all child objects of that container.

By default, inheritance is enabled for all organizational units (OU) and for all user accounts, except for the built-in administrator account. If you create user accounts that have inheritance disabled or if you create administrative accounts by copying the built-in administrator account, you must enable inheritance for these accounts. Otherwise, the inheritance model does not apply to these accounts.

### How to create a confidential attribute

1. Determine what attribute to mark as confidential, or add an attribute that you want to make confidential.
2. Grant the appropriate users Control_Access permissions so the users can view the attribute data.  

Tools such as the Ldp.exe tool and the Adsiedit.msc tool can be used to create a confidential attribute. .ldf files are typically used to extend the schema. These files can also be used to mark an attribute as confidential. The files that you create for an implementation should be tuned during the testing phase so that you know exactly what you are adding to the schema when you roll out to production. .ldf files help prevent errors.

The following sample .ldf files can be used to do the following:

- Add an attribute to the schema
- Mark the attribute as confidential
- Add the attribute to the user class

> [!NOTE]
> Before you use .ldf files, make sure that you read the "Object identifiers" and " Attribute syntax" sections for important information about how to add objects and attributes to the schema.

#### Sample .ldf files

The following code adds an attribute to the schema and then marks the attribute as confidential.

> dn: CN=ConfidentialAttribute-LDF,CN=Schema,Cn=Configuration,DC=domain,DC=com  
changetype: add  
objectClass: attributeSchema  
lDAPDisplayName: ConfidentialAttribute  
adminDescription: This attribute stores user's confidential data  
attributeID: 1.2.840.113556.1.xxxx.xxxx.1.x  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
showInAdvancedViewOnly: TRUE  
searchFlags: 128  
>
> dn:  
changeType: modify  
add: schemaupdatenow  
schemaupdatenow: 1  
\-

The following code adds the new attribute to the user class.

> dn: CN=User,CN=Schema,CN=Configuration,DC=domain,DC=com  
changetype: modify  
add: mayContain  
mayContain: ConfidentialAttribute  
\-  
>
> dn:  
changeType: modify  
add: schemaupdatenow  
schemaupdatenow: 1  
\-

### How to let non-administrative users see the attribute data

> [!NOTE]
> The following procedures require that you use the Ldp.exe tool that is included with Windows Server 2003 R2 Active Directory Application Mode (ADAM). Other versions of the Ldp.exe tool cannot set permissions.

#### How to manually set Control_Access permissions on a user account

1. Open the Ldp.exe tool that is included with Windows Server 2003 R2 ADAM.
2. Connect and bind to the directory.
3. Select a user account, right-click the account, click
 **Advanced**, click **Security Descriptor**, and then click **OK**.
4. In the **DACL** box, click **Add ACE**.
5. In the **Trustee** box, type the group name or the user name to which you want to grant permissions.
6. In the **Control Access** box, verify the changes that you made in step 5.

#### How to use inheritance to assign Control_Access permissions

To use inheritance, create an access control entry that grants Control_Access permissions to the desired users or groups that are higher in the container hierarchy than the objects that have confidential attributes. You can set this access control entry at the domain level or at any point in the container hierarchy that works well for an enterprise. The child objects that have confidential attributes must have inheritance enabled.

To assign Control_Access permissions, follow these steps:

1. Open the Ldp.exe file that is included in Windows Server 2003 R2 ADAM.
2. Connect and bind to a directory.
3. Select an OU or a container that is the higher in the container hierarchy than the objects that have confidential attributes, right-click the OU or the container, click **Advanced**, click
 **Security Descriptor**, and then click **OK**.

4. In the **DACL** box, click
 **Add ACE**.
5. In the **Trustee** box, type the group name or the user name to which you want to grant permissions.
6. In the **Control Access** box, verify the changes that you made in step 5.
7. In the **Object Type** box, click the confidential attribute that you added.
8. Make sure that inheritance is enabled on the target objects.

### How to determine the systemFlags attribute value when you use an existing attribute

If you use an existing object, you must verify what the current searchFlags attribute value is. If you add an object, you can define the value when you add the object. There are many ways to obtain the searchFlags attribute value. Use the method that works best for you.

To use the Ldp.exe tool to obtain the searchFlags attribute value, follow these steps:

1. Click **Start**, click **Run**, type LDP, and then click **OK**.
2. Click **Connection**, and then click
 **Bind**.
3. Bind as the Administrator of the root domain, or bind as an account that is an Enterprise Administrator.

4. Click **View**, and then click
 **Tree**.
5. Click
 **CN=schema,cn=configuration,dc=**rootdomain****, and then click **OK**.
6. In the left pane, expand
 **CN=schema,cn=configuration,dc=**rootdomain****.
7. Locate the domain name of the attribute that you want to mark as confidential, and then expand it.
8. In the list of attributes that are populated for the object, find **searchFlags** to determine the current searchFlags attribute value for that object.

> [!NOTE]
> To determine the new searchFlags attribute value, use the following formula:  
128 + **currentsearchFlagsattribute value** =
 **newsearchFlagsattribute value**.  

### How to determine whether an attribute is a base schema attribute

To determine whether an attribute is a base schema attribute, use the Ldp.exe tool to examine the systemFlags attribute value.

#### LDP output of Employee-ID - systemFlags: 0x10 = (FLAG_SCHEMA_BASE_OBJECT)

In the following sample Ldp.exe output, Ldp.exe identifies the systemFlags attribute value as 0x10 and as a base schema attribute. Therefore, you cannot mark this attribute as confidential.

> \>> Dn: CN=Employee-ID,CN=Schema,CN=Configuration,DC=domain,DC=com  
2> objectClass: top; attributeSchema;  
1> cn: Employee-ID;  
1> distinguishedName: CN=Employee-ID,CN=Schema,CN=Configuration,DC=domain,DC=com;  
1> instanceType: 0x4 = ( IT_WRITE );  
1> whenCreated: \<DateTime>;  
1> whenChanged: \<DateTime>;  
1> uSNCreated: 220;  
1> attributeID: 1.2.840.113556.1.4.35;  
1> attributeSyntax: 2.5.5.12 = ( SYNTAX_UNICODE_TYPE );  
1> isSingleValued: TRUE;  
1> rangeLower: 0;  
1> rangeUpper: 16;  
1> uSNChanged: 220;  
1> showInAdvancedViewOnly: TRUE;  
1> adminDisplayName: Employee-ID;  
1> adminDescription: Employee-ID;  
1> oMSyntax: 64 = ( OM_S_UNICODE_STRING );  
1> searchFlags: 0x0 = ( );  
1> lDAPDisplayName: employeeID;  
1> name: Employee-ID;  
1> objectGUID: 64fb3ed1-338f-466e-a879-595bd3940ab7;  
1> schemaIDGUID: bf967962-0de6-11d0-a285-00aa003049e2;  
1> systemOnly: FALSE;  
1> systemFlags: 0x10 = ( FLAG_SCHEMA_BASE_OBJECT );  
1> objectCategory: CN=Attribute-Schema,CN=Schema,CN=Configuration,DC=domain,DC=com;

#### LDP output of Employee-Number systemFlags: 0x0 = ( )

In the following sample Ldp.exe output, Ldp.exe identifies the systemFlags attribute value as 0. This attribute can be marked as confidential.

> \>> Dn: CN=Employee-Number,CN=Schema,CN=Configuration,DC=warrenw,DC=com  
2> objectClass: top; attributeSchema;  
1> cn: Employee-Number;  
1> distinguishedName: CN=Employee-Number,CN=Schema,CN=Configuration,DC=warrenw,DC=com;  
1> instanceType: 0x4 = ( IT_WRITE );  
1> whenCreated: \<DateTime>;  
1> whenChanged: \<DateTime>;  
1> uSNCreated: 221;  
1> attributeID: 1.2.840.113556.1.2.610;  
1> attributeSyntax: 2.5.5.12 = ( SYNTAX_UNICODE_TYPE );  
1> isSingleValued: TRUE;  
1> rangeLower: 1;  
1> rangeUpper: 512;  
1> mAPIID: 35943;  
1> uSNChanged: 221;  
1> showInAdvancedViewOnly: TRUE;  
1> adminDisplayName: Employee-Number;  
1> adminDescription: Employee-Number;  
1> oMSyntax: 64 = ( OM_S_UNICODE_STRING );  
1> searchFlags: 0x0 = ( );  
1> lDAPDisplayName: employeeNumber;  
1> name: Employee-Number;  
1> objectGUID: 2446d04d-b8b6-46c7-abbf-4d8e7e1bb6ec;  
1> schemaIDGUID: a8df73ef-c5ea-11d1-bbcb-0080c76670c0;  
1> systemOnly: FALSE;  
1> systemFlags: 0x0 = ( );  
1> objectCategory: CN=Attribute-Schema,CN=Schema,CN=Configuration,DC=warrenw,DC=com;  

### Object identifiers

When you add an attribute or a class object to the schema, one of the required attributes is the object identifier (also known as OID). Object identifiers are used to uniquely define object classes and attributes. Make sure that your company obtains a unique object identifier to identify its attribute. Tools that generate object identifiers, such as the Oidgen.exe tool, are not supported. To obtain an object identifier from Microsoft, visit the following Microsoft Web site:  
[Obtaining an Object Identifier from Microsoft](/windows/win32/ad/obtaining-an-object-identifier-from-microsoft)  

### Attribute syntax

The attributeSyntax attribute is also required to add new objects to the schema. This attribute defines the storage representation, byte ordering, and matching rules for comparisons of property types. The syntax defines whether the attribute value must be a string, a number, or a unit of time. Each attribute of every object is associated with exactly one syntax. Make sure that you select the correct attribute syntax for the new attribute. This is especially important if you synchronize a Lightweight Directory Access Protocol (LDAP) directory with another LDAP directory. After the attribute is added to the schema, its attribute syntax cannot be changed.

For more information about the attributeSyntax attribute, see [Attribute-Syntax attribute](/windows/win32/adschema/a-attributesyntax).

See the [Search-Flags attribute](/windows/win32/adschema/a-searchflags) for more information.
