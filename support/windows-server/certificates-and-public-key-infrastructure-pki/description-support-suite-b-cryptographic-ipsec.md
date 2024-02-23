---
title: Description of the support for Suite B cryptographic algorithms that was added to IPsec
description: Describes the support for Suite B cryptographic algorithms that was added to IPsec. Also describes the IPsec policy configuration syntax that uses Suite B algorithms.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, clayse
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
---
# Description of the support for Suite B cryptographic algorithms that was added to IPsec

This article describes the support for Suite B cryptographic algorithms that was added to IPsec.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 949856

Support for Windows Vista Service Pack 1 (SP1) ends on July 12, 2011. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).

## Introduction

This article describes the support for Suite B cryptographic algorithms that was added in Windows Vista Service Pack 1 (SP1) and in Windows Server 2008. Suite B is a group of cryptographic algorithms that are approved by the United States National Security Agency (NSA).

Suite B is used as an interoperable cryptographic framework for protecting sensitive data. Support has been extended to the Suite B algorithms for the following areas:

- Main mode
- Quick mode
- Authentication settings  

This article also describes the Internet Protocol security (IPsec) policy configuration syntax that uses Suite B algorithms.
  
>[!Note]
> This content supercedes some content published on archived [IPsec algorithms and methods supported in Windows](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd125380(v=ws.10)).

## More information

### Support limitations

Support limitations for Suite B include the following:

- The creation and enforcement of IPsec policy by using Suite B algorithms is supported only in Windows Vista Service Pack 1 (SP1), in Windows Server 2008, or in later versions of Windows.
- The authoring of policies that contain Suite B algorithms is supported via the "Windows Firewall with Advanced Security" Microsoft Management Console (MMC) snap-in for Windows 7 and for later versions of Windows.
- The Netsh advfirewall help command does not display configuration options for Suite B algorithms. This applies only to Windows Vista SP1.

### Definitions

- Suite B

Suite B is a set of standards that are specified by the National Security Agency (NSA). Suite B provides the industry with a common set of cryptographic algorithms that can be used to create products that meet the widest range of U.S. government needs. Suite B includes specification of the following types of algorithms:

  - Integrity
  - Encryption
  - Key exchange
  - Digital signature
- Federal Information Processing Standards (FIPS) 

FIPS is a set of guidelines and standards that govern federal computing resources. All Suite B algorithms are FIPS-approved.

