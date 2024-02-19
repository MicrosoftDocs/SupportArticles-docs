---
title: '"The parameter is incorrect" error and cluster validation fails against Validate Resource status'
description: Helps to resolve an error "The parameter is incorrect" that occurs when cluster validation fails against the Validate Resource status
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
---
# Error (The parameter is incorrect) and cluster validation fails against "Validate Resource" status

This article helps to resolve the error "The parameter is incorrect" that occurs when cluster validation fails against the Validate Resource status.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4561946

## Symptoms

When you check the Active Directory organizational unit (OU), cluster validation fails against the "Validate Resource" status, and you receive the following error message:  

> An error occurred while executing the test. The operation has failed. An error occurred while checking the Active Directory organizational unit for the cluster name resource. The parameter is incorrect.

:::image type="content" source="media/parameter-incorrect-error-cluster-validation-fails/parameter-incorrect-error.png" alt-text="An error occurred while executing the test. The operation has failed." border="false":::

If you try to create the client access points, the process can still fail if the IP address used is the same as the address in the error message.  

This problem can also occur after you grant CNO permission to the cluster OU, and the user also has full control permissions on the CNO object.

## Cause

The parameter error is caused when authenticated users don't have default Read permissions on the default **Computers** container.

## Resolution

To resolve this problem, grant the Read permission to authenticated users. Authenticated users require Read permissions to objects that are in the **Computers** container, even if the computer objects aren't there.

## Status

A test has been added to cluster validation to specifically check for the CNO permission.
