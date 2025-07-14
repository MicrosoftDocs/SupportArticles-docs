---
title: Can't open an IRM-protected document with sign-in prompts
description: If a domain has Conditional Access requirements, the authentication may fail so that you can't open the IRM-protected content.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Credentials don't work for IRM-protected content

## Symptoms

When you try to open an Information Rights Management (IRM)-protected document, workbook, email message, or other item, you discover that you don't have access to the item even though you correctly signed in to Microsoft Office. Additionally, you're prompted to sign in, but you still can't access the content when you should be able to access to it.

This symptom is usually that you are prompted to sign in but your credentials don't work.

## Cause

This behavior occurs when the following conditions are true:

- Your environment is configured for cross-domain authentication.
- The domain where the content is created is configured to have Conditional Access requirements.
- The authentication fails.

For example, *John@contoso.com* protects content and sends it to *Jenny@fabrikam.com*. To access the protected content, *Jenny@fabrikam.com* has to authenticate to *contoso.com* to obtain the key to decrypt the content. If *contoso.com* has Conditional Access requirements, this authentication may fail.

Most Conditional Access challenges require that the user is provisioned in the resource tenant (*contoso.com*). If the guest user (*Jenny@fabrikam.com*) is explicitly invited and the invitation is redeemed, *Jenny@fabrikam.com* is provisioned in the resource tenant *contoso.com*. If the user is a pass-through user, the Conditional Access validation code servicing *contoso.com* doesn't have a way to satisfy the challenges, and so the request fails. This is expected and secure behavior. For many cases, this behavior causes the Office client code to prompt for sign-in so that the user can supply credentials to open the file because authentication failed.

## Reference

For more information about Conditional Access policies, see the following blog:

[Conditional Access policies for Azure Information Protection](https://techcommunity.microsoft.com/t5/Enterprise-Mobility-Security/Conditional-Access-policies-for-Azure-Information-Protection/ba-p/250357)
