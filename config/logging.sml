structure Logging =
struct

val logfilename = "mbtcpn.log";

val file = ref (NONE :(TextIO.outstream option));

fun log msg =
  case (!file) of
      NONE => ()
   |  SOME (stream) =>
      let
	  val time = Date.toString(Date.fromTimeLocal(Time.now()));
      in
	  TextIO.output(stream,time^" "^msg^"\n")
      end;

fun start () =
  let
      val filename = Config.getModelDir()^logfilename
  in
      (file := SOME (TextIO.openOut(filename));
       log "Logging started")
  end; (* TODO: do not reopen if logging is already running *)

fun stop() =
  case (!file) of
      NONE => ()
    | SOME(stream) => (log "Logging stopped";
		       TextIO.closeOut(stream);
		       file := NONE);

end;
