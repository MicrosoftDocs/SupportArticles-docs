---
title: How to configure a domain suffix search list on the Domain Name System clients
description: Describes how to automate the process of configuring the domain suffix search list on your Domain Name System (DNS) clients.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, drewba
ms.custom: sap:dns, csstroubleshoot
---
# How to configure a domain suffix search list on the Domain Name System clients

This article describes how to automate the process of configuring the domain suffix search list on your Domain Name System (DNS) clients.

> [!Note]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 275553

## Summary

This article does not describe when it is necessary to configure the domain suffix search list on a client. This article only describes how to distribute a large-scale domain suffix search list.

## More Information

The typical name resolution process for Microsoft Windows 2000 uses the primary DNS suffix and any connection-specific DNS suffixes. If these suffixes do not work, the devolution of the primary DNS suffix is attempted by the name resolution process.

When a domain suffix search list is configured on a client, only that list is used. The primary DNS suffix and any connection-specific DNS suffixes are not used, nor is the devolution of the primary suffix attempted. The domain suffix search list is an administrative override of all standard Domain Name Resolver (DNR) look-up mechanisms.

For more information about how DNS suffixes are used, go to Windows 2000 Help and view the Configuring Client Settings topic (located in the Networking/DNS/Concepts/Using DNS/Managing Clients/ folder).

### Pushing the domain suffix search list to DNS clients

The following methods of distribution are available for pushing the domain suffix search list to DNS clients:

- Regini.exe. The Regini.exe tool from the Microsoft Windows 2000 Resource Kit can be used to place the domain suffix search list setting into the registry. A sample Regini script is provided in the "Sample Regini Script" section of this article.
- Unattended installation. You can populate the domain suffix search list settings during an unattended installation.

The following methods of distribution are not available for pushing the domain suffix search list to DNS clients:

- Dynamic Host Configuration Protocol (DHCP). You cannot configure DHCP to send out a domain suffix search list. This is currently not supported by the Microsoft DHCP server.
- Netsh (Netshell). The Netsh utility has no command to set or to change the domain suffix search list.
- Group Policy. In Windows 2000, Group Policy has no mechanism for distributing the domain suffix search list. However, Windows Server 2003 includes this feature.
- Microsoft Visual Basic Scripting Edition (VBScript). No application programming interfaces (APIs) are available that enable you to script a change to the domain suffix search list.

### Sample Regini script

Create a text file with the following two lines of text and save it as the Suffix.txt file. The following spacing must be exactly as shown, where `adatum.xxx` signifies a domain suffix. Up to six domain suffixes may be specified. The search order is left to right.

`\Registry\Machine\System\CurrentControlSet\Services\TCPIP\Parameters`  
`SearchList="testadatum.com,test2adatum.net,test3adatum.gov"`

Copy the Regini.exe and Suffix.txt files to the preceding location and run the regini.exe suffix.txt command.

When the script has updated the registry, you must restart the computer for the settings to be updated.

To run the script, you must have administrator or system-level access to the computer.

> [!NOTE]
> Another method is to use Microsoft Windows Script Host:
>
> 1. Create a file with the .vbs extension (for example, C:\\add.vbs).
> 2. Add the following two lines to the file:
>
>    ```vbscript
>    SET WSHShell = CreateObject("WScript.Shell")
>    WSHShell.RegWrite "HKLM\System\CurrentControlSet\Services\TCPIP\Parameters\SearchList", "testadatum.com,test2adatum.net,test3adatum.gov", "REG_SZ"
>    ```
>
>    (the second line starts with "WSHShell.RegWrite" and ends with "REG_SZ")
> 3. Double-click the file to run or at a command prompt, type *C:\\add.vbs*
