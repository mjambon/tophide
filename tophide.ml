(* $Id$ *)

(*
  Copyright 2008 Martin Jambon. All rights reserved.
  This file is distributed under the terms stated in file LICENSE.
*)

open Toploop
open Outcometree

type env = {
  print_out_class_type : 
    Format.formatter -> out_class_type -> unit;
  print_out_module_type :
    Format.formatter -> out_module_type -> unit;
  print_out_phrase :
    Format.formatter -> out_phrase -> unit;
  print_out_sig_item :
    Format.formatter -> out_sig_item -> unit;
  print_out_signature : 
    Format.formatter -> out_sig_item list -> unit;
  print_out_type :
    Format.formatter -> out_type -> unit;
  print_out_value :
    Format.formatter -> out_value -> unit;
}

let save_env () = {
  print_out_class_type = !print_out_class_type;
  print_out_module_type = !print_out_module_type;
  print_out_phrase = !print_out_phrase;
  print_out_sig_item = !print_out_sig_item;
  print_out_signature =  !print_out_signature;
  print_out_type = !print_out_type;
  print_out_value = !print_out_value;
}

let load_env env =
  print_out_class_type := env.print_out_class_type;
  print_out_module_type := env.print_out_module_type;
  print_out_phrase := env.print_out_phrase;
  print_out_sig_item := env.print_out_sig_item;
  print_out_signature := env.print_out_signature;
  print_out_type := env.print_out_type;
  print_out_value := env.print_out_value


let default_env = save_env ()

let filter_sig_item = function
    Osig_class (_, _, _, _, _)
  | Osig_class_type (_, _, _, _, _)
  | Osig_typext _
  | Osig_modtype _
  | Osig_module _
  | Osig_ellipsis
  | Osig_type _ as x -> Some x
  | Osig_value {oval_name = name; _} as x ->
      if name <> "" && name.[0] = '_' then None
      else Some x


let rec select f = function
    [] -> []
  | hd :: tl ->
      match f hd with
	  None -> select f tl
	| Some x -> x :: select f tl


let special_print_out_phrase fmt x0 =
  let x =
    match x0 with
	Ophr_signature l0 ->
	  let l = 
	    select (
	      fun (si0, ov) -> 
		match filter_sig_item si0 with
		    None -> None
		  | Some si -> Some (si, ov)
	    ) l0
	  in
	  Ophr_signature l
	 
      | Ophr_eval _
      | Ophr_exception _ -> x0
  in   
  default_env.print_out_phrase fmt x


let special_env = 
  { default_env with print_out_phrase = special_print_out_phrase }


let hide () = load_env special_env
let show () = load_env default_env

let _ =
  (* Add "#hide" directive: *)
  Hashtbl.add
    directive_table
    "hide"
    (Directive_none hide);
  
  (* Add "#show" directive: *)
  Hashtbl.add
    directive_table
    "show"
    (Directive_none show);

  (* Enter "hide" mode upon loading *)
  hide ()
