///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Spi_to_pnb_rev.v
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

module Spi_to_pnb_rev(
sck,
cs,
sdi,
datain,
vld
);
input sck,cs,sdi;
output wire [80:0] datain;
output vld;
reg [80:0] data_r;
//<statements>
always@(posedge sck)
begin
if(cs)
    begin
        data_r<= 81'b0;
    end
else
    begin
        data_r<= {data_r[79:0], sdi};
    end
end
assign vld = (data_r[80:65]==16'h55ab)&&(data_r[7:0]==8'haa);
assign datain = data_r;
endmodule

