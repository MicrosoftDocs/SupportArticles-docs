---
title: Re-create the Project Accounting Reports dictionary (Parept.dic) for Microsoft Dynamics GP
description: Describes how to re-create the Project Accounting Reports dictionary (Parept.dic) for Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: ansather, ppeterso
ms.date: 03/13/2024
---
# How to re-create the Project Accounting Reports dictionary (Parept.dic) for Microsoft Dynamics GP

This article describes how to re-create the Project Accounting Reports dictionary (Parept.dic) for Microsoft Dynamics GP or for Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865526

To re-create the Project Accounting Reports dictionary (Parept.dic), follow these steps:

1. Have all users exit Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0.

2. Rename the Parept.dic file as the Parept.old file.

    This file may be located on the server or on the workstation. The default location of the file is as follows:

    - By default, the Microsoft Dynamics GP 10.0 code folder is in the following location:

        C:\\Program Files\\Microsoft Dynamics\\GP

    - By default, the Microsoft Dynamics GP 9.0 code folder is in the following location:

        C:\\Program Files\\Microsoft Dynamics\\GP

    - By default, the Microsoft Business Solutions - Great Plains 8.0 code folder is in the following location:

        C:\\Program Files\\Microsoft Business Solutions\\Great Plains

3. Start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0, and then open Report Writer.

    When you open Report Writer, a new Parept.dic file is created. To open Report Writer, follow one of these steps:

    - In Microsoft Dynamics GP 10.0, click the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Customize**, and then click **Report Writer**. In the **Product** list, click **Project Accounting**.

    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, click the **Tools** menu, point to **Customize**, and then click **Report Writer**. In the **Product** list, click **Project Accounting**.

4. Click **Reports**, and then verify that the **Modified Reports** list is empty.

    If the **Modified Reports** list is not empty, you renamed the incorrect Parept.dic file in step 2. Locate the correct Parept.dic file, and then repeat steps 1 through 3.

5. Click **Import**.

6. In the **Source Dictionary** field, browse to the Parept.old file, and then click **Open**.

7. Select the modified reports to import from the **Source Dictionary Reports** section, and then insert the modified reports into the **Reports to Import** section.

8. After the modified reports are inserted, click **Import**.

    When the **Reports to Import** section is empty, the modified reports are imported into the new Parept.dic file.
