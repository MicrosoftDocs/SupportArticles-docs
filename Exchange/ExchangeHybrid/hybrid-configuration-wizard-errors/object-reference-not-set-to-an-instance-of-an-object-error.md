---
title: Object reference not set to an instance of an object error
description: Describes that you receive an Object reference not set to an instance of an object error when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: timothyh
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Object reference not set to an instance of an object error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067696

## Symptoms

When you run the Hybrid Configuration wizard, you receive the following error message:

> ERROR: Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Creating Organization Relationships.  
Object reference not set to an instance of an object.

## Cause

The hybrid object is missing from the Active Directory domain. For example, this can occur if the object was deleted.

## Resolution Method 1 - Rerun setup /prepareAD

1. On the server that is running Microsoft Exchange Server, open a Command Prompt window as an administrator, and then change to the folder in which the Exchange installation files are stored.

2. Run the following command:

    ```console
    setup /prepareAD
    ```

3. Restart the server.
4. Rerun the Hybrid Configuration wizard.

## Resolution Method 2 - Perform an authoritative restore of the hybrid object

Restore the hybrid object that was deleted from the following location:

CN=Configuration,DC=\<DOMAIN>,DC=\<COM>,CN=Services,CN=Microsoft Exchange,CN=\<ORGANIZATIONAME>,CN=Hybrid Configuration

For more information about how to do this, see [Performing Authoritative Restore of Active Directory Objects](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816878(v=ws.10)).

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
