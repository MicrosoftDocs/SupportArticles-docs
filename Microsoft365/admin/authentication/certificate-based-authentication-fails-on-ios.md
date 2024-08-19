---
title: Certificate-based authentication for iOS fails to prompt for user certificates
description: Fixes an issue that federated users on iOS devices can't use Certificate-Based Authentication (CBA) to authenticate.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Entra ID
  - Microsoft 365
ms.date: 10/20/2023
---

# Certificate-based authentication for iOS fails to prompt for user certificates

## Symptoms

Federated users on Apple iOS devices that have valid user certificates discover that they can't perform Certificate-Based Authentication (CBA) against Microsoft Entra ID. However, federated users on Android and Windows devices can successfully authenticate by using CBA. The same iOS users encounter no issues when they authenticate by using their username and password.

Here's the typical experience for iOS users who can't authenticate when they sign in to ADAL-enabled Office applications on iOS:

1. The user walks through the Office app setup experience. At the "Office365" sign-in page, the user selects Sign-in.
2. The ADAL Sign-in page appears, on which the user enters their federated email address and then selects Next.
3. The ADAL Sign-in process hangs at a blank page until it times out and returns a "There's a problem with your account. Try again later" error. This page includes the option to tap OK.
4. If the user taps OK, they sit at the same blank Sign-in page with the option at the top to tap Back.
5. Tapping Back returns the user to the ADAL Sign-in page, where the process starts all over: the user is prompted to enter their federated email address and then selects Next.
6. Tapping OK returns to a blank Sign-in screen, where the user can enter their UserPrincipalName and repeat the process.

To eliminate Office applications as a factor, we recommend that federated users in an iOS environment test certificate-based authentication in the Safari browser by following the steps in the "More Information" section. The typical experience for iOS users who can't authenticate against [https://portal.office.com](https://portal.office.com/) from a Safari browser goes as follows:

1. The user isn't prompted as expected to approve the use of their user certificate after they select the Sign-in using an X.509 certificate link.
2. The federated user either sits at an unresponsive STS sign-in page or advances to the default STS sign-in page, where they're prompted as follows:

    Select a certificate that you want to use for authentication. If you cancel the operation, close your browser and try again.

    **Note** If other authentication methods are enabled in AD FS, the users also see a link stating "Sign-in with other options." If they select this link, they return to the STS sign-in page.

3. Both experiences fail with the following error:

    Safari could not open the page because the server stopped responding.

## Cause

The certificate chain is incomplete because the issuing subordinate CA certificate isn't retrieved by the device as expected when the MDM policy pushes just the Root certificate to the Apple device along with the SCEP profile.

The iOS device doesn't correctly acquire the .crt file from the Issuing CA, even though the AIA path on the user certificate has a valid URL that points to the *.crt file in the Issuing subordinate CA.

## Resolution

If the customer is using Intune to manage the device, advise them to create a new configuration policy for an iOS Trusted Root Certificate that points to the Intermediate Certificate Authorities' *.CER file. Then, advise them to open the company portal on the device and refresh the policy. The connection should now succeed.

## More Information

If you take an "Apple Configurator 2" trace from an OS X client that's connected to the iPad by using the lightning cable, the trace log resembles the following example:

```output
Nov 2 15:53:49 CSSs-iPad MobileSafari(Accounts)[618] <Notice>: __51-[ACRemoteAccountStoreSession _configureConnection]_block_invoke.62 (57) "The connection to ACDAccountStore was invalidated."
Nov 2 15:53:49 CSSs-iPad MobileSafari(ProtectedCloudStorage)[618] <Notice>: KeychainGetStatus(PCSiCloudServiceMarkerName): keychain: -25300
Nov 2 15:53:49 CSSs-iPad MobileSafari(ProtectedCloudStorage)[618] <Notice>: KeychainGetStatus(PCSiCloudServiceMarkerName): status: off
Nov 2 15:53:49 CSSs-iPad accountsd(AccountsDaemon)[216] <Notice>: -[ACDServer listener:shouldAcceptNewConnection:] (320) "<private> (<private>) received"
Nov 2 15:53:49 CSSs-iPad MobileSafari(ProtectedCloudStorage)[618] <Notice>: PCSIdentitySetCreate: CloudKit { kPCSSetupDSID = "<<VALUE>>";
}
Nov 2 15:53:49 CSSs-iPad MobileSafari(Accounts)[618] <Notice>: __51-[ACRemoteAccountStoreSession _configureConnection]_block_invoke.62 (57) "The connection to ACDAccountStore was invalidated."
Nov 2 15:53:49 CSSs-iPad MobileSafari(ProtectedCloudStorage)[618] <Notice>: KeychainGetStatus(PCSiCloudServiceMarkerName): keychain: -25300
Nov 2 15:53:49 CSSs-iPad MobileSafari(ProtectedCloudStorage)[618] <Notice>: KeychainGetStatus(PCSiCloudServiceMarkerName): status: off
Nov 2 15:53:49 CSSs-iPad MobileSafari(ProtectedCloudStorage)[618] <Notice>: PCSIdentitySetCreate: CloudKit { kPCSSetupDSID = "<<VALUE>>";
}
...
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(libsystem_network.dylib)[619] <Info>: nw_connection_endpoint_report [8 sts.<name>.info:49443 in_progress resolver (satisfied)] reported event flow:finish_transport
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(CFNetwork)[619] <Notice>: TIC TCP Conn Cancel [1:0x13dd17990]
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(libsystem_network.dylib)[619] <Info>: nw_endpoint_handler_cancel [1 portal.office.com:443 ready resolver (satisfied)]
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(libsystem_network.dylib)[619] <Info>: nw_endpoint_handler_cancel [1.1 13.107.7.190:443 ready socket-flow (satisfied)]
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(libsystem_network.dylib)[619] <Notice>: __nw_socket_service_writes_block_invoke sendmsg(fd 4, 85 bytes): socket has been closed
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(libsystem_network.dylib)[619] <Info>: nw_endpoint_flow_protocol_disconnected [1.1 13.107.7.190:443 cancelled socket-flow (null)] Output protocol disconnected
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(CFNetwork)[619] <Notice>: TIC TCP Conn Destroyed [1:0x13dd17990]
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(CFNetwork)[619] <Notice>: TIC TLS Event [8:0x13dd4e0c0]: 2, Pending(0)
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(CFNetwork)[619] <Notice>: TIC TLS Event [8:0x13dd4e0c0]: 11, Pending(0)
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(CFNetwork)[619] <Notice>: TIC TLS Event [8:0x13dd4e0c0]: 12, Pending(0)
Nov 2 15:54:33 CSSs-iPad com.apple.WebKit.Networking(CFNetwork)[619] <Notice>: TIC TLS Event [8:0x13dd4e0c0]: 13, Pending(0)
Nov 2 15:54:34 CSSs-iPad securityd[88] <Notice>: items matching issuer parent: Error Domain=NSOSStatusErrorDomain Code=-25300 "no matching items found" UserInfo={NSDescription=no matching items found}
```
