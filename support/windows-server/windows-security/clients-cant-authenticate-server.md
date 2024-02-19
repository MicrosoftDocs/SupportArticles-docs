---
title: Clients can't authenticate with a server
description: Provides a solution to an issue where clients can't authenticate with a server after you obtain a new certificate to replace an expired certificate on the server.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:certificate-enrollment, csstroubleshoot
---
# Clients can't authenticate with a server after you obtain a new certificate to replace an expired certificate on the server

This article provides a solution to an issue where clients can't authenticate with a server after you obtain a new certificate to replace an expired certificate on the server.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 822406

## Symptoms

After you replace an expired certificate with a new certificate on a server that is running Microsoft Internet Authentication Service (IAS) or Routing and Remote Access, clients that have Extensible Authentication Protocol-Transport Layer Security (EAP-TLS) configured to verify the server's certificate can no longer authenticate with the server. When you view the System log in Event Viewer on the client computer, the following event is displayed.

If you enable verbose logging on the server that is running IAS or Routing and Remote Access (for example, by running the `netsh ras set tracing * enable` command), information similar to the following one is displayed in the Rastls.log file that is generated when a client tries to authenticate.

> [!NOTE]
> If you're using IAS as your Radius server for authentication, you see this behavior on the IAS server. If you're using Routing and Remote Access, and Routing and Remote Access is configured for Windows Authentication (not Radius authentication), you see this behavior on the Routing and Remote Access server.

> [1072] 15:47:57:280: CRYPT_E_NO_REVOCATION_CHECK will not be ignored
>
> [1072] 15:47:57:280: CRYPT_E_REVOCATION_OFFLINE will not be ignored
>
> [1072] 15:47:57:280: The root cert will not be checked for revocation
>
> [1072] 15:47:57:280: The cert will be checked for revocation
>
> [1072] 15:47:57:280:
>
> [1072] 15:47:57:280: EapTlsMakeMessage(Example\client)
>
> [1072] 15:47:57:280: >> Received Response (Code: 2) packet: Id: 11, Length: 25, Type: 0, TLS blob length: 0. Flags:
>
> [1072] 15:47:57:280: EapTlsSMakeMessage
>
> [1072] 15:47:57:280: EapTlsReset
>
> [1072] 15:47:57:280: State change to Initial
>
> [1072] 15:47:57:280: GetCredentials
>
> [1072] 15:47:57:280: The name in the certificate is: server.example.com
>
> [1072] 15:47:57:312: BuildPacket
>
> [1072] 15:47:57:312: << Sending Request (Code: 1) packet: Id: 12, Length: 6, Type: 13, TLS blob length: 0. Flags: S
>
> [1072] 15:47:57:312: State change to SentStart
>
> [1072] 15:47:57:312:
>
> [1072] 15:47:57:312: EapTlsEnd(Example\client)
>
> [1072] 15:47:57:312:
>
> [1072] 15:47:57:312: EapTlsEnd(Example\client)
>
> [1072] 15:47:57:452:
>
> [1072] 15:47:57:452: EapTlsMakeMessage(Example\client)
>
> [1072] 15:47:57:452: >> Received Response (Code: 2) packet: Id: 12, Length: 80, Type: 13, TLS blob length: 70. Flags: L
>
> [1072] 15:47:57:452: EapTlsSMakeMessage
>
> [1072] 15:47:57:452: MakeReplyMessage
>
> [1072] 15:47:57:452: Reallocating input TLS blob buffer
>
> [1072] 15:47:57:452: SecurityContextFunction
>
> [1072] 15:47:57:671: State change to SentHello
>
> [1072] 15:47:57:671: BuildPacket
>
> [1072] 15:47:57:671: << Sending Request (Code: 1) packet: Id: 13, Length: 1498, Type: 13, TLS blob length: 3874. Flags: LM
>
> [1072] 15:47:57:702:
>
> [1072] 15:47:57:702: EapTlsMakeMessage(Example\client)
>
> [1072] 15:47:57:702: >> Received Response (Code: 2) packet: Id: 13, Length: 6, Type: 13, TLS blob length: 0. Flags:
>
> [1072] 15:47:57:702: EapTlsSMakeMessage
>
> [1072] 15:47:57:702: BuildPacket
>
> [1072] 15:47:57:702: << Sending Request (Code: 1) packet: Id: 14, Length: 1498, Type: 13, TLS blob length: 0. Flags: M
>
> [1072] 15:47:57:718:
>
> [1072] 15:47:57:718: EapTlsMakeMessage(Example\client)
>
> [1072] 15:47:57:718: >> Received Response (Code: 2) packet: Id: 14, Length: 6, Type: 13, TLS blob length: 0. Flags:
>
> [1072] 15:47:57:718: EapTlsSMakeMessage
>
> [1072] 15:47:57:718: BuildPacket
>
> [1072] 15:47:57:718: << Sending Request (Code: 1) packet: Id: 15, Length: 900, Type: 13, TLS blob length: 0. Flags:
>
> [1072] 15:48:12:905:
>
> [1072] 15:48:12:905: EapTlsMakeMessage(Example\client)
>
> [1072] 15:48:12:905: >> Received Response (Code: 2) packet: Id: 15, Length: 6, Type: 13, TLS blob length: 0. Flags:
>
> [1072] 15:48:12:905: EapTlsSMakeMessage
>
> [1072] 15:48:12:905: MakeReplyMessage
>
> [1072] 15:48:12:905: SecurityContextFunction
>
> [1072] 15:48:12:905: State change to SentFinished. Error: 0x80090318
>
> [1072] 15:48:12:905: Negotiation unsuccessful
>
> [1072] 15:48:12:905: BuildPacket
>
> [1072] 15:48:12:905: << Sending Failure (Code: 4) packet: Id: 15, Length: 4, Type: 0, TLS blob le

