structure Execute : TCGEN =
struct

(* simulation-based test case generation *)
    
fun sim n =
  let
      fun simrun 0 = ()
	| simrun m  =

	  let
	      val tcs = SIMTCG.gen()

	      val _ = Logging.log ("Run          : "^(Int.toString (n-m+1))^":"^(Int.toString n));
	      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));
	      val _ = Logging.log ("Test cases   : "^(Int.toString (List.length tcs)));
	  in
	      simrun (m-1)
	  end


      val _ = Logging.start ();
      val _ = Logging.sep();
      val _ = Logging.log ("Simulation-based test-case generation");
      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));
      
      val _ = SimConfig.init();

      val _ = simrun n;
      
      val _ = Logging.log ("Completed");
      val _ = Logging.sep();
      
      val _ = Logging.stop ();
  in
      SimConfig.getTestcases()
  end;

(* state-space based test case generation *)

fun ss () =
  let
      val _ = CPN'Sim.init_all(); (* exception raised here earlier ? *)
      val _ = DeleteStateSpace(); 
      val _ = Logging.start ();

      val _ = Logging.sep();
      
      val _ = Logging.log ("State space-based test-case generation");
      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));

      val _ = Logging.log ("Generating state space ... "^(Int.toString (NoOfNodes ())));
      val _ = CalculateOccGraph();

      val _ = Logging.log ("Completed: "^(Int.toString (NoOfNodes()))^" "^(Int.toString (NoOfArcs())));
      val _ = Logging.log ("Generating test cases ...");

      val tcs = SSTCG.gen();
      
      val _ = Logging.log ("Completed: "^(Int.toString (List.length tcs)));

      val _ = Logging.sep();
      val _ = Logging.stop ();
  in
      tcs
  end;

fun export (tcs : (TCEvent list) list) = Export.export tcs;

end;
