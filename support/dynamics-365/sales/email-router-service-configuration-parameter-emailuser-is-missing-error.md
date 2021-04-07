---
title: The E-mail Router service configuration parameter Emailuser is missing error
description: Describes an error message that you may receive when you use the Microsoft Dynamics CRM E-mail Router. Provides a resolution.
ms.reviewer: danhamre
ms.topic: troubleshooting
ms.date: 
---
# The E-mail Router service configuration parameter Emailuser is missing error when you use the Microsoft Dynamics CRM E-mail Router

This article provides a resolution for the issue that you may receive an error message about the parameter `Emailuser` is missing when you use the Microsoft Dynamics CRM E-mail Router.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 947094

## Symptoms

When you use the Test Access functionality in the Microsoft Dynamics CRM E-mail Configuration Manager, you receive the following error message:

> Incoming Status: Failure - The E-mail Router service configuration parameter "Emailuser" is missing. This parameter is required.

## Cause

This problem occurs because Microsoft Dynamics CRM isn't configured to use your credentials to send and to receive e-mail messages. Therefore, the Microsoft Dynamics CRM E-mail Router doesn't have the user name and the password to retrieve the mail.

## Resolution

To resolve this problem, enable Microsoft Dynamics CRM to send and to receive e-mail on your behalf. To do this, follow these steps:

1. Start the Microsoft Dynamics CRM Web client.
2. Select **Tools**, and then select **Options**.
3. On the **Email** tab, select the **Allow Email router to use my credentials to send and receive email on my behalf** check box.
4. Type the user name and the password.
5. Select **OK**.
