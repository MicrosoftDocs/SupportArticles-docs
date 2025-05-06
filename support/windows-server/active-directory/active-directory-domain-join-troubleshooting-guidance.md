---
title: Active Directory domain join troubleshooting guidance
description: Provides guidance to troubleshoot domain join issues.
ms.date: 05/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Active Directory domain join troubleshooting guidance

This guide provides the fundamental concepts used when troubleshooting Active Directory domain join issues.

## Troubleshooting checklist

- Domain Name System (DNS): Anytime you have an issue joining a domain, one of the first things to check is DNS. DNS is the heart of Active Directory (AD) and makes things work correctly, including domain join. Make sure of the following items:

  - DNS server addresses are correct.
  - DNS suffix search order is correct if multiple DNS domains are in play.
  - There are no stale or duplicate DNS records referencing the same computer account.
  - Reverse DNS doesn't point to a different name as the A record.
  - The domain name, domain controllers (DCs), and DNS servers can be pinged.
  - Check for DNS record conflicts for the specific server.

- *Netsetup.log*: The *Netsetup.log* file is a valuable resource when you troubleshoot a domain join issue. The *netsetup.log* file is located at *C:\\Windows\\Debug\\netsetup.log*.
- Network trace: During an AD domain join, multiple types of traffic occur between the client and some DNS servers and then between the client and some DCs. If you see an error in any of the above traffic, follow the corresponding troubleshooting steps of that protocol or component to narrow it down. For more information, see [Using Netsh to Manage Traces](/windows/win32/ndf/using-netsh-to-manage-traces).
- Domain join hardening changes: Windows updates released on and after October 11, 2022, contain additional protections introduced by [CVE-2022-38042](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-38042). These protections intentionally prevent domain join operations from reusing an existing computer account in the target domain unless one of the following conditions exist:

  - The user attempting the operation is the creator of the existing account.
  - The computer was created by a member of domain administrators.

   For more information, see [KB5020276—Netjoin: Domain join hardening changes](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8).

### Port Requirements

The following table lists the ports required to be open between the client computer and the DC.

|Port|Protocol|Application protocol|System service name|
|---|---|---|---|
|53|TCP|DNS|DNS Server|
|53|UDP|DNS|DNS Server|
|389|UDP|DC Locator|LSASS|
|389|TCP|LDAP Server|LSASS|
|88|TCP|Kerberos|Kerberos Key Distribution Server|
|135|TCP|RPC|RPC Endpoint Mapper|
|445|TCP|SMB|LanmanServer|
|1024-65535|TCP|RPC|RPC Endpoint Mapper for DSCrackNames, SAMR and Netlogon calls between Client and Domain Controller|

## Common issues and solutions

|Domain join error code|Cause|Related article|
|---|---|---|
|0x569|This error occurs because the domain join user account lacks the **Access this computer from the network** user right at the domain controller (DC) servicing the domain join operation.|[Troubleshooting error code 0x569: The user has not been granted the requested logon type at this computer](error-0x569-not-granted-logon-type.md) |
|0x6BF or 0xC002001C|This error occurs when a network device (router, firewall, or virtual private network (VPN) device) rejects network packets between the client being joined and the domain controller (DC).|[Troubleshooting status code 0x6bf or 0xc002001c: The remote procedure call failed and did not execute](status-code-0x6bf-0xc002001c.md) |
|0x6D9|This error occurs when network connectivity is blocked between the joining client and the Domain Controller (DC).|[Troubleshooting error code 0x6D9 "There are no more endpoints available from the endpoint mapper"](./domain-join-error-0x6d9-there-are-no-more-endpoints-available-from-the-endpoint-mapper.md) |
|0xa8b|This error occurs when you join a workgroup computer to a domain.|[Troubleshooting error code 0xa8b: An attempt to resolve the DNS name of a DC in the domain being joined has failed](error-0xa8b-resolve-dns-fail.md) |
|0x40|The issue is related to getting Kerberos Tickets for a Server Message Block (SMB) session.|[Troubleshooting error code 0x40 "The specified network name is no longer available"](domain-join-error-0x40-the-specified-network-name-is-no-longer-available.md) |
|0x54b|This error occurs because the specified domain can't be contacted, pointing to issues locating domain controllers (DCs).|[Troubleshooting error code 0x54b](error-code-0x54b.md) |
|0x0000232A|This error indicates that the Domain Name System (DNS) name can't be resolved.|[Troubleshooting error code 0x0000232A](error-code-0x0000232a.md) |
|0x3a|This error occurs when the client computer lacks reliable network connectivity on Transmission Control Protocol (TCP) 389 port between the client computer and the domain controller (DC).|[Troubleshooting status code 0x3a: The specified server cannot perform the requested operation](status-code-0x3a-server-not-perform-operation.md) |
|0x216d|This error occurs when the user account has exceeded the limit of 10 computers that can be joined to the domain, or when a Group Policy restricts users from joining computers to the domain.|[Troubleshooting status code 0x216d: Your computer could not be joined to the domain](status-code-0x216d-not-joined-domain.md) |

