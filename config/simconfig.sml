structure SimConfig = 
struct

val testcases = ref ([] : (tcevent list) list);

val testcase = ref ([] : (tcevent list));

fun clear () = (testcase := []);

fun getTestcases () = (!testcases);

fun observe tcevents = (testcase := tcevents^^(!testcase);0); 
  
fun init() = (); 

fun stop() = (testcases := (!testcase)::(!testcases));


end
