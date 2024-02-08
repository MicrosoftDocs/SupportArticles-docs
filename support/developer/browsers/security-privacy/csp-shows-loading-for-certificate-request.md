---
title: Failed to submit certificate application
description: Describes a problem that occurs because active scripting is disabled for the security zone to which the application enterprise CA belongs. A resolution is provided.
ms.date: 06/03/2020
ms.reviewer: okang
---
# CSP shows Loading when using Advanced Certificate Request to submit a request to an enterprise CA

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a solution to enable active scripting in the Internet Explorer security zone so that the webpage can receive your instruction to issue a certificate request.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 939290

## Symptoms

Consider the following scenario in Internet Explorer :

- You use the Advanced Certificate Request page.
- You submit a certificate request to an enterprise certification authority (CA). In this scenario, the value in the **CSP** field under **Key Options** appears as **Loading**.

## Cause

This problem occurs because active scripting is disabled for the security zone to which the application enterprise CA belongs.

## Resolution

To resolve this problem, enable active scripting for the security zone to which the enterprise CA belongs. To do this, follow these steps:

1. Open Internet Explorer.
2. On the **Tools** menu, click **Internet Options**.
3. On the **Security** tab, click the security zone to which the enterprise CA belongs, and then click **Custom Level**.

    > [!NOTE]
    > The security zone appears in the Internet Explorer status bar when you use the Advanced Certificate Request page.

4. Scroll down to **Scripting**. Note the current setting for **Active scripting**.
5. If **Active Scripting** is set to **Disable** or to **Prompt**, click **Enable**, and then click **OK**.
6. Click **Yes** to dismiss the warning message.

## References

For more information about how to troubleshoot script errors in Internet Explorer 6 and in Internet Explorer 7 on Windows 2000-based, Windows XP-based, Windows Server 2003-based, or Windows Vista-based computers, see [How to troubleshoot script errors in Internet Explorer](https://support.microsoft.com/help/308260/how-to-troubleshoot-script-errors-in-internet-explorer).
