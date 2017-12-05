structure Execute =
struct

(* simulation-based test case generation *)

fun simgenTC n = CPN'Replications.nreplications n;

(* state-space based test case generation *)

fun ssgenTC () =
  let
      val _ = DeleteStateSpace();
      val _ = Logging.log ("Starting state space test-case generation");

      val _ = CalculateOccGraph();

      val tcs = SSTCG.gen();
      
      val _ = Logging.log ("Configuration: "^(Config.getConfigName ()));
      val _ = Logging.log ("Completed");
  in
      tcs
  end;
end;
