structure SimConfig = 
struct

(* add x to xs if not already present *)
fun add (x,xs) = if (List.exists (fn x' => x = x') xs) then xs else x::xs 

fun merge dl sl = List.foldr (fn (x,dl) => add (x,dl)) dl sl;

									   
val testcases = ref ([] : (TCEvent list) list);

val testcase = ref ([] : (TCEvent list));

fun clear () = (testcase := []);

fun getTestcases () = (!testcases);

fun observe tcevents = (testcase := merge (tcevents (!testcase));0); 
  
fun init() = (testcases := [];
	      testcase := []);

(* TODO: do not insert a duplicate test case *) 
fun stop() = (testcases := (!testcase)::(!testcases);
	      testcase := []);


end
