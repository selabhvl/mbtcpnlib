structure Config =
struct

  val modeldir = ref "";
  fun getModelDir () = (!modeldir);
  fun setModelDir outdir = (modeldir := outdir);
  
  (* output directory where files are stored *)
  val tcoutputdir = ref "testcases/";
  fun getOutputDir () = (!tcoutputdir);
  fun setOutputDir outdir = (tcoutputdir := outdir);

  (* for naming file holding a set of test cases *)
  val confignaming = ref (fn () => "tcs");
  fun setConfigNaming namingfn = (confignaming := namingfn);
  fun getConfigName () = (!confignaming ());

  (* for naming individual test cases *)
  val tcnaming = ref (fn i => Int.toString i);
  fun setTCNaming namingfn = (tcnaming := namingfn);
  fun getTCName i = (!tcnaming i);

  (* event detection function *)
  val tcdetect = ref (fn (x:Bind.Elem) => false);
  fun setTCdetect detectfn = (tcdetect := detectfn);
  fun detectTC event = (!tcdetect event);

  (* observation function *)
  val tcobserve = ref (fn (x:Bind.Elem) => [] : TCEvent list);
  fun setTCobserve observefn = (tcobserve := observefn);
  fun observeTC event = (!tcobserve event);

  (* formatting  function *)
  val tcformat = ref (fn (x:TCEvent) => "");
  fun setTCformat formatfn = (tcformat := formatfn);
  fun formatTC event = (!tcformat event);

  (* configuration information for the test *)
  val configformat = ref (fn () => "");
  fun setConfigformat configformatfn = (configformat := configformatfn);
  fun formatConfig () = (!configformat ());

  (* normalisation function for test case events *)
  val tcnormal = ref (fn (tce : (TCEvent list)) => (tce: TCEvent list));
  fun setTCnormal confignormalfn = (tcnormal := confignormalfn);
  fun normalTC tce = (!tcnormal tce);
  
  (* TODO: oracle detection and observation *)
  (* may need to go into a seperate monitor *)

  (* test cases per event *)
  val testcaseevent = ref false; (* true for single event test case generation *)
  fun setTestcaseevent bf = (testcaseevent := bf);
  fun getTestcaseevent () = (!testcaseevent);
  
end;
