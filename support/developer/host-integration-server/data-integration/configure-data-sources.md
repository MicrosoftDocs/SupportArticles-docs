---
title: Configure data sources
description: This article describes how to configure data sources for the Microsoft OLE DB Provider for DB2.
ms.date: 05/07/2024
ms.custom: sap:Data Integration (DB2, Host Files)
ms.reviewer: syedw, jeremyr
ms.topic: how-to
---
# Configure data sources for the Microsoft OLE DB Provider for DB2

This article describes how to configure data sources for the Microsoft OLE DB Provider for DB2.

_Original product version:_ &nbsp; Host Integration Server  
_Original KB number:_ &nbsp; 218590

## Configure OLE DB Data Source for DB2 using Data Links

The Provider tab allows the user to select the OLE DB provider (the provider name string) to be used in this UDL file from a list of possible OLE DB providers. Choose OLE DB Provider for DB2.

The Connection tab allows the user to configure the basic properties required to connect to a data source. For OLE DB Provider for DB2, the connection properties include the following values:

- Data Source: The data source is an optional parameter that can be used to describe the data source. When the Data Links configuration program is loaded from the SNA Server program folder, the Data Source field is required. This field is used to name the UDL file, which is stored in the `Program Files\Common Files\System\OLE DB\Data` directory.

- User name: A valid user name is normally required to access data on DB2. Optionally, you can persist a user name in the Data Link. The OLE DB provider will prompt the user at runtime to enter a valid password. Additionally, the prompt dialog box will allow the user to override the user name stored in the Data Link.

- The AS/400 computer is case-sensitive with regard to user ID and password. The AS/400 only accepts a DB2/400 user ID and password in UPPER CASE. (If DB2/400 connection fails because of incorrect authentication, the OLE DB provider will resend the authentication, forcing the user ID and password into UPPER CASE.)

- The mainframe is case-insensitive. This means that on mainframe computers, you can enter the DB2 user ID and password in any case. The OLE DB provider will send these values in UPPER CASE.

- DB2 UDB for Windows NT is case-sensitive. The user ID is stored in UPPER CASE. The password is stored in mixed case. The user must enter the password in the correct case. The OLE DB provider sends exactly the password in the case entered by the user. The user does not have to qualify the Windows NT user name with the Windows NT domain name.

- Password: A valid password is normally required to access data on DB2. Optionally, you can choose to save the password in the UDL file by selecting the **Allow saving password** check box.

  > [!WARNING]
  > This option persists the authentication information in plain text within the UDL file.

- Initial Catalog: This OLE DB property is used as the first part of a three-part fully qualified table name.

- In DB2 (MVS, OS/390), this property is referred to as LOCATION. The SYSIBM.LOCATIONS table lists all the accessible locations. To find the location of the DB2 to which you need to connect, ask your administrator to look in the TSO Clist DSNTINST under the DDF definitions. These definitions are provided in the DSNTIPR panel in the DB2 installation manual.

- In DB2/400, this property is referred to as RDBNAM. The RDBNAM value can be determined by invoking the WRKRDBDIRE command from the console to the OS/400 system. If there is no RDBNAM value, then one can be created using the Add option.

- In DB2 Universal Database, this property is referred to as DATABASE.

The Connection tab also includes a Test Connection button that can be used to test the connection parameters. The connection can only be tested after all of the required parameters are entered. When you click this button, a session is established to the remote DB2 system using OLE DB Provider for DB2.

The All tab allows the user to configure additional properties used to connect to a data source. Some of the properties in the All tab are required. These properties may be edited by selecting a property from the displayed list and selecting Edit Value. For OLE DB Provider for DB2, these properties include the following values:

- **Alternate TP Name:** This property is only required when connecting to SQL/DS (DB2/VM or DB2/VSE), and is referred to as the remote transaction program.

- **APPC Local LU Alias:** The name of the local LU alias configured in SNA Server.

- **APPC Mode Name:** The APPC mode that matches the host configuration and SNA Server configuration. Legal values for the APPC mode include QPCSUPP (common system default), #INTER (interactive), #INTERSC (interactive with minimal routing security), #BATCH (batch), #BATCHSC (batch with minimal routing security), and #IBMRDB (DB2 remote database access).

