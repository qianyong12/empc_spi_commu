///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: crc_check.v
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

module crc_check(
input [56:0] in,
input start,
input clk,
input rstn,
output reg out,
output reg clr
);
//<statements>
parameter [7:0] poly = 8'b0000_0111;
reg [56:0]din_temp;
reg crc_en;
reg [5:0]crc_cnt;

always@(posedge clk or negedge rstn)
if(~rstn)
        din_temp <= 57'b0;
else if(start)
        din_temp <= in;
else if(crc_en)
begin
        din_temp[56:49] <= din_temp[56]? din_temp[55:48]^poly : din_temp[55:48];
        din_temp[48:0] <= { din_temp[47:0],1'b0};
end

always@(posedge clk or negedge rstn)
if(~rstn)
        crc_en <= 1'b0;
else if(start)
        crc_en <= 1'b1;
else if(crc_cnt == 6'd56)
        crc_en <= 1'b0;

always@(posedge clk or negedge rstn)
if(~rstn)
        crc_cnt <= 6'd0;
else if(start)
        crc_cnt <= 6'd0;
else if(crc_en)
        crc_cnt <= crc_cnt +1'b1;

always@(posedge clk or negedge rstn)
if(~rstn)
        out <= 1'b0;
else if(crc_en && crc_cnt == 6'd56)
        out <= ~din_temp[56];
else
        out <= 1'b0;

always@(posedge clk or negedge rstn)
if(~rstn)
        clr <= 1'b0;
else if(crc_en && crc_cnt == 6'd56)
        clr <= 1'b1;
else
        clr <= 1'b0;

endmodule
