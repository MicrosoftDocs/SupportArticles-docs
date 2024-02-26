---
title: DirectAccess clients can't connect with IP-HTTPS
description: DirectAccess clients may not be able to connect to DirectAccess Server by using Internet Protocol over Secure Hypertext Transfer Protocol (IP-HTTPS) connections because the revocation check fails.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ajayps
ms.custom: sap:remote-access, csstroubleshoot
---
# DirectAccess clients may be unable to connect with error 0x80092013

This article provides help to solve an issue where DirectAccess clients aren't able to connect to DirectAccess Server by using Internet Protocol over Secure Hypertext Transfer Protocol (IP-HTTPS) connections.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2980672

## Symptoms

DirectAccess clients may be unable to connect to DirectAccess Server by using IP over IP-HTTPS connections because the revocation check fails.  

The output of the command netsh interface http show interface will display the following error:

> Error: 0x80092013
>
> Translates to: CRYPT_E_REVOCATION_OFFLINE  
\# The revocation function was unable to check revocation because the revocation server was offline.

## Cause

This error may occur for one of the following reasons:

1. The CRL location (CDP) is unreachable.
2. The CRL location (CDP) is unpublished.
3. The CRL has expired and a new one was not published.
4. The CRL is reachable but the client is picking from an old cache.

## Resolution

If the CRL location (CDP) is unreachable, then verify that the CRL is downloadable from the system context by following these steps:  

1. Determine whether the connectivity issue is being caused by the Proxy Settings. To determine this you can query by using the follow registry values:
   - cmd.exe /c reg query  
   `HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v ProxyEnable
   - cmd.exe /c reg query  
   `HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v ProxyServer
   - cmd.exe /c reg query  
   `HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v ProxyOverride
   - cmd.exe /c reg query  
   `HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v AutoConfigURL
   - cmd.exe /c reg query  
   `HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v ProxyEnable
   - cmd.exe /c reg query  
   `HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v ProxyServer
   - cmd.exe /c reg query  
   `HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v ProxyOverride
   - cmd.exe /c reg query  
   `HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v AutoConfigURL  

   1. If the **ProxyEnable**  value equals 1 in either. Default or S-1-5-18 then it means DO NOT **Automatically Detect Settings**. This means that connections are made only by using the proxy defined in **ProxyServer** or **AutoConfigURL**.
   2. If the ProxyEnable value equals 0, it means **Automatically Detect Settings**. Therefore you cannot change the Value in the registry to make DA work as the HKU\\\<UserSID> hive is the dump for the HKCU hive. Any changes that you made to HKU will be overwritten every time that the **System Service** is active. To change this setting, you must start Internet Explorer or CMD.exe under the **System Account** (NT AUTHORITY\System). To do this, from an elevated **Command Prompt** run:
     - psexec.exe -s -i cmd.exe /c reg add `HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings` /v ProxyEnable /t REG_DWORD /d 0 /f
       - CRL Location could be unreachable for one of the following reasons:
        1. System context proxy is applied but unreachable and requires user authentication.
        2. Hotspot logon is pending.
        3. CRL Location is unavailable on the Internet.
        4. CRL Location requires authentication before access is granted.
        5. CRL Location is reachable. But the CRL files are not allowed to be served.
       - In this case, check **File System Permissions** on the CRL and Delta CRL files.
       - Ensure that **DoubleEscaping** is enabled for the CDP location:
         - Set-WebConfiguration -Filter system.webServer/security/requestFiltering -PSPath 'IIS:\Sites\<SiteName> -Value @{allowDoubleEscaping=$true}  

2. If the CRL location (CDP) is unpublished follow these steps:  

      1. Click **Start**, point to **Administrative Tools**, and then click **Certification Authority**.
      2. In the console tree, right-click **corp-DC1-CA**, and then click **Properties**.
      3. Click the **Extensions tab**, and then click **Add**.
      4. In **Location**, type `http://\<Public-IIS-URL>/crld/` (WAN URL required Internet Access)
      5. In **Variable**, click \<CAName>, and then click **Insert**.
      6. In **Variable**, click \<CRLNameSuffix>, and then click **Insert**.
      7. In **Variable**, click \<DeltaCRLAllowed>, and then click **Insert**.
      8. In **Location**, type .crl at the end of the Location string, and then click **OK**.
      9. Select **Include** in CRLs. Clients use this to find Delta CRL locations. Select **Include** in the CDP extension of issued certificates, and then click **OK**. Then click **Add**.
      10. In **Location**, type \\\<IIS-ServerName>\crldist$\ (Internal Location used by the Certification Authority to publish to and by IIS to serve clients.)
      11. In **Variable**, click \<CAName>, and then click **Insert**.
      12. In Variable, click \<CRLNameSuffix>, and then click **Insert**.
      13. In Variable, click \<DeltaCRLAllowed>, and then click **Insert**.
      14. In Location, type .crl at the end of the string, and then click **OK**.
      15. Select **Publish CRLs** to this location and **Publish Delta CRLs** to this location, and then click **OK**.
      16. Click yes to restart Active Directory Certificate Services.
      17. Close the Certification Authority console.
