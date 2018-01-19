#!/bin/sh

echo "Packing library ..."

zip mbtcpn_v"$1".zip execute/*.sml export/*.sml config/*.sml compute/*.sml build.sml README.md examples/tpc/tcg.sml examples/tpc/twophasecommit.cpn 
