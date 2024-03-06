---
title: The given Key was not present in the dictionary
description: Describes an issue that occurs when you run the Group Policy Modeling Wizard against a new Group Policy setting.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Group Policy error: "The given Key was not present in the dictionary"

This article provides a solution to a Group Policy error (The given Key was not present in the dictionary) that occurs when you run the Group Policy Modeling Wizard against a new Group Policy setting.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2692409

## Symptoms

Consider the following scenario:  

- You create a new Group Policy setting and configure some registry items under **Preferences (user or Computer)**. To do this, you use the registry wizard to add keys or values to the registry. For example, under `Computer configuration\Preferences\Registry`, you right-click and then select **New** -> **Registry Wizard**. This opens a user interface that enables you to manipulate registry items.
- On Windows Server 2008 R2 and Windows Server 2008, you run the Group Policy Modeling Wizard against the new Group Policy setting. In this scenario, you experience one of the following symptoms, depending on your version of Internet Explorer:  
- In Internet Explorer 8, you receive the following error message and error code 80131577: An error occurred while generating report. The given Key was not present in the dictionary

- In Internet Explorer 9, the wizard runs but does not report any registry settings. Additionally, the **Registry Preferences** section is empty.

## Cause

There is a faulty registry item in the XML file that is associated with the Group Policy registry settings.

## Resolution

To fix this issue, re-create the Group Policy and registry settings. However, while you are using the registry browser to select values in a registry key, do not select the parent key together with the values in it. The parent key is autoselected. This is, when you select a value in a key, a red tick appears automatically on the parent key folder. It is not necessary also to select the parent key.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
