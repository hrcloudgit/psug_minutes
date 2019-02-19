# Project 1: Active Directory Account Clean-Up

## Objectives

* Identify unused / dormant computer accounts and process them to "clean up" the domain

## Assumptions

* Dormant accounts:
  * Not having authenticated to the AD domain for at least 90 days
  * Ignore servers, focus on desktops/laptops only
* Move to OU: contoso.local\graveyard
* Must be portable: No need for RSAT, a DC or any other tools, modules, etc.
* Log entries must include activity details (date, time, who, what, etc)

## Approach

* Whiteboard the steps involved, sequence order
* Establish parameters for controlling behavior
* Map out functions and parameters
* Assemble control script using function calls

## What you will need

* A test environment with an Active Directory domain (e.g. "contoso.local")
* A user account with permissions in the domain to modify user and computer accounts
* A Windows 10 or Windows Server 2016 computer joined to the domain (for script build/test)

## Estimated Time to Complete

* 2.0 hours