## Cause

This issue may occur if all the following conditions are true:

- The IAS or Routing and Remote Access server is a domain member, but automatic certificate requests functionality (autoenrollment) isn't configured in the domain. Or, the IAS or Routing and Remote Access server isn't a domain member.
- You manually request and receive a new certificate for the IAS or Routing and Remote Access server.
- You don't remove the expired certificate from the IAS or Routing and Remote Access server. If an expired certificate is present on the IAS or Routing and Remote Access server together with a new valid certificate, client authentication doesn't succeed. The "Error 0x80090328" result that is displayed in the Event Log on the client computer corresponds to "Expired Certificate."

## Workaround

To work around this issue, remove the expired (archived) certificate. To do it, follow these steps:

1. Open the Microsoft Management Console (MMC) snap-in where you manage the certificate store on the IAS server. If you don't already have an MMC snap-in to view the certificate store from, create one. To do so:
    1. Select **Start**, select **Run**, type mmc in the **Open** box, and then select **OK**.
    2. On the **Console** menu (the **File** menu in Windows Server 2003), select **Add/Remove Snap-in**, and then select **Add**.
    3. In the **Available Standalone Snap-ins** list, select **Certificates**, select **Add**, select **Computer account**, select **Next**, and then select **Finish**.

        > [!NOTE]
        > You can also add the Certificates snap-in for the user account and for the service account to this MMC snap-in.
    4. Select **Close**, and then select **OK**.
2. Under **Console Root**, select **Certificates (Local Computer)**.
3. On the **View** menu, select **Options**.
4. Click to select the **Archived certificates** check box, and then select **OK**.
5. Expand **Personal**, and then select **Certificates**.
6. Right-click the expired (archived) digital certificate, select **Delete**, and then select **Yes** to confirm the removal of the expired certificate.
7. Quit the MMC snap-in. You don't have to restart the computer or any services to complete this procedure.

## More information

Microsoft recommends that you configure automatic certificate requests to renew digital certificates in your organization. For more information, see [Certificate Autoenrollment in Windows XP](/previous-versions/windows/it-pro/windows-xp/bb456981(v=technet.10))