3. If the CRL has expired follow these steps:
   - Republish the CRL
     - Certutil -crl
4. If the CRL is reachable but the client is picking from an old cache, follow these steps:  

   Clear the client Caches  
    1. TVO (Time Validated objects)  
         - Certutil -setreg chain\ChainCacheResyncFiletime @now  
    2. URL Cache  
       - Certutil -urlcache * delete  

## More information

DirectAccess Connectivity Methods  

DirectAccess clients use multiple methods to connect to the DirectAccess server. This enables access to internal resources. Clients have the option to use either Teredo, 6to4, or IP-HTTPS to connect to DirectAccess. This also depends on how the DirectAccess server is configured.

When the DirectAccess client has a public IPv4 address, it will try to connect by using the 6to4 interface. However, some ISPs give the illusion of a public IP Address. What they provide to end users is a pseudo public IP address. What this means is that the IP address received by the DirectAccess client (a data card or SIM connection) might be an IP from the public address space, but in reality is behind one or more NATs.

When the client is behind a NAT device, it will try to use Teredo. Many businesses such as hotels, airports, and coffee shops do not allow Teredo traffic to traverse their firewall. In such scenarios, the client will fail over to IP-HTTPS. IP-HTTPS is built over an SSL (TLS) TCP 443-based connection. SSL outbound traffic will most likely be allowed on all networks.

Having this in mind, IP-HTTPS was built to provide a backup connection that is reliable and always reachable. A DirectAccess client will use this when other methods (such as Teredo or 6to4) fail.

More information about transition technologies can be found at [IPv6 transition technologies](https://technet.microsoft.com/library/bb726951.aspx).

Certificate Revocation Lists  

Certificate revocation lists (CRLs) are used to distribute information about revoked certificates to individuals, computers, and applications that try to verify the validity of certificates. CRLs are complete, digitally signed lists of unexpired certificates that have been revoked. The CRL is retrieved by clients who can then cache the CRL (based on the configured lifetime of the CRL) and use it to verify certificates presented for use. By default, the CRL is published in two locations by a Microsoft Enterprise CA:  

- `http://CAName/certenroll/CRLName`
- LDAP:///CN=CAName,CN=CAComputerName,CN=CDP,CN=PublicKeyServices,CN=Services,CN=Configuration,DC=ForestRootDomain,DC=TLD  

Basic Certificate Chain Validation  

When CryptoAPI builds and validates a certificate chain, three distinct phases occur:  

1. All possible certificate chains are built by using locally cached certificates. If none of the certificate chains end in a self-signed certificate, CryptoAPI then selects the best possible chain and tries to retrieve issuer certificates specified in the authority information access extension to complete the chain. This process is repeated until a chain to a self-signed certificate is built.
2. For each chain that ends in a self-signed certificate in the trusted root store, revocation checking is performed.
3. Revocation checking is performed from the root CA certificate down to the evaluated certificate.  

More information about certificate revocation list (CRL) distribution points can be found at [Specify CRL Distribution Points](https://technet.microsoft.com/library/cc753296.aspx)  

Certificate Revocation Checking and CRL Distribution Points  

A certificate revocation check is required for the IP-HTTPS connection between the DirectAccess client and the DirectAccess server. If the certificate revocation check fails, DirectAccess clients cannot make IP-HTTPS-based connections to a DirectAccess server. Therefore, an Internet-based CRL distribution point location must be present in the IP-HTTPS certificate and available for DirectAccess clients that are connected to the Internet.

A certification revocation check is required for the IP-HTTPS-based connection between the DirectAccess client and the network location server. If the certificate revocation check fails, DirectAccess clients cannot access an IP-HTTPS-based URL on the network location server. Therefore, an intranet-based CRL distribution point location must be present in the network location server certificate and be available for DirectAccess clients that are connected to the intranet, even when there are DirectAccess rules in the Name Resolution Policy Table (NRPT).

A certification revocation check is required for the IPsec tunnels between the DirectAccess client and the DirectAccess server.  
