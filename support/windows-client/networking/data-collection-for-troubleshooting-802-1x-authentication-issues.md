---
title: Data collection for troubleshooting 802.1X authentication issues
description: Use the steps in this article to collect data that can be used to troubleshoot 802.1X authentication issues.
ms.date: 02/14/2023
manager: dcscontentpm
ms.service: windows-client
author: dansimp
ms.author: dansimp
ms.topic: troubleshooting
ms.subservice: networking
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
ms.reviewer: dansimp
audience: itpro
localization_priority: medium
---
# Data collection for troubleshooting 802.1X authentication

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806441" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Wireless technology issues.

Use the following steps to collect data that can be used to troubleshoot 802.1X authentication issues. When you have collected data, see [Advanced troubleshooting 802.1X authentication](802-1x-authentication-issues-troubleshooting.md).

_Applies to:_ &nbsp; Windows 10

## Capture wireless/wired functionality logs

Use the following steps to collect wireless and wired logs on Windows and Windows Server:

1. Create *C:\\MSLOG* on the client machine to store captured logs.
2. Launch an elevated command prompt on the client machine, and run the following commands to start a RAS trace log and a Wireless/Wired scenario log.

   Wireless Windows 8.1, Windows 10, and Windows 11:

   ```console
   netsh ras set tracing * enabled
   netsh trace start scenario=wlan,wlan_wpp,wlan_dbg,wireless_dbg globallevel=0xff capture=yes maxsize=1024 tracefile=C:\MSLOG\%COMPUTERNAME%_wireless_cli.etl
   ```

   Wireless Windows 7 and Windows 8:

   ```console
   netsh ras set tracing * enabled
   netsh trace start scenario=wlan,wlan_wpp,wlan_dbg globallevel=0xff capture=yes maxsize=1024 tracefile=C:\MSLOG\%COMPUTERNAME%_wireless_cli.etl
   ```

   Wired client, regardless of version

   ```console
   netsh ras set tracing * enabled
   netsh trace start scenario=lan globallevel=0xff capture=yes maxsize=1024 tracefile=C:\MSLOG\%COMPUTERNAME%_wired_cli.etl
   ```

3. Run the following command to enable CAPI2 logging and increase the size:

   ```console
   wevtutil.exe sl Microsoft-Windows-CAPI2/Operational /e:true
   wevtutil sl Microsoft-Windows-CAPI2/Operational /ms:104857600
   ```

4. Create *C:\\MSLOG* on the NPS to store captured logs.
5. Launch an elevated command prompt on the NPS server and run the following commands to start a RAS trace log and a Wireless/Wired scenario log:

   Windows Server 2012 R2, Windows Server 2016 wireless network:

   ```console
   netsh ras set tracing * enabled
   netsh trace start scenario=wlan,wlan_wpp,wlan_dbg,wireless_dbg globallevel=0xff capture=yes maxsize=1024 tracefile=C:\MSLOG\%COMPUTERNAME%_wireless_nps.etl
   ```

   Windows Server 2008 R2, Windows Server 2012 wireless network

   ```console
   netsh ras set tracing * enabled
   netsh trace start scenario=wlan,wlan_wpp,wlan_dbg globallevel=0xff capture=yes maxsize=1024 tracefile=C:\MSLOG\%COMPUTERNAME%_wireless_nps.etl
   ```

   Wired network

   ```console
   netsh ras set tracing * enabled
   netsh trace start scenario=lan globallevel=0xff capture=yes maxsize=1024 tracefile=C:\MSLOG\%COMPUTERNAME%_wired_nps.etl
   ```

6. Run the following command to enable CAPI2 logging and increase the size:

   ```console
    wevtutil.exe sl Microsoft-Windows-CAPI2/Operational /e:true
    wevtutil sl Microsoft-Windows-CAPI2/Operational /ms:104857600
   ```

7. Run the following command from the command prompt on the client machine and start PSR to capture screen images:

   > [!NOTE]
   > When the mouse button is clicked, the cursor will blink in red while capturing a screen image.

   ```console
   psr /start /output c:\MSLOG\%computername%_psr.zip /maxsc 100
   ```

8. Repro the issue.
9. Run the following command on the client PC to stop the PSR capturing:

   ```console
   psr /stop
   ```

