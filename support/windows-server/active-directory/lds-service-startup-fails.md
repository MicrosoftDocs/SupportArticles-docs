---
title: LDS service startup fails
description: Introduce the solution for LDS Service startup failure after you manually change msDS-Behavior-Version attribute.
ms.date: 02/26/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, sagiv, wincicadsec
ms.custom:
- sap:active directory\ldap configuration and interoperability
- pcy:WinComm Directory Services
---
# LDS service startup fails after you manually change msDS-Behavior-Version in Windows Server

This article provides a solution to an error that the LDS service startup fails after you manually change the **msDS-Behavior-Version** attribute.

_Applies to:_ &nbsp; All supported versions of Windows Server and Windows Client  
_Original KB number:_ &nbsp; 4550446

In ADSI Edit, you change the **msDS-Behavior-Version** attribute of the **Partitions** container to **7** in order to raise the Active Directory (AD) Lightweight Directory Services (LDS) instance functional level to **WIN2016**.

:::image type="content" source="media/lds-service-startup-fails/attribute-editor.png" alt-text="Change the msDS-Behavior-Version attribute to 7.":::

After you restart the server or stop the LDS service, the LDS service cannot be started. When you try to manually start the service, the following event errors are logged:

> Log Name: ADAM (LDS)  
Source: ADAM [LDS] General  
Event ID: 1168  
Task Category: Internal Processing  
Level: Error  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: `LDS.CONTOSO.COM`  
Description:  
Internal error: An Active Directory Lightweight Directory Services error has occurred.
>
> Additional Data  
Error value (decimal):  
-1601  
Error value (hex):  
fffff9bf  
Internal ID:  
20801a4  

Additionally, you receive the following error message:

> Windows could not start the \<ServiceName> LDS service on Local Computer.  
> Error 0xc0000025: 0xc0000025

:::image type="content" source="media/lds-service-startup-fails/error-message.png" alt-text="Error 0xc0000025 Windows could not start the L D S service on Local Computer.":::

For Windows servers with monthly updates before the February 2025 update rollup installed, manually setting the **msDS-Behavior-Version** attribute value of LDS instances to **7** isn't supported. To resolve the issue, install the February 2025 update rollup or a later version.
