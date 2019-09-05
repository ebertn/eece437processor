// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

`include "alu_if.vh"

`include "cpu_types_pkg.vh"

module alu_tb;

import cpu_types_pkg::*;

  // interface
  alu_if aluif ();
  // test program
  test PROG (aluif);

  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.portA (aluif.portA),
    .\aluif.portB (aluif.portB),
    .\aluif.aluOp (aluif.aluOp),
    .\aluif.negative (aluif.negative),
    .\aluif.overflow (aluif.overflow),
    .\aluif.zero (aluif.zero)
  );
`endif

endmodule

program test
import cpu_types_pkg::*;
(
	alu_if.tb aluif);

parameter PERIOD = 10;
int test_num;

initial begin
	$monitor("Starting ALU testbench");

	test_num = 0;
	$monitor("Test SLL");
	aluif.aluOp = ALU_SLL;
	aluif.portA = 1;
	aluif.portB = 8;

	#(PERIOD);

	assert(aluif.outPort == (1 << 8)) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$monitor("Test SRL");
	aluif.aluOp = ALU_SRL;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (8 >> 2)) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$monitor("Test AND");
	aluif.aluOp = ALU_AND;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (8 & 2)) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$monitor("Test OR");
	aluif.aluOp = ALU_OR;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (8 | 2)) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$monitor("Test XOR");
	aluif.aluOp = ALU_XOR;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (8 ^ 2)) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$monitor("Test NOR");
	aluif.aluOp = ALU_NOR;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == ~(8 | 2)) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$monitor("Test ADD");
	aluif.aluOp = ALU_ADD;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (8 + 2)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test SUB");
	aluif.aluOp = ALU_SUB;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (8 - 2)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SUB negative", test_num);
	aluif.aluOp = ALU_SUB;
	aluif.portA = 2;
	aluif.portB = 8;

	#(PERIOD);

	assert(aluif.outPort == (2 - 8)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 1) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SUB overflow", test_num);
	aluif.aluOp = ALU_SUB;
	aluif.portA = 32'h80000000;
	aluif.portB = 1;

	#(PERIOD);

	assert(aluif.outPort == (32'h80000000 - 1)) $display("Passed");
	assert(aluif.overflow == 1) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SLT greater than", test_num);
	aluif.aluOp = ALU_SLT;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort[30:0] == (8 - 2) && !aluif.outPort[31]) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SLT less than", test_num);
	aluif.aluOp = ALU_SLT;
	aluif.portA = 2;
	aluif.portB = 8;

	#(PERIOD);

	assert(aluif.outPort[31:0] == (2 - 8)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 1) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SLT equal", test_num);
	aluif.aluOp = ALU_SLT;
	aluif.portA = 2;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort[30:0] == (2 - 2) && !aluif.outPort[31]) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 1) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SLT signed greater", test_num);
	aluif.aluOp = ALU_SLT;
	aluif.portA = 8;
	aluif.portB = -2;

	#(PERIOD);

	assert(aluif.outPort[31:0] == (8 - (-2))) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SLT signed less", test_num);
	aluif.aluOp = ALU_SLT;
	aluif.portA = -8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort[31:0] == (-8 - 2)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 1) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test %d SLT signed equal", test_num);
	aluif.aluOp = ALU_SLT;
	aluif.portA = -2;
	aluif.portB = -2;

	#(PERIOD);

	assert(aluif.outPort[31:0] == (-2 - (-2))) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 1) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test SLTU greater");
	aluif.aluOp = ALU_SLTU;
	aluif.portA = 8;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (8 - 2)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test SLTU less");
	aluif.aluOp = ALU_SLTU;
	aluif.portA = 2;
	aluif.portB = 8;

	#(PERIOD);

	assert(aluif.outPort == (2 - 8)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 1) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test SLTU equal");
	aluif.aluOp = ALU_SLTU;
	aluif.portA = 2;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == (2 - 2)) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 1) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test SLTU negative less");
	aluif.aluOp = ALU_SLTU;
	aluif.portA = 2;
	aluif.portB = -2;

	#(PERIOD);

	assert(aluif.outPort == ({1'b0, 32'd2} - (-{1'b0, 32'd2}))) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test SLTU negative greater");
	aluif.aluOp = ALU_SLTU;
	aluif.portA = -2;
	aluif.portB = 2;

	#(PERIOD);

	assert(aluif.outPort == ({1'b0, -32'd2} - {1'b0, 32'd2})) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 1) $display("Passed");
	assert(aluif.zero == 0) $display("Passed");

	#(PERIOD);

	test_num += 1;
	$display("Test SLTU negative equal");
	aluif.aluOp = ALU_SLTU;
	aluif.portA = -2;
	aluif.portB = -2;

	#(PERIOD);

	assert(aluif.outPort == ({1'b0, -32'd2} - ({1'b0, -32'd2}))) $display("Passed");
	assert(aluif.overflow == 0) $display("Passed");
	assert(aluif.negative == 0) $display("Passed");
	assert(aluif.zero == 1) $display("Passed");

	#(PERIOD);

end

endprogram
