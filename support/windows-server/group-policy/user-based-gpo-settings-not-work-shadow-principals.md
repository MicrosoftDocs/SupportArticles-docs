---
title: User-based GPO settings aren't applied when signing in with shadow principals
description: Helps resolve the issue in which user-based Group Policy Object (GPO) settings don't work with shadow principals.
ms.date: 11/06/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, dennhu, tmaddala, v-lianna
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot, ikb2lmc
ms.technology: windows-server-group-policy
---
# User-based GPO settings aren't applied when signing in with shadow principals

This article helps resolve the issue in which user-based Group Policy Object (GPO) settings don't work when signing in with shadow principals.

_Original KB number:_ &nbsp; 5031575

You have two forests, `contoso.net` and `pam.contoso.com`. `Pam.contoso.com` is an admin forest which has shadow principals. Selective authentication is configured for the forest trust.

You create a group named "ShadowPrincipalGroup" and include all shadow principals.

When you sign in domain-joined (contoso.net) devices by using shadow principals, user-based GPOs aren't applied.

This issue occurs because selective authentication is configured as the scope of authentication for users in the forest trust. When this option is used, Windows doesn't automatically authenticate users from the trusted forest, and shadow principals weren't part of the group which are allowed to authenticate. You can remove selective authentication to work around this issue.

To resolve this issue, add the shadow principal account or the group "ShadowPrincipalGroup" to the "Allowed to authenticate" permission on the krbtgt account in the target user's domain.
