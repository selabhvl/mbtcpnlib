structure Export =
struct

fun output (filename,testname) (prefixfn,postfixfn) (testcasefn,tc_formatter) testcases  =
  let
      val file = TextIO.openOut((Config.getOutputDir ())^filename);

      val _ = TextIO.output(file,prefixfn testname);

      val _ =
	  List.foldr (fn (test,i) =>
			 let
			     val teststr = testcasefn (i,tc_formatter test)
			     val _ = TextIO.output(file,teststr)
			 in
			     (i+1)
			 end)
		     1
		     testcases;
      
      val _ = TextIO.output(file,postfixfn testname);
      
      val _ = TextIO.closeOut(file)
  in
      ()
  end
      
end;
