(* 
use (mbtcpnlibpath^"config/testcases.sml");

val mbtcpnlibpath = "c:/work/mbtcpnlib/";

use (mbtcpnlibpath^"config/simconfig.sml");
*)

use (mbtcpnlibpath^"config/config.sml");

use (mbtcpnlibpath^"config/logging.sml");

use (mbtcpnlibpath^"compute/sstcg.sml");

use (mbtcpnlibpath^"execute/execute.sml");

use (mbtcpnlibpath^"export/export.sml");

use (mbtcpnlibpath^"execute/run.sml");

use (mbtcpnlibpath^"examples/tpc/tcg.sml");


fun b() = (use (mbtcpnlibpath^"build.sml"));

	 
