---
title: Troubleshoot AD FS 2.0 error (Access is denied)
description: This article contains step-by-step instructions to troubleshoot claims rules problems.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# ADFS 2.0 error: Access is denied

This article provides a solution to fix the Active Directory Federated Services (AD FS) 2.0 error.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3044977

## Summary

Most AD FS 2.0 problems belong to one of the following main categories. This article contains step-by-step instructions to troubleshoot claims rules problems.

- [Connectivity problems (KB 3044971)](this-page-cant-displayed.md)  
- [ADFS service problems (KB 3044973)](adfs-2-service-fails-to-start.md)  
- [Certificate problems (KB 3044974)](adfs-2-certificate-error-build-chain.md)  
- [Authentication problems (KB 3044976)](adfs-error-401-requested-resource-requires-authentication.md)  

## Symptoms

- The token that is issued by the AD FS service does not have the appropriate claims to authorize user access to the application.
- The AD FS server returns the following error message:

    > Access is Denied

- If you enable AD FS auditing by using the [Configuring ADFS Servers for Troubleshooting](/previous-versions/windows/it-pro/windows-server-2003/cc738766(v=ws.10)) topic, you see the following error logged in the event log:

    > Event ID 325  
    > The Federation Service could not authorize token issuance for the caller.

## Resolution

To resolve this problem, follow these steps in the order given. These steps will help you to determine the cause of the problem. Make sure that you check whether the problem is resolved after every step.

### Step 1: Obtain details about required claims

- Determine which claim types are required in the SAML token from the relying party owner.
- Determine which claims provider was used to authenticate the user.

For example:  

- A relying party provider may indicate that it wants the **Email**, **Name**, and **Role**  values of the user to be provided.
- If the claim provider in this situation is "Active Directory," you should configure an Acceptance claim rule at the "Active Directory" level.

    > [!NOTE]
    > If the claim provider is another Security Token Service (STS), we must create a Pass Through or Transform claim rule to accept the claim values store in locally defined claims types that are to be passed to the relying party.
- Create a Pass Through claim for these claims at the relying party level.

### Step 2: Check whether AD FS is denying the token based on Authorization rules

To do this, right-click the relying party, click **Edit Claim Rules**, and then click the **Issuance Authorization Rules** tab. When you examine the rules information, consider the following guidelines:  

- All authorization claims rules are processed.
- If no rules are defined, the AD FS server denies all users.
- The allowlist approach can also be used instead of using a Permit All rule. In this situation, you define a set of rules that specify the conditions under which the user must be issued a token.
- In the blocklist approach, you will need one Permit all Rule, along with one or more Deny rules that are based on a condition.
- A Deny rule always overrides an Allow rule. This means that if both the Allow and Deny claim conditions are true for the user, the Deny rule will be followed.
- For authorization rules that are based on other claim values to allow or deny a token, those claims should already be pushed into the claim pipeline from the claim provider trust level.

### Step 3: Capture a Fiddler trace

Capture a Fiddler Web Debugger trace to capture the communication to the AD FS service and determine whether a SAML token was issued. If a SAML token was issued, decode the token to determine whether the correct set of claims is being issued.

For more information about this process, see [AD FS 2.0: How to Use Fiddler Web Debugger to Analyze a WS-Federation Passive Sign-In](https://social.technet.microsoft.com/wiki/contents/articles/3286.ad-fs-2-0-how-to-use-fiddler-web-debugger-to-analyze-a-ws-federation-passive-sign-in.aspx).

To find the SAML token that is issued by the AD FS service:  

- In a fiddler trace, review the response from AD FS to determine where the AD FS service is setting the MSISAuth and MSISAuthenticated cookies. Or, review the request after AD FS sets the MSISAuth and MSISAuthenticated cookies.
- Select the token, and then start TextWizard in Fiddler. Use URLDecode for an RSTR (WS-Fed) or FromDeflatedSAML for a SAML 2.0 protocol response.

### Step 4: Enable ADFS Auditing and to check if the Token was issued or denied, along with the list of claims being processed

Configure the AD FS servers to record the auditing of AD FS events to the Security log. To configure the Windows Security log to support auditing of AD FS events, follow these steps:  

1. Click **Start**, point to **Administrative Tools**, and then click **Local Security Policy**.
2. Double-click **Local Policies**, and then click **Audit Policy**.
3. In the details pane, double-click **Audit object access**.
4. On the **Audit object access Properties** page, select either **Success** or **Failure** or both, and then click OK.
5. Close the Local Security Settings snap-in.
6. At a command prompt, type *gpupdate /force*, and then press Enter to immediately refresh the local policy.  

You can also use the following GPO to configure the Windows Security Log:

Computer Configuration\Policies\Windows Settings\Security Settings\Advanced Audit Policy Configuration\Audit Policies\Object Access\Audit Application Generated - Success and Failure Configure ADFS  

This is helpful in a scenario in which AD FS denied a token to the user. The AD FS auditing process will report the event and the claims that were generated before the token was denied. This helps you determine which claim caused the Deny rule to be applied. Examine the Security event log particularly for Event ID 299, 500, 501 and 325.  

### Step 5: Determine whether you require a custom claim

If the claim issuance requirements cannot be fulfilled by the default claim rule templates, you may need to write a custom claim. For more information, see [Understanding Claim Rule Language in AD FS 2.0 & Higher](https://social.technet.microsoft.com/wiki/contents/articles/4792.understanding-claim-rule-language-in-ad-fs-2-0-higher.aspx).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
