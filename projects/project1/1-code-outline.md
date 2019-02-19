# Project 1: Code Outline

This document provides an outline for a live (in-person or online) session focused on building a script to accomplish a stated task.  In this exercise, the task is to automate the processing of dormant AD computer accounts.

## Workflow Outline

1. Fetch computer accounts which have not authenticated with AD in X days
   * (foreach account...)
2. Disable the account
3. Modify the Description attribute
4. Move the account to a special OU
5. Record the event in a log file

## More...