10. Run the following commands from the command prompt on the NPS server.

    - To stop RAS trace log and wireless scenario log:

      ```console
      netsh trace stop
      netsh ras set tracing * disabled
      ```

    - To disable and copy CAPI2 log:

      ```console
      wevtutil.exe sl Microsoft-Windows-CAPI2/Operational /e:false
      wevtutil.exe epl Microsoft-Windows-CAPI2/Operational C:\MSLOG\%COMPUTERNAME%_CAPI2.evtx
      ```

11. Run the following commands on the client PC.
    - To stop RAS trace log and wireless scenario log:

      ```console
      netsh trace stop
      netsh ras set tracing * disabled
      ```

    - To disable and copy the CAPI2 log:

      ```console
      wevtutil.exe sl Microsoft-Windows-CAPI2/Operational /e:false
      wevtutil.exe epl Microsoft-Windows-CAPI2/Operational C:\MSLOG\%COMPUTERNAME%_CAPI2.evtx
      ```

12. Save the following logs on the client and the NPS:

    Client
      - *C:\\MSLOG\\%computername%_psr.zip*
      - *C:\\MSLOG\\%COMPUTERNAME%_CAPI2.evtx*
      - *C:\\MSLOG\\%COMPUTERNAME%_wireless_cli.etl*
      - *C:\\MSLOG\\%COMPUTERNAME%_wireless_cli.cab*
      - All log files and folders in *%Systemroot%\\Tracing*

    NPS
      - *C\\MSLOG\\%COMPUTERNAME%_CAPI2.evtx*
      - *C:\\MSLOG\\%COMPUTERNAME%_wireless_nps.etl* (*%COMPUTERNAME%_wired_nps.etl* for wired scenario)
      - *C:\\MSLOG\\%COMPUTERNAME%_wireless_nps.cab* (*%COMPUTERNAME%_wired_nps.cab* for wired scenario)
      - All log files and folders in *%Systemroot%\\Tracing*

## Save environment and configuration information

### On Windows client

