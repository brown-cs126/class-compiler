open S_exp
open Asm

exception BadExpression of s_exp

let rec compile_exp (exp : s_exp) : directive list =
  match exp with
  | Num n ->
    [Mov (Reg Rax, Imm n)]
  | Lst [Sym "add1"; arg] ->
    compile_exp arg @
    [Add (Reg Rax, Imm 1)]
  | Lst [Sym "sub1"; arg] ->
    compile_exp arg @
    [Sub (Reg Rax, Imm 1)]
  | e -> raise (BadExpression e)

let compile (program : s_exp) : string =
  [Global "entry"; Label "entry"] @
  compile_exp program @
  [Ret] |> List.map string_of_directive |> String.concat "\n"

let rec interp_exp (exp : s_exp) : int =
  match exp with
  | Num n -> n
  | Lst [Sym "add1"; arg] ->
    (interp_exp arg) + 1
  | Lst [Sym "sub1"; arg] ->
    (interp_exp arg) - 1
  | e -> raise (BadExpression e)

let interp (program : string) : string =
  interp_exp (parse program) |> string_of_int

let compile_to_file (program : string) : unit =
  let file = open_out "program.s" in
  output_string file (compile (parse program));
  close_out file

let compile_and_run (program : string) : string =
  compile_to_file program;
  ignore (Unix.system "nasm program.s -f macho64 -o program.o");
  ignore (Unix.system "gcc program.o runtime.o -o program");
  let inp = Unix.open_process_in "./program" in
  let r = input_line inp in
  close_in inp;
  r

let difftest (examples : string list) =
  let results = List.map (fun ex -> (compile_and_run ex, interp ex)) examples in
  List.for_all (fun (r1, r2) -> r1 = r2) results

let test () =
  difftest ["43"; "5"; "(add1 (sub1 4))"; "(sub1 (sub1 1))"]