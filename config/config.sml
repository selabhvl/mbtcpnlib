structure Config =
struct

  type testcase = Bind.Elem list;

  val modeldir = ref "";
  fun getModelDir () = (!modeldir);
  fun setModelDir outdir = (modeldir := outdir);
  
  (* output directory where files are stored *)
  val tcoutputdir = ref "testcases/";
  fun getOutputDir () = (!tcoutputdir);
  fun setOutputDir outdir = (tcoutputdir := outdir);

  (* for naming file holding a set of test cases *)
  val confignaming = ref (fn () => "");
  fun setConfigNaming namingfn = (confignaming := namingfn);
  fun getConfigName () = (!confignaming ());

  (* for naming individual test cases *)
  val tcnaming = ref (fn () => "");
  fun setTCNaming namingfn = (tcnaming := namingfn);
  fun getTCName () = (!tcnaming ());

  (* event detection function *)
  val tcdetect = ref (fn (x:Bind.Elem) => false);
  fun setTCdetect detectfn = (tcdetect := detectfn);
  fun detectTC event = (!tcdetect event);

  (* observation function *)
  val tcobserve = ref (fn (x:Bind.Elem) => [] : tcevent list);
  fun setTCobserve observefn = (tcobserve := observefn);
  fun observeTC event = (!tcobserve event);

  (* TODO: oracle detection and observation *)
  (* may need to go into a seperate monitor *)
  
end;
