
(* logging and output *)
Config.setModelDir (mbtcpnlibpath^"examples/tpc/");
Config.setOutputDir ((Config.getModelDir())^"output/");

(* configuration and test case naming *)
Config.setConfigNaming (fn () => "tpctests-"^(Int.toString W));
Config.setTCNaming(fn i => "CaseID=\""^(Int.toString i)^"\" NumOfWorker=\""^(Int.toString W)^"\"");

val configs2 = [SS,(SIM 5),(SIM 10)]

val configs3 = [SS,(SIM 10),(SIM 20)]
		   
val configs4 = [SS,(SIM 50),(SIM 100)]

val configs5 = [SS,(SIM 100),(SIM 200)]

val configs10 = [(SIM 5000),(SIM 10000)]

val configs20 = [(SIM 10000),(SIM 20000)]		   
