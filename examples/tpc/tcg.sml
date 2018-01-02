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
fun testfn testname teststr =
  "<Test TestName=\""^testname^"\">\n"^
  teststr^
  "</Test>\n";

fun testcasefn (i,teststr) =
  "  <TestCase CaseID=\""^(Int.toString i)^"\" NumOfWorker=\""^(Int.toString W)^"\">\n"^
  teststr^
  "  </TestCase>\n"

fun formatevent (InEvent (wrk(i),vote)) =
  "      <Votes>\n"^
  "        <WorkerID>"^(Int.toString i)^"</WorkerID>\n"^
  "        <VoteValue>"^(if vote = No then "0" else "1")^"</VoteValue>\n"^
  "      </Votes>\n"
  | formatevent (OutEvent (WDecision (wrk(i),decision))) =
    "        <Decision>\n"^
    "          <WorkerID>"^(Int.toString i)^"</WorkerID>\n"^
    "          <DecisionValue>"^(if decision = abort then "0" else "1")^"</DecisionValue>\n"^
    "        </Decision>\n"
  | formatevent (OutEvent (SDecision (decision))) =
    "        <FinalDecision>"^(if decision = abort then "0" else "1")^"</FinalDecision>";

fun tc_formatter testcases =
  let
      val (testvalues,testoracles) = List.partition (fn InEvent _ => true | _ => false) testcases
      val testvaluesstr = String.concat (List.map formatevent testvalues)
      val testoraclesstr = String.concat (List.map formatevent testoracles)
  in
      "    <TestValues>\n"^
      testvaluesstr^
      "    </TestValues>\n"^
      "    <TestOracles>\n"^
      testoraclesstr^"\n"^
      "    </TestOracles>\n"
  end
      
fun tpcoutput testcases = Export.output ("tpctests.xml","TPCTest")
					(testfn "TPCTest")
					(testcasefn,tc_formatter) testcases;

(* logging and output *)
Config.setModelDir (mbtcpnlibpath^"examples/tpc/");
Config.setOutputDir ((Config.getModelDir())^"output/");

fun sstpc () = tpcoutput (Execute.ssgenTC ());

fun simtpc () = tpcoutput (Execute.simgenTC 10);
