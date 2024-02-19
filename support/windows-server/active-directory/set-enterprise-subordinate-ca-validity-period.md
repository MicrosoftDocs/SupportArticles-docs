---
title: Set different validity period for subordinate CA
description: Describes how to set an enterprise subordinate certification authority (CA) to have a different certificate validity period than that of the parent CA.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# How to Set an Enterprise Subordinate CA to Have a Different Certificate Validity Period than the Parent CA

This article describes how to set an enterprise subordinate certification authority (CA) to have a different certificate validity period than that of the parent CA.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 281557

## Summary

You can use the following steps to give a subordinate CA a different certificate validation period than that of the parent CA. This process is divided into the following three steps:

Step 1: Set the validation period on the parent CA.
Step 2: Install the subordinate CA.
Step 3: Set the validation time back on the parent CA.

1. Set the validation period on the parent CA. To do this, use the following commands to set the desired validation period on the parent CA that will issue the certificate of the subordinate CA:

    ```console
    certutil -setreg ca\ValidityPeriod "Weeks" 
    certutil -setreg ca\ValidityPeriodUnits "3" 
    ```

2. Install the subordinate CA. Make sure that you use the parent CA that you used in step 1.
3. Reset the validation period on the parent CA that issued the certificate of the subordinate CA (for example, "2 years", which is the default value). To do this, use the following commands:

    ```console
    certutil -setreg ca\ValidityPeriod "Years" 
    certutil -setreg ca\ValidityPeriodUnits "2"
    ```

    > [!NOTE]
    > If you run `certutil -getreg ca\val*` on the subordinate CA, both the ValidityPeriod property and the ValidityPeriodUnits property are still synchronized with the parent CA, even though the subordinate CA certificate is only valid for three weeks.
