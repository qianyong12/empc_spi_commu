///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Protocol_analysis.v
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

module Protocol_analysis(
input sck,
input [80:0] datain,
input vld,
input rstn,

output [40:0] payload,
output pvld
);
//<statements>
reg [48:0] payload_r;
reg vld_r;
wire crc_check_result;
wire clr;
always@(posedge sck or negedge rstn)
begin
if(!rstn)
    begin
    payload_r<= 49'b0;
    end
else if(vld)
    begin
    payload_r<= datain[64:16];
    end
end
always@(posedge sck or negedge rstn)
begin
if(!rstn)
    begin
    vld_r<=1'b0;
    end
else if(vld)
    begin
    vld_r<=1'b1;
    end
else if(clr)
    begin
    vld_r<=1'b0;
    end
end
crc_check u_crc_check(
.in(datain[64:8]),
.start(vld),
.clk(sck),
.rstn(rstn),
.out(crc_check_result),
.clr(clr)
);
assign payload= payload_r[40:0];
assign pvld= vld_r&&crc_check_result;
endmodule