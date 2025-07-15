---
title: Can't Edit or Delete an AD Object and Receive Errors
description: Helps resolve an issue where you can't edit or delete an AD object and receive the error Attribute is owned by SAM or The specified account does not exist.
ms.date: 03/11/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom:
- sap:active directory\user,computer,group,and object management
- pcy:WinComm Directory Services
---
# Can't edit or delete an AD object and receive the error "attribute is owned by the Security Accounts Manager (SAM)" or "The specified account does not exist"

This article helps resolve an issue in which you can't edit or delete an Active Directory (AD) object and receive the error "attribute is owned by the Security Accounts Manager (SAM)" or "The specified account does not exist."

You have a user, Managed Service Account (MSA), Group Managed Service Account (gMSA), computer, or group object that is in use. When you attempt to delete a security principal from AD, you receive the following Lightweight Directory Access Protocol (LDAP) error:

> Operation failed. Error code: 0x525  
The specified account does not exist.  
00000525: NameErr: DSID-031A120B, problem 2001 (NO_OBJECT), data 0, best match of

When you retrieve the properties of a computer object by using the following cmdlet:

```PowerShell
get-adcomputer -identity oldcomputer -properties *
```

You receive the following output:

```output
CanonicalName                   : contoso.com/Workstations/Disabled/oldcomputer
CN                              : oldcomputer
Created                         : <DateTime>
createTimeStamp                 : <DateTime>
Deleted                         :
Description                     :
DisplayName                     :
DistinguishedName               : CN=oldcomputer,OU=Disabled,OU=Workstations,DC=contoso,DC=com
dNSHostName                     : oldcomputer.contoso.com
dSCorePropagationData           : {<DateTime>, <DateTime>, <DateTime>, <DateTime>...}
instanceType                    : 4
isDeleted                       :
LastKnownParent                 :
Modified                        : <DateTime>
modifyTimeStamp                 : <DateTime>
Name                            : oldcomputer
nTSecurityDescriptor            : System.DirectoryServices.ActiveDirectorySecurity
objectCategory                  :
ObjectClass                     : computer
```

From the output, you notice an attribute excerpt and some key details:

- The object isn't deleted.
- The `objectCategory` attribute is shown as empty.
- The `sAMAccountType` attribute isn't listed.

When you try to edit the object, this error appears for most changes:

> 0x209a Access to the attribute is not permitted because the attribute is owned by the Security Accounts Manager (SAM).

When you check the metadata with the distinguished name (DN) obtained from the preceding output (excerpts of the attribute list) by using the following command, you receive unexpected results:

```console
repadmin -showobjmeta DC01 "CN=oldcomputer,OU=Disabled,OU=Workstations,DC=contoso,DC=com"
 312781 DC12\0ADEL:AF9F2C0D-6B9F-4e32-A94D-A3E235A31BF7  98364396 YYYY-09-16 13:01:55    2 isDeleted
...
 312781            83ddc6a9-65e8-4ace-8c84-8d1dd2778e47 104437043 YYYY-09-16 13:01:43    2 sAMAccountType
...
 312781            83ddc6a9-65e8-4ace-8c84-8d1dd2778e47 104437043 YYYY-09-16 13:01:43    2 objectCategory
...
 312781 DC12\0ADEL:AF9F2C0D-6B9F-4e32-A94D-A3E235A31BF7  98364396 YYYY-09-16 13:01:55    2 isRecycled
```

Here's the interpretation of the metadata:

- The `sAMAccountType` and `objectCategory` attributes
  - They're usually set once.
  - The version is `2`, and they aren't set at this time. So, they were removed during the object deletion and weren't repopulated during the undeletion.
- The `isDeleted` attribute
  - The version also shows `2`. This means the object was deleted and was undeleted by clearing the attribute.
  - If the object was revived using an authoritative restore, the version numbers for all attributes would be higher (the default version increase is 100000).
- The `isRecycled` attribute
  - It shows that at least at the time of the undeletion, the Active Directory (AD) Recycle Bin wasn't enabled.
  - When using the AD Recycle Bin, the attribute would only be set on a recycled object.
- Expected behaviors
  - If the undeletion worked as expected, the version of `sAMAccountType` and `objectCategory` would be an odd value (for example, `3`).
  - The timestamp for these attributes would match or be slightly newer than the timestamp for `IsDeleted`.

## The sAMAccountType and objectCategory attributes aren't added to the object in an undeletion process

The object was deleted and undeleted. Deleted objects don't have the `sAMAccountType` and `objectCategory` attributes. They're added to the object after the undeletion in the normal case. In the problem case, the process fails, leaving the object active without these key attributes. This state of the object is a known problem that can't be reproduced, and the root cause of this sporadic problem hasn't been identified.

