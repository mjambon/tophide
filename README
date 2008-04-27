Tophide
=======

Tophide is meant to be loaded in an ocaml toplevel.
Definitions of values whose name starts with an underscore do not result
in the typical 'val NAME : TYPE' output but are simply not shown.

This behavior is particularly useful for hiding preprocessor-generated
values that are not meant to be reviewed by the user/programmer.


1. Installation

  make
  make install         # requires ocamlfind

Uninstallation can be performed with

  make uninstall       # requires ocamlfind


2. Usage

There are two modes: "hide" and "show".

The "hide" mode is automatically triggered when tophide is loaded.
It is the mode that hides the values whose name starts with "_".

The "show" mode is the regular mode. This mode can be entered using the
"#hide" directive. It restores the output functions as they were just before
tophide was loaded.
The "#hide" directive allows to switch back to the "hide" mode.


3. Example

The best way of using this is with findlib.
Findlib provides the "#require" directive for finding and loading a given
package.

#use "topfind";;          (* just once *)
- : unit = ()
Findlib has been successfully loaded. Additional directives:
  #require "package";;      to load a package
  #list;;                   to list the available packages
  #camlp4o;;                to load camlp4 (standard syntax)
  #camlp4r;;                to load camlp4 (revised syntax)
  #predicates "p,q,...";;   to set these predicates
  Topfind.reset();;         to force that packages will be reloaded
  #thread;;                 to enable threads

- : unit = ()
# #require "tophide";;      (* loads tophide *)
/home/martin/godi/lib/ocaml/site-lib/tophide: added to search path
/home/martin/godi/lib/ocaml/site-lib/tophide/tophide.cmo: loaded




It is recommended to put these directives into a .ocamlinit file.
Then they would be executed at the beginning of each ocaml session.
(see chapter "The toplevel system (ocaml)" of the Objective Caml reference
manual)

Let's see what we get:

# let a = 1;;                                               
val a : int = 1
# let _a = 2;;      (* good, no output for _a! *)
# 

Now you can load your favorite camlp4 extensions.
