		    
fun tcedetect (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = true
  | tcedetect (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision})) = true
  | tcedetect (Bind.Workers'Receive_Decision (_,{w,decision}))  = true
  | tcedetect _ = false;

exception obsExn;
fun tceobs (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = [InEvent (w,vote)]
  | tceobs (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision}))  = [OutEvent (SDecision decision)]
  | tceobs (Bind.Workers'Receive_Decision (_,{w,decision})) = [OutEvent (WDecision (w,decision))]
  | tceobs _ = raise obsExn; 

(*
fun oradetect (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = true
  | oradetect (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision}))  = true
  | oradetect _ = false; 

exception oraExn;
fun oraobs (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = WDecision (w,vote)
  | oraobs 
  | oraobs _ = raise oraExn; 
*)
(* TODO: the TCE and the TCO types could be type parameterised *)
(* type TestCase = (TCE list) * (TCO list); *)

Config.setTCdetect(tcedetect);
Config.setTCobserve(tceobs);
		  
						


