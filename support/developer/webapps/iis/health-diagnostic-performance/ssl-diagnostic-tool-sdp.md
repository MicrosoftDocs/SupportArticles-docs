---
title: IIS SSL Diagnostic tool for SDP
description: This article describes that IIS SSL Diagnostic tool for SDP is designed to troubleshoot SSL problems on IIS and it collects information used for troubleshooting common SSL problems.
ms.date: 04/10/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.technology: iis-health-diagnostic-performance
---
# Information about IIS SSL Diagnostic tool for SDP

This article describes the information collected from a machine when you run the Microsoft Internet Information Services (IIS) Secure Sockets Layer (SSL) Diagnostic on a computer that is experiencing problems while browsing to web sites running over SSL.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2753695

## Summary

The IIS SSL Diagnostic tool for Support Diagnostic Platform (SDP) is designed to troubleshoot SSL issues on IIS and it collects information used for troubleshooting common SSL issues. This diagnostic also allows the user to capture an Event Tracing for Windows (ETW) trace log for the IIS and Secure Channel (Schannel) providers.

## Operating system

|Description|
|-|
|Machine Name|
|OS Name|
|Build|
|Time Zone/Offset|
|Last Reboot/Uptime|
|User Account Control|
|Username|
||

## Computer system

|Description|
|-|
|Computer Model|
|Processor(s)|
|Machine Domain|
|Role|
|RAM (physical)|
||

## Certutil output

|Description|File Name|
|--|--|
|This file will contain the output of running the certutil -verify store command on the thumbprint of certificate assigned to each binding on the web site|{Computername}_CERTUTIL_VERFIYSTORE_CERT(n).TXT|
|This file contains dumps the CRL URL cache of the OS (obtained by running the command certutil -url cache CRL)|{Computername}_CERTUTIL_CRL_CACHE.TXT|
  
## Event log files

|Description| File Name|
|---|---|
|Application Event Log|{Computername}_evt_Application.evtx|
|System Event Log|{Computername}_evt_System.evtx|
|Security Event Log|{Computername}_evt_Security.evtx|
  
## IIS configuration

|Description|File Name|
|--|--|
|IIS/ASP.NET Configuration Files|{Computername}_IISConfiguration.zip|
  
## IIS log files

|Description|File Name|
|--|--|
|If during execution the option to collect ETW traces is selected then this file will contain the ETW trace, which enables various IIS and SCHANNEL providers|{Computername}_IISSSLETWLOGFILES.zip|
  
## IIS-SSL related registry setting

|Description|File Name|
|--|--|
|`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\HTTP`|{Computername}_REG_SERVICES_HTTP.TXT|
|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL`|{Computername}_REG_SCHANNEL.TXT|
|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Defaults`|{Computername}_REG_CRYPTOGRAPHY.TXT|
  
## Installed updates/hotfixes

|Description|File Name|
|--|--|
|Update/Hotfix history|{Computername}_Hotfixes.CSV|
|Update/Hotfix history|{Computername}_Hotfixes.htm|
|Update/Hotfix history|{Computername}_Hotfixes.TXT|
  
## Networking information

| Description| File Name |
|--|--|
|TCP/IP Basic Information|{Computername}_TcpIp-Info.txt|
|SMB Basic Information|{Computername}_SMB-Info.txt|
  
## SSL settings report

|Description|File Name|
|--|--|
|This file contains information about various metabase settings that are relevant for troubleshooting SSL issues, for example,  AccessSSLFlags, AccessSSL, AccessSSLNegotiateCert, AccessSSLRequireCert, IIS Client Certificate Mapping, AD Client Certificate authentication.<br/><br/>It also lists down the status of IIS services and provides details of each secure binding configured on the web site showing the details of the certificate bound to it.<br/><br/>Also if any of the SSL-related protocols is disabled on the server, this file will contain information about them.<br/><br/>If the policy for changing the Order of Cipher Suites, then the order specified will also be shown in this file.|{Computername}_SSLReport.htm|
  
## Virtualization information

|Description|File Name|
|--|--|
|Machine Virtualization Information in HTM format|{Computername}_Virtualization.htm|
|Machine Virtualization Information in TXT format|{Computername}_Virtualization.txt|
  
## More information

If the user selects to collect an IIS ETW Log, the diagnostic will enable IIS ETW Trace named _IIS ETW SDP Trace_. The diagnostic will automatically stop this trace when the user is clicks **next** while the trace is running. If the user clicks **Cancel**, they should stop the trace with the following command from an Administrative command prompt:

```console
logman.exe stop "IIS ETW SDP Trace" -ets
```

In addition to the collected information that is listed in these tables, this troubleshooter can detect one or more of the following situations:

- IIS-related Services in a running state or not.
- Whether the site contains an SSL Binding or not.
- Whether HTTP.SYS is listening on the SSL Binding port or if the port is occupied by another executable.
- Whether the web site has a certificate assigned to the secure binding.
- Whether the web site is in a started state or not.
- If Active Directory client certificate authentication is enabled, and if the `DsMapperUsage` setting on the binding matches that of the site.
- If Active Directory client certificate authentication is enabled but on the web site, we don't require or accept the client certificates.
- Permissions on the machine keys folder.
- Whether the binding format specified in the web site bindings is correct or not.
- If Internet Protocol (IP) inclusion list is configured on the server, and if the IP address configured on the website binding isn't present in the IP inclusion list.

- Whether the type of certificate is correct or not (that is, Intended Purposes says Server Authentication).
- If the certificate is archived.
- If the certificate is missing the private key.
- Incorrect `Key-Spec` (that is, if the certificate has any other `KEYSPEC` defined other than `AT_EXCHANGE`).
- If the certificate has subject alternate name, an information message is shown.

- If the certificate has subject alternate name, then all the bindings of other web sites are checked to see if they match the binding and port combination or not and if they do, then we match whether the binding has the same certificate or not and that the host headers don't match.  
If the certificate has wildcard, an information message is shown.

- If the certificate has wildcard, then all the bindings of other web sites are checked to see if they match the binding and port combination or not and if they do, then we match whether the binding has the same certificate or not and that the host headers don't match.

- Whether the validation of the server certificate succeeds.
- Checks if the certificate is expired.
- Whether any of the SSL protocols are disabled on the server.
- Whether the order of cipher suites has been changed on the server.
- Check if any of the keys of the certificate have length less than 1024 bits.
- If MS12-006 is installed on the machine.
