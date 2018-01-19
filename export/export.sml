structure Export =
struct

fun testfn testname teststr =
  "<Test TestName=\""^testname^"\">\n"^
  teststr^
  "</Test>\n";

fun testcasefn (i,teststr) =
  "  <TestCase "^(Config.getTCName i)^">\n"^
  teststr^
  "  </TestCase>\n"

fun tc_formatter testcases =
  let
      val (testvalues,testoracles) = List.partition (fn InEvent _ => true | _ => false) testcases
      val testvaluesstr = String.concat (List.map Config.formatTC testvalues)
      val testoraclesstr = String.concat (List.map Config.formatTC testoracles)
  in
      "    <TestValues>\n"^
      testvaluesstr^
      "    </TestValues>\n"^
      "    <TestOracles>\n"^
      testoraclesstr^
      "    </TestOracles>\n"
  end

fun output (filename,testname) testfn (testcasefn,tc_formatter) testcases  =
  let
      val file = TextIO.openOut((Config.getOutputDir ())^filename^".xml");

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

      fun export testcases = output (Config.getConfigName (),Config.getConfigName ())
			(testfn (Config.getConfigName ()))
			(testcasefn,tc_formatter) testcases;


end;
