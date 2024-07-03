---
title: Troubleshoot grid issues in model-driven apps
---

# Contents

[Terms](#terms)

[Useful tools](#useful-tools)

[Steps to perform before starting troubleshooting](#steps-to-perform-before-starting-troubleshooting)

[Grid or sub-grid displays incorrect content](#grid-or-sub-grid-displays-incorrect-content)

[Grid or sub-grid does not display all the records](#grid-or-sub-grid-does-not-display-all-the-records)

[The overall record count does not match the displayed content](#the-overall-record-count-does-not-match-the-displayed-content)

[Cannot edit data in the grid after enabling editing mode](#cannot-edit-data-in-the-grid-after-enabling-editing-mode)

[Some columns don't contain data 9](#some-columns-dont-contain-data)

[Cannot use sorting or sorting does not work correctly](#cannot-use-sorting-or-sorting-does-not-work-correctly)

[Cannot use column filters on a Grid or Sub-grid or filtering does not work correctly](#cannot-use-column-filters-on-a-grid-or-subgrid-or-filtering-does-not-work-correctly)

[Quick Find does not produce correct results](#quick-find-does-not-produce-correct-results)

[Modern Advanced Find does not work correctly](#modern-advanced-find-does-not-work-correctly)

[Nested grid does not display data](#nested-grid-does-not-display-data)

# Terms

1.  Grid control – control that is displayed in an entity page (see screenshots below).

2.  Sub-grid control - control that is displayed in a form or inside a reference panel.

3.  View selector – drop-down control that allows selecting the current view.

4.  Ribbon command bar – content-dependent button bar at the top of a page or form.

5.  Sub-grid menu – content-dependent menu.

6.  Quick Find – search control that allows filtering the current view by typing a search string.

7.  Column Editor – tool that allows adding, removing, or reordering columns in the current view.

8.  Modern Advanced Find – tool that allows applying complex filters to the current view.

9.  Column filters – tool that allows applying simple filters to the grid.

10. Column sorting - tool that allows sorting the grid content by one or more columns.

11. Status column – grid column that allows selecting rows. It is also used for displaying row related messages.

12. Nested grid – child grid that renders inside a grid or sub-grid control.

13. Column header – The header at the top of the Grid or Sub-grid control.

14. Jump bar – Alpha-numeric bar at the bottom of the grid.

![Image](images/image1.png)
Image 1. Entity page with Grid control.


![Image](images/image2.png)
Image 2. Form page.

![Image](images/image3.png)
Image 3. Grid column header and status column.

![Image](images/image4.png)
Image 4. Nested grid.

# Useful tools

1.  [Power Apps Monitoring tool](https://learn.microsoft.com/en-us/power-apps/maker/monitor-overview).

2.  [Web Developer tool](https://developer.chrome.com/docs/devtools/network).

# Steps to perform before starting troubleshooting

1.  Remove or disable custom scripts. One of the first steps is to ensure that custom scripts do not interfere with product functionality. It is highly recommended to perform this step even when custom scripts used to work in one of the previous versions.

    1.  If all custom scripts are attached via form events, follow the steps in [this document](https://learn.microsoft.com/en-us/power-apps/developer/model-driven-apps/troubleshoot-forms#:~:text=app%20form%20behavior-,Use%20URL%20parameters%20to%20disable%20various%20form%20components,-When%20you%27re%20troubleshooting) to disable them.

    2.  Other custom scripts are usually added directly via web resources, custom solutions, or plugins.

    3.  If the issue can not be reproduced after removing custom scripts, then please investigate all the customizations to find the problem.

    4.  If custom scripts are correctly using publicly documented APIs and the product does not behave as documented, try to simplify the custom script to localize the problem. In most of the cases, 10-30 lines of script code is enough to reproduce an issue.

2.  If the problem involves custom entities, custom relationships, custom views, custom configurations, or other custom resources, try to reproduce the issue with OOB (out-of-the-box) standard resources and avoid any custom resources. This will help localize the problem.

3.  Disable all the applicable business rules to see if the issue is caused by a business rule.

4.  If reproducing the issue involves the use of third-party tools, try to reproduce the issue with standard OOB tools.
