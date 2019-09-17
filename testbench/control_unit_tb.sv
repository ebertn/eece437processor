// mapped timing needs this. 1ns is too fast


`include "cpu_types_pkg.vh"


// interface include
`include "control_unit_if.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module control_unit_tb;

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    // Control Unit interface
    control_unit_if cuif();

    // test program
    test PROG (CLK, cuif);

    // DUT
    control_unit  cuDUT (cuif);

endmodule

program test (
    input logic CLK,
    control_unit_if cuif);

    parameter PERIOD = 10;
    int test_num;
    string ij_test_names [0:15];
    string r_test_names [0:12];
    string test_name;
    opcode_t [15:0] IJ_type_instrs;
    funct_t [12:0] R_type_instrs;

    initial begin
        $display("Starting memory control testbench");

        // I/J Type instructions
        $display("I/J Type Instructions");
        IJ_type_instrs = {J, JAL, BEQ, BNE, ADDI, ADDIU, SLTI, SLTIU, ANDI, ORI, XORI, XORI, LUI, LW, SW, HALT};
        ij_test_names = {"J", "JAL", "BEQ", "BNE", "ADDI", "ADDIU", "SLTI", "SLTIU", "ANDI", "ORI", "XORI", "XORI", "LUI", "LW", "SW", "HALT"};

        test_num = -1;
        @(posedge CLK)
        // TEST 0
        for (test_num = 0; test_num < 16; test_num++) begin
            test_name = ij_test_names[test_num];
            $display("Test %d: %s", test_num, test_name);

            cuif.Equal = 0;
            cuif.InstrOp = IJ_type_instrs[15 - test_num];
            cuif.InstrFunc = AND;

            @(posedge CLK);
        end

        // I/J Type instructions
        $display("R Type Instructions");
        R_type_instrs = {SLLV, SRLV, JR, ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU};
        r_test_names = '{"SLLV", "SRLV", "JR", "ADD", "ADDU", "SUB", "SUBU", "AND", "OR", "XOR", "NOR", "SLT", "SLTU"};

        test_num = -1;
        @(posedge CLK)
        // TEST 0
        for (test_num = 0; test_num < 13; test_num++) begin
            test_name = r_test_names[test_num];
            $display("Test %d: %s", test_num, test_name);

            cuif.Equal = 1;
            cuif.InstrOp = RTYPE;
            cuif.InstrFunc = R_type_instrs[12 - test_num];

            @(posedge CLK);
        end

        cuif.Equal = 0;

        @(posedge CLK);


    end

endprogram : test