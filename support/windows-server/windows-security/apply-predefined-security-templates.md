---
title: Apply predefined security templates
description: Describes how to apply predefined security templates.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:security-templates, csstroubleshoot
---
# How to apply predefined security templates in Windows Server 2003

This step-by-step article describes how to apply predefined security templates.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816585

## Summary

Microsoft Windows Server 2003 includes several predefined security templates that you can apply to increase the level of security on your network. You can modify security templates to suit your requirements by using Security Templates in Microsoft Management Console (MMC).

### Predefined Security Templates in Windows Server 2003

- Default security (Setup security.inf)

    The Setup security.inf template is created during installation, and it is specific for each computer. It varies from computer to computer, based on whether the installation was a clean installation or an upgrade. Setup security.inf represents the default security settings that are applied during the installation of the operating system, including the file permissions for the root of the system drive. It can be used on servers and client computers; it cannot be applied to domain controllers. You can apply portions of this template for disaster recovery purposes.

    Do not apply Setup security.inf by using Group Policy. If you do so, you may experience decreased performance.

    > [!NOTE]
    > In Microsoft Windows 2000, two miscellaneous security templates exist, ocfiless (for file servers) and ocfilesw (for workstations). In Windows Server 2003, these files have been superseded by the Setup security.inf file.

- Domain controller default security (DC security.inf)

    This template is created when a server is promoted to a domain controller. It reflects file, registry, and system service default security settings. If you reapply this template, these settings are set to the default values. However, the template may overwrite permissions on new files, registry keys, and system services created by other programs.

- Compatible (Compatws.inf)

    This template changes the default file and registry permissions that are granted to the members of the Users group in a manner that is consistent with the requirements of most programs that do not belong to the Windows Logo Program for Software. The Compatible template also removes all members of the Power Users group.

    For more information about the Windows Logo Program for Software, visit the following Microsoft Web site:
    [Windows Server Catalog](https://www.windowsservercatalog.com/content.aspx?ctf=logo.htm)
    > [!NOTE]
    > Do not apply the Compatible template to domain controllers.

- Secure (Secure*.inf)

    The Secure templates define enhanced security settings that are least likely to affect program compatibility. For example, the Secure templates define stronger password, lockout, and audit settings. Additionally, the templates limit the use of LAN Manager and NTLM authentication protocols by configuring clients to send only NTLMv2 responses and by configuring servers to refuse LAN Manager responses.

    There are two predefined Secure templates in Windows Server 2003: Securews.inf for workstations and Securedc.inf for domain controllers. For additional information about using these templates and other security templates, search Help and Support Center for "predefined security templates".

- Highly Secure (hisec*.inf)

    The Highly Secure templates specify additional restrictions that are not defined by the Secure templates, such as encryption levels and signing required for authentication and data exchange over secure channels and between Server Message Block (SMB) clients and servers.

- System root security (Rootsec.inf)

    This template specifies the root permissions. By default, Rootsec.inf defines these permissions for the root of the system drive. You can use this template to reapply the root directory permissions if they are inadvertently changed, or you can modify the template to apply the same root permissions to other volumes. As specified, the template does not overwrite explicit permissions that are defined on child objects; it propagates only the permissions that are inherited by child objects.
- No Terminal Server user SID (Notssid.inf)

    You can apply this template to remove Windows Terminal Server security identifiers (SIDs) from the file system and registry locations when Terminal Services is not being run. After you do so, system security does not necessarily improve.
    For more detailed information about all predefined templates in Windows Server 2003, search Help and Support Center for "predefined security templates".

    > [!IMPORTANT]
    > Implementing a security template on a domain controller may change the settings of the Default Domain Controller Policy or Default Domain Policy. The applied template may overwrite permissions on new files, registry keys and system services created by other programs. Restoring these policies might be required after you apply a security template. Before you follow these steps on a domain controller, create a backup of the SYSVOL share.

### Apply a Security Template

1. Click **Start**, click **Run**, type *mmc*, and then click **OK**.
2. On the **File** menu, click **Add/Remove Snap-in**.
3. Click **Add**.
4. In the **Available Stand Alone Snap-ins** list, click **Security Configuration and Analysis**, click
 **Add**, click **Close**, and then click
 **OK**.
5. In the left pane, click **Security Configuration and Analysis** and view the instructions in the right pane.
6. Right-click **Security Configuration and Analysis**, and then click **Open Database**.
7. In the
 **File name** box, type the name of the database file, and then click **Open**.
8. Click the security template that you want to use, and then click
 **Open** to import the entries that are contained in the template to the database.
9. Right-click **Security Configuration and Analysis** in the left pane, and then click **Configure Computer Now**.
