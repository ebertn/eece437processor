`ifndef FORWARD_IF_VH
`define FORWARD_IF_VH

`include "cpu_types_pkg.vh"

interface forward_if; 
import cpu_types_pkg::*;



modport forward (

); 

modport tb (

); 


endinterface 

`endif