(* implementation of the test case specification for the TPC example *)

structure TPCTCSpec : TCSPEC = struct
	  
fun detection (Bind.Workers'Receive_CanCommit _)  = true
  | detection (Bind.Coordinator'Receive_Acknowledgements _) = true
  | detection (Bind.Workers'Receive_Decision _)  = true
  | detection _ = false;

exception obsExn;
fun observation (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = [InEvent (w,vote)]
  | observation (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision}))  = [OutEvent (SDecision decision)]
  | observation (Bind.Workers'Receive_Decision (_,{w,decision})) = [OutEvent (WDecision (w,decision))]
  | observation _ = raise obsExn; 

fun format (InEvent (wrk(i),vote)) =
  "      <Votes>\n"^
  "        <WorkerID>"^(Int.toString i)^"</WorkerID>\n"^
  "        <VoteValue>"^(if vote = No then "0" else "1")^"</VoteValue>\n"^
  "      </Votes>\n"
  | format (OutEvent (WDecision (wrk(i),decision))) =
    "        <Decision>\n"^
    "          <WorkerID>"^(Int.toString i)^"</WorkerID>\n"^
    "          <DecisionValue>"^(if decision = abort then "0" else "1")^"</DecisionValue>\n"^
    "        </Decision>\n"
  | format (OutEvent (SDecision (decision))) =
    "        <FinalDecision>"^(if decision = abort then "0" else "1")^"</FinalDecision>\n";

fun normalise tce = tce;

end;

(* setup test case generation for the TPC example *)
Config.setTCdetect(TPCTCSpec.detection);
Config.setTCobserve(TPCTCSpec.observation);
Config.setTCformat(TPCTCSpec.format);
Config.setTCnormal(TPCTCSpec.normalise);

(* logging and output *)
Config.setModelDir (mbtcpnlibpath^"examples/tpc/");
Config.setOutputDir ((Config.getModelDir())^"output/");

(* configuration and test case naming *)
Config.setConfigNaming (fn () => "tpctests");
Config.setTCNaming(fn i => "CaseID=\""^(Int.toString i)^"\" NumOfWorker=\""^(Int.toString W)^"\"");
