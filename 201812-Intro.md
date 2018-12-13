Hampton Roads PowerShell User Group Meeting Minutes (HRPSUG) Intro
========================

## Introductions
  * Steve Correia
  * Dave Stein
  * Brandon Hunter
  * Anthony Brown
  * Dave Evans (not a member)
  * George Grundy

## PowerShell User Group
- Agreed to meet 2nd Wednesday of every month 
- Decided skillset is considered moderate
- Will use Slack to communicate, meetup.com for meetups, github for code/files
- Dave Evans mentioned he is starting up 757 Labs (basically Geek hangout - 757labs.org) in Portsmouth
- Decided to add "Employment News" to agenda  
- Discussed the benefits and drawbacks of degrees (not Powershell related but interesting nonetheless)
- Discussed basic powershell commands processing
- Discussed several powershell projects that Dave Stein has been working.
- Suggested topics
  - Slack webhooks
  - Slack chatbots

## Links

* www.w3schools.com
* www.ss64.com
* Don Jones on YouTube - https://www.youtube.com/results?search_query=don+jones+powershell

## Topics

* Twitter hashtag "#hrpsug"
* Topics:
  * Function basics, parameters, validation
    * ValidateRange(n,n)
    * ValidateNotNullOrEmpty()
    * ValidateSet('a','b','c')
    * ValidateLength(12)
  * String basics
    * Here-strings... @"..."@ and @'...'@ (delimiters must be on separate line from body text)
    * Normal string wrapping "..." (can start with first part of body text and end with body)
  * Pipeline basics: 
    * $(Get-Process | Where-Object {$_.ProcessName -like "A*"} | Sort-Object ProcessName | Select -First 3)
  * Dot-sourcing
    * Loads code into memory where it's called from (script or console session, etc.)
    
  
