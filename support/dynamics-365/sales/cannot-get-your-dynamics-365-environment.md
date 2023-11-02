---
title: Can't get to your Dynamics 365 environment
description: Provides a solution to an error that occurs when you access your Common Data Service environment for the first time.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-access
---
# You cannot get to your Dynamics 365 environment using the above URL. Error message displays when you access your Common Data Service environment for the first time

This article provides a solution to an error that occurs when you access your Common Data Service environment for the first time.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4541747

## Introduction

To provide better service and availability, we're upgrading our authentication protocol by replacing the URL redirector service.  The replaced URL redirector service will be removed on **March 31, 2020**.

When you access your Common Data Service environment for the first time or every time after you've signed out from a prior session, you're directed to Microsoft Entra ID for sign-in. In the Sign-in page URL, it contains a set of internal values/codes that include a link to the URL redirector service. Upon successful sign-in, the URL Redirector service directs you to your Common Data Service environment.

The URL redirector service was replaced in September 2019. This change would impact you if you've created a bookmark of the sign-in page before September 2019 that contained the link of the replaced URL redirector service.

Some of the internal values/codes are time-sensitive and are only valid for a short period of time. We recommend that you bookmark the Common Data Service environment page instead of the sign-in page.

> [!NOTE]
> Only a small set of users are impacted by this change and the impacted users will see a notification page with instructions on how to correct the problem.

## Symptoms

When you first access your environment, you're directed to a Sign-in page (below) to enter your credentials.

:::image type="content" source="media/cannot-get-your-dynamics-365-environment/sign-your-account.png" alt-text="Screenshot of the authentication sign-in dialog." lightbox="media/cannot-get-your-dynamics-365-environment/sign-your-account.png" border="false":::

Upon entering your credentials, you see this notification page:

> You cannot get to your Dynamics 365 environment using the above URL.

:::image type="content" source="media/cannot-get-your-dynamics-365-environment/sign-in-error.png" alt-text="Screenshot of the authentication sign-in error page.":::

> [!NOTE]
> The Common Data Service URL shown in the above screen shot is just an example, your environment actual URL will be displayed in the message.

## Cause

In the Sign-in page URL, the link of the old Redirector service is embedded.

Example (old):

:::image type="content" source="media/cannot-get-your-dynamics-365-environment/old-example.png" alt-text="Screenshot shows an example of the old U R L.":::

The deprecated redirector service is called <cloudredirector.crm.dynamics.com>.

And it's replaced by something like `bn1 -- namcrlivesg614.crm.dynamics.com`.

> [!NOTE]
> It's just an example and this URL is different based on where your tenant resides.

Example (new):

:::image type="content" source="media/cannot-get-your-dynamics-365-environment/new-example.png" alt-text="Screenshot shows an example of the new U R L.":::

To avoid user and business interruption with this upgrade, we've created a notification page for users who accessed the environment that has a Sign-in page URL that contains the deprecated redirector URL.

> [!NOTE]
>
> **NOT** all your users will see this notification page - only the following users may see the notification page:
>
> 1. Users who had saved the Sign-in page in their bookmark before **September 2019**, and
> 1. Users who access their environment via their company portal that has a link that contains the deprecated redirector URL.

## Resolution

The notification page will be rolled out starting the week of **February 17, 2020**.

1. For bookmark scenario:

    Correct your bookmark by following the instructions on the notification page.  

2. For company portal or Single-SignOn (SSO) scenario:  

    It usually applies to customers who are using their own Secure Token Service (STS) that federates with Microsoft Entra ID to provide an SSO experience for their users.

    To provide an SSO experience, you might have an SSO link that looks something like this:

    `https://sts.contoso.com/adfs/ls/?client-request-id=...&wa=wsignin1.0&wtrealm=urn%3afederation%3aMicrosoftOnline&wctx=LoginOptions%3D3%26estsredirect%3d2%26estsrequest%3d<encodedPayload>&cbcxt=&mkt=&lc=&RedirectToIdentityProvider=...`

    You most likely have captured the \<encodedPayload> by recording the sign-in process when you sign in to your org URL in a fresh browser session.

    While we understand that this method allows you to mitigate certain STS SSO limitation, it's officially not supported as it uses the encoded payload captured at that time. There's some data that is short-lived in the encoded payload and once it expires, you'll need to recapture a new payload. The captured encoded payload can also easily be invalidated with changes in our backend service. It isn't recommended as it causes interruption to your user sign-in experience.

    A better approach is to pass your domain name such as `?whr=contoso.com` in your Dynamics 365 org url (see below). Which tells Microsoft Entra ID to skip the home realm discovery phase and goes directly to your STS service. It may achieve SSO depending on your STS configuration.

    Example: `https://contoso.crm.dynamics.com/?whr=contoso.com`  
    (replace org URL and `contoso.com` with your domain name)

3. If you're running automation scripts, you may also have recorded the deprecated redirector URL. These scripts will fail, and they need to be updated.