For more information, see [Information Technology Laboratory](http://www.itl.nist.gov/fipspubs/geninfo.htm).

- NIST 

  This is an acronym for the National Institute of Standards and Technology.
- Data integrity algorithms 

  Data integrity algorithms use message hashes to make sure that information is not being changed while it is in transit.
- Data encryption algorithms 

  Data encryption algorithms are used to hide information that is being transmitted. The encryption algorithms are used to convert plain text to a secret code.

  For example, the encryption algorithms can convert plain text to ciphertext. The ciphertext can then be decoded to the original plain text. Each algorithm uses a "key" to perform the conversion. The type of key and the length of the key depend on the algorithm that is being used.
- IPsec 

  This is an abbreviation for the term "Internet Protocol security."

  For more information about IPsec, see [What Is IPSec?](https://technet.microsoft.com/network/bb531150.aspx)

- Elliptic Curve Digital Signature Algorithm (ECDSA) 

  Elliptic curve (EC) is a variant of the digital signature algorithm that operates on EC groups. The EC variant provides smaller key sizes for the same security level.

  This algorithm is described in FIPS publication 186-2. To view this publication, see [Digital Signature Standard (DSS)](http://csrc.nist.gov/publications/fips/archive/fips186-2/fips186-2.pdf).

- Certification authority (CA) 

  A certification authority is an entity that issues digital certificates. IPsec can use these certificates as an authentication method.
- Authentication Header (AH) 

  Authentication Header is an IPsec protocol that provides authentication, integrity, and anti-replay functionality for the whole packet. This includes the IP header and the data payload.

  AH does not provide confidentiality. This means that AH does not encrypt the data. The data is readable, but it is unwriteable.
- Encapsulating Security Payload (ESP) 

  ESP is an IPsec protocol that provides confidentiality, authentication, integrity, and anti-replay functionality. ESP can be used alone, or it can be used together with AH.


### Main-mode algorithms

In Windows Vista SP1 and in Windows Server 2008, the following integrity algorithms are supported in addition to those algorithms that are already supported in the release version of Windows Vista:
- SHA-256
- SHA-384

> [!NOTE]
> The key exchange algorithm and the encryption algorithm are not changed.

### Quick-mode algorithms

In Windows Vista SP1 and in Windows Server 2008, the following algorithms are supported in addition to those algorithms that are already supported in the release version of Windows Vista.

#### Integrity (AH or ESP)


- SHA-256
- AES-GMAC-128
- AES-GMAC-192
- AES-GMAC-256

#### Integrity and encryption (ESP only)


- AES-GCM-128
- AES-GCM-192
- AES-GCM-256  

For more information about AH and ESP combinations that are supported and not supported, see the "Quick-mode cryptographic algorithm combinations that are supported and not supported" section.

#### Restrictions for Quick mode


- The same integrity algorithm should be used for both AH and ESP.
- The AES-GMAC algorithms are available for an integrity algorithm that has null encryption. Therefore, if any of these algorithms are specified for ESP integrity, the encryption algorithm cannot be specified.
- If you use an AES-GCM algorithm, the same algorithm should be specified for both ESP integrity and encryption.

### Authentication

In Windows Vista SP1 and in Windows Server 2008, the following authentication methods are supported in addition to those authentication methods that are already supported in the release version of Windows Vista.
- Computer certificate with ECDSA-P256 signing
- Computer certificate with ECDSA-P384 signing> 
>[!NOTE]
The default authentication method for Windows Vista is RSA SecurId authentication.

### Syntax and examples

This section describes the syntax for using the Netsh advfirewall command to add and to modify connection security rules. This section also provides examples of Netsh advfirewall commands.

#### Add a connection security rule

```
Netsh advfirewall
Usage: add rule name=<string>
 endpoint1=any|localsubnet|dns|dhcp|wins|defaultgateway|
 <IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>
 endpoint2=any|localsubnet|dns|dhcp|wins|defaultgateway|
 <IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>
 action=requireinrequestout|requestinrequestout|
 requireinrequireout|noauthentication
 [description=<string>]
 [mode=transport|tunnel (default=transport)]
 [enable=yes|no (default=yes)]
 [profile=public|private|domain|any[,...] (default=any)]
 [type=dynamic|static (default=static)]
 [localtunnelendpoint=<IPv4 address>|<IPv6 address>]
 [remotetunnelendpoint=<IPv4 address>|<IPv6 address>]
 [port1=0-65535|any (default=any)]
 [port2=0-65535|any (default=any)]
 [protocol=0-255|tcp|udp|icmpv4|icmpv6|any (default=any)]
 [interfacetype=wiresless|lan|ras|any (default=any)]
 [auth1=computerkerb|computercert|computercertecdsap256|computercertecdsap384|computerpsk|
 computerntlm|anonymous[,...]]
 [auth1psk=<string>]
 [auth1ca="<CA Name> [certmapping:yes|no] [excludecaname:yes|no] ..."]
 [auth1healthcert=yes|no (default=no)]
 [auth1ecdsap256ca="<CA Name> [certmapping:yes|no] [excludecaname:yes|no] ..."]
 [auth1ecdsap256healthcert=yes|no (default=no)]
 [auth1ecdsap384ca="<CA Name> [certmapping:yes|no] [excludecaname:yes|no] ..."]
 [auth1ecdsap384healthcert=yes|no (default=no)]
 [auth2=computercert| computercertecdsap256|computercertecdsap384|userkerb|usercert| usercertecdsap256|usercertecdsap384|userntlm|anonymous[,...]]
 [auth2ca="<CA Name> [certmapping:yes|no] ..."]
 [auth2ecdsap256ca="<CA Name> [certmapping:yes|no] ..."]
 [auth2ecdsap384ca="<CA Name> [certmapping:yes|no] ..."]
 [qmpfs=dhgroup1|dhgroup2|dhgroup14|ecdhp256|ecdhp384|mainmode|
 none (default=none)]
 [qmsecmethods=
 ah:<integrity>+esp:<integrity>-<encryption>+[valuemin]+[valuekb]
 |default]

Remarks:

- The rule name should be unique, and it cannot be "all."
 - When mode=tunnel, both tunnel endpoints must be specified and must be
 the same IP version. Also, the action must be requireinrequireout.
 - At least one authentication must be specified.
 - Auth1 and auth2 can be comma-separated lists of options.
 - The "computerpsk" and "computerntlm" methods cannot be specified together
 for auth1.
 - Computercert cannot be specified with user credentials for auth2.
 - Certsigning options ecdsap256 and ecdsap384 are supported only on Windows Vista SP1 and on later versions of Windows Vista.
 - Qmsecmethods can be a list of proposals separated by a comma (,).
 - For qmsecmethods, integrity=md5|sha1|sha256| aesgmac128|aesgmac192|aesgmac256|aesgcm128|aesgcm192|aesgcm256 and
 encryption=3des|des|aes128|aes192|aes256|aesgcm128|aesgcm192|aesgcm256.
 - If aesgcm128, aesgcm192, or aesgcm256 is specified, it must be used for both ESP integrity and encryption. 
 - sha-256, aesgmac128, aesgmac192, aesgmac256, aesgcm128, aesgcm192, aesgcm256 are supported only on Windows Vista SP1 and on later versions of Windows Vista. 
 - Qmpfs=mainmode uses the main mode key exchange setting for PFS.
 - We recommend that you do not use DES, MD5, or DHGroup1. These
 cryptographic algorithms are provided for backward compatibility
 only.
 - The default value for certmapping and for excludecaname is "no."
 - The quotation mark (") characters in the CA name must be replaced with a backslash character followed by a single quotation mark (\').
```

##### Example 1

Consider the following example of a Netsh advfirewall command:  
  Netsh advfirewall consec add rule name=test1 endpoint1=any endpoint2=any action=requestinrequestout description="Use ECDSA256 certificate and AESGMAC256" auth1=computercert,computercertecdsap256 auth1ca="C=US, O=MSFT, CN=\'Microsoft North, South, East, and West Root Authority\'" auth1healthcert=no auth1ecdsap256ca="C=US, O=MSFT, CN=\'Microsoft North, South, East, and West Root Authority\'" auth1ecdsap256healthcert=yes qmsecmethods=ah:aesgmac256+esp:aesgmac256-none 
 
This command creates a connection security rule that has the following authentication methods in the authentication set:
- The first authentication method is a certificate that uses RSA certificate signing.
- The second authentication method is a health certificate that uses ECDSA256 for certificate signing.  
- The connection security rule protects traffic by using AH and ESP integrity with the new AES-GMAC 256 algorithm. The rule does not include encryption.

##### Example 2

Consider the following example of a Netsh advfirewall command:  
 Netsh advfirewall consec add rule name=test2 endpoint1=any endpoint2=any action=requestinrequestout description="Use SHA 256 for Integrity and AES192 for encryption" auth1=computercert auth1ca="C=US, O=MSFT, CN=\'Microsoft North, South, East, and West Root Authority\'" auth1healthcert=no qmsecmethods=ah:sha256+esp:sha256-aes192  

This command creates a connection security rule that has one authentication method in the authentication set. The authentication method is a certificate that uses RSA certificate signing.

The connection security rule protects traffic by using AH and ESP integrity with SHA256 for integrity and with AES192 for encryption.

#### Modify an existing connection security rule

```
Netsh advfirewall
Usage: set rule
 group=<string> | name=<string>
 [type=dynamic|static]
 [profile=public|private|domain|any[,...] (default=any)]
 [endpoint1=any|localsubnet|dns|dhcp|wins|defaultgateway|
 <IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
 [endpoint2=any|localsubnet|dns|dhcp|wins|defaultgateway|
 <IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
 [port1=0-65535|any]
 [port2=0-65535|any]
 [protocol=0-255|tcp|udp|icmpv4|icmpv6|any]
 new
 [name=<string>]
 [profile=public|private|domain|any[,...]]
 [description=<string>]
 [mode=transport|tunnel]
 [endpoint1=any|localsubnet|dns|dhcp|wins|defaultgateway|
 <IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
 [endpoint2=any|localsubnet|dns|dhcp|wins|defaultgateway|
 <IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
 [action=requireinrequestout|requestinrequestout|
 requireinrequireout|noauthentication]
 [enable=yes|no]
 [type=dynamic|static]
 [localtunnelendpoint=<IPv4 address>|<IPv6 address>]
 [remotetunnelendpoint=<IPv4 address>|<IPv6 address>]
 [port1=0-65535|any]
 [port2=0-65535|any]
 [protocol=0-255|tcp|udp|icmpv4|icmpv6|any]
 [interfacetype=wiresless|lan|ras|any]
 [auth1=computerkerb|computercert|computercertecdsap256|computercertecdsap384|computerpsk|
 computerntlm|anonymous[,...]]
 [auth1psk=<string>]
 [auth1ca="<CA Name> [certmapping:yes|no] [excludecaname:yes|no] ..."]
 [auth1healthcert=yes|no (default=no)]
 [auth1ecdsap256ca="<CA Name> [certmapping:yes|no] [excludecaname:yes|no] ..."]
 [auth1ecdsap256healthcert=yes|no (default=no)]
 [auth1ecdsap384ca="<CA Name> [certmapping:yes|no] [excludecaname:yes|no] ..."]
 [auth1ecdsap384healthcert=yes|no (default=no)]
 [auth2=computercert| computercertecdsap256|computercertecdsap384|userkerb|usercert| usercertecdsap256|usercertecdsap384|userntlm|anonymous[,...]]
 [auth2ca="<CA Name> [certmapping:yes|no] ..."]
 [auth2ecdsap256ca="<CA Name> [certmapping:yes|no] ..."]
 [auth2ecdsap384ca="<CA Name> [certmapping:yes|no] ..."]
 [qmsecmethods=
 ah:<integrity>+esp:<integrity>-<encryption>+[valuemin]+[valuekb]|
 default]

Remarks:

- This sets a new parameter value on an identified rule. The command fails
 if the rule does not exist. To create a rule, use the "add" command.
 - Values after the new keyword are updated in the rule. If there are
 no values, or if the "new" keyword is missing, no changes are made.
 - Only a group of rules can be enabled or disabled.
 - If multiple rules match the criteria, all matching rules are 
 updated.
 - The rule name should be unique, and it cannot be "all."
 - Auth1 and auth2 can be comma-separated lists of options.
 - The computerpsk and computerntlm methods cannot be specified together
 for auth1.
 - Computercert cannot be specified by using user credentials for auth2.
 - Certsigning options ecdsap256 and ecdsap384 are supported only on Windows Vista SP1 and on later versions of Windows Vista. 
 - Qmsecmethods can be a list of proposals that are separated by a comma (,).
 - For qmsecmethods, integrity=md5|sha1|sha256| aesgmac128|aesgmac192|aesgmac256|aesgcm128|aesgcm192|aesgcm256 and
 encryption=3des|des|aes128|aes192|aes256|aesgcm128| aesgcm192|aesgcm256
 - If aesgcm128 or aesgcm256 is specified, it must be used for both ESP integrity and for encryption. 
 - Sha-256, aesgmac128, aesgmac192, aesgmac256, aesgcm128, aesgcm192, and aesgcm256 are supported only on Windows Vista SP1 and on later versions of Windows Vista.
 - If qmsemethods are set to "default," qmpfs will be set to "default" also.
 - Qmpfs=mainmode uses the main mode key exchange setting for PFS.
 - We recommend that you do not use DES, MD5, or DHGroup1. These
 cryptographic algorithms are provided for backward compatibility
 only.
 - The default value for "certmapping" and "excludecaname" is "no."
 - The quotation mark (") characters in the CA name must be replaced with a backslash character followed by a single quotation mark (\').

```

The following is an example of a command that updates the rule that was created in "Example 1" in the previous section: Netsh advfirewall consec set rule name=test new qmsecmethods=ah:aesgmac256+esp:aesgcm256-aesgcm256 
This command updates the rule to use AES-GCM 256 for ESP integrity and encryption and to use AES-GMAC 256 for AH integrity.

#### Set global Main-mode settings

The following Help text is for the Netsh advfirewall set global command.  
```
netsh advfirewall>set global

Usage: set global statefulftp|statefulpptp enable|disable|notconfigured
 set global IPsec (parameter) (value)
 set global mainmode (parameter) (value) | notconfigured

IPsec Parameters:

strongcrlcheck - Configures how CRL checking is enforced.
 0: Disable CRL checking
 1: Fail if cert is revoked and the CRL exists in the client's CRL cache (default behavior)and the CRL exists in the client's CRL cache (default behavior) 2: Fail on any error
 notconfigured: Returns the value to its unconfigured state.
 saidletimemin - Configures the security association idle time in
 minutes.
 - Usage: 5-60|notconfigured (default=5)
 defaultexemptions - Configures the default IPsec exemptions. The default is
 to exempt IPv6 neighbordiscovery protocol from
 IPsec.
 - Usage: none|neighbordiscovery|notconfigured

Main Mode Parameters:

mmkeylifetime - Sets the main mode key lifetime in minutes, in sessions, or in both.
 - Usage: <num>min,<num>sess
 mmsecmethods - Configures the main mode list of proposals
 - Usage:
 keyexch:enc-integrity,enc-integrity[,...]|default
 - keyexch=dhgroup1|dhgroup2|dhgroup14|
 ecdhp256|ecdhp384
 - enc=3des|des|aes128|aes192|aes256
 - integrity=md5|sha1|sha256|sha384

Remarks:

- This configures global settings, such as advanced IPsec options.
 - We recommend that you do not use DES, MD5, or DHGroup1. These
 cryptographic algorithms are provided for backward compatibility
 only.
 - The mmsecmethods keyword default sets the policy to the following:
 dhgroup2-aes128-sha1,dhgroup2-3des-sha1
 - Sha256 and sha384 are supported only on Windows Vista SP1 and on later versions of Windows Vista.
```

The following is an example of a command that uses the new SHA algorithms in the Main-mode cryptographic set: Netsh advfirewall set global mainmode mmsecmethods dhgroup1:3des-sha256, 3des-sha384 

### Troubleshooting, configuration, and verification commands

#### The "Netsh advfirewall consec show rule all" command

The Netsh advfirewall consec show rule all command displays configuration for all connection security rules.

The following is a sample of output for this command.
```
Rule Name:test
Enabled:Yes
Profiles:Domain,Private,Public
Type:Static
Mode:Transport
Endpoint1:Any
Endpoint2:Any
Protocol:Any
Action:RequestInRequestOut
Auth1:ComputerPSK
Auth1PSK: 12345
MainModeSecMethods ECDHP384-3DES-SHA256,ECDHP384-3DES-SHA384
QuickModeSecMethodsAH:AESGMAC256+ESP:AESGCM256-AESGCM256+60 min+100000kb
```

#### The "Netsh advfirewall monitor show mmsa" command

The Netsh advfirewall monitor show mmsa command displays the Main mode security association.

The following is a sample of output for this command.
```
Main Mode SA at 01/04/2008 13:10:09
Local IP Address:157.59.24.101
Remote IP Address: 157.59.24.119
My ID:
Peer ID:
First Auth:ComputerPSK
Second Auth:None
MM Offer: ECDHAP384-3DES-SHA256
Cookie Pair:203d57505:5d088705
Health Pair:No
Ok.
```

#### The "Netsh advfirewall monitor show qmsa" command

The Netsh advfirewall monitor show qmsa command displays the Quick mode security association.

The following is a sample of output for this command.
```
Main Mode SA at 01/04/2008 13:10:09
Local IP Address:157.59.24.101
Remote IP Address: 157.59.24.119
Local Port:Any
Remote Port:Any
Protocol:Any
Direction:Both
QM Offer: AH:AESGMAC256+ESP:AESGCM256-AESGCM256+60min +100000kb
Ok.
```

#### The "Netsh advfirewall show global" command

The Netsh advfirewall show global command displays global settings.

The following is a sample of output for this command.
```
Global Settings:
IPsec:
StrongCRLCheck0:Disabled
SAIdleTimeMin5min
DefaultExemptions NeighborDiscovery
IPsecThroughNAT Server and client behind NAT

StatefulFTPEnable
StatefulPPTPEnable

Main Mode:
KeyLifetime2min,0sess
SecMethodsDHGroup1-3DES-SHA256,DHGroup1-3DES-SHA384
```

### Interoperability

Creation, enforcement, and management of the IPsec policy that uses Suite B algorithms was introduced in Windows Vista SP1 and in Windows Server 2008. You can manage a Group Policy that contains Suite B algorithms only by using tools that were released with Windows Vista SP1 or with Windows Server 2008.

Sample scenarios and expected results are as follows.

#### Scenario 1

You use the new cryptographic algorithms to apply a policy that is created on a computer that is running Windows Server 2008 or Windows Vista SP1 to a computer that is running the release version of Windows Vista.

##### Expected result

If a rule contains cryptographic suites that use the new cryptographic algorithms, these cryptographic suites are dropped and other cryptographic suites in the cryptographic set are used instead.

If none of the cryptographic suites in the rule are recognized, the whole rule is dropped. An event is logged that indicates that the rule cannot be processed. Therefore, if all cryptographic suites in the key exchange cryptographic set are dropped, none of the connection security rules in the policy are applied. However, all firewall rules are still applied.

The authentication set process resembles the cryptographic set process. If a policy that contains the new certificate flags (ECDSA-P256 or ECDSA-P384) is applied to a computer that is running the release version of Windows Vista, the authentication methods are dropped.

If all authentication methods in the first authentication set are dropped for this reason, the whole rule is not processed. If all authentication methods in the second authentication set are dropped, the rule is processed by using only the first authentication set.

#### Scenario 2

On a computer that is running the release version of Windows Vista, you use the new cryptographic algorithms to view a policy that was created on a computer that is running Windows Server 2008 or Windows Vista SP1.

##### Expected result

The new algorithms are displayed as "unknown" in both the monitoring and authoring parts of the Windows Firewall Advanced Security MMC snap-in. The Netsh advfirewall command also displays the algorithms as "unknown" in Windows Vista.

#### Restrictions on interoperability

Restrictions on interoperability are as follows:
- We do not support remote management of policies that use Suite B algorithms on computers that are running Windows Vista SP1 or Windows Server 2008 from a computer that is running the release version of Windows Vista.
- When a policy that is created on a computer that is running Windows Vista SP1 or Windows Server 2008 is imported to a computer that is running the release version of Windows Vista, some parts of the policy are dropped. This occurs because the release version of Windows Vista cannot recognize the new algorithms.

### Quick-mode cryptographic algorithm combinations that are supported and not supported

The following table shows supported Quick-mode cryptographic algorithm combinations.

|Protocol|AH Integrity|ESP Integrity|Encryption|
|---|---|---|---|
|AH|AES-GMAC 128|None|None|
|AH|AES-GMAC 192|None|None|
|AH|AES-GMAC 256|None|None|
|AH|SHA256|None|None|
|AH|SHA1|None|None|
|AH|MD5|None|None|
|ESP|None|AES-GMAC 128|None|
|ESP|None|AES-GMAC 192|None|
|ESP|None|AES-GMAC 256|None|
|ESP|None|SHA256|None|
|ESP|None|SHA1|None|
|ESP|None|MD5|None|
|ESP|None|SHA256|Any supported encryption algorithm except AES-GCM algorithms|
|ESP|None|SHA1|Any supported encryption algorithm except AES-GCM algorithms|
|ESP|None|MD5|Any supported encryption algorithm except AES-GCM algorithms|
|ESP|None|AES-GCM 128|AES-GCM 128|
|ESP|None|AES-GCM 192|AES-GCM 192|
|ESP|None|AES-GCM 256|AES-GCM 256|
|AH+ESP|AES-GMAC 128|AES-GMAC 128|None|
|AH+ESP|AES-GMAC 128|AES-GMAC 128|None|
|AH+ESP|AES-GMAC 128|AES-GMAC 128|None|
|AH+ESP|SHA-256|SHA-256|None|
|AH+ESP|SHA1|SHA1|None|
|AH+ESP|MD5|MD5|None|
|AH+ESP|SHA256|SHA256|Any supported encryption algorithm except AES-GCM algorithms|
|AH+ESP|SHA1|SHA1|Any supported encryption algorithm except AES-GCM algorithms|
|AH+ESP|MD5|MD5|Any supported encryption algorithm except AES-GCM algorithms|
|AH+ESP|AES-GMAC 128|AES-GCM 128|AES-GCM 128|
|AH+ESP|AES-GMAC 192|AES-GCM 192|AES-GCM 192|
|AH+ESP|AES-GMAC 256|AES-GCM 256|AES-GCM 256|

> [!NOTE]
> AES-GMAC is the same as AES-GCM with null encryption. For example, you can specify AH integrity to use AES-GMAC 128, and you can specify ESP Integrity to use AES-GCM 128. This is the only exception to the rule that AH and ESP integrity algorithms must be identical.

The combinations that are described in the following table are not supported.

|Protocol|AH Integrity|ESP Integrity|Encryption|
|---|---|---|---|
|ESP|None|AES-GMAC 128|Any supported encryption algorithm|
|ESP|None|AES-GMAC 192|Any supported encryption algorithm|
|ESP|None|AES-GMAC 256|Any supported encryption algorithm|
|ESP|None|AES-GCM 128|1.None<br/>2.Any encryption algorithm except AES-GCM 128<br/>|
|ESP|None|AES-GCM 192|1.None<br/>2.Any encryption algorithm except AES-GCM 192<br/>|
|ESP|None|AES-GCM 256|1.None<br/>2.Any encryption algorithm except AES-GCM 256<br/>|
|AH+ESP|AES-GMAC 128|AES-GMAC 128|Any supported encryption algorithm|
|AH+ESP|AES-GMAC 192|AES-GMAC 192|Any supported encryption algorithm|
|AH+ESP|AES-GMAC 256|AES-GMAC 256|Any supported encryption algorithm|

For more information about Suite B, see [Commercial National Security Algorithm Suite](https://media.defense.gov/2021/Sep/27/2002862527/-1/-1/0/CNSS%20WORKSHEET.PDF).

For more information about IPsec and connection security rules, see [Windows Firewall with Advanced Security and IPsec](https://go.microsoft.com/fwlink/?linkid=96525).
