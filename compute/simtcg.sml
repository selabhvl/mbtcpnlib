structure SIMTCG =
struct

fun gen () =
  let
      (* val _ = SimConfig.init();*)
      
      val _ = CPN'Sim.init_all();
      val _ = CPN'Sim.run();
      
      val tcs = SimConfig.getTestcases();

  in
      tcs
  end;

end;
