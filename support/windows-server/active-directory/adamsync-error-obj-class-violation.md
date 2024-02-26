---
title: OBJ_CLASS_VIOLATION error in Adamsync tool
description: Describes how to troubleshoot a problem that occurs when you try to synchronize Active Directory objects to ADAM by using the Adamsync tool.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, clandis
ms.custom: sap:active-directory-lightweight-directory-services-ad-lds-and-active-directory-application-mode-adam, csstroubleshoot
---
# Troubleshoot an OBJ_CLASS_VIOLATION error in Adamsync

This article describes how to troubleshoot an OBJ_CLASS_VIOLATION error that occurs when you use the Adamsync tool in Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 923835

## Summary

This error occurs because of class definition differences between the Active Directory directory service and the ADAM instance. To troubleshoot this issue, follow the steps that are described in the following sections:  

- Determine the attribute and class of the object
- Steps to resolve the problem when attributes belong to the TOP class
- Steps to resolve the problem when attributes do not belong to the TOP class  

## Symptoms

You try to use the Active Directory Application Mode (ADAM) Synchronizer (Adamsync.exe) tool to synchronize the Active Directory objects to an ADAM instance on a Windows Server. However, an error message that resembles the following is
logged in the Adamsync log file:  
> Processing Entry: Page X, Frame X, Entry X, Count X, USN X Processing source entry  
<guid=f9023a23e3a06d408f07a0d51c301f38> Processing in-scope entry  
f9023a23e3a06d408f07a0d51c301f38. Adding target object  
CN= **TestGroup**,OU= **Accounts**,dc= **domain**, dc= **com**. Adding attributes: sourceobjectguid, objectClass, instanceType, displayName, info, adminDescription, displayNamePrintable, userAccountControl, codePage, countryCode, logonHours, primaryGroupID, comment, accountExpires, sAMAccountName, desktopProfile, legacyExchangeDN, userPrincipalName
>
> Ldap error occurred. ldap_add_sW: Object Class Violation. Extended Info: 0000207D: UpdErr: DSID-0315119D, problem 6002 (OBJ_CLASS_VIOLATION), data -2054643804

## Cause

This problem occurs because of the class definition differences between Active Directory and ADAM. This difference appears when you try to modify an object to include an attribute that is invalid for its class. For example, the attribute is not defined in the ADAM schema at all, or the attribute is defined
but the attribute is not present in the list of Mandatory or Optional attributes for the specific class. Typically, the second situation is the most frequent
cause of this problem.

The class definition for the object that is to be synchronized contains one or more attributes in Active Directory that are unavailable in ADAM. The
"Adding attributes" section of the error message that is mentioned in the "Symptoms" section displays the attributes that you try to add. These
attributes are defined in the list of Optional or Mandatory attributes for the class of the object that is being synchronized.

For example, in the error message that is mentioned in the "Symptoms" section, the reference object is CN=TestGroup. When you view the **CN=TestGroup** object in Active Directory, and you check the list of attributes for this class and all parent classes, you see that one or more attributes in this list are not in the list of Mandatory or Optional attributes that are enabled for this class in ADAM.

> [!NOTE]
> This includes attribute lists from all parent classes.

## Resolution

To resolve this problem, follow these steps.

### Determine the attributes and class of the object

1. Verify the list of attributes that are being added to the object that failed. You can determine the object that failed by viewing the error message in the sync log. The failed object is always the last object that is indicated at the end of the sync log exactly before the error message. For example, the **CN=TestGroup** object has failed in the error message that is mentioned in the "Symptoms" section.
2. Determine whether the DisplayNamePrintable, Flags, or ExtensionName attributes are included in the error message. If one of these attributes is included in the error message, see the "Steps to resolve the problem when attributes belong to the TOP class" section. If no attributes are included in the error message, see the "Steps to resolve problem when attributes do not belong to the TOP class" section.

### Steps to resolve the problem when attributes belong to the TOP class

You will find that the TOP class in the Active Directory schema contains the DisplayNamePrintable, Flags, or ExtensionName attribute. However, these attributes are not contained in the TOP class in ADAM. However, you cannot change the TOP class in ADAM. Therefore, use one of the following methods, to resolve the issue:  