1. Create *C:\\MSLOG* to store captured logs.
2. Launch a command prompt as an administrator.
3. Run the following commands.
   - Environment information and Group Policy application status

     ```console
     gpresult /H C:\MSLOG\%COMPUTERNAME%_gpresult.htm
     msinfo32 /report c:\MSLOG\%COMPUTERNAME%_msinfo32.txt
     ipconfig /all > c:\MSLOG\%COMPUTERNAME%_ipconfig.txt
     route print > c:\MSLOG\%COMPUTERNAME%_route_print.txt
     ```

   - Event logs

     ```console
     wevtutil epl Application c:\MSLOG\%COMPUTERNAME%_Application.evtx
     wevtutil epl System c:\MSLOG\%COMPUTERNAME%_System.evtx
     wevtutil epl Security c:\MSLOG\%COMPUTERNAME%_Security.evtx
     wevtutil epl Microsoft-Windows-GroupPolicy/Operational C:\MSLOG\%COMPUTERNAME%_GroupPolicy_Operational.evtx
     wevtutil epl "Microsoft-Windows-WLAN-AutoConfig/Operational" c:\MSLOG\%COMPUTERNAME%_Microsoft-Windows-WLAN-AutoConfig-Operational.evtx
     wevtutil epl "Microsoft-Windows-Wired-AutoConfig/Operational" c:\MSLOG\%COMPUTERNAME%_Microsoft-Windows-Wired-AutoConfig-Operational.evtx
     wevtutil epl Microsoft-Windows-CertificateServicesClient-CredentialRoaming/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-CredentialRoaming_Operational.evtx
     wevtutil epl Microsoft-Windows-CertPoleEng/Operational c:\MSLOG\%COMPUTERNAME%_CertPoleEng_Operational.evtx
     ```

   - For Windows 8 and later, also run these commands for event logs:

     ```console
     wevtutil epl Microsoft-Windows-CertificateServicesClient-Lifecycle-System/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-Lifecycle-System_Operational.evtx
     wevtutil epl Microsoft-Windows-CertificateServicesClient-Lifecycle-User/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-Lifecycle-User_Operational.evtx
     wevtutil epl Microsoft-Windows-CertificateServices-Deployment/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServices-Deployment_Operational.evtx
     ```

   - Certificates Store information:

     ```console
     certutil -v -silent -store MY > c:\MSLOG\%COMPUTERNAME%_cert-Personal-Registry.txt
     certutil -v -silent -store ROOT > c:\MSLOG\%COMPUTERNAME%_cert-TrustedRootCA-Registry.txt
     certutil -v -silent -store -grouppolicy ROOT > c:\MSLOG\%COMPUTERNAME%_cert-TrustedRootCA-GroupPolicy.txt
     certutil -v -silent -store -enterprise ROOT > c:\MSLOG\%COMPUTERNAME%_TrustedRootCA-Enterprise.txt
     certutil -v -silent -store TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-Reg.txt
     certutil -v -silent -store -grouppolicy TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-GroupPolicy.txt
     certutil -v -silent -store -enterprise TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-Enterprise.txt
     certutil -v -silent -store CA > c:\MSLOG\%COMPUTERNAME%_cert-IntermediateCA-Registry.txt
     certutil -v -silent -store -grouppolicy CA > c:\MSLOG\%COMPUTERNAME%_cert-IntermediateCA-GroupPolicy.txt
     certutil -v -silent -store -enterprise CA > c:\MSLOG\%COMPUTERNAME%_cert-Intermediate-Enterprise.txt
     certutil -v -silent -store AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-Registry.txt
     certutil -v -silent -store -grouppolicy AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-GroupPolicy.txt
     certutil -v -silent -store -enterprise AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-Enterprise.txt
     certutil -v -silent -store SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-Registry.txt
     certutil -v -silent -store -grouppolicy SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-GroupPolicy.txt
     certutil -v -silent -store -enterprise SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-Enterprise.txt
     certutil -v -silent -store -enterprise NTAUTH > c:\MSLOG\%COMPUTERNAME%_cert-NtAuth-Enterprise.txt
     certutil -v -silent -user -store MY > c:\MSLOG\%COMPUTERNAME%_cert-User-Personal-Registry.txt
     certutil -v -silent -user -store ROOT > c:\MSLOG\%COMPUTERNAME%_cert-User-TrustedRootCA-Registry.txt
     certutil -v -silent -user -store -enterprise ROOT > c:\MSLOG\%COMPUTERNAME%_cert-User-TrustedRootCA-Enterprise.txt
     certutil -v -silent -user -store TRUST > c:\MSLOG\%COMPUTERNAME%_cert-User-EnterpriseTrust-Registry.txt
     certutil -v -silent -user -store -grouppolicy TRUST > c:\MSLOG\%COMPUTERNAME%_cert-User-EnterpriseTrust-GroupPolicy.txt
     certutil -v -silent -user -store CA > c:\MSLOG\%COMPUTERNAME%_cert-User-IntermediateCA-Registry.txt
     certutil -v -silent -user -store -grouppolicy CA > c:\MSLOG\%COMPUTERNAME%_cert-User-IntermediateCA-GroupPolicy.txt
     certutil -v -silent -user -store Disallowed > c:\MSLOG\%COMPUTERNAME%_cert-User-UntrustedCertificates-Registry.txt
     certutil -v -silent -user -store -grouppolicy Disallowed > c:\MSLOG\%COMPUTERNAME%_cert-User-UntrustedCertificates-GroupPolicy.txt
     certutil -v -silent -user -store AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-3rdPartyRootCA-Registry.txt
     certutil -v -silent -user -store -grouppolicy AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-3rdPartyRootCA-GroupPolicy.txt
     certutil -v -silent -user -store SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-SmartCardRoot-Registry.txt
     certutil -v -silent -user -store -grouppolicy SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-SmartCardRoot-GroupPolicy.txt
     certutil -v -silent -user -store UserDS > c:\MSLOG\%COMPUTERNAME%_cert-User-UserDS.txt
     ```

   - Wireless LAN client information:

     ```console
     netsh wlan show all > c:\MSLOG\%COMPUTERNAME%_wlan_show_all.txt
     netsh wlan export profile folder=c:\MSLOG\
     ```

   - Wired LAN Client information

     ```console
     netsh lan show interfaces > c:\MSLOG\%computername%_lan_interfaces.txt
     netsh lan show profiles > c:\MSLOG\%computername%_lan_profiles.txt
     netsh lan show settings > c:\MSLOG\%computername%_lan_settings.txt
     netsh lan export profile folder=c:\MSLOG\
     ```

4.  Save the logs stored in *C:\\MSLOG*.

### On NPS

