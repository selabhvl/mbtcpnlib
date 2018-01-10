signature TCSPEC = sig

    val detection   : Bind.Elem -> bool;
    val observation : Bind.Elem -> TCEvent list;
    val format      : TCEvent -> string;
end;
