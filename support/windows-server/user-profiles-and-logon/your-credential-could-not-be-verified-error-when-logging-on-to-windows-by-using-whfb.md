---
title: Your credentials could not be verified error when logging on to Windows with WHFB
description: Introduces how to troubleshoot the Your credentials could not be verified error that occurs when you try to log on to Windows 10 or Windows 11.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 05/05/2023
ms.prod: windows-server
ms.reviewer: kaushika
ms.technology: windows-server-user-profiles
ms.custom: sap:user-logon-fails, csstroubleshoot, ikb2lmc
---
# "Your credentials could not be verified" error when logging on to Windows with Windows Hello for Business

This article introduces how to fix the error "Your credentials could not be verified" that occurs when you try to log on to Windows with Windows Hello for Business (WHFB).

_Applies to:_ Windows 10, Windows 11  
_Original KB number:_ 4519735

## Symptom

When you try to sign in to a Windows 10 or Windows 11 device by using a WHFB certificate or key trust, it fails with one of the following error messages:

> Your credentials could not be verified

> Something went wrong and your PIN isn't available (status: 0xc00000bb, substatus:0x0). Click to set up your PIN again.

## Cause

This issue occurs because the issuing Certificate Authority (CA) certificate is missing in the NTAuth store of the domain controller and client machine.

When you use WHFB, the domain controller needs to validate the certificate sent by the client machine. During the validation, it checks the Key Distribution Center (KDC) service on the domain controller to verify if it can find the issuing CA certificate in the NTAuth registry key. The NTAuth registry key locates at `HKLM\Software\Microsoft\EnterpriseCertificates\NTAuth\Certificates`.

> [!NOTE]
> What the EnterpriseCertificates registry key presents is a location in Active Directory. During a Group policy update, these certificates are imported to the registry by all client machines, members, and domain controllers in the forest.

### How to identify the issue

1. Open the **Certificate Authority** snap-in.
2. Right-click on the issuing CA server and select **Properties**.
3. Go to the **General** tab and select the current certificates if there are multiple certificates, and then select **View Certificate**.
4. Go to the **Details** tab and scroll down to the **Thumbprint** attribute.
5. Write down the thumbprint of the issuing CA certificate.
6. Open the registry on the domain controller and navigate to `HKLM\Software\Microsoft\EnterpriseCertificates\NTAuth\Certificates`.
7. Verify if you have a folder under the above registry key with the thumbprint value.

## Resolution

1. Open the **Certificate Authority** snap-in.
2. Right-click on the issuing CA server and select **Properties**.
3. Go to the **General** tab and select the current certificates if there are multiple certificates, and then select **View Certificate**.
4. Export the certificate by using the **Copy to File** option. And save it as a file such as *IssuingCA.cer*.
5. Sign in by using the Enterprise administrator credentials on a domain controller and run the following command:

   ```console
   certutil -dspublish -f IssuingCA.cer NTAuthCA
   certutil -enterprise -addstore NTAuth IssuingCA.cer
   ```

6. Run `gpupdate /force` and confirm that the thumbprint of your issuing CA is created under this registry hive, `HKLM\Software\Microsoft\EnterpriseCertificates\NTAuth\Certificates`.
7. Wait for the Active Directory replication to complete.
8. Run `gpupdate /force` on the client computers as well and ensure that the thumbprint of the issuing CA certificate is created on the client computers.