1. Create *C:\\MSLOG* to store captured logs.
2. Launch a command prompt as an administrator.
3. Run the following commands.

   - Environmental information and Group Policies application status:

       ```console
       gpresult /H C:\MSLOG\%COMPUTERNAME%_gpresult.txt
       msinfo32 /report c:\MSLOG\%COMPUTERNAME%_msinfo32.txt
       ipconfig /all > c:\MSLOG\%COMPUTERNAME%_ipconfig.txt
       route print > c:\MSLOG\%COMPUTERNAME%_route_print.txt
       ```

   - Event logs:

       ```console
       wevtutil epl Application c:\MSLOG\%COMPUTERNAME%_Application.evtx
       wevtutil epl System c:\MSLOG\%COMPUTERNAME%_System.evtx
       wevtutil epl Security c:\MSLOG\%COMPUTERNAME%_Security.evtx
       wevtutil epl Microsoft-Windows-GroupPolicy/Operational c:\MSLOG\%COMPUTERNAME%_GroupPolicy_Operational.evtx
       wevtutil epl Microsoft-Windows-CertificateServicesClient-CredentialRoaming/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-CredentialRoaming_Operational.evtx
       wevtutil epl Microsoft-Windows-CertPoleEng/Operational c:\MSLOG\%COMPUTERNAME%_CertPoleEng_Operational.evtx
       ```

   - Run the following commands on Windows Server 2012 and later:

       ```console
       wevtutil epl Microsoft-Windows-CertificateServicesClient-Lifecycle-System/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-Lifecycle-System_Operational.evtx
       wevtutil epl Microsoft-Windows-CertificateServicesClient-Lifecycle-User/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-Lifecycle-User_Operational.evtx
       wevtutil epl Microsoft-Windows-CertificateServices-Deployment/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServices-Deployment_Operational.evtx
       ```

   - Certificates store information

       ```console
       certutil -v -silent -store MY > c:\MSLOG\%COMPUTERNAME%_cert-Personal-Registry.txt
       certutil -v -silent -store ROOT > c:\MSLOG\%COMPUTERNAME%_cert-TrustedRootCA-Registry.txt
       certutil -v -silent -store -grouppolicy ROOT > c:\MSLOG\%COMPUTERNAME%_cert-TrustedRootCA-GroupPolicy.txt
       certutil -v -silent -store -enterprise ROOT > c:\MSLOG\%COMPUTERNAME%_TrustedRootCA-Enterprise.txt
       certutil -v -silent -store TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-Reg.txt
       certutil -v -silent -store -grouppolicy TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-GroupPolicy.txt
       certutil -v -silent -store -enterprise TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-Enterprise.txt
       certutil -v -silent -store CA > c:\MSLOG\%COMPUTERNAME%_cert-IntermediateCA-Registry.txt
       certutil -v -silent -store -grouppolicy CA > c:\MSLOG\%COMPUTERNAME%_cert-IntermediateCA-GroupPolicy.txt
       certutil -v -silent -store -enterprise CA > c:\MSLOG\%COMPUTERNAME%_cert-Intermediate-Enterprise.txt
       certutil -v -silent -store AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-Registry.txt
       certutil -v -silent -store -grouppolicy AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-GroupPolicy.txt
       certutil -v -silent -store -enterprise AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-Enterprise.txt
       certutil -v -silent -store SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-Registry.txt
       certutil -v -silent -store -grouppolicy SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-GroupPolicy.txt
       certutil -v -silent -store -enterprise SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-Enterprise.txt
       certutil -v -silent -store -enterprise NTAUTH > c:\MSLOG\%COMPUTERNAME%_cert-NtAuth-Enterprise.txt
       certutil -v -silent -user -store MY > c:\MSLOG\%COMPUTERNAME%_cert-User-Personal-Registry.txt
       certutil -v -silent -user -store ROOT > c:\MSLOG\%COMPUTERNAME%_cert-User-TrustedRootCA-Registry.txt
       certutil -v -silent -user -store -enterprise ROOT > c:\MSLOG\%COMPUTERNAME%_cert-User-TrustedRootCA-Enterprise.txt
       certutil -v -silent -user -store TRUST > c:\MSLOG\%COMPUTERNAME%_cert-User-EnterpriseTrust-Registry.txt
       certutil -v -silent -user -store -grouppolicy TRUST > c:\MSLOG\%COMPUTERNAME%_cert-User-EnterpriseTrust-GroupPolicy.txt
       certutil -v -silent -user -store CA > c:\MSLOG\%COMPUTERNAME%_cert-User-IntermediateCA-Registry.txt
       certutil -v -silent -user -store -grouppolicy CA > c:\MSLOG\%COMPUTERNAME%_cert-User-IntermediateCA-GroupPolicy.txt
       certutil -v -silent -user -store Disallowed > c:\MSLOG\%COMPUTERNAME%_cert-User-UntrustedCertificates-Registry.txt
       certutil -v -silent -user -store -grouppolicy Disallowed > c:\MSLOG\%COMPUTERNAME%_cert-User-UntrustedCertificates-GroupPolicy.txt
       certutil -v -silent -user -store AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-3rdPartyRootCA-Registry.txt
       certutil -v -silent -user -store -grouppolicy AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-3rdPartyRootCA-GroupPolicy.txt
       certutil -v -silent -user -store SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-SmartCardRoot-Registry.txt
       certutil -v -silent -user -store -grouppolicy SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-SmartCardRoot-GroupPolicy.txt
       certutil -v -silent -user -store UserDS > c:\MSLOG\%COMPUTERNAME%_cert-User-UserDS.txt
       ```

   - NPS configuration information:

       ```console
       netsh nps show config > C:\MSLOG\%COMPUTERNAME%_nps_show_config.txt
       netsh nps export filename=C:\MSLOG\%COMPUTERNAME%_nps_export.xml exportPSK=YES
       ```

