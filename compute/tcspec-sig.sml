signature TCSPEC = sig

    val detection   : Bind.Elem -> bool;
    val observation : Bind.Elem -> TCEvent list;
    val format      : TCEvent -> string;
    val normalise   : TCEvent list -> TCEvent list;
end;
