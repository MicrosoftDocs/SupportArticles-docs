---
title: Troubleshooting the disjoint DNS namespace error
description: This article provides symptoms and resolution for the disjoint DNS namespace error.
ms.date: 12/05/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Disjoint DNS namespace error

This article helps you to resolve the disjoint DNS namespace error.

## Symptoms

If the organizational hierarchy in Active Directory (AD) and in DNS don't match, the wrong Service Provider Name (SPN) might be generated if you use the NETBIOS name in the connection string. The SPN won't be found and NTLM credentials are used instead of Kerberos credentials.

## Resolution

 Use the fully-qualified name of the server or specify the SPN name in the connection string to mitigate problems.
