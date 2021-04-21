---
title: Description of the DNSLint utility
description: Describes the DNSLint utility and its syntax.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: timr, larryga, kaushika
ms.prod-support-area-path: DNS
ms.technology: networking
---
# Description of the DNSLint utility

This article describes the DNSLint utility and its syntax.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 321045

## Summary

DNSLint is a Microsoft Windows utility that helps you to diagnose common Domain Name System (DNS) name resolution issues.

For more information about how to download Microsoft Support files, see the following article:

[119591](https://support.microsoft.com/help/119591) How to Obtain Microsoft Support Files from Online Services

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.  

## DNSLint functions

DNSLint has three functions that verify DNS records and generate an HTML report. The three functions are:

- `dnslint /d`: Diagnoses potential causes of "lame delegation" and other related DNS problems.
- `dnslint /ql`: Verifies a user-defined set of DNS records on multiple DNS servers.
- `dnslint /ad`: Verifies DNS records used specifically for Active Directory replication.

DNSLint is a command-line utility. The syntax is:

```console
dnslint /d domain_name | /ad [LDAP_IP_address] | /ql input_file  
[/c [smtp,pop,imap]] [/no_open] [/r report_name]  
[/t] [/test_tcp] [/s DNS_IP_address] [/v] [/y]  
```

Specify either `/d`, `/ad`, or `/ql` when you run DNSLint. Other switches are optional.

You use the `/d` switch to request domain name tests. This switch is useful when you troubleshoot lame delegation issues.

- Specify a domain name to test.
- You can't use the `/d` switch with the `/ad` switch.

You use the `/ad` switch to request Active Directory tests.

- The `/ad` switch resolves DNS records that are used for AD forest replication.
- By default, the local system's LDAP service is used.

- You can specify a remote LDAP server IP address (optional).
- Only valid IP addresses are accepted. Names aren't accepted.  
Typically,  it's an Active Directory domain controller.
- Use the `/ad` switch with the `/s` option, where `/s` specifies the IP address of a DNS server that is authoritative for the _msdcs zone in the AD forest root.
- You can't use the `/ad` switch with `/d` or `/c`.

You use the `/ql` switch to request DNS query tests from a list.

- The `/ql` switch sends the DNS queries specified in a text input file
- Specify the path and name of the input file.
- the `/ql` switch supports A, PTR, CNAME, SRV, and MX record queries.
- You create a sample input file by running the following command:

    ```console
    dnslint /ql autocreate  
    ```

- You can't use the `/ql` switch with `/d`, `/ad`, or `/c`.  

> [!NOTE]
>
> - You can't use `/d`, `/ad`, and `/ql` together.
> - You can't use `/c` together with `/ad` or `/ql`.
> - When you use `/ad`, you must also specify `/s`.

## Optional switches

Use `/c` to request connectivity tests on e-mail servers.

- The `/c` switch tests Simple Mail Transfer Protocol (SMTP), POP, and IMAP ports on e-mail servers found.
- By default, all three (the SMTP, POP, and IMAP ports) are tested. You can specify one or a combination. To do so, use a comma-separated list: `/c pop,imap,smtp`.

To prevent report from automatically opening, use `/no_open`. The `/no_open` switch is useful in scripts.

Use the `/r` switch to specify the name of the report file that is created.

- The .htm file name extension is automatically added to report names.
- The report is created in HTML format. The default name is Dnslint.htm
- The default location is the current directory.

Use the `/s` switch to bypass an InterNIC `whois` lookup.

- You can specify DNS server IP address instead of querying InterNIC for one.
- The `/s` switch starts checking DNS records by using the supplied IP address.
- Only valid IP addresses are accepted. Names aren't accepted.
- Use this option to check domain names that aren't supported by InterNIC.
- When you use `/ad`, you must use `/s` to specify a DNS server that is authoritative for the _msdcs subdomain in the root domain of the AD forest.
- When you use `/ad`, you can run `/s` localhost to determine whether the local system can resolve records that are found in the AD tests.

Use `/t` to request output to a text file.

- The text file shares the same name as the .htm report, but it has a .txt file name extension.
- The text file created in the same directory as the .htm report file.

Use `/test_tcp` to request to test TCP port 53.

- By default, only UDP port 53 is tested.
- The `/test_tcp` option checks whether TCP port 53 is responding to queries.
- The `/test_tcp` option can't be used with `/ql`.

Use `/v` to request verbose output to the screen.

Use `/y` to overwrite an existing report file without being prompted. The `/y` switch is useful in scripts.

## Required parameters

To run DNSLint, you must use one of the three following parameters:

1. Use `/d` for domain name tests
2. Use `/ad` for Active Directory replication tests.
3. Use `/ql` for tests specified in a query list.

Use the `/d` (domain name test) switch to test a particular DNS domain name. Use this switch to help diagnose "lame delegation" issues and other related DNS issues. The domain name that you test can be:

- A name that's registered for use on the Internet.
- A name that's used in a private namespace.

When you test domain names on a private network, or domain names registered on the Internet that are more than two levels deep, you must use the `/s` option.

Use the `/ad` (Active Directory test) switch to test the DNS records responsible for Active Directory forest replication. After the `/ad` switch, specify the IP address of an LDAP server that's used for this test. Typically, it's an Active Directory domain controller. If DNSLint is running on a domain controller, no IP address is necessary because the default value for this switch is 127.0.0.1.

Use the `/ql` (query list test) switch to test the DNS records specified in a text input file. Specify the full path and name of the text input file immediately after the switch. Run `dnslint /ql autocreate` to generate a sample text input file called In-dnslint.txt. This file contains an explanation on the required format. You can use this file as a template to create other input files.

## More optional switches

The `/v` (verbose) switch turns on "verbose mode". With this switch on, DNSLint will output the steps it's taking to collect data to the screen. You can send this output to a file. For example, `dnslint /v /d msn.com`.
By default, the name of the report that DNSLint generates is Dnslint.htm. With the `/r` (report) switch, you can specify the name and location of the report file that DNSLint generates. You can give the report file the same name as the domain name or DNS server that was tested. The ".htm" file name extension is appended to the report name automatically because the report is in HTML format.

By default, DNSLint tries to automatically open the report file after it's generated, by using whatever program is associated with the report file's .htm file. Typically, Microsoft Internet Explorer is associated with the .htm extension. There's no way to change the report format to something other than HTML by using DNSLint.

To define the location to which the report file is written, specify the full path and name of the report file. DNSLint supports both local drives and Universal Naming Convention (UNC) paths. For example, the command `dnslint /d msn.com /r c:\reports\reskit` creates a report called Reskit.htm in the C:\Reports folder. The command `dnslint /d mydom.local /r \\\server1\reports\mydom` creates a report on the remote system called server1 in the Reports share. The report name is Mydom.htm.

If you specify the `/t` (text) switch, DNSLint generates a text report and an HTML report. The text report uses the same name as the .htm report except that its file name extension is .txt. The file is created in the same folder as the .htm file. For example, the command `dnslint /d msn.com /r c:\reports\reskit /t` creates two reports in the C:\Reports folder. One report is called Reskit.htm and the other is called Reskit.txt.

By default, when DNSLint detects that a report file with the same name as the one that it's going to generate already exists in the target folder, DNSLint prompts you to overwrite the file. With the `/y` option, DNSLint can overwrite an existing report file without prompting you for permission. Both the .htm file and the optional .txt file are overwritten when you use this option.

The command `dnslint /y /d msn.com /r c:\reports\reskit /t` creates two reports in the C:\Reports folder. One report is called Reskit.htm and the other is called Reskit.txt. Existing report files are overwritten without prompting you.

The `/no_open` switch prevents DNSLint from automatically opening the report after it's generated. This option is useful when you use DNSLint in scripts if you don't want to:

- Review the reports immediately.
- Review the reports from the system that DNSLint was run from.

For example, the command `dnslint /y /d msn.com /no_open` generates a report called Dnslint.htm that overwrites a pre-existing report with the same name, without prompting the user. DNSLint doesn't automatically open the report when it's completed.

Use the `/test_tcp` (test TCP port 53) option to request to test TCP port 53 when `/d` is used. Many DNS servers on the Internet today don't accept DNS queries on TCP port 53, to avoid possible attacks on that port. By default, only UDP port 53 is tested when DNSLint is run. Specifying the `/test_tcp` option will get DNSLint to send a single DNS query by TCP and report whether a response was received.

You can use the `/test_tcp` option with `/d` and `/ad`. However, you can't use the `/test_tcp` option with `/ql` or the `/ad` `/s` localhost combination. With the `/ql` function, TCP port 53 can be tested directly from the input file. The `/ad /s localhost` function tests whether the locally configured DNS servers can resolve DNS records used for Active Directory Forest replication. You can test TCP port 53 connectivity by using `/ad` `/s` **ip_addr** instead, where **ip_addr** is the IP address of a DNS server that is authoritative for the _msdcs zone in the root of the Active Directory domain.

For example: `dnslint /d microsoft.com /v /test_tcp`  

The `/c` (connectivity test) switch requests that DNSLint test well-known e-mail ports on all of the e-mail servers it finds while inspecting DNS servers for the specified domain name. The SMTP, Post Office Protocol (POP version 3), and Internet Message Access Protocol (IMAP version 4) are supported. By default, when the `/c` switch is specified, DNSLint tries to connect to all three ports on each e-mail server that it finds:

- TCP port 25 for SMTP
- TCP port 110 for POP
- TCP port 143 for IMAP

DNSLint reports the state that each port is in: "Listening", "Not Listening", or "No Response." If DNSLint finds that a port is Listening, it also returns the response from the port. For example, if an SMTP port is listening, it typically returns a response that's consistent with the SMTP protocol specification, such as the following example:

220 `mailsrv.reskit.com` Microsoft ESMTP MAIL Service, Version: 5.0.2195.3705 ready at Mon, 13 May 2002 17:08:36 -0700

When a port is reported as "Not Listening", it indicates the e-mail server being queried has responded with a TCP packet with the Reset flag set. It also indicates there's no service or program listening on the port.

"No Response" is reported when the target e-mail server doesn't respond to the connection attempt. If the target server is operational and running, it indicates that the port is being filtered on:

- The target server.
- Somewhere between the client that's running DNSLint and target server.

The command `dnslint /y /v /c /d msn.com` generates a report called Dnslint.htm that overwrites a pre-existing report with the same name, without prompting the user. Because the `/c` option is specified, an extra section is appended to the bottom of the standard DNSLint report:

Network Connectivity Tests  
E-mail server: `smtp-gw-4.msn.com`  
IP address: 207.46.181.13  

SMTP response:  
220 `cpimssmtpa18.msn.com` Microsoft ESMTP MAIL Service, Version:  
5.0.2195.4905 ready at Tue, 14 May 2002 09:26:06 -0700  

POP response: NO RESPONSE (possibly filtered)  

IMAP response: NO RESPONSE (possibly filtered)

> [!NOTE]
>
> One or more POP servers didn't respond.  
One or more IMAP servers didn't respond.

When a target e-mail server doesn't respond to a connection attempt on one of its e-mail ports, DNSLint retries the connection three times. It's standard behavior for a TCP client. Before DNSLint indicates that there was "No Response," it waits for three separate TCP connections attempts to time out. This process can slow down the completion of the report. To optimize DNSLint operation, you can specify which e-mail port or ports you want to check instead of always checking all three ports.

By default, when the `/c` option is specified, all three TCP ports (25, 110, 143) are checked. But you can specify which ports to check after the `/c` option. Specify a comma-delimited list immediately after the `/c` option. Specify valid ports only: `smtp`, `pop`, `imap`. Any combination of these three ports works. For example, the command `dnslint /d reskit.com /c smtp` specifies that only the SMTP port (TCP port 25) should be checked.

The command `dnslint /d reskit.com /c pop`, smtp specifies that only the SMTP port (TCP port 25) and POP port (TCP port 110) should be checked.

The command `dnslint /d reskit.com /c imap`, pop specifies that only the IMAP port (TCP port 143) and POP port (TCP port 110) should be checked.

You can use the `/s` (server) switch with the `/d` and `/ad` functions. The `/s` switch has several purposes, but it only takes one type of data, a valid IP address of a DNS server (with one exception).

When you specify `/d`, the `/s` option bypasses the InterNIC `Whois` lookup that DNSLint does by default. As a result, DNSLint can run tests on private networks and on domain names that are deeper than the second-level domains on the Internet. DNSLint can also test domain names that aren't supported by InterNIC. At the time this article was written, InterNIC supported `Whois` lookups for the following domains: `.biz`, `.com`, `.coop`, `.edu`, `.info`, `.int`, `.museum`, `.net`, and `.org`.

When you use `/ad`, the `/s` switch is used to specify the IP address of a DNS server that's authoritative for the subdomain where DNS records used for Active Directory forest replication are registered. Typically, it's the _msdcs subdomain under the root of the Active Directory forest. For example, if the root of the Active Directory forest is called `myad.contoso.com`, the DNS server that hosts this domain may also be authoritative for the `_msdcs.myad.contoso.com` zone. In the zone, the DNS records used in Active directory replication are registered. Or, the `_msdcs.myad.contoso.com` zone may be delegated to a different DNS server. However the DNS infrastructure has been designed, the `/s` option is used to specify a DNS server that's authoritative for the `_msdcs.myad.contoso.com` zone.

The `/s` option must specify a valid IP address. The only exception to this rule is the following combination: `dnslint /ad /s localhost`

"localhost" isn't a valid IP address. When you specify this parameter with the `/ad /s` combination, DNSLint tests the local system's (the system that's running DNSLint) ability to resolve the DNS records that are used for Active Directory forest replication. Recursive DNS queries are sent to the local system's configured DNS servers to confirm that the local system can resolve the DNS records used for Active Directory forest replication. It can be useful when troubleshooting Active Directory replication problems on a particular domain controller.

Typically, not all of the local system's configured DNS servers are queried during this process. Default DNS client resolver behavior is observed. If the DNS server at the top of the local system's DNS Server list doesn't respond, the next server in the list is used.
