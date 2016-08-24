type t = Ojs.t

type node_module = t

type require_option = Ojs.t

val require_fn : string -> (require_option -> t [@foo])
  [@@js.global "process.mainModule.require"]

val require : string -> node_module
  [@@js.global "process.mainModule.require"]

val t_to_js : t -> Ojs.t

val t_of_js : Ojs.t -> t

val node_module_of_js : Ojs.t -> node_module

val node_module_to_js : node_module -> Ojs.t

val require_option_of_js : Ojs.t -> require_option

val require_option_to_js : require_option -> Ojs.t
