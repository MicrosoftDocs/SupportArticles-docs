---
title: Errors occur when you install a certificate
description: This article describes the problem where you receive an error message when you try to install a certificate by using IIS Manager, and provides a resolution.
ms.date: 03/31/2020
ms.custom: sap:WWW authentication and authorization
ms.subservice: www-authentication-authorization
---
# Errors when you try to install a certificate by using IIS 7.0 Manager

This article helps you resolve the problem where an unexpected runtime error may be thrown when you try to install a certificate by using Microsoft Internet Information Services (IIS) 7.0 Manager

_Original product version:_ &nbsp; Windows Server 2008 Service Pack 2, Internet Information Services 7.0  
_Original KB number:_ &nbsp; 959216

## Symptoms

When you try to install a certificate from a `PKCS#7` file by using IIS 7.0 Manager, you may receive one of the following error messages:

- Error message 1

    > Cannot find the certificate request associated with this certificate file. A certificate request must be completed on the computer where it was created.

- Error message 2

    > There was an error while performing this operation  
    > Details: CertEnroll::CX509Enrollment::p_InstallResponse: ASN1 bad tag value met.  
    > 0x8009310b (ASN:276)

> [!NOTE]
> The certificate is installed correctly despite the error message.

## Cause

This issue occurs because IIS Manager performs a lookup operation to look for a friendly name of the certificate during the installation. However, the code that performs this lookup operation misses this specific case, and it doesn't know how to retrieve the friendly name of a certificate in a `PKCS#7` file. That's why the lookup operation fails, and you receive the error message.

## Resolution

To resolve this problem, add a friendly name to the certificate. Follow these steps to resolve this problem:

1. Select **Start**, select **Run**, type **certmgr.msc**, and then select **OK**.
2. Select **File**, select **Add/Remove Span-ins**.
3. Select **Certificates**, and select **Add**, and then select **OK**.
4. Select **Computer account**, and select **Next**, and then select **Finish**.
5. Select **OK**.
6. Expand **Certificates (Local Computer)**, and **Personal**, and then **Certificates**.
7. Right-click the **certificate**, and then select **Properties**.
8. Edit the **Friendly name** field.

## More information

This issue is scheduled to be resolved in Windows Server 2008 Service Pack 3.
