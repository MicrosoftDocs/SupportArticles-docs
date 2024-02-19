---
title: Renewal of Enrollment Agent certificate fails
description: Provides a solution to fix an issue where renewing Exchange Enrollment Agent (Offline request) certificate by using NDES fails.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:network-device-enrollment-services-ndes, csstroubleshoot
---
# Renewal of "Enrollment Agent" certificate used by NDES may fail

This article provides a solution to fix an issue where renewing Exchange Enrollment Agent (Offline request) certificate by using NDES fails.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2712186

## Symptoms

You get the error "Status: unavailable" when trying to renew "Exchange Enrollment Agent (Offline request)" certificate used by NDES, from the computer certificate store console in MMC.

## Cause

Network Device Enrollment Service (NDES) requests two certificates according to the following two certificate templates configured with the "Intended purpose" (Enhanced Key Usages) set to "Certificate Request Agent":

- CEP Encryption.
- Exchange Enrollment Agent (Offline request).

When you install the NDES service on a Windows Server 2008 server, it requires you to provide a domain user that the NDES will use to authorize certificate requests. So, there are different security contexts to consider: the installer context (who installs the NDES) and the service context (the domain user that is provided during installation, and under which the NDES runs later). The Enrollment Agent certificate is enrolled during the installation and under the installer context, but will be loaded by the NDES later under the service context. For the above reason, the Enrollment Agent certificate (and the CEP Encryption certificate) must be stored in the common store that those context can access, and the computer certificate store is chosen.

However, since the "Subject Type" of the certificate template "Exchange Enrollment Agent (Offline request)" is set to "User", we won't be able to renew the certificate template "Exchange Enrollment Agent (Offline request)" in MMC console (computer certificate store) due to mismatched type of subject. The error "Status: unavailable" would be returned in this situation.

Note: This issue doesn't happen when trying to renew "CEP Encryption" certificate template, because its subject type is set to "Computer or other Device". Therefore, renewal of this certificate can succeed as long as you have sufficient permission on the system and certificate template.  

## Resolution

Use the certreq.exe tool to renew the Exchange Enrollment Agent (Offline request) certificate with the following steps:

1. Create a file named Request.inf with the following contents:  

    > *[Version]*  
    *Signature="$Windows NT$"*  
    *[NewRequest]*  
    *RenewalCert="\<Certificate Hash>"*  
    *MachineKeySet=TRUE*  

    > [!Note]
    > The INF file contains input options that define the certificate request parameters. In the above INF file, it tells the command-line tool certreq.exe to renew the certificate with the specified Certificate Hash. You can get the Exchange Enrollment Agent (Offline request) certificate's certificate hash by copying the value of the certificate's "*t* *h* *umbprint* " extension retrieved from certificate's "Details tab". For example, if the certificate's Thumbprint is "*5* *3 60 8f 10 49 1d 50 bf a2 9f 06 17 96 8a 93 05 13 cc b9 55*", we will need to edit the contents to the lines below:

    > *[Version]*  
     *Signature="$Windows NT$"*  
     *[NewRequest]*  
     *RenewalCert="53 60 8f 10 49 1d 50 bf a2 9f 06 17 96 8a 93 05 13 cc b9 55"*  
     *MachineKeySet=TRUE*  

    > [!Note]
    > MachineKeySet set to "True" so the certificate and its private key will be stored in computer certificate store.

   > [!Note]
   > To open the computer certificate store, please refer to the following technet article:
    Add the Certificates Snap-in to an MMC
    [Add the Certificates Snap-in to an MMC](https://technet.microsoft.com/library/cc754431%28v=ws.10%29.aspx#bkmk_computer)  

2. Run the following three commands to renew that old Enrollment Agent certificate:  

    ```console
    CertReq.exe -New Request.inf Certnew.req  
    CertReq.exe -Submit Certnew.req Certnew.cer  
    CertReq.exe -Accept Certnew.cer  
    ```

    > [!Note]
    >
    > - You will need administrative permissions and certificate enrollment permission to perform the actions above. If your enrollment request needs to wait for CA manager's approval, please contact your CA manager to approve the request. Or, provide the request file generated in first command to your CA manager, and ask for a certificate so we can use the third command to install the certificate.
    > - The steps above apply to the situation where the default certificate template is used for NDES. In the case that NDES is configured to use specific template, please change the inf file contents accordingly. For more Information about the syntax of the request file, please refer to the following article:  
    [Appendix 3: Certreq.exe Syntax](https://technet.microsoft.com/library/cc736326%28v=ws.10%29.aspx)  
    > - When running first command above, a dialog box will pop up to let us confirm the certificate that needs be renewed. Ensure the old Enrollment Agent certificate is selected, and click OK.
    > - At the second command, another dialog box will pop up to let us choose the CA server for issuing the renewed Enrollment Agent certificate. Please select the proper CA, and click OK.
