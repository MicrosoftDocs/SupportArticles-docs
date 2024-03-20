---
title: Event ID 300 - Windows Hello successfully created in Windows 10
description: This event is created when a Windows Hello for Business is successfully created and registered with Microsoft Entra ID.
ms.date: 12/26/2023
manager: dcscontentpm
ms.reviewer: prsriva, aaroncz
ms.collection: M365-identity-device-management
ms.topic: troubleshooting
ms.custom: sap:Windows Security Technologies\Biometric, Passwordless Authentication, SSO, and Windows Hello, csstroubleshoot
audience: itpro
localization_priority: medium
---
# Event ID 300 - Windows Hello successfully created

This event is created when Windows Hello for Business is successfully created and registered with Microsoft Entra ID. Applications or services can trigger actions on this event. For example, a certificate provisioning service can listen to this event and trigger a certificate request.

_Applies to:_ &nbsp; Windows 10, Windows 11

## Event details

Product: Windows 10 or Windows 11 operating system  
Log: Event Viewer > Applications and Service Logs\\Microsoft\\Windows\\User Device Registration\\Admin  
ID: 300  
Source: Microsoft Azure Device Registration Service  
Version: 10 or 11  
Message: The NGC key was successfully registered. Key ID: {\<Key ID\>}. UPN:test@contoso.com. Attestation: ATT\_SOFT. Client request ID: . Server request ID: \<Server Request ID\>.</br>Server response: {"kid":"4476694e-8e3b-4ef8-8487-be21f95e6f07","upn":"test@contoso.com"}

## Resolution

This is a normal condition. No further action is required.

## More information

- [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-identity-verification)
- [How Windows Hello for Business works](/windows/security/identity-protection/hello-for-business/hello-how-it-works)
- [Manage Windows Hello for Business in your organization](/windows/security/identity-protection/hello-for-business/hello-manage-in-organization)
- [Why a PIN is better than a password](/windows/security/identity-protection/hello-for-business/hello-why-pin-is-better-than-password)
- [Prepare people to use Windows Hello](/windows/security/identity-protection/hello-for-business/hello-prepare-people-to-use)
- [Windows Hello and password changes](/windows/security/identity-protection/hello-for-business/hello-and-password-changes)
- [Windows Hello errors during PIN creation](windows-hello-errors-during-pin-creation-in-windows-10.md)
- [Windows Hello biometrics in the enterprise](/windows/security/identity-protection/hello-for-business/hello-biometrics-in-enterprise)
