---
title: Troubleshoot authentication problems in Azure Bastion
description: Troubleshoot Azure Bastion authentication problems, including SSH key errors and domain-joined VM sign-in problems. Learn how to resolve these problems quickly.
services: bastion
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: Connectivity
---

# Troubleshoot authentication problems in Azure Bastion

## Summary

This article describes common Azure Bastion authentication problems and their resolutions, including SSH key errors and domain-joined VM sign-in problems.

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|---------|
|Can't use SSH key with Azure Bastion|When you try to browse your SSH key file, you get the following error: *'SSH Private key must start with -----BEGIN RSA/DSA/OPENSSH PRIVATE KEY----- and ends with -----END RSA/DSA/OPENSSH PRIVATE KEY-----'*.|Azure Bastion currently supports RSA, DSA, and OPENSSH private keys. Make sure that you browse a key file that is RSA, DSA, or OPENSSH private key for SSH, with public key provisioned on the target VM.<br><br>As an example, you can use the following command to create a new RSA SSH key:<br><br>**ssh-keygen -t rsa -b 4096 -C "email@domain.com"**<br><br>For sample output, see the [SSH key generation example](#ssh-key-generation-example).|
|Can't sign in to Windows domain-joined virtual machine|You're unable to connect to your Windows virtual machine that is domain-joined.|Azure Bastion supports domain-joined VM sign-in for username-password based domain sign-in only. When specifying the domain credentials in the Azure portal, use the UPN (username@domain) format instead of *domain\username* format to sign in. This support is for domain-joined or hybrid-joined (both domain-joined and Microsoft Entra joined) virtual machines. It isn't supported for Microsoft Entra joined-only virtual machines.|

### SSH key generation example

The following example shows the output when you create a new RSA SSH key:

```
ashishj@dreamcatcher:~$ ssh-keygen -t rsa -b 4096 -C "email@domain.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ashishj/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/ashishj/.ssh/id_rsa.
Your public key has been saved in /home/ashishj/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:c+SBciKXnwceaNQ8Ms8C4h46BsNosYx+9d+AUxdazuE email@domain.com
The key's randomart image is:
+---[RSA 4096]----+
|      .o         |
| .. ..oo+. +     |
|=.o...B==.O o    |
|==o  =.*oO E     |
|++ .. ..S =      |
|oo..   + =       |
|...     o o      |
|         . .     |
|                 |
+----[SHA256]-----+
```

## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)
