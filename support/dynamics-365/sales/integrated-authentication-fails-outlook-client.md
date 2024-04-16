---
title: Integrated Authentication fails for Outlook client
description: This article provides a resolution for the problem that occurs when the WindowsTransport endpoint is not enabled on the AD FS Server.
ms.reviewer: edwinsol
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Integrated Authentication fails with the Microsoft Dynamics CRM 2015 for Outlook client

This article helps you resolve the problem that occurs when the WindowsTransport endpoint is not enabled on the AD FS Server.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 3070297

## Symptoms

Silent Integrated Authentication with federated Dynamics CRM Online 2015 organizations may fail with the following error message:

> Exception during Signin Microsoft.Crm.CrmException: integrated_authentication_failed: Integrated authentication failed. You may try an alternative authentication method ---> Microsoft.IdentityModel.Clients.ActiveDirectory.AdalException: integrated_authentication_failed: Integrated authentication failed. You may try an alternative authentication method ---> Microsoft.IdentityModel.Clients.ActiveDirectory.AdalException: wstrust_endpoint_not_found: WS-Trust endpoint not found in metadata document

## Cause

This occurs if the WindowsTransport endpoint is not enabled on the AD FS Server.

## Resolution

On the AD FS Server:

1. Open the AD FS Management Console and in the left navigation pane, browse to AD FS |Service |Endpoints.
2. Locate the Endpoint called `/adfs/service/trust/13/windowstransport`.
3. Right-click and Enable.
4. Restart the AD FS Service

When using versions prior to CRM 2015 Update 1.1, use the direct organization URL, such as `<yourorg>.crm.dynamics.com` instead of the generic CRM Online option in the configuration drop-down, otherwise configuration may fail.

## More information

The ability to perform Silent Integrated Authentication with federated Dynamics CRM organizations has been removed with the release of Microsoft Dynamics CRM 2015 Update 1. Do not install this update if you would like to use Integrated Authentication. This feature was added back with the release of CRM 2015 Update 1.1.

In addition to the error logged in the *Crm70ClientConfig.log*, the following error is logged in Event Viewer on the AD FS server under `Applications and Services Logs\AD FS\Admin`:

```console
Encountered error during federation passive request.

Additional Data

Protocol Name:

wsfed

Relying Party:

urn:federation:MicrosoftOnline

Exception details:

Microsoft.IdentityServer.Service.Policy.PolicyServer.Engine.InvalidAuthenticationTypePolicyException: MSIS7102: Requested Authentication Method is not supported on the STS.

at Microsoft.IdentityServer.Web.Authentication.GlobalAuthenticationPolicyEvaluator.EvaluatePolicy(IList`1 mappedRequestedAuthMethods, AccessLocation location, ProtocolContext context, HashSet`1 authMethodsInToken, Boolean& validAuthMethodsInToken)

at Microsoft.IdentityServer.Web.Authentication.AuthenticationPolicyEvaluator.RetrieveFirstStageAuthenticationDomain(Boolean& validAuthMethodsInToken)

at Microsoft.IdentityServer.Web.Authentication.AuthenticationPolicyEvaluator.EvaluatePolicy(Boolean& isLastStage, AuthenticationStage& currentStage, Boolean& strongAuthRequried)

at Microsoft.IdentityServer.Web.PassiveProtocolListener.GetAuthMethodsFromAuthPolicyRules(PassiveProtocolHandler protocolHandler, ProtocolContext protocolContext)

at Microsoft.IdentityServer.Web.PassiveProtocolListener.GetAuthenticationMethods(PassiveProtocolHandler protocolHandler, ProtocolContext protocolContext)

at Microsoft.IdentityServer.Web.PassiveProtocolListener.OnGetContext(WrappedHttpListenerContext context)
```
