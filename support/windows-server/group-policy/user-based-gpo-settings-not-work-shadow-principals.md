---
title: User-based GPO settings aren't applied when signing in with shadow principals
description: Helps resolve an issue in which user-based Group Policy Object (GPO) settings don't work with shadow principals.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dennhu, tmaddala, v-lianna
ms.custom: sap:Group Policy\Problems Applying Group Policy, csstroubleshoot, ikb2lmc
---
# User-based GPO settings aren't applied when signing in with shadow principals

This article helps resolve an issue in which user-based Group Policy Object (GPO) settings don't work when signing in using shadow principals.

You have two forests, `contoso.net` and `pam.contoso.com`. `Pam.contoso.com` is an admin forest that has shadow principals. Selective authentication is configured for the forest trust. Then, you create a group named `ShadowPrincipalGroup` that includes all shadow principals.

When you sign in to domain-joined (`contoso.net`) devices by using shadow principals, user-based GPOs aren't applied.

This issue occurs because selective authentication is configured as the scope of authentication for users in the forest trust. When this option is used, Windows doesn't automatically authenticate users in the trusted forest, and shadow principals aren't part of the group that is allowed to authenticate. You can remove selective authentication to work around this issue.

To resolve this issue, add the shadow principal account or the `ShadowPrincipalGroup` group to the "Allowed to authenticate" permission on the `krbtgt` account in the target user's domain.
