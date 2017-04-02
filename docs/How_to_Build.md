---
layout: default
---

# How to build the Gemspec

## Instructions

1. Upload this repo to your own repo on __GitHub__ (**note: you _MUST_ change something in this repo!**)
2. Open the `rps.gemspec` file with your preferred **IDE**
3. Delete these lines:
   + `spec.cert_chain  = ["certs/gem-public_cert.pem"]`
   - `spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/`
4. Save
5. Open `Terminal`/`Command Prompt`
6. `cd` to the directory of the `rps.gemspec` file (**note: this file must be in the _root_ of the repo folder**)
7. Type: `gem build rps`
8. Hit <kbd>return</kbd>/<kbd>enter</kbd>

-----------

## Site Nav 

[Home](./) | [How to Test](Testing) | [Contributing](CONTRIBUTING) | [Code of Conduct](CODE_OF_CONDUCT)