## Use the fixupObjectState attribute with LDIFDE to repair the object

> [!NOTE]
> This method includes the scenario where an object remains active without these attributes and can't be repaired or deleted.
>
> If the undeletion was done recently, you can restore the object using a backup in an authoritative restore. This also restores these attributes.

To resolve this issue,  use the new facility included in Windows Server 2022 and Windows Server 2025 to repair broken objects as specified in [[MS-ADTS]: fixupObjectState](/openspecs/windows_protocols/ms-adts/37294765-9e7d-41a1-aded-2d6f744eee8c).

> [!NOTE]
> There's also functionality to repair the `LastLogonTimeStamp` attribute. For more information, see [User or computer accounts have the lastLogonTimestamp value set to a future time](accounts-lastlogontimestamp-future-time.md).

### Step 1: Identify the object name and globally unique identifier (GUID)

For example:

- DN: `cn=brokenuser,ou=bad-users,dc=contoso,dc=com`
- GUID: `cf2b4aca-0e67-47d9-98aa-30a5fe30dc36`

### Step 2: Prepare an LDIFDE import file using the DN string or GUID-based syntax

- Use the DN string:

    ```output
    DN:
    Changetype:modify
    add: fixupObjectState
    fixupObjectState: cn=brokenuser,ou=bad-users,dc=contoso,dc=com: SamAccountType,Objectcategory
    -
    ```

    > [!NOTE]
    > The line with only a hyphen (`-`) and the empty line are required for a well-formed LDIFDE import file. This example requests the repair of both SAM-relevant attributes.

- Use the GUID-based syntax:

    If the object name contains special characters, use Unicode for the LDIFDE import file, or use the GUID-based syntax.

    An object name can be expressed as`<guid=cf2b4aca-0e67-47d9-98aa-30a5fe30dc36>` in the GUID-based syntax.

    So, the expression of `fixupObjectState: cn=brokenuser,ou=bad-users,dc=contoso,dc=com:Objectcategory, SamAccountType` becomes `fixupObjectState: <guid=cf2b4aca-0e67-47d9-98aa-30a5fe30dc36>:Objectcategory, SamAccountType`.

    To use this syntax with the LDIFDE import file, you need to encode the text after the first colon in Base64 format because of the  greater-than (>) and less-than (<) signs:

    ```output
    fixupObjectState:: PGd1aWQ9Y2YyYjRhY2EtMGU2Ny00N2Q5LTk4YWEtMzBhNWZlMzBkYzM2PjpPYmplY3RjYXRlZ29yeSxTYW1BY2NvdW50VHlwZQ==
    ```

    > [!NOTE]
    > The double colon tells LDIFDE that the attribute value is in Base64 format. You can use the [Base64 encoder](https://www.bing.com/search?q=site%3Amicrosoft.com%20base64%20encoder&qs=n&form=QBRE&sp=-1&lq=0&pq=site%3Amicrosoft.com%20base64%20encoder&sc=0-33&sk=&cvid=CE994D44ADFC432CA2D3784CEBB3D934&ghsh=0&ghacc=0&ghpl=) to encode the string directly on the web.

    After using the Base64 format, the import file updates the attributes individually:

    - For the `sAMAccountType` attribute:

      ```output
      DN:
      Changetype:modify
      add: fixupObjectState
      fixupObjectState:: PGd1aWQ9Y2YyYjRhY2EtMGU2Ny00N2Q5LTk4YWEtMzBhNWZlMzBkYzM2PjpTYW1BY2NvdW50VHlwZQ==
      -
      ```

    - For the `objectCategory` attribute:
  
      ```output
      DN:
      Changetype:modify
      add: fixupObjectState
      fixupObjectState:: PGd1aWQ9Y2YyYjRhY2EtMGU2Ny00N2Q5LTk4YWEtMzBhNWZlMzBkYzM2PjpPYmplY3RjYXRlZ29yeQ==
      -
      ```

### Step 3: Repair the object using LDIFDE

Sign in as an Enterprise Administrator, and import the LDIFDE import file with the following command by specifying the import file name (for example, **repair-user.txt**):

```console
ldifde /i /f repair-user.txt
Connecting to "<DC>"
Logging in as current user using SSPI
Importing directory from file " repair-user.txt"
Loading entries...
2 entries modified successfully.
```

Then, the `objectCategory` and `sAMAccountType` attributes of the object are repopulated.

### Step 4: Delete the object again

Delete the object again, as the algorithm doesn't always ensure the `sAMAccountType` attribute is correct. SAM allows the object in the new state to be deleted, but other operations on the object might fail. Additionally, the object might lack other crucial attributes that make it function properly.
