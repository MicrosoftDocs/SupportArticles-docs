---
title: TLS 1.2 support for Microsoft SQL Server
description: This article provides information about the updates that Microsoft releases to enable TLS 1.2 support for SQL Server.
ms.date: 10/18/2023
ms.custom: sap:Connection issues
author: PiJoCoder 
ms.author: jopilov
ms.reviewer: v-sidong
---
# TLS 1.2 support for Microsoft SQL Server

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3135244

## Introduction

This article provides information about the updates that Microsoft releases to enable TLS 1.2 support for SQL Server 2017 on Windows, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008, and SQL Server 2008 R2. This article also lists supported client providers. SQL Server 2016, SQL Server 2017, and SQL Server 2019 support TLS 1.2 without the need for an update.

Several known vulnerabilities have been reported against Secure Sockets Layer (SSL) and earlier versions of Transport Layer Security (TLS). We recommend that you upgrade to TLS 1.2 for secure communication.

> [!IMPORTANT]
> No known vulnerabilities have been reported for the Microsoft TDS implementation. This is the communication protocol that's used between SQL Server clients and the SQL Server database engine. The Microsoft Schannel implementation of TLS 1.0 (regarding the known vulnerabilities that have been reported to Microsoft as of the publication date of this article) is summarized in the Schannel implementation of TLS 1.0 in Windows security status update: November 24, 2015.

## How to know whether you need this update

Use the following table to determine whether your current version of SQL Server already supports TLS 1.2 or whether you have to download an update to enable TLS 1.2 support. Use the download links in the table to obtain the server updates that are applicable to your environment.

> [!NOTE]
> Builds that are later than those listed in this table also support TLS 1.2.

