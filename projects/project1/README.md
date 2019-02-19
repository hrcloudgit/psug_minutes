# Project 1: Active Directory Account Clean-Up

## Objectives

* Identify unused / dormant user and computer accounts
* Move them to a designated OU
* Disable them
* Change the account description to indicate what/when/why/who
* Maintain a log file of changed accounts

## Assumptions

* Dormant accounts:
  * Not having authenticated to the AD domain for at least 90 days
  * Users: ignore accounts in OU "Service Accounts"
  * Computers: ignore servers
* Move to OU: \graveyard\computers or \graveyard\users
* Must be portable: No need for RSAT, a DC or any other tools, modules, etc.
* Log entries must include date/time, account type, account name, runas account, and actions taken

## Approach

* Design for future needs:
  * Easy control over last-logon threshold (days)
  * Easy control over target OU
  * Easy control over excluded OU's
  * Easy control over log file location
* Use "LastLogonTimeStamp" attribute for basis of determination
* Potential roadmap:
  * Make into a PowerShell module
  * Schedule to run daily

## What you will need

* An Active Directory domain in a test environment
* A user account with permissions in the domain to modify user and computer accounts
* A Windows 10 or Windows Server 2016 computer joined to the domain (for script build/test)
