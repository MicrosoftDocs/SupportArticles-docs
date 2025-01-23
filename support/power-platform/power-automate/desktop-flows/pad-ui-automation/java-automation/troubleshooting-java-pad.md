---
title: Troubleshooting Java automation in PAD
description: Solves java automation issues with PAD
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/22/2025
---

# Troubleshooting Java automation in PAD

## Requirements

To use Java Automation using Power Automate for desktop (PAD), one or more of the following Java versions need to be installed:

> [!NOTE]
> The type of installation can be either Oracle/OpenJDK JDK or JRE

1. Java 7
1. Java 8
1. Java 11+

## How to verify that Java Automation works

1. Open the Java Control Panel by typing "Java" in the search bar.
1. Open the Configure Java.
1. Then try capture a button from the General Tab. For example the button "About". Make sure that the highlighter highlights the correct element.
1. Create a desktop flow that runs the "Click element in Window" action and verify that the element was clicked.