- **APPC Remote LU Alias:** The name of the remote LU alias configured in SNA Server.

- **Auto Commit Mode:** This property allows for implicit `COMMIT` on all SQL statements. In Auto Commit Mode, every database operation is a transaction that is committed when performed. This mode is suitable for common transactions that consist of a single SQL statement. It is unnecessary to delimit or specify completion of these transactions. No ROLLBACK is allowed when using Auto Commit Mode. The default is **True**.

- **Cache Authentication:** The provider's data source object or enumerator is allowed to cache sensitive authentication information such as a password in an internal cache. The default is False.

- **Default Isolation Level:** This determines the level of isolation used in cases of simultaneous access to DB2 objects by multiple applications. The default is NC. The following levels are supported:

    ```console
    CS      Cursor Stability.  
            In DB2/400, this corresponds to COMMIT(*CS).  
            In ANSI, this corresponds to Read Committed (RC).  

    NC      No Commit.
            In DB2/400, this corresponds to COMMIT(*NONE).
            In ANSI, this corresponds to No Commit (NC).

    UR      Uncommitted Read.
            In DB2/400, this corresponds to COMMIT(*CHG).
            In ANSI, this corresponds to Read Uncommitted.

    RS      Read Stability.
            In DB2/400, this corresponds to COMMIT(*ALL).
            In ANSI, this corresponds to Repeatable Read.

    RR      Repeatable Read.
            In DB2/400, this corresponds to COMMIT(*RR).
            In ANSI, this corresponds to Serializable (Isolated).
    ```

- **Default Schema:** The name of the collection where the provider looks for catalog information. The OLE DB provider uses Default Schema to restrict results sets for popular operations, such as enumerating a list of tables in a target collection (for example, OLE DB `IDBSchemaRowset` `DBSCHEMA_TABLES`). Additionally, the OLE DB provider uses Default Schema to build a SQL `SELECT` statement for `IOpenRowset::OpenRowset` requests.

- **Extended Properties:** A method to specify additional provider-specific properties. Properties passed through this parameter should be delimited by semicolons and will be interpreted by the provider's underlying network client.

- **Host CCSID:** The character code set identifier (CCSID) matching the DB2 data as represented on the remote computer. This parameter defaults to U.S./Canada (37). The CCSID property is required when processing binary data as character data. Unless the **Process Binary as Character** value is set, character data is converted based on the DB2 column CCSID and default ANSI code page.

- **Network Address:** This property is used to locate the target DB2 computer, specifically the TCP/IP address or TCP/IP host name/alias associated with the DRDA port. The network address is required when connecting by means of TCP/IP.

- **Network Port:** This property is used to locate the target DB2 DRDA service access port when connecting by means of TCP/IP. The default is the well-known DRDA port address of 446.

- **Network Transport Library:** The network transport dynamic link library property designates whether the provider connects by means of SNA LU6.2 or TCP/IP. The default value is SNA. If TCP/IP is selected, then values for Network Address and Network Port are required. If the default SNA is selected, then values for APPC Local LU Alias, APPC Mode Name, and APPC Remote LU Alias are required.

- **Package Collection:** The name of the DRDA COLLECTION where you want the driver to store and bind DB2 packages. This could be same as the Default Schema.

- **PC Code Page:** This property is required when processing binary data as character data. Unless the **Process Binary as Character** value is set, character data is converted based on the default ANSI code page configured in Windows. The default value for this property is Latin 1 (1252).

- **Persist Security Info:** Optionally, you can choose to save the password in the UDL file by selecting the **Allow saving password** check box.

  > [!WARNING]
  > This option persists the authentication information in plain text within the UDL file.

- **Process Binary as Character:** This option treats binary (CCSID 65535) data type fields as character data type fields on a per-data source basis. The Host CCSID and PC Code Page values are required input and output parameters.

- **Read Only:** Creates a read-only data source. The user has read-only access to objects, such as tables, and cannot do update operations, such as `INSERT`, `UPDATE`, or `DELETE`.
