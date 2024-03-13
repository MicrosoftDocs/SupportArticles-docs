---
title: Version numbers and build numbers of Dexterity in Microsoft Dynamics GP
description: Describes Dexterity version numbers and build numbers in Microsoft Dynamics GP. Also contains solutions for a related login problem if the version and the build numbers of Dexterity are not consistent.
ms.reviewer:
ms.date: 03/13/2024
---
# Information about version numbers and build numbers of Dexterity in Microsoft Dynamics GP

This article introduces the version numbers and the build numbers of Dexterity that are used in Microsoft Dynamics GP. This article also describes a problem that occurs in Microsoft Dynamics GP if the version numbers and the build numbers of Dexterity are not consistent.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 920831

Starting with the release of Dexterity for Microsoft Dynamics GP, tighter version controls are enforced by both Dexterity and by Microsoft Dynamics GP.

Dexterity will extract a chunk file only when the following information is true:

- Dexterity has the same major and minor versions.
- Dexterity has a build number that is greater than or equal to the build number of the existing dictionary that is installed in Microsoft Dynamics GP.

These conditions mean that you cannot accidentally install an older build of a chunk file. However, these conditions can also prevent the installation of upgrades to new versions of a third-party product. For example, if version 8.0 a third-party dictionary remains in a version 9.0 environment, you cannot install version 9.0 of the chunk file to upgrade the third-party program. To install version 9.0 of the chunk file, you must first delete the version 8.0 dictionary.

Microsoft Dynamics GP also has a version checking feature. Microsoft Dynamics GP will not let you log in unless all dictionaries that are installed on the workstation match the version and build information that is stored in the DU000020 table. If there is a problem that involves the version and build information, you receive the following error message:

> A product installed on your computer is on a different version than the database version. You will not be able to use the application until this issue is resolved. Use the GP_LoginErrors.log file in your temp directory to assist in resolving this issue.

After you install a service pack, the build number of the core dictionary changes. For version 9.0, the build number of the core dictionary changed from 114 to 259. This change means that when a developer tries to run a program in Test Mode, the system typically produces this error.

This error also occurs when you try to view a source code dictionary that is based on an earlier build than the current build. This error occurs for earlier builds of products that have not been updated in any service pack.

To resolve this problem, we recommend that you obtain a new dictionary that is based on the current build of the Dynamics.dic file. For third-party dictionaries, you can update the code that is in the current build of the Dynamics.dic file by using the Dexterity Source Code Control Service.

For more information about how to upgrade a Dexterity-based application by using the Dexterity Source Code Control Service, see [How to upgrade a Dexterity-based application in Microsoft Dynamics GP by using the Dexterity Source Code Control Service](https://support.microsoft.com/topic/how-to-upgrade-a-dexterity-based-application-in-microsoft-dynamics-gp-by-using-the-dexterity-source-code-control-service-9a592921-430d-e33b-9ab5-b7072dd9d026).

For dictionaries that you want to access but that you do not plan to change, follow these steps to enable the dictionaries to run in Test Mode:

1. In Dexterity Resource Explorer, click **Application**, and then double-click **Install**.
2. In the **Install Information** window, click **Module 066**.
3. In the **Build Number** field, type the current build number. For example, type a value from 114 to 259 for Microsoft Dynamics GP 9.0 Service Pack 1.
4. Click **OK**.

Alternatively, you can take the following actions:

- Change the DU000020 table in Microsoft SQL Server.
- Change the build number in the "PRODID = 0" line of the TSQL code that will be run in Microsoft SQL Query Analyzer.

> [!IMPORTANT]
> You must restore the build number after you finish accessing the dictionaries.

## References

For more information about index files and Great Plains Dexterity source code control functionality, see [How to use an index file and the Microsoft Dynamics GP Dexterity source code control functionality to make sure that the resources that you create maintain the same resource ID in different builds and versions of your code](https://support.microsoft.com/topic/how-to-use-an-index-file-and-the-microsoft-dynamics-gp-dexterity-source-code-control-functionality-to-make-sure-that-the-resources-that-you-create-maintain-the-same-resource-id-in-different-builds-and-versions-of-your-code-02402cc4-d884-afcf-d910-1d47722c18cc).
