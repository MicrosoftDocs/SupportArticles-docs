---
title: Title bar displays Lync after you install November 2015 update for Lync 2013
description: Discusses an issue in which Lync is displayed in the title bar of Lync 2013 (Skype for Business 2015) after you install the November 2015 update.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2015
ms.date: 03/31/2022
---

# Title bar displays "Lync" after you install the November 2015 update for Lync 2013 (Skype for Business 2015)

## Symptoms

Consider the following scenario:

- You install the latest update.
- You configure the Skype for Business user interface to be displayed in the Lync 2013 (Skype for Business 2015) client.

In this scenario, you see "Lync" displayed in the title bar of the main window after you log on and also in the "Help > About" window.

## Resolution

To fix this issue, install the [January 12, 2016 update (KB3114502)](https://support.microsoft.com/help/3114502) for Lync 2013 (Skype for Business).

**Note** Lync 2013 was upgraded to Skype for Business in April 2015.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this problem, manually change the product name displays. To do this, use the following methods, depending on your operating system version and whether you are running the Basic client or Pro-Plus (full) client.

### Title bar

Follow these steps for the following setups:

- 64-bit of Lync 2013 Basic client running on 64-bit Windows
- 32-bit Lync 2013 Basic client running on 32-bit Windows

1. Exit the Lync 2013 (Skype for Business 2015) client.
2. Start Registry Editor, and then locate and select the following subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Registration\\{90150000-012D-0000-0000-0000000FF1CE}**
3. In the details pane, right-click the **REG_SZ \<LyncEntryName\>** entry, and then click **Modify**.
4. Type Skype for Business Basic to change the name, and then click **OK**.
5. Restart the Lync 2013 (Skype for Business 2015) client.

Follow the same steps for the following setups, except use the indicated values:

- 32-bit Lync 2013 Basic client running on 64-bit Windows

    **Subkey:**

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Registration\\{90150000-012D-0000-0000-0000000FF1CE}**
- Lync 2013 Pro Plus client

    **Subkey:**

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Registration\\{91150000-0011-0000-0000-0000000FF1CE}**

    **Entry: REG_SZ \<LyncName\>**

> [!NOTE]
> The "Lync" name may continue to be displayed in the title bar immediately upon restart. However, the name will change after the program has read the changed registry setting.

### "Help > About" window

Follow these steps for the following setups:

- 64-bit of Lync 2013 Basic client running on 64-bit Windows
- 32-bit Lync 2013 Basic client running on 32-bit Windows

1. Exit the Lync 2013 (Skype for Business 2015) client.
2. Start Registry Editor, and then locate and select the following subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Registration\\{90150000-012D-0000-0000-0000000FF1CE}**
3. In the details pane, right-click the **REG_SZ \<LyncNameVersion\>** entry, and then click **Modify**.
4. Type Microsoft&reg; Skype for Business&reg; 2015 to change the name, and then click **OK**.
5. Restart the Lync 2013 (Skype for Business 2015) client.

Follow the same steps for the following setups, except use the indicated values:

- 32-bit Lync 2013 Basic client running on 64-bit Windows

    **Subkey:**

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Registration\\{90150000-012D-0000-0000-0000000FF1CE}**
- Lync 2013 Pro Plus client

    **Subkey:**

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Registration\\{91150000-0011-0000-0000-0000000FF1CE}**

    **Entry: REG_SZ \<LyncName\>**

**Note** The correct name will be displayed after the program restarts.

## More Information

For more information about how to configure the Skype for Business user interface, go to the following articles:

- [Why do I see Skype for Business when I'm using Lync?](https://support.office.com/article/why-do-i-see-skype-for-business-when-i-m-using-lync-50935112-4978-46b8-b2ad-9dd7b81365bf)
- [Switching between the Skype for Business and the Lync client user interfaces](https://support.office.com/article/switching-between-the-skype-for-business-and-the-lync-client-user-interfaces-a2394a4c-7522-484c-a047-7b3289742be0)
- [Configure the client experience with Skype for Business 2015](/skypeforbusiness/deploy/deploy-clients/configure-the-client-experience)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
