---
title: CSP shows loading if submitting a certificate request
description: Describes a problem that occurs because active scripting is disabled for the security zone to which the application enterprise CA belongs. A resolution is provided.
ms.date: 03/08/2020
ms.prod-support-area-path: Internet Explorer
ms.reviewer:  v-jomcc, okang
---
# CSP field shows Loading when you submit a certificate request to an enterprise CA in Internet Explorer

This article provides the resolution to solve the issue that the value in the CSP field appears as Loading if you use the Advanced Certificate Request page to submit a certificate request to an enterprise CA in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 939290

## Symptoms

Consider the following scenario in Windows Internet Explorer:

- You use the Advanced Certificate Request page.

- You submit a certificate request to an enterprise certification authority (CA).

In this scenario, the value in the **CSP** field under **Key Options** appears as Loading.

## Cause

This problem occurs because active scripting is disabled for the security zone to which the application enterprise CA belongs.

## Resolution

To solve this problem, enable active scripting for the security zone to which the enterprise CA belongs. To do this, follow these steps:

1. Open Internet Explorer.

2. On the **Tools** menu, click **Internet Options**.

3. On the **Security** tab, click the security zone to which the enterprise CA belongs, and then click **Custom Level**.

   > [!NOTE]
   > The security zone appears in the Internet Explorer status bar when you use the Advanced Certificate Request page.

4. Scroll down to **Scripting**. Note the current setting for **Active scripting**.

5. If **Active Scripting** is set to **Disable** or to **Prompt**, click **Enable**, and then click **OK**.

6. Click **Yes** to dismiss the warning message.

## References

For more information about how to troubleshoot script errors in Internet Explorer 6 and in Internet Explorer 7 on Windows 2000-based, Windows XP-based, Windows Server 2003-based, or Windows Vista-based computers, see [How to Troubleshoot Script Errors in Internet Explorer](https://support.microsoft.com/help/308260).
