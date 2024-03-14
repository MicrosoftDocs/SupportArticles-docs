---
title: How to combine Dynamics.dic core dictionary and an extracted dictionary by using Dexterity Utilities in Microsoft Dynamics GP
description: Discusses how to combine a Dynamics.dic file and an extracted dictionary by using Dexterity Utilities in Microsoft Dynamics GP.
ms.topic: how-to
ms.date: 03/13/2024
ms.reviewer: theley
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to combine the Dynamics.dic core dictionary and an extracted dictionary by using Dexterity Utilities in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 930350

## Introduction

When you work with Dexterity in Microsoft Dynamics GP, you start with a copy of the Dynamics.dic core dictionary. Then, you make additions and changes as needed. This dictionary is called the development dictionary. When the code is completed and tested in the development environment, you create a chunk dictionary to package the code for distribution. When you create the chunk dictionary, you create an extracted dictionary that contains source code. This extracted source dictionary contains all the changes and the additions that you made.

If you have to send your dictionary to another developer, send the extracted source dictionary instead of the significantly larger development dictionary. Before you can use an extracted source dictionary together with Dexterity, you must combine the extracted source dictionary with the core dictionary to re-create a development dictionary.

Also, if you want to view resources such as table definitions or reports that are used by a third-party dictionary, you have to combine the third-party dictionary with the core dictionary to create a combined dictionary. You can use this combined dictionary to explore resources. However, the combined dictionary does not contain source code.

When you open an extracted dictionary directly in the Dexterity development environment, you may receive various error messages because certain resources are missing. You may receive any of the following error messages:

- Error Message 1
    > [Not FOUND]
- Error Message 2
    > String Missing
- Error Message 3
    > Script Not Found
- Error Message 4
    > (No Source)

Do not try to make changes in an extracted dictionary. If you try to make changes in an extracted dictionary, you could cause the extracted dictionary to become corrupted.

## Steps to combine dictionaries

If you combine an extracted source dictionary and a core dictionary, you create a combined dictionary that contains source code. The term "combined dictionary" refers to such a dictionary. You can use the combined dictionary as your development dictionary.

1. Make a copy of the Dynamics.dic file in a new location to use as the extracted dictionary.

    This dictionary is also the core dictionary that will become the combined dictionary after the resources from the extracted dictionary are added.

2. Start Dexterity Utilities. To do this, click **Start**, point to **All Programs**, point to **Microsoft Dexterity**, and then click **Dexterity Utilities**.

3. Open the extracted dictionary as the source dictionary. To do this, click **File**, and then click **Open Source Dictionary**. Click the extracted dictionary, and then click **Open**.

4. Open the core dictionary as the destination dictionary. To do this, click **File**, and then click **Open Destination Dictionary**. Click the core dictionary, and then click **Open**.

5. Click **Transfer**, and then click **Developer Update** to transfer all the resources that have a resource ID that is larger than 22,000 into the core dictionary. This creates the combined dictionary.

    > [!NOTE]
    > You cannot use the Alternate Forms functionality of the **Developer Update** command because the source dictionary is an extracted dictionary and does not contain the core dictionary resources.

6. Click **Transfer**, and then click **Dictionary Module** to update all the modified forms for each series and for all the modified reports for each series. Click **All**, and then click **Yes** when you are prompted to overwrite the changes.

7. Close the source dictionary. To do this, click **File**, and then click **Close Source Dictionary**.

8. Close the destination dictionary. To do this, click **File**, and then click **Close Destination Dictionary**.

9. Exit Dexterity Utilities.

> [!NOTE]
> You can now open the combined dictionary in the Dexterity development environment.

> [!WARNING]
> This technique should only be used with dictionaries of the same version. You should use a source code control program if you want to upgrade to a new version. You can use this technique to create a development dictionary before you upgrade to a newer version of Dexterity.

## Glossary

|Term|Definition|
|---|---|
|chunk dictionary|A chunk dictionary is a self-installing dictionary that is based on the extracted source dictionary. However, the chunk dictionary typically does not contain source code.|
|combined dictionary|A combined dictionary is a combination of an extracted source dictionary and a core dictionary. You can use Dexterity to view resources in a combined dictionary. A combined dictionary can become your development dictionary.|
|core dictionary|A core dictionary is a copy of the original Dynamics.dic file from the application folder. A core dictionary does not include source code.|
|destination dictionary|A destination dictionary is any Dexterity dictionary that is opened in Dexterity Utilities when you click **File** and then click **Open Destination Dictionary**.|
|editable dictionary|An editable dictionary is any Dexterity dictionary that is opened in Dexterity Utilities when you click **File** and then click **Open Editable Dictionary**.|
|development dictionary|A development dictionary is a copy of the core dictionary that also contains additions and changes that were made by a developer.|
|extracted dictionary|The extracted dictionary is created when the chunk dictionary is installed after you start Microsoft Dynamics GP. An extracted dictionary resembles an extracted source dictionary. However, the extracted dictionary does not typically include source code. The extracted dictionary only contains source code if the chunk dictionary from which the extracted dictionary is derived did include source code.|
|extracted source dictionary|An extracted source dictionary is created during the chunking process. An extracted source dictionary contains only the additions and the source code changes from the development dictionary.|
|source code|The source code is the Dexterity SanScript scripts that are entered by a developer and then compiled by Dexterity. The source code is usually removed when a product is shipped.|
|source dictionary|A source dictionary is any Dexterity dictionary that is opened in Dexterity Utilities when you click **File** and then click **Open Source Dictionary**.|
|third-party dictionary|Within the context of Dexterity, a third-party dictionary is an extracted dictionary that is from a product other than Microsoft Dynamics GP. Therefore, a third-party dictionary can be an extracted dictionary from another Microsoft product or from an independent software vendor.|
  
For more information about how to create a chunk file from a Development Dictionary, see [How to create a chunk file in Great Plains 8.0 Dexterity](https://support.microsoft.com/help/894700).

For more information about how to use Source Code Control to upgrade a Development Dictionary, see [How to upgrade a Dexterity-based application in Microsoft Dynamics GP or in Microsoft Great Plains by using the Dexterity Source Code Control Service](https://support.microsoft.com/help/910527).
