structure Logging =
struct

val logfilename = "mbtcpn.log";

val file = ref (NONE :(TextIO.outstream option));

fun startLogging () =
  let
      val filename = Config.getModelDir()^logfilename
  in
      file := SOME (TextIO.openOut(filename))
  end; (* TODO: do not reopen if logging is already running *)

fun log msg =
  case (!file) of
      NONE => ()
   |  SOME (stream) => TextIO.output(stream,msg);

fun stopLogging () =
  case (!file) of
      NONE => ()
    | SOME(stream) => (TextIO.closeOut(stream);
		       file := NONE);

end;
