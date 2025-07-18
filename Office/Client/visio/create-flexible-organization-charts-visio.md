---
title: Create flexible organization charts in Visio
description: This article describes how to create organization charts in Visio.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Charts
  - CSSTroubleshoot
appliesto: 
- Visio 2013
- Visio 2016
- Visio 2019
- Visio 2021
search.appverid: MET150
ms.reviewer: johngue
author: simonxjx
ms.author: v-six
ms.date: 06/06/2024
---
# Create flexible organization charts in Visio

This step-by-step article discusses methods that you can use to create flexible organization charts in Microsoft Visio. This article contains information about how to:

- Make your organization chart easy to revise
- Revise the reporting structure, the position type, and the location of shapes
- Compare two versions of the same organization chart and create a report of the changes
- Store data in your organization chart and generate reports

## Make your organization chart easy to revise

To make your organization chart easy to revise in the future, use one or both of the following methods:

- Create the organization chart by using the Organization Chart solution. The Organization Chart solution is a set of specially designed shapes, wizards, and other tools.

    On the **File** menu, point to **New**, select **Organization Chart**, select **Metric Units** or **US Units**, and then select **Create**.

- Let the Organization Chart template automatically draw the connectors that establish the reporting relationships in your organization chart.

    To automatically establish a reporting relationship, drag a shape from the **Organization Chart Shapes** stencil, and then drop the shape directly on top of the shape that represents the position to which it reports.

## Revise the reporting structure, the position type, and the location of shapes

To revise the reporting structure, the position type, and the location of shapes in your organization chart, use, or more of the following methods:

- To quickly create reporting relationships between one supervisor and several subordinates, drag either the **Multiple shapes** shape or the **Three Positions** shape on top of the supervisor shape.

- To convert the position type of one shape to a different position type, right-click the shape, select **Change Position Type**, select the position type that you want, and then select **OK**.

- To assign a position and its subordinates to a new supervisor, drag the shape that represents the subordinate position on top of the shape that represents the supervisor position to which you want the subordinate position to report.

- To move a position and keep the same reporting structure, select the shape that represents the position, point to **Move Subordinates** on the **Organization Chart** menu, and then select either **Left/Up** or **Right/Down**.

    > [!NOTE]
    > In Visio 2010, "Move Subordinates" is now the **Move Left/Up** and **Move Right/Down**  buttons in the **Arrange** group of the **Org Chart** tab on the Ribbon.

- To change the layout of positions in a reporting structure, right-click the shape that represents the top level of the reporting structure, and then select **Arrange Subordinates**. Click the layout style that you want, and then select **OK**.

## Compare two versions of the same organization chart and create a report of the changes

You can compare two different versions of the same organization chart, and then generate a report of the differences between the older version and the newer version. You can use the information in the report to update information in an older version of an organization chart. To compare two different versions of the same organization chart, follow these steps:

1. Open either the newer version of the organization chart or the older version of the organization chart.

2. On the **Organization Chart** menu, select **Compare Organization Data**.

    > [!NOTE]
    > In Visio 2010, select the **Org Chart** tab, and then select **Compare** in the **Organization Data**  group.

3. In the **Drawing to compare it with** box, select **Browse**, locate the version of the organization chart that you want to compare, and then select **Open**.

4. Under **Compare type**, use one of the following steps, depending on your situation:

   - Select **My drawing is older. Show a report of the changes made to the other drawing**.
   - Select **My drawing is newer. Show a report of the changes I've made to my drawing**.

5. Under **Report type**, specify the option that you want.

6. Select **OK**.The following are examples of situations where you may want to compare two versions of an organization chart:

    - You have two versions of a departmental organization chart. One version is for distribution, and the other version is for your private use. The version that you keep for private use contains confidential data, such as employee dates of hire, salaries, and grade levels. When the departmental organization changes, you only have to update the public version. By comparing the public version with the private version, you can manually update the structural changes without affecting the confidential data.

    - You updated a departmental organization chart to reflect recent staffing changes. The updated departmental organization chart contains new information and is not synchronized with the overall organization chart for your company. By comparing the departmental chart with the overall organization chart for your company, you can generate a report of the differences and submit the report to your human resources department so that the organization chart for your whole company can be updated.

    - You spent lots of time formatting and laying out a special version of an organization chart for a presentation. Then, just before the presentation, you learn that the organization has changed. By comparing the formatted chart with a chart that represents the new organization, you can more easily update the formatted chart without losing any formatting.

## Store data in your organization chart and generate reports

You can add data such as e-mail addresses and telephone numbers to shapes in your organization chart. To do this, follow these steps:

1. In your organization chart, right-click the shape to which you want to add data, and then select **Properties**.

2. In the **Custom Properties** dialog box, type the data that you want to add, and then select **OK**.Note that you can also create custom property fields for data that you want to add to shapes in your organization chart. The following are two examples of situations where you may want to store data in shapes in your organization chart:

    - You want the organization chart to serve as a public data source and to represent organizational structure. For example, if you store employee telephone numbers and e-mail addresses in organization chart shapes, you can turn your organization chart into a communication directory.

    - You want the organization chart to serve as the central repository for either public or private employee data. For example, you want to store telephone numbers, dates of hire, salaries, and grade levels in your organization chart. Additionally, you want to generate a report from the organization chart. You can save the report as a Microsoft Office Excel spreadsheet, as an HTML file, as an XML file, or as an Excel spreadsheet that is embedded in a shape in your drawing.
