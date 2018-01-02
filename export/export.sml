structure Export =
struct

fun output (filename,testname) testfn (testcasefn,tc_formatter) testcases  =
  let
      val file = TextIO.openOut((Config.getOutputDir ())^filename);

      val (_,testcasestr) =
	  List.foldr (fn (test,(i,str)) =>
			 let
			     val testcasestr = testcasefn (i,tc_formatter test)
			 in
			     (i+1,str^testcasestr)
			 end)
		     (1,"")
		     testcases;
      
      val teststr = testfn testcasestr		      
      val _ = TextIO.output(file,teststr)
      
      val _ = TextIO.closeOut(file)
  in
      ()
  end
      
end;
