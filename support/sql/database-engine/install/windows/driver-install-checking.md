---
title: Database driver installation check
description: This article provides steps users can take to troubleshoot common driver installation issues on Windows.
ms.date: 12/20/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: mastewa, jopilov, prmadhes, v-sidong
---
# Database driver installation check

Drivers play a crucial role in facilitating communication between hardware and software on a computer system. Specifically, a database driver facilitates communication between a client database application and a database server locally or across a network. When encountering database driver installation issues, it's essential to follow specific steps to identify and potentially resolve these problems. While the responsibility lies primarily with the driver vendor, there are steps users can take to troubleshoot common driver installation issues on Windows.

## Driver installation verification

Database drivers are physically represented as [DLLs](/troubleshoot/windows-client/deployment/dynamic-link-library) files in Windows. Applications need to know how to find the appropriate DLL and load it into the process space. Both [ODBC](/sql/odbc/reference/odbc-overview) and [OLE DB](/cpp/data/oledb/ole-db-programming-overview) use the Windows registry to locate the driver or provider to load into memory. The process of loading drivers into memory varies depending on the type of drivers and the operating system being used.

- In Windows, drivers are loaded into memory via the [Load Library Win32 API](/windows/win32/api/libloaderapi/nf-libloaderapi-loadlibrarya). Once the driver has loaded into memory, the ODBC Driver Manager proxies the calls between the application and the driver. This proxy functionality allows the tracing functionality. However, for performance and other reasons, this trace isn't recommended.

- For OLE DB, it's loaded via COM APIs, such as [CoCreateInstance](/windows/win32/api/combaseapi/nf-combaseapi-cocreateinstance) (C++) or [CreateObject](/office/vba/language/reference/user-interface-help/createobject-function) (VBA/VBScript).

- For .NET providers, the DLLs are typically loaded from the [Global Assembly Cache](/dotnet/framework/app-domains/gac) or the application directory, according to .NET search rules. The registry isn't used.

- There are also .NET providers for ODBC drivers and OLE DB providers. Once the .NET provider DLLs are loaded, they follow the ODBC or OLE DB rules to load the actual driver or provider DLLs.

[Process Monitor (Procmon)](/sysinternals/downloads/procmon) can be used to trace the installation or load and may indicate if any DLLs or registry keys are missing or have permission issues.

> [!NOTE]
> When tracing 32-bit applications, references to *c:\windows\system32* are automatically redirected to *c:\windows\syswow64*. It's similar to registry access.

Driver manufacturers may also install a client application together with their driver, for example, SQL*Plus for Oracle. If that client application can't connect to the respective database server, the driver should be reinstalled, and the software vendor should be engaged.

> [!NOTE]
> In most cases, driver installation issues are generally the vendor's responsibility.

Ensuring the proper installation of drivers is critical for seamless connectivity and functionality within various software ecosystems. The trio of ODBC, OLE DB, and .NET drivers form the backbone of data access and interaction across diverse applications and platforms. Verifying the installation status of these drivers guarantees robust connectivity and optimal performance, enabling smooth data operations and enhanced functionality.

Let's delve into the methods to efficiently check the installation status of these drivers to ensure their readiness for data handling and exchange.

- [ODBC driver installation check](odbc-driver-install-checking.md)
- [OLE DB driver installation check](oledb-driver-install-check.md)
- [.NET data provider installation check](net-driver-install-check.md)

## Installation support for various database drivers and providers

When it comes to navigating the vast landscape of drivers and providers, understanding their support structure is crucial for seamless operations and troubleshooting. Here's an overview of the support mechanisms for different third-party drivers and providers:

- Non-Microsoft drivers and providers are ultimately supported by the software vendor who developed them.
- For drivers and providers that come preinstalled with Windows, such as SQL Server, Microsoft ODBC for Oracle, and Access (and its IISAM drivers, Text, Paradox, dBase, Excel, and so on), generally, you must repair or reinstall Windows. The [Microsoft Windows support team](https://support.microsoft.com/contactus#!) can assist. These drivers shouldn't be used for new application development.
- For the ACE provider and the ODBC drivers that derive from it, such as the Excel ODBC driver, the [Access or Office team](https://support.microsoft.com/contactus#!) can provide support.
- For the Microsoft DB/2 drivers and providers, the Host Integration Services team supports them.
- For the Active Directory provider, the Active Directory team can provide support.
- For the Exchange provider, the Exchange team can provide support.
- For the installable Microsoft SQL Server drivers and providers, the SQL Networking team supports them.
- For sample connection strings for testing, see [The Connection Strings Reference](https://www.connectionstrings.com/). (This is a non-Microsoft site.)

## More information

- [ODBC driver installation check](odbc-driver-install-checking.md)
- [OLE DB driver installation check](oledb-driver-install-check.md)
- [.NET data provider installation check](net-driver-install-check.md)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