- Exclude these attributes by using the \<exclude> section in the XML configuration file.
- By using the MMC schema, manually add these attributes to the list of Optional attributes for the relevant class in the ADAM schema. For example, in the error message that is mentioned in the "Symptoms" section, the failing object is of the Group class. Therefore, you must add these attributes to the Optional attributes list for the Group class in ADAM.

### Steps to resolve the problem when attributes do not belong to the TOP class

1. In ADSchemaAnalyzer, under the **Tools**\\**Options** menu, click **Update with references to new and present elements** on the **LDIF generation** tab.
2. Use the **File** menu to load Active Directory as the target schema and ADAM as the base schema. Wait for the tool to finish comparing the schemas.
3. On the **Schema** menu, click **Mark all elements as included**.
4. On the **File** menu, click **Create LDIF file** to create an LDF file that contains the changes.

    > [!NOTE]
    > If you import this LDF file directly into ADAM, the necessary attributes will probably not be added or modified correctly.  
5. No error message is displayed. See the "Why you cannot import the LDF file directly into ADAM" section for an explanation of why this occurs. In this case, go to step 5 without importing the LDF file.
6. Examine the LDF file that you created in step 4. Specifically, view the class that is causing the problem. For example, view the Group class. The section for this class will contain the list of attributes that are present in the list of Mandatory or Optional attributes for this class in Active Directory but that are missing in ADAM.
7. Find the problem attribute in the LDF file. To do this, examine the "#attributes" section in the LDF file. Attributes that are not imported remain in this section. Typically, the problem attribute is the only attribute that you find in the "#attributes" section. If you find the problem attribute, go to step 8. If you do not find the problem attribute, go to step 7.
8. If the problem attribute is not obvious from the "#attributes" section in the LDF file, follow these steps to find the problem attribute:  

    1. Currently all modifications to a class are under one section in the LDF file. This is the "#Updating Present Elements" section. Under this section, locate the section that updates the class that has the problem. For example, if the Group class is the problem, you will find a section that resembles the following:  

        > \# Update element: group  
        dn: cn=Group,cn=Schema,cn=Configuration,dc=X  
        changetype: modify  
        add: mayContain  
        \# mayContain: adminCount  
        mayContain: 1.2.840.113556.1.4.150  
        \# mayContain: controlAccessRights  
        mayContain: 1.2.840.113556.1.4.200  
        \# mayContain: groupAttributes  
        mayContain: 1.2.840.113556.1.4.152  
        \# mayContain: groupMembershipSAM  
        mayContain: 1.2.840.113556.1.4.166  
        \-  
        >
        > Note Some more entries that may be located here have been excluded from this example.
        >
        > dn:  
        changetype: modify  
        add: schemaUpdateNow  
        schemaUpdateNow: 1  

    2. Change the entries that you located in step 4a by splitting the entries into a single attribute per operation. For example, change the entries in the example in step 7a by using entries that resemble the following:

        > \# Update element: group  
        > dn: cn=Group,cn=Schema,cn=Configuration,dc=X  
        changetype: modify  
        add: mayContain  
        \# mayContain: adminCount  
        mayContain: 1.2.840.113556.1.4.150  
        \-  
        >
        > \# Update element: group  
        dn: cn=Group,cn=Schema,cn=Configuration,dc=X  
        changetype: modify  
        add: mayContain  
        \# mayContain: controlAccessRights  
        mayContain: 1.2.840.113556.1.4.200  
        \-  
        >
        > dn: cn=Group,cn=Schema,cn=Configuration,dc=X  
        changetype: modify  
        add: mayContain  
        \# mayContain: groupAttributes  
        mayContain: 1.2.840.113556.1.4.152  
        \-  
        >
        > dn: cn=Group,cn=Schema,cn=Configuration,dc=X  
        changetype: modify  
        add: mayContain  
        \# mayContain: groupMembershipSAM  
        mayContain: 1.2.840.113556.1.4.166  
        \-
        >
        > Note Some more entries that may be located here have been excluded from this example.  
        >
        > dn:  
        changetype: modify  
        add: schemaUpdateNow  
        schemaUpdateNow: 1  