4. Take the following steps to save an NPS accounting log.
   1. Open **Administrative tools** > **Network Policy Server**.
   2. On the Network Policy Server administration tool, select **Accounting** in the left pane.
   3. Select **Change Log File Properties**.
   4. On the **Log File** tab, note the log file naming convention shown as **Name** and the log file location shown in **Directory** box.
   5. Copy the log file to *C:\\MSLOG*.

5. Save the logs stored in *C:\\MSLOG*.

## Certification Authority (CA) (OPTIONAL)

1. On a CA, launch a command prompt as an administrator. Create *C:\\MSLOG* to store captured logs.
2. Run the following commands.
   - Environmental information and Group Policies application status

       ```console
       gpresult /H C:\MSLOG\%COMPUTERNAME%_gpresult.txt
       msinfo32 /report c:\MSLOG\%COMPUTERNAME%_msinfo32.txt
       ipconfig /all > c:\MSLOG\%COMPUTERNAME%_ipconfig.txt
       route print > c:\MSLOG\%COMPUTERNAME%_route_print.txt
       ```

   - Event logs

       ```console
       wevtutil epl Application c:\MSLOG\%COMPUTERNAME%_Application.evtx
       wevtutil epl System c:\MSLOG\%COMPUTERNAME%_System.evtx
       wevtutil epl Security c:\MSLOG\%COMPUTERNAME%_Security.evtx
       wevtutil epl Microsoft-Windows-GroupPolicy/Operational c:\MSLOG\%COMPUTERNAME%_GroupPolicy_Operational.evtx
       wevtutil epl Microsoft-Windows-CertificateServicesClient-CredentialRoaming/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-CredentialRoaming_Operational.evtx
       wevtutil epl Microsoft-Windows-CertPoleEng/Operational c:\MSLOG\%COMPUTERNAME%_CertPoleEng_Operational.evtx
       ```

   - Run the following lines on Windows 2012 and up

       ```console
       wevtutil epl Microsoft-Windows-CertificateServicesClient-Lifecycle-System/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-Lifecycle-System_Operational.evtx
       wevtutil epl Microsoft-Windows-CertificateServicesClient-Lifecycle-User/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServicesClient-Lifecycle-User_Operational.evtx
       wevtutil epl Microsoft-Windows-CertificateServices-Deployment/Operational c:\MSLOG\%COMPUTERNAME%_CertificateServices-Deployment_Operational.evtx
       ```

   - Certificates store information

       ```console
       certutil -v -silent -store MY > c:\MSLOG\%COMPUTERNAME%_cert-Personal-Registry.txt
       certutil -v -silent -store ROOT > c:\MSLOG\%COMPUTERNAME%_cert-TrustedRootCA-Registry.txt
       certutil -v -silent -store -grouppolicy ROOT > c:\MSLOG\%COMPUTERNAME%_cert-TrustedRootCA-GroupPolicy.txt
       certutil -v -silent -store -enterprise ROOT > c:\MSLOG\%COMPUTERNAME%_TrustedRootCA-Enterprise.txt
       certutil -v -silent -store TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-Reg.txt
       certutil -v -silent -store -grouppolicy TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-GroupPolicy.txt
       certutil -v -silent -store -enterprise TRUST > c:\MSLOG\%COMPUTERNAME%_cert-EnterpriseTrust-Enterprise.txt
       certutil -v -silent -store CA > c:\MSLOG\%COMPUTERNAME%_cert-IntermediateCA-Registry.txt
       certutil -v -silent -store -grouppolicy CA > c:\MSLOG\%COMPUTERNAME%_cert-IntermediateCA-GroupPolicy.txt
       certutil -v -silent -store -enterprise CA > c:\MSLOG\%COMPUTERNAME%_cert-Intermediate-Enterprise.txt
       certutil -v -silent -store AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-Registry.txt
       certutil -v -silent -store -grouppolicy AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-GroupPolicy.txt
       certutil -v -silent -store -enterprise AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-3rdPartyRootCA-Enterprise.txt
       certutil -v -silent -store SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-Registry.txt
       certutil -v -silent -store -grouppolicy SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-GroupPolicy.txt
       certutil -v -silent -store -enterprise SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-SmartCardRoot-Enterprise.txt
       certutil -v -silent -store -enterprise NTAUTH > c:\MSLOG\%COMPUTERNAME%_cert-NtAuth-Enterprise.txt
       certutil -v -silent -user -store MY > c:\MSLOG\%COMPUTERNAME%_cert-User-Personal-Registry.txt
       certutil -v -silent -user -store ROOT > c:\MSLOG\%COMPUTERNAME%_cert-User-TrustedRootCA-Registry.txt
       certutil -v -silent -user -store -enterprise ROOT > c:\MSLOG\%COMPUTERNAME%_cert-User-TrustedRootCA-Enterprise.txt
       certutil -v -silent -user -store TRUST > c:\MSLOG\%COMPUTERNAME%_cert-User-EnterpriseTrust-Registry.txt
       certutil -v -silent -user -store -grouppolicy TRUST > c:\MSLOG\%COMPUTERNAME%_cert-User-EnterpriseTrust-GroupPolicy.txt
       certutil -v -silent -user -store CA > c:\MSLOG\%COMPUTERNAME%_cert-User-IntermediateCA-Registry.txt
       certutil -v -silent -user -store -grouppolicy CA > c:\MSLOG\%COMPUTERNAME%_cert-User-IntermediateCA-GroupPolicy.txt
       certutil -v -silent -user -store Disallowed > c:\MSLOG\%COMPUTERNAME%_cert-User-UntrustedCertificates-Registry.txt
       certutil -v -silent -user -store -grouppolicy Disallowed > c:\MSLOG\%COMPUTERNAME%_cert-User-UntrustedCertificates-GroupPolicy.txt
       certutil -v -silent -user -store AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-3rdPartyRootCA-Registry.txt
       certutil -v -silent -user -store -grouppolicy AuthRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-3rdPartyRootCA-GroupPolicy.txt
       certutil -v -silent -user -store SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-SmartCardRoot-Registry.txt
       certutil -v -silent -user -store -grouppolicy SmartCardRoot > c:\MSLOG\%COMPUTERNAME%_cert-User-SmartCardRoot-GroupPolicy.txt
       certutil -v -silent -user -store UserDS > c:\MSLOG\%COMPUTERNAME%_cert-User-UserDS.txt
       ```

   - CA configuration information

       ```console
       reg save HKLM\System\CurrentControlSet\Services\CertSvc c:\MSLOG\%COMPUTERNAME%_CertSvc.hiv
       reg export HKLM\System\CurrentControlSet\Services\CertSvc c:\MSLOG\%COMPUTERNAME%_CertSvc.txt
       reg save HKLM\SOFTWARE\Microsoft\Cryptography c:\MSLOG\%COMPUTERNAME%_Cryptography.hiv
       reg export HKLM\SOFTWARE\Microsoft\Cryptography c:\MSLOG\%COMPUTERNAME%_Cryptography.txt
       ```

3. Copy the following files, if exist, to *C:\\MSLOG: %windir%\\CAPolicy.inf*
4. Sign in to a domain controller and create *C:\\MSLOG* to store captured logs.
5. Launch Windows PowerShell as an administrator.
6. Run the following PowerShell cmdlets. Replace the domain name in ";.. ,DC=test,DC=local"; with appropriate domain name. The example shows commands for "; test.local"; domain.

   ```powershell
   Import-Module ActiveDirectory
   Get-ADObject -SearchBase ";CN=Public Key Services,CN=Services,CN=Configuration,DC=test,DC=local"; -Filter * -Properties * | fl * > C:\MSLOG\Get-ADObject_$Env:COMPUTERNAME.txt
   ```

7. Save the following logs.

   - All files in *C:\\MSLOG* on the CA
   - All files in *C:\\MSLOG* on the domain controller
