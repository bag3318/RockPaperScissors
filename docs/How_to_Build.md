---
layout: default
title: How to Build - Play Rock Paper Scissors Game
---

# How to build the Gemspec

## Requirments 

* Ruby and Ruby Gems installed

## Instructions

1. Open the `rps.gemspec` file with your preferred **IDE**
2. Delete these lines:
   + `spec.cert_chain  = ["certs/gem-public_cert.pem"]`
   - `spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/`
3. Save
4. Open `Terminal`/`Command Prompt`
5. `cd` to the directory of the `rps.gemspec` file (**note: this file must be in the _root_ of the repo folder**)
6. Type: `gem build rps`
7. Hit <kbd>return</kbd>/<kbd>enter</kbd>
