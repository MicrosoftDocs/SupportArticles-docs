---
title: Integrated authentication with Firefox
description: This article provides a resolution for the problem that occurs when Mozilla Firefox users attempt to log in to Microsoft Dynamics CRM 2011 by using Integrated Windows authentication.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 
---
# Microsoft Dynamics CRM 2011 Integrated authentication with Firefox in Update Rollup 12

This article helps you resolve the problem that occurs when Mozilla Firefox users attempt to log in to Microsoft Dynamics CRM 2011 using Integrated Windows authentication.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2786247

## Symptoms

Mozilla Firefox users are prompted for credentials when attempting to log in to Microsoft Dynamics CRM 2011 by using Integrated Windows authentication.

## Cause

This behavior is by design, as Firefox rejects all SPNEGO login challenges (Kerberos, NTLM, or other authentication protocols). For more information regarding this behavior, see [Integrated Authentication](https://developer.mozilla.org/docs/integrated_authentication).

## Resolution

This issue can be resolved by altering the `network.automatic-ntlm-auth.trusted-uris` configuration property to include the Microsoft Dynamics CRM website.

1. In Firefox, navigate to the URL: `about:config`.
2. If a warning page appears with the message: **`This might void your warranty!`**, click **`I'll be careful, I promise!`**.
3. Locate and double-click on the **network.automatic-ntlm-auth.trusted-uris** string property.
4. In the **Enter String Value** box, enter the URL address used to access the Microsoft Dynamics CRM website (ex. `https://crm`).

    > [!NOTE]
    > The multiple websites can be separated in the string value by using a comma.

5. Click **Ok**.
6. Close and reopen **Firefox**.

## More information

Cross browser compatibility was introduced to Microsoft Dynamics CRM 2011 in Update Rollup 12. Previous versions of Microsoft Dynamics CRM are not supported for cross browser access.
