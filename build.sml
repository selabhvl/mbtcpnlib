val mbtcpnlibpath = "c:/work/mbtcpnlib/";

use (mbtcpnlibpath^"config/config.sml");
use (mbtcpnlibpath^"config/logging.sml");

use (mbtcpnlibpath^"execute/execute.sml");
use (mbtcpnlibpath^"execute/run.sml");

fun b() = (use (mbtcpnlibpath^"build.sml");