9. Save the LDF file.
10. Import the LDF file into the ADAM schema by using the command that is provided at the beginning of the LDF file.
11. View the report that is displayed by the Ldifde utility. Ldifde will now report the errors that occur with the attributes that were not imported. The error information will resemble the following sample information:

    ```console
    ldifde -i -u -f c:\data\problem\KBtest_modified.ldf -s localhost:50010 -j .-c "cn=Configuration,dc=X" #configurationNamingContext  
    Connecting to "localhost:50010"
    ```

    > Logging in as current user using SSPI  
    Importing directory from file "c:\data\problem\KBtest_modified.ldf"  
    Loading entries.  
    Add error on line 15: Already Exists  
    The server side error is: 0x2071 An attempt was made to add an object to the  
    ectory with a name that is already in use.  
    The extended server error is:  
    00002071: UpdErr: DSID-0305030D, problem 6005 (ENTRY_EXISTS), data 0  

    > [!NOTE]
    > Locate the problem attribute in the LDF file by viewing the line number that is indicated in the error report.
12. Use this error information to find the problem attribute and resolve the problem. Follow these steps to try to resolve the problem:  

    1. Locate the problem attribute in the LDF file by viewing the line number that is indicated in the error report. The failed attribute may have a "DUP-" prefix in the DisplayName.
    2. Note the object identifier (OID) of the attribute and look for this object identifier in ADAM.
    3. Find the attribute in ADAM that has the same object identifier.
    4. Compare the attribute in ADAM and in the LDF file to find any differences. For example, the attributes may have a different DisplayName but the same object identifier.
    5. Decide which attribute to keep, and then correct the other one. For example, you can remove the entry from the LDF file, or you can correct the ADAM attribute entry. Or, you can exclude the problem attribute from the synchronization by using the \<exclude> section in the XML configuration file.
13. After the problem attribute is corrected in Active Directory or in the ADAM schema or after the attribute is removed from the LDF file, import the modified LDF file again. Now the import operation should be successful. If the problem is not resolved, there may be another attribute that is causing the problem. Repeat steps 10 through 12 until all the attributes are imported.

### Diagnostics Logging

When you find the problem attribute, it may not be obvious what is wrong with it. For example, you may not find a duplicate object identifier or a

different DisplayName entry. When a problem attribute is not imported, you can obtain more information about the failure by turning on debug logging for the LDAP interface. To do this, follow these steps:  

1. To obtain more information about the ldifde failure, turn on LDAP logging in ADAM. To do this, change the value for the **Category 16 LDAP Interface events** registry entry to 5. This registry entry is located under the following registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ADAM_instanceName\Diagnostics`

2. Import the LDF file again.
3. Look at the event log for errors.
4. After you finish troubleshooting, reset the value for the **Category 16 LDAP Interface events** registry entry to 0. Otherwise, the event log will be flooded.

### Contact Microsoft Support

If the problem is not resolved after you complete the steps in this article, contact [Microsoft Support](https://support.microsoft.com/).

## Status

This behavior is by design.  

## More information

To synchronize data from Active Directory to ADAM by using the Adamsync tool, follow these steps:  

1. Click **Start**, point to **All Programs**, point to **ADAM**, and then click **ADAM Tools Command Prompt**.
2. At the command prompt, type the following command, and then press ENTER: adamsync /fs **Server_Name**: **port_number** **configurationName** /log **log_file_name**.log  

### Why you cannot import the LDF file directly into ADAM

If you import the LDF file that you created in step 1 under the "Steps to resolve the problem when attributes do not belong to the TOP class" section into ADAM, these attributes are still not added to the attribute list in ADAM. You can verify this behavior by using the ADAM schema MMC or ADSIEDIT to examine the schema. This behavior occurs because the Ldifde import operation fails silently. Currently, Ldifde does not report errors. It fails silently because of the way that ADSchemaAnalyzer constructs the LDF file. ADSchemaAnalyzer uses the **ntdsschemaadd** and **ntdsSchemamodify** commands. These commands turn on permissive LDAP control. This means that any failure is silent.

Additionally, for each class, all attributes to be added into the Optional attributes list are added in one add/modify operation. Therefore, if there is a problem adding one of the attributes, the whole operation fails, and no attributes in the list are added. Therefore, additional steps must be taken to find the problem attribute.

Usually, the likely reason for failure is a duplicate object identifier of an attribute or some other difference in the attribute definitions in Active Directory and ADAM. This means that duplicate OIDs may be missed, and an attribute may be seen as a new attribute if the LDapDisplayName does not exist in ADAM.  
