structure Execute : TCGEN =
struct

(* simulation-based test case generation *)

fun tcscount tcs = (if (Config.getTestcaseevent ())
		    then   List.length (remdupl (List.concat tcs))
		    else (List.length tcs));

(* List.foldr (fn (tc,c) => c+(List.length tc)) 0 tcs; *)

fun sim n =
  let
      fun simrun 0 = ()
	| simrun m  =

	  let
	      val tcs = SIMTCG.gen()

	      val _ = Logging.log ("Simulation   : "^(Int.toString (n-m+1))^":"^(Int.toString n));
	      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));
	      val _ = Logging.log ("Steps        : "^(IntInf.toString (step())));
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
      
      val tcs = SimConfig.getTestcases();
      val tcsc = tcscount tcs; 
      
      val _ = Logging.log ("Total cases  : "^(Int.toString (tcsc)));
      val _ = Logging.sep();
      
      val _ = Logging.stop ();
  in
      tcs 
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
      
      val _ = Logging.log ("Completed");
      val tcsc = tcscount tcs; 
      
      val _ = Logging.log ("Total cases  : "^(Int.toString (tcsc)));

      val _ = Logging.sep();
      val _ = Logging.stop ();
  in
      tcs
  end;

fun export (tcs : (TCEvent list) list) = Export.export tcs;

end;
