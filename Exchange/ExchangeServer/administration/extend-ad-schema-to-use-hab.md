---
title: Extend AD schema for Hierarchical Address Book
description: Describes a way to install the Active Directory schema for the Hierarchical Address Book (HAB) on a server that is running Exchange Server 2010 server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Extend the Active Directory schema for the Hierarchical Address Book (HAB) on an Exchange Server 2010 server

_Original KB number:_ &nbsp; 973788

## Use Hierarchical Address Book

The HAB is an add-in for Exchange Server 2010 and for Outlook 2010 beta. To use the HAB, you must extend the AD DS schema in the Active Directory forest in which you installed Exchange Server 2010. In order to extend the AD DS schema, you must belong to the Schema Admins group. The schema classes and attributes that are added to AD DS for the HAB are compatible with all languages and versions of Exchange server. The HAB schema extensions for Exchange Server 2010 will also be compatible with future versions of Exchange server.

## Install the HAB Active Directory add-in

1. The LDIFDE tool is required to implement the schema changes. The LDIFDE tool is installed when the remote administration tools for Windows Server 2008 server are installed. To install the remote administration tools, follow these steps on the server:

    1. Click **Start**, and then click **Run**.
    2. Type `ServerManagerCmd -i RSAT-ADDS` in the **Open** field, and then click **OK**.

2. Copy the following schema change script to a text file that is named *schema_file.txt* for later use. Make sure that the first line of the file is blank.

    ```console
    dn: CN=ms-DS-Phonetic-Display-Name,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-DS-Phonetic-Display-Name
    adminDisplayName: ms-DS-Phonetic-Display-Name
    attributeID: 1.2.840.113556.1.4.1946
    attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA==
    attributeSyntax: 2.5.5.12
    isSingleValued: TRUE
    lDAPDisplayName: msDS-PhoneticDisplayName
    mapiId: 35986
    name: ms-DS-Phonetic-Display-Name
    oMSyntax: 64
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    rangeLower: 0
    rangeUpper: 256
    schemaIdGuid:: 5JQa4mYt5UyzDQ74endv8A==
    searchFlags: 5
    showInAdvancedViewOnly: TRUE
    systemFlags: 16
    systemOnly: FALSE

    dn: CN=ms-DS-HAB-Seniority-Index,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: Contains the seniority index as applied by the organization where the person works.
    adminDisplayName: ms-DS-HAB-Seniority-Index
    attributeID: 1.2.840.113556.1.4.1997
    attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA==
    attributeSyntax: 2.5.5.9
    isMemberOfPartialAttributeSet: TRUE
    isSingleValued: TRUE
    lDAPDisplayName: msDS-HABSeniorityIndex
    mapiId: 36000
    name: ms-DS-HAB-Seniority-Index
    oMSyntax: 2
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    schemaIdGuid:: 8Un03jv9RUCYz9lljaeItQ==
    searchFlags: 1
    showInAdvancedViewOnly: TRUE
    systemFlags: 16
    systemOnly: FALSE

    dn: CN=ms-Exch-HAB-Root-Department-Link,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-Exch-HAB-Root-Department-Link
    adminDisplayName: ms-Exch-HAB-Root-Department-Link
    attributeID: 1.2.840.113556.1.4.7000.102.50824
    attributeSyntax: 2.5.5.1
    isMemberOfPartialAttributeSet: FALSE
    isSingleValued: TRUE
    lDAPDisplayName: msExchHABRootDepartmentLink
    mapiId: 35992
    name: ms-Exch-HAB-Root-Department-Link
    oMSyntax: 127
    oMObjectClass:: KwwCh3McAIVK
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    linkID: 1092
    schemaIdGuid:: f/ewOgOh9UeAbUpAzOY4qg==
    searchFlags: 0

    dn: CN=ms-Exch-HAB-Root-Department-BL,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-Exch-HAB-Root-Department-BL
    adminDisplayName: ms-Exch-HAB-Root-Department-BL
    attributeID: 1.2.840.113556.1.4.7000.102.50826
    attributeSyntax: 2.5.5.1
    isMemberOfPartialAttributeSet: FALSE
    isSingleValued: FALSE
    lDAPDisplayName: msExchHABRootDepartmentBL
    mapiId: 35995
    name: ms-Exch-HAB-Root-Department-BL
    oMSyntax: 127
    oMObjectClass:: KwwCh3McAIVK
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    linkID: 1093
    schemaIdGuid:: jIKVD70qh0CwJo98xedSpA==
    searchFlags: 0

    dn: CN=ms-Org-Group-Subtype-Name,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-Org-Group-Subtype-Name
    adminDisplayName: ms-Org-Group-Subtype-Name
    attributeID: 1.2.840.113556.1.6.47.2.3
    attributeSyntax: 2.5.5.12
    isMemberOfPartialAttributeSet: TRUE
    isSingleValued: TRUE
    lDAPDisplayName: msOrg-GroupSubtypeName
    mapiId: 36063
    name: ms-Org-Group-Subtype-Name
    oMSyntax: 64
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    rangeUpper: 128
    schemaIdGuid:: RFjt7cOzw0Gp5omEtSt/mA==
    searchFlags: 17

    dn: CN=ms-Org-Is-Organizational-Group,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-Org-Is-Organizational-Group
    adminDisplayName: ms-Org-Is-Organizational-Group
    attributeID: 1.2.840.113556.1.6.47.2.1
    attributeSyntax: 2.5.5.8
    isMemberOfPartialAttributeSet: TRUE
    isSingleValued: TRUE
    lDAPDisplayName: msOrg-IsOrganizational
    mapiId: 36061
    name: ms-Org-Is-Organizational-Group
    oMSyntax: 1
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    schemaIdGuid:: C1a3SQdHoEqifOF6Cco/lw==
    searchFlags: 16

    dn: CN=ms-Org-Other-Display-Names,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-Org-Other-Display-Names
    adminDisplayName: ms-Org-Other-Display-Names
    attributeID: 1.2.840.113556.1.6.47.2.4
    attributeSyntax: 2.5.5.12
    isMemberOfPartialAttributeSet: TRUE
    isSingleValued: FALSE
    lDAPDisplayName: msOrg-OtherDisplayNames
    mapiId: 36064
    name: ms-Org-Other-Display-Names
    oMSyntax: 64
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    rangeUpper: 128
    schemaIdGuid:: JF+QjxOkWkOO0TU4XsF59w==
    searchFlags: 17

    dn: CN=ms-Org-Leaders,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-Org-Leaders
    adminDisplayName: ms-Org-Leaders
    attributeID: 1.2.840.113556.1.6.47.2.2
    attributeSyntax: 2.5.5.1
    isMemberOfPartialAttributeSet: TRUE
    isSingleValued: FALSE
    lDAPDisplayName: msOrg-Leaders
    mapiId: 36062
    name: ms-Org-Leaders
    oMSyntax: 127
    oMObjectClass:: KwwCh3McAIVK
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    linkID: 1208
    schemaIdGuid:: kGdb7lgzqEGT8hNM4h84Ew==
    searchFlags: 16

    dn: CN=ms-Org-Leaders-BL,DC=X
    changetype: ntdsSchemaAdd
    adminDescription: ms-Org-Leaders-BL
    adminDisplayName: ms-Org-Leaders-BL
    attributeID: 1.2.840.113556.1.6.47.2.5
    attributeSyntax: 2.5.5.1
    isMemberOfPartialAttributeSet: FALSE
    isSingleValued: FALSE
    lDAPDisplayName: msOrg-LeadersBL
    mapiId: 36060
    name: ms-Org-Leaders-BL
    oMSyntax: 127
    oMObjectClass:: KwwCh3McAIVK
    objectCategory: CN=Attribute-Schema,DC=X
    objectClass: attributeSchema
    linkID: 1209
    schemaIdGuid:: 7Y6lr5imfkGfVvrVQlLF9A==
    searchFlags: 0

    dn:
    changetype: ntdsSchemaModify
    replace: schemaUpdateNow
    schemaUpdateNow: 1
    -

    dn: CN=Organizational-Person,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msDS-HABSeniorityIndex
    -

    dn: CN=Organizational-Person,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msDS-PhoneticDisplayName
    -

    dn: CN=ms-Exch-Organization-Container,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msExchHABRootDepartmentLink
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: location
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: thumbnailPhoto
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msDS-HABSeniorityIndex
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msDS-PhoneticDisplayName
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msOrg-GroupSubtypeName
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msOrg-IsOrganizational
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msOrg-Leaders
    -

    dn: CN=Group,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msOrg-OtherDisplayNames
    -

    dn: CN=Mail-Recipient,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msDS-HABSeniorityIndex
    -

    dn: CN=Mail-Recipient,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msDS-PhoneticDisplayName
    -

    dn: CN=Top,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msOrg-LeadersBL
    -

    dn: CN=Top,DC=X
    changetype: ntdsSchemaModify
    add: mayContain
    mayContain: msExchHABRootDepartmentBL
    -

    dn:
    changetype: ntdsSchemaModify
    replace: schemaUpdateNow
    schemaUpdateNow: 1
    -
    ```

