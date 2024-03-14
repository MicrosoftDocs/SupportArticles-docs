---
title: How to set up minimum security access to sign in Microsoft Dynamics GP or to Microsoft Great Plains
description: Discusses the minimum security access that's required for a user to sign in Microsoft Dynamics GP or to Microsoft Great Plains.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to set up minimum security access to sign in Microsoft Dynamics GP or to Microsoft Great Plains

This article discusses the minimum security access that's required for a user to sign in Microsoft Dynamics GP or to Microsoft Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858718

## Introduction

To sign in Microsoft Dynamics GP or to Microsoft Business Solutions - Great Plains, you must have the minimum security access. You can enable security access that has regular security or that has advanced security settings.

## Regular security

To set up security that has regular security settings, follow these steps:

1. On the **Tools** menu, click **Setup** > **System** >**Security**.
    > [!NOTE]
    > For versions of the program that are earlier than Microsoft Business Solutions - Great Plains 8.0, click **System** on the **Setup** menu, and then click **Security**.
2. In the **User ID** box, click the user who you want to set security for.
3. In the **Product** box, click **Dynamics**, **eEnterprise**, **Great Plains**, or **Microsoft Dynamics GP**, depending on the product.
4. In the **Type** box, click **Windows**.
5. In the **Series** box, click **System**.
6. In the **Access List** area, double-click the following items to put an asterisk next to each item:
   - **eEnterprise/Dynamics**, **Great Plains**, or **Microsoft Dynamics GP**  
   - **eEnterprise/Dynamics**, **Great Plains**, or **Microsoft Dynamics GP**  
   - **Process Window**  
   - **Toolbar**  
   - **Welcome to Great Plains eEnterprise/Dynamics**, **Welcome to Microsoft Business Solutions - Great Plains**, or **Welcome to Microsoft Dynamics GP**
7. Change **Series** to **Company**.
8. In the **Access List** area, double-click **Company Login** to put an asterisk next to Company Login.
9. In the **Product** box, click **Explorer** or **SmartList**.
10. In the **Type** box, click **Windows**.
11. In the **Series** box, click **Company**.
12. In the **Access List** area, double-click **ASI_Explorer_DDL** to put an asterisk next to "ASI_Explorer_DDL."
13. In the **Product** box, click **Canadian Payroll**.
14. In the **Type** box, click **Windows**.
15. In the **Series** box, click **Project**.
16. In the **Access List** area, double-click the following items to put an asterisk next to each item:
    - **(Middle) Windows 1**  
    - **~Internal~**
17. In the **Product** box, click **Analytical Accounting**.
18. In the **Type** box, click **Windows**.
19. In the **Series** box, click **Company**.
20. In the Access List area, double-click the following items to put an asterisk next to each item:
    - **Fields - the first one on the list**  
    - **Fields - Do not assign!**
21. Change the Series to Financial.
22. In the Access list area, double-click **~Internal~** to put an asterisk next to the ~Internal~ item.
23. Change the Series to System.
24. In the Access list area, double-click **Inquiry** to put an asterisk next to Inquiry.
25. In the **Product** box, click **Project Accounting**.
26. In the **Type** box, click **Windows**.
27. In the **Series** box, click **Project**.
28. In the **Access list** area, double-click **Toolbar** to put an asterisk (*) next to the Toolbar item.
29. In the **Product** box, click **Manufacturing**.
30. In the **Type** box, click **Window** s.
31. In the **Series** box, click **3rd Party**.
32. In the **Access List** area, double-click the following items to put an asterisk next to each item:
    - Toolbar Invisible
    - Set MFG & HRP Globals
33. In the **Product** box, click **Cash Flow Management**.
34. In the **Type** box, click **Windows**.
35. In the **Series** box, click **3rd Party**.
36. In the **Access List** area, double-click **CFM DBUtil Class** to put an asterisk next to the item.

## Advanced security

To set up security that has advanced security settings, follow these steps:

1. On the **Tools** menu, click **Setup** > **System** > **Advanced Security**.
    > [!NOTE]
    >
    > - For versions of the program that are earlier than Microsoft Business Solutions - Great Plains 8.0, click **System** on the **Setup** menu, and then click **Advanced Security**.
    > - Advanced Security is not available for Microsoft Business Solutions - Great Plains 6.0.

2. In the left pane of the Advanced Security window, expand **by Dictionary** > **Microsoft Dynamics GP** > **Forms** > **System**.
3. Click to select the following check boxes:
   - **Great Plains** or **Microsoft Dynamics GP**  
   - **Great Plains** or **Microsoft Dynamics GP**  
   - **Process Window**  
   - **Toolbar**  
   - **Welcome to Microsoft Business Solutions - Great Plains** or **Welcome to Microsoft Dynamics GP**
4. Expand **Company**, and then click to select the **Company Login** check box.
5. Under **by Dictionary**, expand **SmartList** > **Forms** > **Company**.
6. Click to select the **ASI_Explorer_DDL** check box.
7. Under **By Dictionary**, expand **Canadian Payroll** > **Forms** > **Project**.
8. Click to select the following check boxes:
   - **(Middle) Windows 1**  
   - **~Internal~**
9. Under **By Dictionary**, expand **Analytical Accounting** > **Forms** > **Company**.
10. Click to select the following check boxes:
    - **Fields - the first Fields listed**  
    - **Fields - Do not assign!**
11. Expand **Financial**, and then click to select the **~Internal** check box.
12. Expand **System**, and then click to select the **Inquiry** check box.
13. Under **By Dictionary**, expand **Project Accounting** > **Forms** > **Project**, and then click to select the **Toolbar** check box.
14. Under **By Dictionary**, expand **Manufacturing** > **Forms** > **3rd Part**.
15. Click to select the following check boxes:
    - Toolbar Invisible
    - Set MFG & HRP Globals
16. Under **By Dictionary**, expand **Cash Flow Management** > **Forms** > **3rd Party**.
17. Click to select the **CFM DBUtil Class** check box.

## References

For more information about the required security settings for using Manufacturing, click the following article number to view the article in the Microsoft Knowledge Base:

[857467](https://support.microsoft.com/help/857467)'You do not have access to open this form' when you load Manufacturing in Great Plains
