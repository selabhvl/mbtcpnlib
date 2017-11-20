type TCE = Worker * Decision; 
		    
fun tcedetect (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = true
  | tcedetect _ = false;

exception obsExn;
fun tceobs (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = [(w,vote)]
  | tceobs _ = raise obsExn; 

datatype TCO = WDecision of Worker * Vote
	     | SDecision of Decision; 

fun oradetect (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = true
  | oradetect (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision}))  = true
  | oradetect _ = false; 

exception oraExn;
fun oraobs (Bind.Workers'Receive_CanCommit (_,{w,vote}))  = WDecision (w,vote)
  | oraobs (Bind.Coordinator'Receive_Acknowledgements (_,{workers,decision}))  = SDecision decision
  | oraobs _ = raise oraExn; 

(* TODO: the TCE and the TCO types could be type parameterised *)
type TestCase = (TCE list) * (TCO list); 

						


