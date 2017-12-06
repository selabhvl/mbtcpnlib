structure SimConfig = 
struct

val testcases = ref ([] : (TCEvent list) list);

val testcase = ref ([] : (TCEvent list));

fun clear () = (testcase := []);

fun getTestcases () = (!testcases);

fun observe tcevents = (testcase := tcevents^^(!testcase);0); 
  
fun init() = (testcases := [];
	      testcase := []);

(* TODO: do not insert a duplicate test case *) 
fun stop() = (testcases := (!testcase)::(!testcases);
	      testcase := []);


end
