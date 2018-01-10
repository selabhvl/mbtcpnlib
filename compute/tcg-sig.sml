signature TCGEN = sig

    val sim : int -> (TCEvent list) list;
    val ss  : unit -> (TCEvent list) list;

    val export : (TCEvent list) list
end;
