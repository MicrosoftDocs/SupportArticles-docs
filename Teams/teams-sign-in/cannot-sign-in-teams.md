---
title: Sign-in issues in Teams
description: Provides troubleshooting steps for Teams sign-in issues. 
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 156289
- CSSTroubleshoot
ms.reviewer: billkau; meerak
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Can't sign in Teams

This article provides some methods that help you fix the sign-in issues in Microsoft Teams. Try each of the following methods in the order in which they're listed.

1. Run the Teams sign-in diagnostics: [Diag: Teams Sign-In](https://aka.ms/TeamsSignInDiag), which will populate the diagnostic in the Microsoft 365 Admin Center.
1. Make sure the [Teams client is updated](https://support.microsoft.com/en-us/office/update-microsoft-teams-535a8e4b-45f0-4f6c-8b3d-91bca7a51db1).
1. If you use federated sign-in providers, validate Active Directory Federation Services (AD FS) configuration with the [Office 365 Single Sign-on Test](https://testconnectivity.microsoft.com/tests/SingleSignOn/input) in Microsoft Remote Connectivity Analyzer.
1. Check the error code on the Teams sign-in screen:
    - **0xCAA82EE7** or **0xCAA82EE2**  
        Make sure that you have the Internet access. To understand endpoints that should be reachable for customers using Teams in Office 365 plans, Government and other clouds, read [Office 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges). To enable the communication to the IP addresses and ports needed for Teams, the administrator can use the [Network assessment tool](https://www.microsoft.com/en-us/download/details.aspx?id=53885) to verify network and network elements between the user location and the Microsoft Network are configured correctly.

    - **0xCAA20004**  
        Check if conditional access is preventing the sign- in, see [Conditional Access policies for Teams](/microsoftteams/security-compliance-overview#how-conditional-access-policies-work-for-teams) for more information.

    - **0xCAA70004** or **0xCAA70007**, or the sign-in issues also occurs in other Office applications.  
        See [Connection issues in sign-in after update to Office 2016 build 16.0.7967](../../Microsoft365/admin/authentication/connection-issue-when-sign-in-office-2016.md) for troubleshooting steps.

    - Check the error codes listed in [Why am I having trouble signing in to Microsoft Teams](https://support.microsoft.com/en-us/topic/a02f683b-61a3-4008-9447-ee60c5593b0f). The article provides the troubleshooting action for each error code to help you fix the issue.

1. If the sign-in issue only occurs in Microsoft Teams, you can check the resolution in [Microsoft Teams is stuck in a login loop](sign-in-loop.md) to fix the issue. Alternatively, you can reinstall Teams as follows:

    1. [Uninstall or remove Teams](https://support.microsoft.com/en-us/windows/uninstall-or-remove-apps-and-programs-in-windows-10-4b55f974-2cc6-2d2b-d092-5905080eaf98).
    1. Browse to the *%appdata%\Microsoft* folder on your computer and delete the Teams folder.
    1. Download and install [Teams](https://www.microsoft.com/en-us/microsoft-teams/group-chat-software). If possible, reinstall Teams as an administrator (right-click the Teams installer and select **Run as administrator**).

If the sign-in issue persists, you can create a support request. [Collect debug logs](/microsoftteams/log-files) and mention the error code on the Teams sign-in screen in the support request. This will expedite to fix the issue.
