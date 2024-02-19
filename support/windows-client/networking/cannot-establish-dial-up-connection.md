---
title: The PPP link control protocol was terminated error when you establish a dial-up connection
description: Describes an issue where you can't establish a dial-up connection.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: masoudh, kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Error when you try to establish a dial-up connection: Error 734: The PPP link control protocol was terminated

This article helps fix an issue where **Error 734: The PPP link control protocol was terminated** occurs when you try to establish a dial-up connection.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 318718

## Symptoms

If you try to establish a Point-to-Point Protocol (PPP) dial-up connection, you may receive the following error message:
> Error 734: The PPP link control protocol was terminated.

As a result, you can't establish a dial-up connection.

## Cause

This issue may occur if either of the following conditions are true:

- Multi-link negotiation is turned on for the single-link connection.

- The dial-up connection security configuration is incorrectly configured to use the **Require secured password** setting.

## Resolution

To resolve this issue:

1. Click **Start**, point to **Settings**, and then click **Network and Dial-up Connections**.

    > [!NOTE]
    > For Windows Server 2003, click **Start**, point to **Control Panel**, and then point to **Network Connections**.

2. Right-click the appropriate dial-up networking connection, and then click **Properties**.
3. Click the **Networking** tab, and then click **Settings**.
4. Click to clear the **Negotiate multi-link for single link connections** check box (if it's selected).
5. Click **OK** > **OK**.
6. Double-click the connection, and then click **Dial**.

    - If this procedure resolves the issue and you can establish a dial-up connection, you don't have to follow the remaining steps in this article.
    - If this doesn't resolve the issue and you can't establish a dial-up connection, go to step 7 to continue to troubleshoot this issue.
7. Right-click the connection, and then click **Properties**.
8. Click the **Security** tab.
9. Under **Security options**, click **Allow unsecured password** in the **Validate my identity as follows** box, and then click **OK**.
10. Double-click the connection, and then click **Dial** to verify that you can establish a dial-up connection.
