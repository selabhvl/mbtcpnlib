use (mbtcpnlibpath^"config/config.sml");

use (mbtcpnlibpath^"config/logging.sml");

use (mbtcpnlibpath^"compute/tcspec-sig.sml");

use (mbtcpnlibpath^"compute/sstcg.sml");
use (mbtcpnlibpath^"compute/simtcg.sml");

use (mbtcpnlibpath^"compute/tcg-sig.sml");

use (mbtcpnlibpath^"execute/execute.sml");

use (mbtcpnlibpath^"export/export.sml");

use (mbtcpnlibpath^"execute/run.sml");

use (mbtcpnlibpath^"examples/tpc/tcg.sml");

fun b() = (use (mbtcpnlibpath^"build.sml"));

fun s() = (use (mbtcpnlibpath^"boot.sml"));
	 
