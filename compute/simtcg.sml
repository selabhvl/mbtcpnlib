structure SIMTCG =
struct

fun gen n =
  let
      val _ = SimConfig.init();
      val _ = CPN'Replications.nreplications n;
      val testcases = SimConfig.getTestcases ();
  in
      testcases
  end;

fun generate () = gen 2;

end;
