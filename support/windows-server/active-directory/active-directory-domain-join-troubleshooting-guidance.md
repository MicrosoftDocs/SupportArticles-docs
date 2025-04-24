---
title: Active Directory domain join troubleshooting guidance
description: Provides guidance to troubleshoot domain join issues.
ms.date: 01/15/2025
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

### Error code 0x569

For more information, see [Error code 0x569: The user has not been granted the requested logon type at this computer](error-0x569-not-granted-logon-type.md).

### Error code 0x6BF or 0xC002001C

For more information, see [Status code 0x6bf or 0xc002001c: The remote procedure call failed and did not execute](status-code-0x6bf-0xc002001c.md).

### Error code 0x6D9

See [Domain join error 0x6D9 "There are no more endpoints available from the endpoint mapper"](./domain-join-error-0x6d9-there-are-no-more-endpoints-available-from-the-endpoint-mapper.md) for troubleshooting guide.

### Error code 0xa8b

For more information, see [Error code 0xa8b: An attempt to resolve the DNS name of a DC in the domain being joined has failed](error-0xa8b-resolve-dns-fail.md).

### Error code 0x40

For more information, see [Domain join error 0x40 "The specified network name is no longer available"](domain-join-error-0x40-the-specified-network-name-is-no-longer-available.md).

### Error code 0x54b

For more information, see [Domain join error code 0x54b](error-code-0x54b.md).

### Error code 0x0000232A

Error 0x0000232A is logged when the client computer lacks NetBIOS name resolution to the domain.

:::image type="content" source="media/active-directory-domain-join-troubleshooting-guidance/error-0x0000232a-message.png" alt-text="Screenshot of the dialog box showing the error message for error code 0x0000232A.":::

Here's an example of the error message:

> Note: This information is intended for a network administrator.  If you are not your network's administrator, notify the administrator that you received this information, which has been recorded in the file C:\WINDOWS\debug\dcdiag.txt.
>
> The domain name "\<NetBIOS_name\>" might be a NetBIOS domain name.  If this is the case, verify that the domain name is properly registered with WINS.
>
> If you are certain that the name is not a NetBIOS domain name, then the following information can help you troubleshoot your DNS configuration.
>
> The following error occurred when DNS was queried for the service location (SRV) resource record used to locate an Active Directory Domain Controller (AD DC) for domain "\<NetBIOS_name\>":
>
> The error was: "DNS server failure."
> (error code 0x0000232A RCODE_SERVER_FAILURE)
>
> The query was for the SRV record for _ldap._tcp.dc._msdcs.\<NetBIOS_name\>
>
> Common causes of this error include the following:
>
> - The DNS servers used by this computer contain incorrect root hints. This computer is configured to use DNS servers with the following IP addresses:
>
> \<ip_address\>
>
> - One or more of the following zones contains incorrect delegation:
>
> \<NetBIOS_name\>
> . (the root zone)

Here's an example from the *netsetup.log* file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpValidateName: checking to see if '<NetBIOS_name>' is valid as type 3 name
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid for <NetBIOS_name> returned 0x54b, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid [ Exists ] for '<NetBIOS_name>' returned 0x54b
```

When you enter the domain name, make sure you enter the DNS Domain Name rather than the NetBIOS name. For example, if the DNS name of the domain is contoso.com, make sure you enter that name instead of just contoso.

### Error code 0x3a

For more information, see [Status code 0x3a: The specified server cannot perform the requested operation](status-code-0x3a-server-not-perform-operation.md).

### Error code 0x216d

For more information, see [Status code 0x216d: Your computer could not be joined to the domain](status-code-0x216d-not-joined-domain.md).

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
