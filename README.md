#OCaml Node

**WARNING:** This binding is partial.

## What is ocaml-node?

ocaml-node is a binding to NodeJS Core in OCaml written with [gen_js_api](https://github.com/LexiFi/gen_js_api). It will let you use its functions directly in OCaml.

## How to install?

You need to switch to OCaml >= **4.03.0** (due to gen_js_api):

`opam switch 4.03.0`

You also need
[ocaml-js-stdlib](https://github.com/dannywillems/ocaml-js-stdlib).

`opam pin add ocaml-js-stdlib https://github.com/dannywillems/ocaml-js-stdlib.git`

To install this package use the command:

`opam pin add ocaml-node https://github.com/besport/ocaml-node.git`

## How to use?

There are two kinds of require in node :
- Those returning a function waiting for an object
- Those returning a module directly

Here is an example of usage:

Javascript code:

```JavaScript
var jsonfile  = require("jsonfile");
var nightmare = require("nightmare");
var nightmareAux = nightmare({show : true});
```

Equivalent in OCaml using [gen_js_api](https://github.com/lexifi/gen_js_api) (for Ojs.t type):

```OCaml
let jsonfile  = Node.require "jsonfile" in
let nightmare = Node.require_fn "nightmare" in
let opts = Ojs.empty () in
let () = Ojs.set opts "show" (Ojs.bool_to_js true) in
let nightmare_aux = nightmare opts in
()
```
