---
title: NDR error 550 5.7.64 TenantAttribution when sending emails through EOP
description: Describes an issue in which you receive a 550 5.7.64 TenantAttribution; Relay Access Denied SMTP error when sending mail through Exchange Online Protection.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
ms.reviewer: rrajan, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# "550 5.7.64 TenantAttribution" when sending emails through Exchange Online Protection

_Original KB number:_ &nbsp; 3212877

## Problem

Consider the following scenario:

- You relay email through Exchange Online Protection from your on-premises Exchange environment or from your Internet Information Services (IIS) SMTP server.
- You have an inbound connector that's set to on-premises and has certificate validation enabled.

In this scenario, mail isn't relayed through Exchange Online Protection. Additionally, you receive the following error message:

> 550 5.7.64 TenantAttribution; Relay Access Denied SMTP

Senders receive a non-delivery report (NDR) that contains this error code. Or, you see the error logged in IIS SMTP logs or in Send connector logs.

Additionally, if you enabled CAPI2 operational logging in Event Viewer, the following entry is logged:

```xml
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
 <System>
 <Provider Name="Microsoft-Windows-CAPI2" Guid="{5bbca4a8-b209-48dc-a8c7-b23d3e5216fb}" />
 <EventID>30</EventID>
 <Version>0</Version>
 <Level>2</Level>
 <Task>30</Task>
 <Opcode>0</Opcode>
 <Keywords>0x4000000000000001</Keywords>
 <TimeCreated SystemTime="2016-12-01T03:09:55.456180600Z" />
 <EventRecordID>3156</EventRecordID>
 <Correlation />
 <Execution ProcessID="544" ThreadID="1996" />
 <Channel>Microsoft-Windows-CAPI2/Operational</Channel>
 <Computer>CORP-SMTP1.ServerName.com</Computer>
 <Security UserID="S-1-5-18" />
 </System>
 <UserData>
 <CertVerifyCertificateChainPolicy>
 <Policy type="CERT_CHAIN_POLICY_SSL" constant="4" />
 <Certificate fileRef="EC53EBC94A796C42E5B4E5851F961874F013D94C.cer" subjectName="*.ServerName.com" />
 <CertificateChain chainRef="{8729A893-3D34-49D1-8030-8513DE8E8897}" />
 <Flags value="0" />
 <SSLAdditionalPolicyInfo authType="server">
 <IgnoreFlags value="280" SECURITY_FLAG_IGNORE_REVOCATION="true" SECURITY_FLAG_IGNORE_WRONG_USAGE="true" />
 </SSLAdditionalPolicyInfo>
 <Status chainIndex="0" elementIndex="-1" />
 <EventAuxInfo ProcessName="lsass.exe" impersonateToken="S-1-5-18" />
 <CorrelationAuxInfo TaskId="{AD28C3AB-7CFE-4CF0-A623-F6CAC805A73C}" SeqNumber="1" />
 <Result value="800B0109">A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider.</Result>
 </CertVerifyCertificateChainPolicy>
 </UserData>
</Event>
```

## Cause

This problem occurs if the on-premises server is not sending the required certificate chain during the Transport Layer Security (TLS) handshake to Exchange Online.

## Solution

To resolve this problem, follow these steps:

1. Get the list of intermediate certificates from the issuer of the third-party certificate.
1. Export the intermediate certificates from the affected server.

   1. Open the Certificates snap-in on the affected server.
   1. Select **Computer account**, and then click **Local Computer**.
   1. In the console tree, expand **Personal**, and then click **Certificate**.
   1. Double-click the third-party certificate that's associated with the SMTP service, and then click the **Certification Path** tab.
   1. Select the intermediate certificate in the certificate path that's listed, click **View Certificate**, and then click **Copy to File** on the **Detail** tab.
   1. On the **Export File Format** page, select **DER encoded binary X.509 (.CER)**, and then click **Next**.
   1. On the **File to Export** page, select the file name and path, click **Next**, and then click **Finish**.
   1. If there's more than one intermediate certificates in the certificate path, repeat step 2C through step 2F for every intermediate certificate in the path.
1. Import the intermediate certificates that you exported in step 2 to the intermediate certification authorities (CAs) on the sending server. To do this, run the following command in an elevated Windows PowerShell session:

    ```powershell
    Get-ChildItem -Path c:\import\intermediateca.cer | Import-Certificate -CertStoreLocation cert:\LocalMachine\CA
    ```  

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
