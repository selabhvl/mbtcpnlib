structure Export =
struct

fun testfn testname teststr =
  "<Test TestName=\""^testname^"\">\n"^
  "<Configuration>\n"^
  Config.formatConfig()^
  "</Configuration>\n"^
  teststr^
  "</Test>\n";

fun testcasefn (i,teststr) =
  if (not (Config.getTestcaseevent()))
	 then "  <TestCase "^(Config.getTCName i)^">\n"^
	      teststr^"\n"^
	      "  </TestCase>\n"
  else teststr;

fun tc_formatter testcase =
  let
      val inoutevents = List.filter (fn InOutEvent _ => true | _ => false) testcase;
      val testvalues = List.filter (fn InEvent _ => true | _ => false) testcase;
      val testoracles = List.filter (fn OutEvent _ => true | _ => false) testcase;

      (* TODO: numering of unit test cases across several test cases need to be carried forward *)
      (* global numbering of test cases *)

      val (_,unitteststr) = (List.foldr
				     (fn (ioevent,(i,str)) =>
						  (i+1,
						   str^"  <TestCase "^(Config.getTCName i)^">\n"^
						   (Config.formatTC ioevent)^"\n"^
						   "  </TestCase>\n"))	  
				     (1,"")
				     inoutevents)
				      
      val testvaluesstr = String.concat (List.map Config.formatTC testvalues)
      val testoraclesstr = String.concat (List.map Config.formatTC testoracles)
  in
      unitteststr^"\n"^
      testvaluesstr^"\n"^
      testoraclesstr
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
