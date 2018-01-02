structure Execute =
struct

(* simulation-based test case generation *)

fun simgenTC n =
  let
      val _ = Logging.start ();
      val _ = Logging.log ("Simulation-based test-case generation");
 
      val _ = CPN'Sim.init_all();
      val _ = CPN'Sim.run();
      
      val tcs = SimConfig.getTestcases();
      
      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));
      val _ = Logging.log ("Test cases:    "^(Int.toString (List.length tcs)));
      val _ = Logging.log ("Completed");
      
      val _ = Logging.stop ();
  in
     tcs
  end;

(* state-space based test case generation *)

fun ssgenTC () =
  let
      val _ = CPN'Sim.init_all();
      (* val _ = DeleteStateSpace(); *)
      val _ = Logging.start ();
      
      val _ = Logging.log ("Starting state space test-case generation");

      (* val _ = CalculateOccGraph(); *)

      val tcs = SSTCG.gen();
      
      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));
      val _ = Logging.log ("Completed");
      
      val _ = Logging.stop ();
  in
      tcs
  end;
end;
