---
title: Error when sending a report as a .pdf file
description: Provides a solution to an error that occurs when you try to send a report as a .pdf file to an e-mail recipient from Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "When you create a PostScript file you have to send the host fonts." Error message when you try to send a report as a .pdf file to an e-mail recipient from Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to send a report as a .pdf file to an e-mail recipient from Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 915467

## Symptoms

When you try to send a report as a .pdf file to an e-mail recipient from Microsoft Dynamics GP and from Microsoft Business Solutions - Great Plains, you receive the following error message:
> When you create a PostScript file you have to send the host fonts. Please go to the printer properties, "Adobe PDF Settings" page and turn OFF the option "Do not send fonts to Distiller" appears.

You continue to receive this error message after you follow these steps to turn off the **Do not send fonts to Distiller** option:

1. Select **Start**, and then select **Printers and Faxes**.
2. Right-click **Adobe PDF**, and then select **Properties**.
3. On the **General** tab, select **Printing Preferences**.
4. Select the **Do not send fonts to "Adobe PDF"** check box, and then select **OK**.
5. On the **Advanced** tab, select **Printing Defaults**.
6. Select the **Do not send fonts to "Adobe PDF"** check box.
7. Start Microsoft Great Plains.

## Resolution

**Microsoft Dynamics GP**  
To resolve this problem, complete steps 1-6 in the [Workaround](#workaround) section.

**Microsoft Business Solutions - Great Plains 8.0**  
To resolve this problem, complete steps 1-6 of the [Workaround](#workaround) section, and then obtain the latest service pack for Microsoft Business Solutions - Great Plains 8.0.

## Workaround

To work around this problem, follow these steps.

### Adobe 6.0 and Adobe 7.0

1. Select **Start**, and then select **Printers and Faxes**.
2. Right-click **Adobe PDF**, and then select **Properties**.
3. On the **General** tab, select **Printing Preferences**.
4. Select to clear the **Do not send fonts to "Adobe PDF"** check box.
5. On the **Advanced** tab, select **Printing Defaults**.
6. Select to clear the **Do not send fonts to "Adobe PDF"** check box.
7. Start Microsoft Great Plains.
8. In Microsoft Great Plains, select **Print Setup** on the **File** menu.
9. In the **Name** list, select **Adobe PDF**, and then select **Properties**.
10. On the **Adobe Default Settings** tab, select the **Do not send fonts to "Adobe PDF"** check box. Then, select to clear the **Do not send fonts to "Adobe PDF"** check box.
11. Select **OK** two times.

### Adobe 8.0

1. Select **Start**, and then select **Printers and Faxes**.
2. Right-click **Adobe PDF**, and then select **Properties**.
3. On the **General** tab, select **Printing Preferences**.
4. Select to clear the **Rely on System fonts only; do not use document fonts** check box.
5. On the **Advanced** tab, select **Printing Defaults**.
6. Select to clear the **Rely on System fonts only; do not use document fonts** check box.
7. Select **OK** two times.

## Status

**Microsoft Dynamics GP 10.0**  
Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

**Microsoft Dynamics GP 9.0**  
Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

**Microsoft Business Solutions - Great Plains 8.0**  
Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section. This problem was first corrected in Microsoft Business Solution - Great Plains 8.0 Service Pack 4a.

## More information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft doesn't specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article doesn't describe. Because Microsoft must respond to changing market conditions, this information shouldn't be interpreted to be a commitment by Microsoft. Microsoft can't guarantee or support the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. They include but aren't limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, regarding any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
