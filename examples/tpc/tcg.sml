(* detection and observation function for the TPC example *)

fun tcedetect (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = true
  | tcedetect (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision})) = true
  | tcedetect (Bind.Workers'Receive_Decision (_,{w,decision}))  = true
  | tcedetect _ = false;

exception obsExn;
fun tceobs (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = [InEvent (w,vote)]
  | tceobs (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision}))  = [OutEvent (SDecision decision)]
  | tceobs (Bind.Workers'Receive_Decision (_,{w,decision})) = [OutEvent (WDecision (w,decision))]
  | tceobs _ = raise obsExn; 

Config.setTCdetect(tcedetect);
Config.setTCobserve(tceobs);

(* exporting for teh TPC example *)
fun prefixfn testname = "<Test TestName=\"TPCTest\">\n";

fun postfixfn testname = "</Test>\n";

fun testcasefn (i,teststr) =
  "  <TestCase CaseID=\""^(Int.toString i)^"\">\n"^
  teststr^
  "  </TestCase>\n"

fun tc_formatter testcase = "";

fun tpcoutput testcases = Export.output ("tpctests.xml","TPCTest")
					(prefixfn,postfixfn)
					(testcasefn,tc_formatter) testcases;

(* logging and output *)
Config.setModelDir (mbtcpnlibpath^"examples/tpc/");
Config.setOutputDir ((Config.getModelDir())^"output/");

fun sstpc () = tpcoutput (Execute.ssgenTC ());
