---
title: Change expiration date of certificates
description: Describes how to change the validity period of a certificate that is issued by Certificate Authority (CA).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
ms.subservice: active-directory
---
# Change the expiration date of certificates that are issued by Certificate Authority

This article describes how to change the validity period of a certificate that is issued by Certificate Authority (CA).

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 254632

## Summary

By default, the lifetime of a certificate that is issued by a Stand-alone Certificate Authority CA is one year. After one year, the certificate expires and is not trusted for use. There may be situations when you have to override the default expiration date for certificates that are issued by an intermediate or an issuing CA.

The validity period that is defined in the registry affects all certificates that are issued by Stand-alone and Enterprise CAs. For Enterprise CAs, the default registry setting is two years. For Stand-alone CAs, the default registry setting is one year. For certificates that are issued by Stand-alone CAs, the validity period is determined by the registry entry that is described later in this article. This value applies to all certificates that are issued by the CA.

For certificates that are issued by Enterprise CAs, the validity period is defined in the template that is used to create the certificate. Windows 2000 and Windows Server 2003 Standard Edition do not support modification of these templates. Windows Server 2003 Enterprise Edition supports Version 2 certificate templates that can be modified. The validity period defined in the template applies to all certificates issued by any Enterprise CA in the Active Directory forest. A certificate that is issued by a CA is valid for the minimum of the following periods of time:

- The registry validity period that is noted earlier in this article.

    This applies to the stand-alone CA, and Subordinate CA certificates issued by the Enterprise CA.

- The template validity period.

This applies to the Enterprise CA. Templates supported by Windows 2000 and Windows Server 2003 Standard Edition cannot be modified. Templates supported by Windows Server Enterprise Edition (Version 2 templates) do support modification.

For an Enterprise CA, the validity period of an issued certificate is set to the minimum of all the following:

- The registry validity period of the CA (for example: **ValidityPeriod** == Years, **ValidityPeriodUnits** == 1)
- The template validity period
- The remaining validity period of the signing certificate of the CA
- If the EDITF_ATTRIBUTEENDDATE bit is enabled in the policy module's EditFlags registry value, the validity period specified through the request attributes (ExpirationDate:Date or ValidityPeriod:Years\nValidityPeriodUnits:1)

> [!NOTE]
>
> - The ExpirationDate:Date syntax was not supported until Windows Server 2008.
> - For a stand-alone CA, no templates are processed. Therefore, the template validity period does not apply.

## The expiration date of the CA certificate

A CA cannot issue a certificate with a longer validity period than its own CA certificate.

> [!NOTE]
> The Request Attribute name is made up of value string pairs that accompany the request and that specify the validity period. By default, this is enabled by a registry setting on a Standalone CA only.

## Change expiration date of certificates issued by CA

To change the validity period settings for a CA, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).  

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *regedit*, and then click **OK**.
3. Locate, and then click the following registry key:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\CertSvc\Configuration\<CAName>`

4. In the right pane, double-click **ValidityPeriod**.
5. In the **Value data** box, type one of the following, and then click **OK**:

    - Days
    - Weeks
    - Months
    - Years
6. In the right pane, double-click **ValidityPeriodUnits**.
7. In the **Value data** box, type the numeric value that you want, and then click **OK**. For example, type *2*.
8. Stop, and then restart the Certificate Services service. To do so:

    1. Click **Start**, and then click **Run**.
    2. In the **Open** box, type *cmd*, and then click **OK**.
    3. At the command prompt, type the following lines. Press ENTER after each line.

        ```console
        net stop certsvc
        net start certsvc
        ```

    4. Type exit to quit Command Prompt.
