---
layout: default
title:  Copying - Play Rock Paper Scissors Game
permalink: /copying.html
---

# Rules for Copying

Since this project has an [MIT](https://en.wikipedia.org/wiki/MIT_License), one will be allowed to copy the code.
However, one must follow this main rule:

* **Change the code in some way**

The above rule means that you must change any part of the code by physically adding or removing something from it.

**This does not include adding a <kbd>space</kbd> or a <kbd>carriage return (enter/return)</kbd>**

**The best way to follow the above rule is to add or remove a comment from the code**.

Ex. 

## Before

```ruby
module Constants 
  NTRY_TO_SYM = { # define entry to symbol (key to value)
    'p' => :PAPER   , 
    'r' => :ROCK    , 
    's' => :SCISSORS 
  } 
  # ..... 
```

## After

```ruby 
module Constants 
  NTRY_TO_SYM = {
    'p' => :PAPER   , 
    'r' => :ROCK    , 
    's' => :SCISSORS 
  } 
  # .....

```