|SQL Server release  |Initial build/release that supported TLS 1.2  |Current updates with TLS 1.2 support  |Additional information  |
|---------|---------|---------|---------|
|SQL Server 2014 SP1 CU     |     12.0.4439.1 <br><br> SP1 CU5    |   [KB3130926 - Cumulative Update 5 for SQL Server 2014 SP1](https://support.microsoft.com/topic/kb3130926-cumulative-update-5-for-sql-server-2014-service-pack-1-de2cd166-32aa-f502-6efc-0499e63c1be9)  <br><br> **Note**: [KB3130926](https://support.microsoft.com/topic/kb4019099-cumulative-update-13-for-sql-server-2014-sp1-d1f0ffa9-f97e-11ce-eeb1-3def6f11b909) will now install the last CU produced for 2014 SP1 (CU13 - KB4019099), which includes TLS 1.2 support and all hotfixes released to date. If needed, CU5 is available in the [Windows Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=SQL%20Server%202014).  <br><br>**Note**: TLS 1.2 support is also available in [2014 SP2](https://support.microsoft.com/topic/kb3171021-sql-server-2014-service-pack-2-release-information-8383b699-2b34-9960-0f15-6356b1b9667c) and [2014 SP3](https://support.microsoft.com/topic/kb4022619-sql-server-2014-service-pack-3-release-information-64f341d3-2b74-0d86-e857-b9fd0775e493).  |     [KB3052404 -  FIX: You cannot use the Transport Layer Security protocol version 1.2 to connect to a server that is running SQL Server 2014 or SQL Server 2012](https://support.microsoft.com/topic/kb3052404-fix-you-cannot-use-the-transport-layer-security-protocol-version-1-2-to-connect-to-a-server-that-is-running-sql-server-2014-or-sql-server-2012-b6cbf004-bdaf-bff6-beb9-c23dfb17f33f)|
|SQL Server 2014 SP1 GDR   |    12.0.4219.0 <br><br> SP1 GDR TLS 1.2 Update|       TLS 1.2 support for 2014 SP1 GDR is available in the latest cumulative GDR update- [KB4019091](https://support.microsoft.com/topic/kb4019091-description-of-the-security-update-for-sql-server-2014-service-pack-1-gdr-august-8-2017-fa35160c-8344-4786-7f5d-7f9192aaf07a).  <br><br>**Note**: TLS 1.2 support is also available in [2014 SP2](https://support.microsoft.com/topic/kb3171021-sql-server-2014-service-pack-2-release-information-8383b699-2b34-9960-0f15-6356b1b9667c) and [2014 SP3](https://support.microsoft.com/topic/kb4022619-sql-server-2014-service-pack-3-release-information-64f341d3-2b74-0d86-e857-b9fd0775e493).|         |
|SQL Server 2014 RTM CU     |   12.0.2564.0  <br><br> RTM CU12   | [KB3130923 - Cumulative Update 12 for SQL Server 2014](https://support.microsoft.com/topic/kb3130923-cumulative-update-12-for-sql-server-2014-0f47a5d3-4a6f-f8d5-8eb7-dbbe75d67380)<br><br> **Note**: KB3130923 will now install the last CU released for 2014 RTM (CU14 - [KB3158271](https://support.microsoft.com/topic/kb3158271-cumulative-update-14-for-sql-server-2014-41cb8d78-8734-6a94-b6f4-cc9065d86e3d) ), which includes TLS 1.2 support and all hotfixes released to date. If needed, CU12 is available in [Windows Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=SQL%20Server%202014).   <br><br>**Note**: TLS 1.2 support is also available in [2014 SP2](https://support.microsoft.com/topic/kb3171021-sql-server-2014-service-pack-2-release-information-8383b699-2b34-9960-0f15-6356b1b9667c) and [2014 SP3](https://support.microsoft.com/topic/kb4022619-sql-server-2014-service-pack-3-release-information-64f341d3-2b74-0d86-e857-b9fd0775e493).   |   [KB3052404 - FIX: You cannot use the Transport Layer Security protocol version 1.2 to connect to a server that is running SQL Server 2014 or SQL Server 2012](https://support.microsoft.com/topic/kb3052404-fix-you-cannot-use-the-transport-layer-security-protocol-version-1-2-to-connect-to-a-server-that-is-running-sql-server-2014-or-sql-server-2012-b6cbf004-bdaf-bff6-beb9-c23dfb17f33f) |
|SQL Server 2014 RTM GDR     |   12.0.2271.0  <br><br> RTM GDR TLS 1.2 Update    |    TLS Support for SQL 2014 RTM is currently only available by installing [2014 SP2](https://support.microsoft.com/topic/kb3171021-sql-server-2014-service-pack-2-release-information-8383b699-2b34-9960-0f15-6356b1b9667c) and [2014 SP3](https://support.microsoft.com/topic/kb4022619-sql-server-2014-service-pack-3-release-information-64f341d3-2b74-0d86-e857-b9fd0775e493).     |         |
|SQL Server 2012 SP3 GDR     |    11.0.6216.27  <br><br> SP3 GDR TLS 1.2 Update  |     [Description of the security update for SQL Server 2012 SP3 GDR: January 16, 2018](https://support.microsoft.com/topic/description-of-the-security-update-for-sql-server-2012-sp3-gdr-january-16-2018-665440fa-611e-ec02-f795-52b9732f2744)  <br><br> **Note**: TLS 1.2 support is also available in [2012 SP4](https://support.microsoft.com/topic/kb4018073-sql-server-2012-service-pack-4-release-information-69857d74-5457-74df-33f1-956cac4d0b62). |         |
|SQL Server 2012 SP3 CU     |    11.0.6518.0  <br><br> SP1 CU3  |   [KB3123299 - Cumulative Update 1 for SQL Server 2012 SP3](https://support.microsoft.com/topic/kb3123299-cumulative-update-package-1-for-sql-server-2012-sp3-646954b6-66f9-6d1f-b065-ef15edbcf431)  <br><br> **Note**: KB3123299 will now install the last CU released for 2012 SP3 (CU10 - [KB4025925](https://support.microsoft.com/topic/kb4025925-cumulative-update-10-for-sql-server-2012-sp3-f1208a25-0730-3eed-7b32-fbfcc65cd92e), which includes TLS 1.2 support and all hotfixes released to date). If needed, CU1 is available in [Windows Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=SQL%20Server%202014). <br><br>  **Note**: TLS 1.2 support is also available in [2012 SP4](https://support.microsoft.com/topic/kb4018073-sql-server-2012-service-pack-4-release-information-69857d74-5457-74df-33f1-956cac4d0b62). |     [KB3052404  - FIX: You cannot use the Transport Layer Security protocol version 1.2 to connect to a server that is running SQL Server 2014 or SQL Server 2012](https://support.microsoft.com/topic/kb3052404-fix-you-cannot-use-the-transport-layer-security-protocol-version-1-2-to-connect-to-a-server-that-is-running-sql-server-2014-or-sql-server-2012-b6cbf004-bdaf-bff6-beb9-c23dfb17f33f) |
|SQL Server 2012 SP2 GDR     |    11.0.5352.0  <br><br> SP2 GDR TLS 1.2 Update   |    TLS 1.2 support for 2012 SP2 GDR is available in the latest cumulative GDR update - [KB3194719](https://support.microsoft.com/topic/kb3194719-ms16-136-description-of-the-security-update-for-sql-server-2012-service-pack-2-gdr-november-8-2016-ed0cf43e-ce2b-f752-9e37-080fe236f020).  <br><br> TLS 1.2 support is also available in [2012 SP3](https://support.microsoft.com/topic/kb3072779-sql-server-2012-service-pack-3-release-information-f29a80da-8288-5dac-3f57-db65901a1d3b) and [2012 SP4](https://support.microsoft.com/topic/kb3072779-sql-server-2012-service-pack-3-release-information-f29a80da-8288-5dac-3f57-db65901a1d3b).   |         |
|SQL Server 2012 SP2 CU     |   11.0.5644.2 <br><br>  SP2 CU10   |    [KB3120313 - Cumulative Update 10 for SQL Server 2012 SP2](https://support.microsoft.com/topic/kb3120313-cumulative-update-package-10-for-sql-server-2012-sp2-98d38302-ab7e-b0f6-dbef-91bd0eb6cbe5). <br><br> **Note**: KB3120313 will now install the last CU released for 2012 SP2 ([CU16 - KB3205054](https://support.microsoft.com/topic/kb3205054-cumulative-update-16-for-sql-server-2012-sp2-ea2f70ef-a59d-da1f-63c7-620403213193), which includes TLS 1.2 support and all hotfixes released to date). If needed, CU1 is available in [Windows Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=SQL%20Server%202014).  **Note**: TLS 1.2 support is also available in [2012 SP3](https://support.microsoft.com/topic/kb3072779-sql-server-2012-service-pack-3-release-information-f29a80da-8288-5dac-3f57-db65901a1d3b) and [2012 SP4](https://support.microsoft.com/topic/kb4018073-sql-server-2012-service-pack-4-release-information-69857d74-5457-74df-33f1-956cac4d0b62).|  [KB3052404  - FIX: You cannot use the Transport Layer Security protocol version 1.2 to connect to a server that is running SQL Server 2014 or SQL Server 2012](https://support.microsoft.com/topic/kb3052404-fix-you-cannot-use-the-transport-layer-security-protocol-version-1-2-to-connect-to-a-server-that-is-running-sql-server-2014-or-sql-server-2012-b6cbf004-bdaf-bff6-beb9-c23dfb17f33f) |
|SQL Server 2008 R2 SP3 (x86/x64 only)     |    10.50.6542.0 <br><br> SP2 TLS 1.2 Update   |      TLS 1.2 support is available in the latest cumulative update for SQL Server 2008 R2 SP3 - [KB4057113](https://support.microsoft.com/topic/description-of-the-security-update-for-sql-server-2008-r2-sp3-gdr-january-6-2018-f8290bc2-5abe-934c-4672-c454db0b73f6).   |         |
|SQL Server 2008 R2 SP2 GDR (IA-64 only)     |   10.50.4047.0  <br><br> SP2 TLS 1.2 Update   |    [SQL Server 2008 R2 SP2 GDR (IA-64) TLS 1.2 Updates](https://www.microsoft.com/download/details.aspx?id=57605)     |         |
|SQL Server 2008 R2 SP2 CU (IA-64 only)     |  10.50.4344.0  <br><br>   SP2 TLS 1.2 Update   |  [SQL Server 2008 R2 SP2 GDR (IA-64) TLS 1.2 Updates](https://www.microsoft.com/download/details.aspx?id=57605)       |         |
|SQL Server 2008 SP4 (x86/x64 only)     |  10.0.6547.0 <br><br>  SP4 TLS 1.2 Update     |    TLS 1.2 support is available in the latest cumulative update for SQL Server 2008 SP4 - [KB4057114](https://support.microsoft.com/topic/description-of-the-security-update-for-sql-server-2008-sp4-gdr-january-6-2018-32b923c1-7af9-5c4b-5b3d-3522cab972fe)(x86/x64 only).     |         |
|SQL Server 2008 SP3 GDR (IA-64 only)   |  10.0.5545.0  <br><br>  SP3 TLS 1.2 Update   |    [SQL Server 2008 SP3 GDR (IA-64) TLS 1.2 Updates](https://www.microsoft.com/download/details.aspx?id=57605)     |         |
|SQL Server 2008 SP3 CU (IA-64 only)     | 10.0.5896.0   <br><br>  SP3 TLS 1.2 Update   |   [SQL Server 2008 SP3 CU (IA-64) TLS 1.2 Updates](https://www.microsoft.com/download/details.aspx?id=57605)      |         |

### Client component downloads

Use the following table to download the client components and driver updates that are applicable to your environment.

|Client component/driver  |Updates with TLS 1.2 support  |
|---------|---------|
|SQL Server Native Client 10.0 for SQL Server 2008/2008 R2 (x86/x64/IA64)     |    [Microsoft SQL Server 2008 and SQL Server 2008 R2 Native Client](https://www.microsoft.com/download/details.aspx?id=57606)     |
|SQL Server Native Client 11.0 for SQL Server 2012/2014 (x86/x64)     |    [Microsoft SQL Server 2012 Native Client - QFE](https://www.microsoft.com/download/details.aspx?id=50402)     |
|MDAC Client components (Sqlsrv32.dll and Sqloledb.dll)  | [Servicing stack update for Windows 10, version 1809: November 10, 2020](https://support.microsoft.com/en-us/topic/servicing-stack-update-for-windows-10-version-1809-november-10-2020-c7a4dc25-458f-b068-025b-b5d05fabee47) |

## Additional fixes needed for SQL Server to use TLS 1.2

You have to install the following .NET hotfix rollups to enable SQL Server features like Database Mail and certain SSIS components that use .NET endpoints that require TLS 1.2 support like the Web Service task to use TLS 1.2.

|Operating System  |.NET Framework version  |Updates with TLS 1.2 support  |
|---------|---------|---------|
|Windows 7 Service Pack 1, Windows 2008 R2 Service Pack 1     |     3.5.1    |   [Support for TLS v1.2 included in the .NET Framework version 3.5.1](https://support.microsoft.com/topic/support-for-tls-system-default-versions-included-in-the-net-framework-3-5-1-on-windows-7-sp1-and-server-2008-r2-sp1-5ef38dda-8e6c-65dc-c395-62d2df58715a)      |
|Windows 8 RTM, Windows 2012 RTM     |    3.5     |   [Support for TLS v1.2 included in the .NET Framework version 3.5](https://support.microsoft.com/topic/support-for-tls-system-default-versions-included-in-the-net-framework-3-5-on-windows-server-2012-db7ff0cb-fc9e-6530-db50-6a3dfc2834ad)      |
|Windows 8.1, Windows 2012 R2 SP1     |    3.5 SP1     |     [Support for TLS v1.2 included in the .NET Framework version 3.5 SP1 on Windows 8.1 and Windows Server 2012 R2](https://support.microsoft.com/topic/support-for-tls-system-default-versions-included-in-the-net-framework-3-5-on-windows-8-1-and-windows-server-2012-r2-499ff5ef-a88a-128b-c639-ed038b7d2d5f)    |

## Frequently asked questions

- **Is TLS 1.1 supported on SQL Server 2016 and later versions?**

    Yes. SQL Server 2016, SQL Server 2017 on Windows, and SQL Server 2019 on Windows versions ship with TLS 1.0 to TLS 1.2 support. You have to disable TLS 1.0 and 1.1 if you want to use only TLS 1.2 for client-server communication.

- **Does SQL Server 2019 allow connections using TLS 1.0 or 1.1, or only 1.2?**

    SQL Server 2019 has the same level of support as SQL Server 2016 and SQL Server 2017, and SQL Server 2019 supports older versions of TLS. SQL Server 2019 RTM is shipped with TLS 1.2 support, and no other update or fix is required to enable TLS 1.2 support.

- **Is TDS affected by known vulnerabilities?**

    No known vulnerabilities have been reported for the Microsoft TDS implementation. Because several standards-enforcement organizations are mandating the use of TLS 1.2 for encrypted communication channels, Microsoft is releasing support for TLS 1.2 for the widespread SQL Server installation base.

- **How will the TLS 1.2 updates be distributed to customers?**

    This article provides download links for the appropriate server and client updates that support TLS 1.2.

- **Does TLS 1.2 support SQL Server 2005?**

    TLS 1.2 support is offered only for SQL Server 2008 and later versions.

- **Are customers who aren't using SSL/TLS affected if SSL 3.0 and TLS 1.0 are disabled on the server?**

    Yes. SQL Server encrypts the username and password during login even if a secure communication channel isn't used. This update is required for all SQL Server instances that don't use secure communications and that have all other protocols except TLS 1.2 disabled on the server.

- **Which versions of Windows Server support TLS 1.2?**

    Windows Server 2008 R2 and later versions support TLS 1.2.

    What's the correct registry setting to enable TLS 1.2 for SQL Server communication? The correct registry settings are as follows:

    - `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`
    - `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`
    - `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

    These settings are required for both server and client computers. The `DisabledByDefault` and `Enabled` settings are required to be created on Windows 7 clients and Windows Server 2008 R2 servers. On Windows 8 and later versions of the client operating systems or Windows Server 2012 server and later versions of the server operating systems, TLS 1.2 should already be enabled. If you're implementing a deployment policy for Windows Registry that needs to be independent of the OS release, then we recommend adding the mentioned registry keys to the policy.

## Known issues

- Issue 1

    SQL Server Management Studio (SSMS), Report Server, and Report Manager don't connect to the database engine after you apply the fix for SQL Server 2008, 2008 R2, 2012, or 2014. Report Server and Report Manager fail and return the following error message:

    > The report server cannot open a connection to the report server database. A connection to the database is required for all requests and processing. (rsReportServerDatabaseUnavailable)

    This issue occurs because SSMS, Report Manager, and Reporting Services Configuration Manager use ADO.NET, and ADO.NET support for TLS 1.2 is available only in the .NET Framework 4.6. For earlier versions of the .NET Framework, you have to apply a Windows update so that ADO.NET can support TLS 1.2 communications for the client. The Windows updates that enable TLS 1.2 support in earlier versions of the .NET framework are listed in the table in the [How to know whether you need this update](#how-to-know-whether-you-need-this-update) section.

- Issue 2

    Reporting Services Configuration Manager reports the following error message even after client providers have been updated to a version that supports TLS 1.2:

    > Could not connect to server: A connection was successfully established to the server, but then an error occurred during the pre-login handshake.

    :::image type="content" source="media/tls-1-2-support-microsoft-sql-server/test-connection-error.png" alt-text="Screenshot of a test connection error after client providers have been updated to a version that supports TLS 1.2.":::

    To resolve this problem, manually create the following registry key on the system that hosts the Reporting Services Configuration Manager:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client: "Enabled"=dword:00000001`

- Issue 3

    The encrypted endpoint communication that uses TLS 1.2 fails when you use encrypted communications for Availability Groups, Database Mirroring, or Service Broker in SQL Server. An error message that resembles the following is logged in the SQL error log:

    ```output
    Connection handshake failed. An OS call failed: (80090331) 0x80090331(The client and server cannot communicate, because they do not possess a common algorithm.). State 56.
    ```

    For more information about this issue, see [FIX: The encrypted endpoint communication with TLS 1.2 fails when you use SQL Server](https://support.microsoft.com/topic/kb3135852-fix-the-encrypted-endpoint-communication-with-tls-1-2-fails-when-you-use-sql-server-b9945053-3c10-fd5b-8fd6-e08909dd1361).

- Issue 4

    Various errors occur when you try to install SQL Server 2012 or SQL Server 2014 on a server that has TLS 1.2 enabled.

    For more information, see [FIX: Error when you install SQL Server 2012 or SQL Server 2014 on a server that has TLS 1.2 enabled.](https://support.microsoft.com/topic/kb3135769-fix-error-when-you-install-sql-server-2012-or-sql-server-2014-on-a-server-that-has-tls-1-2-enabled-3244c3e9-eb49-9964-ca6b-889e9fc1bad2)

- Issue 5

    An encrypted connection with Database Mirroring or Availability Groups doesn't work when you use a certificate after you disable all other protocols other than TLS 1.2. An error message that resembles the following is logged in the SQL Server error log:

    An encrypted connection with Database Mirroring or Availability Groups doesn't work when you use a certificate after you disable all other protocols other than TLS 1.2. You might notice one of the following symptoms:

    - Symptom 1:

        An error message that resembles the following is logged in the SQL Server error log:

        ```output
        Connection handshake failed. An OS call failed: (80090331) 0x80090331(The client and server cannot communicate, because they do not possess a common algorithm.). State 58.'
        ```

    - Symptom 2:

        An error message that resembles the following is logged in the Windows event log:

        ```output
        Log Name:      System
        Source:        Schannel
        Date:          <Date Time>
        Event ID:      36888
        Task Category: None
        Level:         Error
        Keywords:     
        User:          SYSTEM
        Computer:      ------------
        Description:
        A fatal alert was generated and sent to the remote endpoint. This may result in termination of the connection. The TLS protocol defined fatal error code is 40. The Windows SChannel error state is 1205.
        
        Log Name:      System
        Source:        Schannel
        Date:          <Date Time>
        Event ID:      36874
        Task Category: None
        Level:         Error
        Keywords:     
        User:          SYSTEM
        Computer:      -----------
        Description:
        An TLS 1.2 connection request was received from a remote client application, but none of the cipher suites supported by the client application are supported by the server. The SSL connection request has failed.
        ```

        This issue occurs because Availability Groups and Database Mirroring require a certificate that doesn't use fixed length hash algorithms, such as MD5. Fixed length hashing algorithms aren't supported in TLS 1.2.

    For more information, see [FIX: Communication using MD5 hash algorithm fails if SQL Server uses TLS 1.2](https://support.microsoft.com/topic/fix-communication-that-uses-an-md5-hash-algorithm-fails-when-you-use-tls-1-2-in-sql-server-de67b04f-4f95-bcbb-24a7-575a91af0eb7).

- Issue 6

    The following SQL Server database engine versions are affected by the intermittent service termination issue that's reported in Knowledge Base article [3146034](https://support.microsoft.com/topic/intermittent-service-terminations-occur-after-you-install-any-sql-server-2008-or-sql-server-2008-r2-versions-from-kb3135244-93d04055-1365-9e41-c396-bb72c438c9ff). For customers to protect themselves from the service termination issue, we recommend that they install the TLS 1.2 updates for SQL Server that're mentioned in this article if their SQL Server version is listed in the following table:

    |SQL Server release  |Affected version  |
    |---------|---------|
    |SQL Server 2008 R2 SP3 (x86 and x64)     | 10.50.6537.0     |
    |SQL Server 2008 R2 SP2 GDR (IA-64 only)  | 10.50.4046.0     |
    |SQL Server 2008 R2 SP2 (IA-64 only)      | 10.50.4343.0     |
    |SQL Server 2008 SP4 (x86 and x64)        | 10.0.6543.0      |
    |SQL Server 2008 SP3 GDR (IA-64 only)     | 10.0.5544.0      |
    |SQL Server 2008 SP3 (IA-64 only)         | 10.0.5894.0      |

- Issue 7

    Database Mail doesn't work with TLS 1.2. Database Mail fails with the following error:

    > Microsoft.SqlServer.Management.SqlIMail.Server.Common.BaseException:
Mail configuration information could not be read from the database. Unable to start mail session.

    For more information, see [Additional fixes needed for SQL Server to use TLS 1](#additional-fixes-needed-for-sql-server-to-use-tls-12).

### Common errors that you might experience when TLS 1.2 updates are missing on the client or server

Issue 1

System Center Configuration Manager (SCCM) can't connect to SQL Server after the TLS 1.2 protocol is enabled on SQL Server. In this situation, you receive the following error message:

> TCP Provider: An existing connection was forcibly closed by the remote host

This issue might occur when SCCM uses a SQL Server Native Client driver that doesn't have a fix. To resolve this issue, download and install the Native client fix that's listed in the [Client component downloads](#client-component-downloads) section. For example, [Microsoft® SQL Server® 2012 Native Client - QFE](https://www.microsoft.com/download/details.aspx?id=50402).

You can find out which driver SCCM is using to connect to SQL Server by viewing the SCCM log, as shown in the following example:

```output
[SQL Server Native Client 11.0]TCP Provider: An existing connection was forcibly closed by the remote host.~~  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>
 *** [08001][10054][Microsoft][SQL Server Native Client 11.0]Client unable to establish connection  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>
 *** Failed to connect to the SQL Server, connection type: SMS ACCESS.  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>
 INFO: SQL Connection failed. Connection: SMS ACCESS, Type: Secure  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>Native Client 11.0]TCP Provider: An existing connection was forcibly closed by the remote host.~~  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>
 *** [08001][10054][Microsoft][SQL Server Native Client 11.0]Client unable to establish connection  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>
 *** Failed to connect to the SQL Server, connection type: SMS ACCESS.  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>
 INFO: SQL Connection failed. Connection: SMS ACCESS, Type: Secure  $$<Configuration Manager Setup><08-22-2016 04:15:01.917+420><thread=2868 (0xB34)>
```
