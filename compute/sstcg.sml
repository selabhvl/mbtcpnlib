structure SSTCG =
struct

(* add x to xs if not already present *)
fun add (x,xs) = if (List.exists (fn x' => x = x') xs) then xs else x::xs (* xs^^[x] *)

(* merge sl into dl eliminating duplicates *)								
fun merge dl sl = List.foldr (fn (x,dl) => add (x,dl)) dl sl;

(* combine two sets of test cases *)
fun combine (tcs,tcs') = merge tcs tcs'

(* augment test cases tcs with the test case events *)
fun augment (tcevents,tcs) =
  List.map (fn tc => merge tc tcevents) tcs

(* propagation of test cases along an arc in the state space *)       
fun propagate testcases (detect,observe) (srcnode,event,destnode) =
  let
      (* existing test cases propagated earlier to the node being processed *)
      val (vs,tcsrcnode) = Array.sub(testcases,srcnode)

      (* observe test case events if relevent *)
      val tcevents = (if (detect event) then observe event else [])

      (* augment the test cases in current node *)	    
      val tcsrcnode' = augment(tcevents,tcsrcnode);

      (* existing test cases in the destination node *)
      val (vd,tcdestnode) = Array.sub(testcases,destnode)

      (* combine test cases into the dest node *) 
      val tcdestnode' = combine(tcdestnode,tcsrcnode')
      val _ = Array.update (testcases,destnode,(vd,tcdestnode'))
  in
      ()
  end;

fun process_node (detect,observe) testcases queue =
  if (Queue.isEmpty(queue))
  then testcases
  else
      (
	let
	    val node = Queue.dequeue(queue)
				    
	    val outarcs = OutArcs node;
	    val outnodes = OutNodes node;
	    
	    val edges = List.map (fn arc => (node,arc,DestNode arc)) outarcs;
				 
	    (* propagate the test cases from node *)
	    val _ = List.app (propagate testcases (detect,observe)) edges;

	    (* delete test case information stored at node as it has been propagated *)
	    val _ = if (outarcs<>[]) then Array.update(testcases,node,(true,[])) else ();
	    
	    (* enqueue successor states that are not in the queue *)
	    val _ = List.app
			(fn node =>
			    case (Array.sub(testcases,node)) of
				(true,_) => () (* node already in queue *)
			      | _ => (Queue.enqueue(queue,node);
				      let
					  val (_,tc) = Array.sub(testcases,node)
				      in
					  Array.update(testcases,node,(true,tc))
				      end))
			outnodes

	in
	    process_node (detect,observe) testcases queue
	end);

fun compute (detect,combine) =
  let
      val testcases = Array.tabulate(NoOfNodes()+1,fn _ => (false,[]));
      val queue = Queue.mkQueue ();
      
      val _ = Queue.enqueue(queue,InitNode);
      val _ = Array.update(testcases,InitNode,(true,[[]]));
  in
      process_node (detect,combine) testcases queue
  end;

fun hasall (tc1,tc2) = List.all (fn tc => List.exists (fn tc' => tc'=tc) tc2) tc1;
		     
fun equal tc1 tc2 = hasall (tc1,tc2) andalso hasall (tc2,tc1);
			       
fun generate' (detect,combine) =
  let
      (* generate the test case information *)
      val testcases = compute (detect,combine);
      
      (* extract information stored in the dead markings *)
      val deadmarkings = ListDeadMarkings();

      val testcases = List.concat
			  (List.map
			       (fn node =>
				   let
				       val tcs = (#2 (Array.sub(testcases,node)))
				   in
				       List.map List.rev tcs
				   end)
			       deadmarkings);

      (* remove test cases with identical events in different order *)
      val testcases' =
	  List.foldr
	      (fn (tc,tcs) =>
		  if (List.exists (fn tc' => equal tc tc') tcs) then tcs
		  else tc::tcs) [] testcases
	      
  in
      testcases'
  end;

fun gen () =
  let
      val detect = !Config.tcdetect
      val observe = !Config.tcobserve 
  in
      generate' (fn a =>  detect (ArcToBE a),fn a => observe (ArcToBE a))
  end;

fun test () = generate' (fn a => (print ((Int.toString(a))^" "); false), fn _ => []);

end;
