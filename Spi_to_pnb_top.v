///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Spi_to_pnb_top.v
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

module Spi_to_pnb_top( 
inter_fpga_comms_cs, 
inter_fpga_comms_sdo,
inter_fpga_comms_sck,
rst_n,

inter_fpga_comms_sdi, 
payload,
pvld
);
input inter_fpga_comms_cs, inter_fpga_comms_sdo, inter_fpga_comms_sck, rst_n;
output inter_fpga_comms_sdi;
output [40:0] payload;
output pvld;
//<statements>
wire [80:0] datain;
wire vld;
wire dataout=1'b0;
wire vldout=1'b0;

Spi_to_pnb_rev u_spi_to_pnb_rev(
    .sck(inter_fpga_comms_sck),
    .cs(inter_fpga_comms_cs),
    .sdi(inter_fpga_comms_sdo),

    .datain(datain),
    .vld(vld)
);

Spi_to_pnb_trans u_spi_to_pnb_trans(
    .sck(inter_fpga_comms_sck),
    .dataout(dataout),
    .vld(vldout),

    .sdo(inter_fpga_comms_sdi)
);

Protocol_analysis u_protocol_analysis(
    .sck(inter_fpga_comms_sck),
    .datain(datain),
    .vld(vld),
    .rstn(rst_n),

    .payload(payload),
    .pvld(pvld)
);
endmodule