3. If your domain controller server is running Windows Server 2008, go to step 7. For domain controller servers that are running versions of Windows that are earlier than Windows Server 2008, the LDIF command requires the `RootDSE` entry. In this case, follow steps 4 through 6.

4. To write the `RootDSE` entry to a file, run the following command that specifies the server name of the domain controller:

    ```console
    LDIFDE -f [domain_data.txt] -s [server_name] -p BASE
    ```

5. Open the domain_data.txt file that you created in step 4, and search for the string that is called *schema*. Copy the following text from that section, starting from `CN=schema`, and save it. This text contains the `RootDSE` entry and is used to import the HAB schema extension in step 6. For example, the text may resemble the following string in which Contoso is used as a placeholder:

    > CN=Schema,CN=Configuration,DC= Contoso -dom,DC= Contoso ,DC=com

6. For domain controller servers that are running versions Windows that are earlier than Windows Server 2008, run the following command on the domain controller server to import the HAB schema extension. This command specifies the RootDSE file that you saved in step 5.

    ```console
    LDIFDE -i -f schema_file.txt -c DC=X <RootDSE_entry>
    ```

7. For Windows Server 2008 only, run the following command on the domain controller server to import the HAB schema extension.

    ```console
    LDIFDE -i -f schema_file.txt -c DC=X #SchemaNamingContext
    ```

> [!NOTE]
> The schema changes described in this article have been included in Exchange Server 2010 SP1.
