---
title: Troubleshoot Azure AD Connect installation issues
description: Describes how to troubleshoot scenarios in which you receive an error message that prevents you from installing Azure AD Connect. For example, you may receive error code 1603.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office 365
ms.topic: article
ms.author: v-six
---

# Troubleshoot Azure AD Connect installation issues

## Introduction

This article describes how to troubleshoot issues in which you receive an error message that prevents you from installing Azure AD Connect. For example, a common installation error code is 1603.

## Procedure 

1. Identify the error message. To do this, follow these steps:

   1. Go to the %localappdata%\AADConnect folder, and then open the Synchronization Service_install.txt file.   
   2. Search for the following string: 
      
      value 3

   3. Locate the error message just before the "value 3" string in the file.
2. Troubleshoot the actual error message.   

### Example

Installation failures can occur for many reasons. Here's an example of what to look for in the Synchronization Service_install.txt file.

```asciidoc
MSI (s) (2C!64) [15:48:23:562]: Product: Forefront Identity Manager Synchronization Service -- Error 25009.
The Forefront Identity Manager Synchronization Service setup wizard cannot configure the specified database. 
Invalid object name 'mms_management_agent'. A required privilege is not held by the client.
Error 25009.The Forefront Identity Manager Synchronization Service setup wizard cannot configure the specified 
database. 
Invalid object name 'mms_management_agent'. A required privilege is not held by the client.
CustomAction ConfigDB returned actual error code 1603 (note this may not be 100% accurate if translation 
happened inside sandbox)
Action ended 15:48:23: InstallFinalize. Return value 3. 
```

In this example, the actual error message is the following:

```asciidoc
Service -- Error 25009.The Forefront Identity Manager Synchronization Service setup wizard cannot configure the specified database. Invalid object name 'mms_management_agent'. A required privilege is not held by the client.
```

A search for the error returns the following TechNet topic that you can use to troubleshoot the problem:

[Troubleshooting FIM Installation Error 25009](https://social.technet.microsoft.com/wiki/contents/articles/1734.troubleshooting-fim-installation-error-25009.aspx)

> [!NOTE]
> You may receive a different error message, depending on the problem that you're experiencing. After you identify the error message in the Synchronization Service_install.txt file, you will have more information available to further troubleshoot the issue.

## More information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread)website.