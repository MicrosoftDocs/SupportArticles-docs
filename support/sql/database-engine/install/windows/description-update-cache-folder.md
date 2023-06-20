---
title: Description of the Update Cache folder
description: This article describes why this folder is created and what it's used for.
ms.date: 10/23/2020
ms.custom: sap:Database Engine 
---
# Description of the Update Cache folder in SQL Server

This article describes why this folder is created and what it's used for.

_Original product version:_ &nbsp; SQL Server 2008, SQL Server 2012, SQL Server 2014, SQL Server 2016, SQL Server 2017 on Windows (all editions)  
_Original KB number:_ &nbsp; 3196535

## Summary

The Update Cache folder for Microsoft SQL Server is found in the location: `C:\Program Files\Microsoft SQL Server\<m.n>\Setup Bootstrap\Update Cache`.

This article provides information to help you understand why this folder is created and what it's used for.

## More information

- **When is this folder created and what is it used for?**

    When you install any SQL Server update (cumulative update, critical update, or service pack), the update installation media is cached in the SQL Server Update Cache folder. The entries in `Add/Remove Programs`  are created from the contents of the cached media folder and are used to uninstall (as necessary) the most recent update that was applied to a particular component. The folder may contain multiple earlier updates, allowing for sequential removal of those updates if necessary.

    A variation of this model occurs when a component was installed by a stand-alone MSI file instead of by SQL Server Setup. These components are serviced in-place by replacing the previous MSI file with the new one, without maintaining a history of previous versions. The original MSI file is required for both uninstall and repair operations.

- **When is this folder cleaned up or removed?**  

    When all patches are removed from all instances, or when the product is uninstalled.

- **Why does the folder continue to grow in size?**  

    The folder grows in size with each update that's applied to your SQL Server instance. This growth occurs because each earlier version must be cached. This behavior ensures that you can always access an earlier update if you need to.

- **What happens if you remove this folder or delete its contents?**  

    If the Update Cache folder or some patches are removed from this folder, you can no longer uninstall an update to your SQL Server instance and then revert to an earlier update build. In that situation, `Add/Remove Programs` entries point to non-existing binaries, and therefore the uninstall process does not work. Therefore, Microsoft strongly encourages you to keep the folder and its contents intact.

## Applies to

- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Enterprise Core
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Express
- SQL Server 2014 Standard
- SQL Server 2014 Web
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2017 on Windows (all editions)
