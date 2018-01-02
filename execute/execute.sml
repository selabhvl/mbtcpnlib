structure Execute =
struct

(* simulation-based test case generation *)
    
fun simgenTC n =
  let
      fun simrun 0 = ()
	| simrun m  =

	  let
	      val tcs = SIMTCG.gen()

	      val _ = Logging.log ("Run          : "^(Int.toString m)^":"^(Int.toString n));
	      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));
	      val _ = Logging.log ("Test cases   : "^(Int.toString (List.length tcs)));
	  in
	      simrun (m-1)
	  end


      val _ = Logging.start ();
      val _ = Logging.log ("Simulation-based test-case generation");

      val _ = SimConfig.init();

      val _ = simrun n;
      
      val _ = Logging.log ("Completed");
      
      val _ = Logging.stop ();
  in
      SimConfig.getTestcases()
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
