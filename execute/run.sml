
fun run config =
  let
      val _ = Config.setModelDir mbtcpnlibpath;
      val _ = Logging.start();
      val _ = Execute.ss();
      val _ = Logging.stop ();
  in
      ()
  end;
  