### Other errors that occur when you join Windows-based computers to a domain

For more information, see:

- Troubleshoot [Networking error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#networking-error-messages-and-resolutions)
- Troubleshoot [Authentication error messages and resolutions](troubleshoot-errors-join-computer-to-domain.md#authentication-error-messages-and-resolutions)

## Data collections for domain join issues

To troubleshoot domain join issues, the following logs could help:

- Netsetup log  
  This log file contains most information about domain join activities. The file is located on the client machine at `%windir%\debug\netsetup.log`.  
  This log file is enabled by default. No need to explicitly enable it.

- Network trace  
  The network trace contains the communication between the client computer and relative servers, such as DNS servers and domain controllers over the network. It should be collected at the client computer. Multiple tools can collect network traces, such as Wireshark, netsh.exe which is included in all Windows editions.

You can collect each log separately. Alternatively, you can use some tools provided by Microsoft to collect them all together. To do so, follow the steps in the following sections.

### Collect manually

1. Download and install Wireshark on the client computer that is to join the AD domain.
2. Start the application with administrator privileges, and then start capturing.
3. Try to join the AD domain to reproduce the error. Record the error message.
4. Stop capturing in the app and save the network trace to a file.
5. Collect the netsetup.log file that is located at *%windir%\debug\netsetup.log*.

### Use Auth Scripts

Auth Scripts is a lightweight PowerShell script developed by Microsoft to ease log collection for troubleshooting authentication-related issues. To use it, follow these steps:

1. Download [Auth Scripts](https://aka.ms/authscripts) on the client computer. Extract the files to a folder.
2. Start a PowerShell window with administrator privileges. Switch to the folder containing those extracted files.
3. Run *start-auth.ps1*, accept the EULA if prompted, and allow execution if warned about an untrusted publisher.

   > [!NOTE]
   > If the scripts aren't allowed to run due to execution policies, see [about_Execution_Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies).

4. After the command completed successfully, try to join the AD domain to reproduce the error. Record the error message.
5. Run *stop-auth.ps1*, and allow execution if warned about an untrusted publisher.
6. Log files are saved in the *authlogs* subfolder, which includes the *Netsetup.log* log and the network trace file (Nettrace.etl).

### Use TSS Tool

TSS tool is another tool developed by Microsoft to ease log collection. To use it, follow these steps:

1. Download [TSS tool](https://aka.ms/gettss) on the client computer. Extract the files to a folder.
2. Start a PowerShell window with administrator privileges. Switch to the folder containing those extracted files.
3. Run the following command:

   ```console
   TSS.ps1 -scenario ADS_AUTH -noSDP -norecording -noxray -noupdate -accepteula -startnowait
   ```

   Accept the EULA if prompted, and allow execution if warned about an untrusted publisher.

   > [!NOTE]
   > If the scripts aren't allowed to run due to execution policies, see [about_Execution_Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies).

4. The command takes a few minutes to complete. After the command completes successfully, try to join the AD domain to reproduce the error. Record the error message.
5. Run `TSS.ps1 -stop`, and allow execution if warned about an untrusted publisher.
6. Log files are saved in the *C:\MS_DATA* subfolder, and are zipped already. The ZIP filename follows the format of *TSS_\<hostname\>_\<date\>-\<time\>-ADS_AUTH.zip*.
7. The zip file includes the *Netsetup.log*, and the network trace. The network trace file is named *\<hostname\>_\<date\>-\<time\>-Netsh_packetcapture.etl*.
