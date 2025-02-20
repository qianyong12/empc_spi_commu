///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Spi_to_pnb_trans.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::ProASIC3E> <Die::A3PE3000> <Package::484 FBGA>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module Spi_to_pnb_trans(
sck,
dataout,
vld,
sdo
);
input sck, dataout, vld;
output sdo;
//<statements>
assign sdo = 1'b0;
endmodule